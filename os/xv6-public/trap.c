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
uint boostCh; //전체 tick을 세는 변수

void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
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
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER){
    cprintf("pid : %d process is killed", myproc()->pid);
    exit();
  }

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
     tf->trapno == T_IRQ0+IRQ_TIMER){
     
#ifdef MULTILEVEL_SCHED
  myproc()->tick++;
  if(myproc()->pid % 2 != 0) //odd
      preemption();
  else //even
      yield();


#elif MLFQ_SCHED
      myproc()->tick++;
      boostCh++; //전체 tick을 세는 변수 
      priorCheck(myproc()); //각 큐에서 현재 프로세스보다 더 높은 우선순위를 가진 프로세스가 있는 경우 yield()시킴

      if(boostCh >= 100){     //boostCh이 100이 될 경우 tick,lev,prior_num을 0으로 초기화 하고 다른 프로세스로 바꿔준다.
        boostCh = 0;     //초기화
        boost();     //모든 프로세스들을 lev,tick을 초기화 시키는 함수
      }

      if(myproc()->myLev == 0 && myproc()->tick >= 4){     //L0큐이고 tick이 4가 됬을 때
        myproc()->tick = 0;     //실행 시간 tick 초기화
        myproc()->myLev++;     //L1큐로 옮겨줌
        yield();     //다른프로세스 실행
      }

      if(myproc()->myLev == 1 && myproc()->tick >= 6 && MLFQ_K > 1){     //L1큐이고 tick이 6이 됬을 때
        myproc()->tick = 0;     //실행 시간 tick 초기화
        myproc()->myLev++;     //L2큐로 옮겨줌
        yield();    //다른 프로세스 실행
      }

      if(myproc()->myLev == 2 && myproc()->tick >= 8 && MLFQ_K > 2){     //L2큐이고 tick이 8이 됬을 때
        myproc()->tick = 0;     //실행 시간 tick 초기화
        myproc()->myLev++;     //L3큐로 옮겨줌
        yield();     //다른프로세스 실행
      }

      if(myproc()->myLev == 3 && myproc()->tick >= 10 && MLFQ_K > 3){     //L3큐이고 tick이 10이 됬을 때
        myproc()->tick = 0;     //실행 시간 tick 초기화
        myproc()->myLev++;     //L4큐로 옮겨줌
        yield();    //다른 프로세스 실행
      }

      if(myproc()->myLev == 4 && myproc()->tick >= 12 && MLFQ_K > 4){     //L4큐이고 tick이 12가 됬을 때
        myproc()->tick = 0;     //실행 시간 tick 초기화
	myproc()->myLev++;
        yield();    //다른 프로세스 실행
      }

      if(myproc()->myLev == MLFQ_K){ //스케줄링될 수 있는 프로세스가 존재하지 않는 경우에도 곧바로 priority boosting을 수행
        boostCh = 0;     //초기화
        boost();     //모든 프로세스들을 lev,tick을 초기화 시키는 함수
      }

#endif

  }

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();

}
