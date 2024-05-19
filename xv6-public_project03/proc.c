#include "types.h"
#include "defs.h"
#include "param.h"
#include "mmu.h"
#include "memlayout.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;
// pj3
static struct pthread *initpth;

int nextpid = 1;
// pj3
int nextTid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  struct pthread *pth;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  // pj3
  pth = p->pth;
  p->onTidx = 0;
  pth->state = EMBRYO;
  pth->tid = nextTid++;
  pth->tidx = 0;

  release(&ptable.lock);

  // initialize kstack, ustacks
  for(int i = 0; i < NPTH; i++)
  {
    p->kstacks[i] = 0;
    p->ustacks[i] = 0;
  }

  // Allocate kernel stack.
  if((p->kstacks[0] = kalloc()) == 0){
    p->state = UNUSED;
    pth->state = UNUSED;
    return 0;
  }
  pth->kstack = p->kstacks[0];
  sp = pth->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *pth->tf;
  pth->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *pth->context;
  pth->context = (struct context*)sp;
  memset(pth->context, 0, sizeof *pth->context);
  pth->context->eip = (uint)forkret;

  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  struct pthread *pth;
  
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
  pth = p->pth;
  
  initproc = p;
  initpth = p->pth;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;

  memset(pth->tf, 0, sizeof(*pth->tf));
  pth->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  pth->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  pth->tf->es = pth->tf->ds;
  pth->tf->ss = pth->tf->ds;
  pth->tf->eflags = FL_IF;
  pth->tf->esp = PGSIZE;
  pth->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;
  pth->state = RUNNABLE;

  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  int i, pid;
  struct proc *np;
  struct pthread *npth;
  struct proc *curproc = myproc();
  struct pthread *curpth = mypth();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }
  npth = np->pth;

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(npth->kstack);
    npth->kstack = 0;
    np->kstacks[0] = 0;
    np->state = UNUSED;
    npth->state = UNUSED;
    return -1;
  }

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  // Copy user stack
  for(int i = 0; i < NPTH; i++)
  {
    np->ustacks[i] = curproc->ustacks[i];
  }

  // np의 0번째 thread(Main thread)로 ustack 이동
  uint temp = np->ustacks[curproc->onTidx];
  np->ustacks[curproc->onTidx] = np->ustacks[0];
  np->ustacks[0] = temp;
  np->onTidx = 0;
  npth->tidx = 0;

  np->sz = curproc->sz;
  np->parent = curproc;
  *npth->tf = *curpth->tf;

  // Clear %eax so that fork returns 0 in the child.
  npth->tf->eax = 0;


  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  acquire(&ptable.lock);

  np->state = RUNNABLE;
  npth->state = RUNNABLE;

  release(&ptable.lock);

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  struct pthread *pth;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  // todo: wake up thread or proc ?
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
  for(pth = curproc->pth; pth < &(curproc->pth[NPTH]); pth++)
  {
    if(pth->state == UNUSED)
      continue;
      
    pth->state = ZOMBIE;
  }
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  struct pthread *pth;
  int havekids, pid, i;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        
        for(pth = p->pth, i = 0; pth < &(p->pth[NPTH]); pth++, i++)
        {
          if(pth->kstack != 0)
          {
            kfree(pth->kstack);
            p->kstacks[i] = 0;
          }
          p->ustacks[i] = 0;
          pth->kstack = 0;
          pth->tid = 0;
          pth->state = UNUSED;
        }
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  struct pthread *pth;
  struct cpu *c = mycpu();
  int i;
  c->proc = 0;
  
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    struct proc *scheduled_proc = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;

      for(pth = p->pth, i = 0; pth < &(p->pth[NPTH]); pth++, i++)
      {
        if(pth->state != RUNNABLE)
          continue;

        pth->state = RUNNING;
        p->onTidx = i;

        // schedule되는 첫 proc거나 기존과 다른 proc가 schedule되는 경우
        if(scheduled_proc == 0 || p != scheduled_proc)
        {
          scheduled_proc = p;
          c->proc = p;
          switchuvm(p);
          p->state = RUNNING;
          swtch(&(c->scheduler), pth->context);
          switchkvm();
        }
        else    // 기존의 proc에서 thread scheduling
        {
          switchpth(p);
          swtch(&(c->scheduler), pth->context);
          switchkvm();
        }
      }
      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
  }
}


// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  // struct proc *p = myproc();
  struct pthread *pth = mypth();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  // if(p->state == RUNNING)
  //   panic("sched running");
  if(pth->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&pth->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  // myproc()->state = RUNNABLE;
  mypth()->state = RUNNABLE;
  myproc()->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  struct pthread *curpth = mypth();
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  curpth->chan = chan;
  curpth->state = SLEEPING;

  set_proc_state(p);

  sched();

  // Tidy up.
  curpth->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;
  struct pthread *pth;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if(p->state == SLEEPING || p->state == RUNNABLE || p->state == RUNNING)
    {
      for(pth = p->pth; pth < &(p->pth[NPTH]); pth++)
      {
        if(pth->state == SLEEPING && pth->chan == chan)
        {
          pth->state = RUNNABLE;
          if(p->state == SLEEPING)
            p->state = RUNNABLE;
        }
      }
    }
  }
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;
  struct pthread *pth;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      for(pth = p->pth; pth < &(p->pth[NPTH]); pth++)
      {
        if(pth->state == SLEEPING)
          pth->state = RUNNABLE;
      }
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  struct pthread *pth = mypth();
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(pth->state == SLEEPING)
    {
      getcallerpcs((uint*)pth->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    // cprintf("\n");
  }
}

// pj3

struct pthread*
mypth(void)
{
  struct proc* p;
  struct pthread* pth;

  pushcli();
  p = myproc();
  pth = &(p->pth[p->onTidx]);
  popcli();

  return pth;
}

// for exec()
void
init_allpth(struct proc* p, struct pthread *curpth)
{
  int i = 0;
  struct pthread *pth;

  acquire(&ptable.lock);
  for(pth = p->pth; pth < &(p->pth[NPTH]); pth++)
  {
    // initialize other thread(UNUSED)
    if(pth != curpth)
    {
      if(pth->kstack != 0 || p->kstacks[i] != 0)
      {
        kfree(p->kstacks[i]);
        p->kstacks[i] = 0;
        p->ustacks[i] = 0;
        pth->kstack = 0;
      }
      pth->state = UNUSED;
      pth->tid = 0;
    }
    i++;
  }
  release(&ptable.lock);
}

// return proc state
int
set_proc_state(struct proc *p)
{
  struct pthread *pth;
  int unused = 0, sleeping = 0, runnable = 0, running = 0, zombie = 0;
  for(pth = p->pth; pth < &(p->pth[NPTH]); pth++)
  {
    if(pth->state == RUNNING)
    {
      running = 1;
      break;
    }
    else if(pth->state == RUNNABLE)
      runnable++;
    else if(pth->state == SLEEPING)
      sleeping++;
    else if(pth->state == ZOMBIE)
      zombie++;
    else if(pth->state == UNUSED)
      unused++;
  }

  if(running)
  {
    p->state = RUNNING;
    return RUNNING;
  }
  else if(runnable)
  {
    p->state = RUNNABLE;
    return RUNNABLE;
  }
  else if(sleeping){
    p->state = SLEEPING;
    return SLEEPING;
  }
  else if(zombie){
    p->state = ZOMBIE;
    return ZOMBIE;
  }
  else{
    p->state = UNUSED;
    return UNUSED;
  }
}

