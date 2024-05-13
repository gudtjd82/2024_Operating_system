#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "traps.h"
#include "spinlock.h"

// Interrupt descriptor table (shared by all CPUs).
struct gatedesc idt[256];
extern uint vectors[];  // in vectors.S: array of 256 entry pointers
struct spinlock tickslock;
uint ticks;

// pj2
struct spinlock gticklock;
uint global_tick = 0;

void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  // lab03
  SETGATE(idt[128], 1, SEG_KCODE<<3, vectors[128], DPL_USER);

  initlock(&tickslock, "time");
  // pj2
  initlock(&gticklock, "gtime");
}

void
idtinit(void)
{
  lidt(idt, sizeof(idt));
}

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  // lab03
  case 128:
    cprintf("user interrupt 128 called!\n");
    exit();
    break;
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
      wakeup(&ticks);
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
    break;
  
  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
     tf->trapno == T_IRQ0+IRQ_TIMER)
  {
    // pj2
    myproc()->tick++;
    global_tick++;

    if(!get_MoQ_active())  //MoQ 비활성화 상태
    {
      if(global_tick >= 100)
      {
        global_tick = 0;
        priority_boost();
      }

      if(myproc()->qlev != MoQ && myproc()->tick >= (myproc()->qlev *2 + 2))
      {
        if(myproc()->qlev == L0)
        {
          if(myproc()->pid % 2 != 0)  // L0 -> L1
          {
            myproc()->qlev = L1;
            myproc()->seq = get_LevCnt(1);
            inc_LevCnt(1);
            myproc()->tick = 0;
          }
          else  // L0 -> L2
          {
            myproc()->qlev = L2;
            myproc()->seq = get_LevCnt(2);
            inc_LevCnt(2);
            myproc()->tick = 0;
          }
        }
        else if(myproc()->qlev == L1 || myproc()->qlev == L2) // L1 -> L3 Or L2 -> L3
        {
          myproc()->qlev = L3;
          myproc()->seq = get_LevCnt(3);
          inc_LevCnt(3);
          myproc()->tick = 0;
        }
        else if(myproc()->qlev == L3) // L3 -> L3
        {
          if(myproc()->priority > 0)
            myproc()->priority--;
          myproc()->tick = 0;
        }

        yield();
      }
    }
  }

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}

// pj2
void
reset_global_tick(void)
{
  acquire(&gticklock);
  global_tick = 0;
  release(&gticklock);
}
