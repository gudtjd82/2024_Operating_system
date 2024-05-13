#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

// return  grandparent pid
int
sys_getgpid(void)
{
    struct proc *gp;
    gp = myproc()->parent->parent;
    return gp->pid;
}

// pj2
int
sys_yield(void)
{
  yield();
  return 0;
}

int
sys_getlev(void)
{
  return getlev();
}

int sys_setpriority(void)
{
  int pid, priority;

  if(argint(0, &pid) < 0)
    return -3;

  if(argint(1, &priority) < 0)
    return -4;
  
  return setpriority(pid, priority);
}

int 
sys_setmonopoly(void)
{
  int pid, password;

  if(argint(0, &pid) < 0)
    return -5;

  if(argint(1, &password) < 0)
    return -6;

  return setmonopoly(pid, password);
}

int
sys_monopolize(void)
{
  monopolize();
  return 0;
}

int
sys_unmonopolize(void)
{
  unmonopolize();
  return 0;
}