static struct pthread*
allocpth(struct proc *p)
{
  int i;
  struct pthread *pth;
  char *sp;

  for(pth = p->pth, i = 0; pth < &(p->pth[NPTH]); pth++, i++)
    if(pth->state == UNUSED)
      goto found;
  
  return 0;

found:
  pth->state = EMBRYO;
  pth->tid = nextTid++;
  pth->tidx = i;

  if((pth->kstack = kalloc()) == 0)
  {
    pth->state = UNUSED;
    return 0;
  }
  p->kstacks[i] = pth->kstack;
  sp = pth->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *pth->tf;
  pth->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *pth->context;
  pth->context = (struct context*)sp;
  memset(pth->context, 0, sizeof *pth->context);

  pth->context->eip = (uint)forkret;

  return pth;
}

uint*
alloc_ustack(struct proc *p, int tidx)
{
  uint *ustack;
  uint sz;
  ustack = &(p->ustacks[tidx]);
  // 새로운 ustack 할당 => sz 증가
  if(*(ustack) == 0)
  {
    sz = PGROUNDUP(p->sz);
    if((sz = allocuvm(p->pgdir, sz, sz + PGSIZE)) == 0)
      return 0;

    *ustack = sz;
    p->sz = sz;
  }

  // 이미 할당된 ustack이 존재 => sz 유지
  // do notthing

  return ustack;
}


int
thread_create(thread_t *thread, void*(*start_routine)(void *), void *arg)
{
  int tidx;
  struct pthread *npth;
  struct proc *curproc = myproc();
  struct pthread *curpth = mypth();
  uint sz, *ustack;
  char *sp;

  acquire(&ptable.lock);

  // 1. create new pth
  if((npth = allocpth(curproc)) == 0)
    goto bad;

  *npth->tf = *curpth->tf;
  
  // save new thread id
  tidx = npth->tidx;

  // 2. set starting routine of the new pth
  if((ustack = alloc_ustack(curproc, tidx)) == 0)
    goto bad;

  sz = *(ustack);
  sp = (char*)sz;
  curproc->sz = sz;

  sp -= 4;
  *(uint*)sp = (uint)arg;

  sp -= 4;
  *(uint*)sp = (uint)thread_exit;
  

  npth->tf->esp = (uint)sp;
  npth->tf->eip = (uint)start_routine;

  *thread = npth->tid;

  // intialize state & return value 
  npth->state = RUNNABLE;
  npth->retval = 0;
  release(&ptable.lock);
  return 0;
  
bad:
  npth->kstack = 0;
  curproc->kstacks[tidx] = 0;
  npth->state = UNUSED;
  npth->tid = 0;
  if(ustack)
    *ustack = 0;
  release(&ptable.lock);
  return -1;
}

void
thread_exit(void *retval)
{
  struct pthread *pth = mypth();

  acquire(&ptable.lock);


  pth->retval = retval;

  // wakeup join
  wakeup1((void*)pth->tid);

  pth->state = ZOMBIE;
  set_proc_state(myproc());

  sched();
  panic("thread zombie exit\n");
}

int
thread_join(thread_t thread, void **retval)
{
  struct proc *p;
  struct pthread *pth = 0;
  int havepth, check_zombie;

  acquire(&ptable.lock);

  havepth = 0;
  for(;;)
  {
    check_zombie = 1;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    {
      for(pth = p->pth; pth < &(p->pth[NPTH]); pth++)
      {
        if(pth->tid == thread)
        {
          havepth = 1;
          if(pth->state == ZOMBIE)
          {
            check_zombie = 1;
            pth->kstack = 0;
            pth->state = UNUSED;
            pth->tid = 0;

            *retval = pth->retval;
            pth->retval = 0;

            release(&ptable.lock);
            return 0;
          }
          else
          {
            check_zombie = 0;
            break;
          }
        }
      }
      if(!check_zombie)
        break;
    }

    if(!havepth)
    {
      release(&ptable.lock);
      return -1;
    }

    sleep((void*)thread, &ptable.lock);
  }
}