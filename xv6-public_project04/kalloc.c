// Physical memory allocator, intended to allocate
// memory for user processes, kernel stacks, page table pages,
// and pipe buffers. Allocates 4096-byte pages.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "spinlock.h"

// pj4
#define P2PG(pa) ((uint)(pa) >> 12)     // page size = 2^12 bytes

void freerange(void *vstart, void *vend);
extern char end[]; // first address after kernel loaded from ELF file
                   // defined by the kernel linker script in kernel.ld

struct run {
  struct run *next;
};

struct {
  struct spinlock lock;
  int use_lock;
  struct run *freelist;
} kmem;

// pj4
struct{
  int pgRef[P2PG(PHYSTOP)];   // the num of pages = 2^20 = 1048576       
  int use_lock;
  struct spinlock lock;
} pgRef;

// Initialization happens in two phases.
// 1. main() calls kinit1() while still using entrypgdir to place just
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  // pj4
  initlock(&pgRef.lock, "pgRef");
  pgRef.use_lock = 0;
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
  // pj4
  pgRef.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
  {
    // pj4
    // pg reference 초기화
    pgRef.pgRef[P2PG(p)] = 0;
    kfree(p);
  }
}
//PAGEBREAK: 21
// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
// pj4 (CoW): page의 reference가 0이 되는 경우에만 free
void
kfree(char *v)
{
  struct run *r;
  uint pa;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");

  if(kmem.use_lock)
    acquire(&kmem.lock);

  pa = V2P(v);
  if(get_refc(pa) < 0)
    panic("kfree: page reference");
  else if(get_refc(pa) > 0)
    decr_refc(pa);

  if(get_refc(pa) == 0)
  {
    // Fill with junk to catch dangling refs.
    memset(v, 1, PGSIZE);
   
    r = (struct run*)v;
    r->next = kmem.freelist;
    kmem.freelist = r;
  }
  if(kmem.use_lock)
    release(&kmem.lock);
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
  struct run *r;
  uint pa;

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = kmem.freelist;
  if(r)
    kmem.freelist = r->next;
  
  // pj4
  pa = V2P((char *)r);
  if(get_refc(pa) == 0)
    incr_refc(pa);
  else
    panic("kalloc: not freelist");

  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}

// pj4

void
incr_refc(uint pa)
{
  if(pgRef.use_lock)
    acquire(&pgRef.lock);

  pgRef.pgRef[P2PG(pa)]++;

  if(pgRef.use_lock)
    release(&pgRef.lock);
}

void
decr_refc(uint pa)
{
  if(pgRef.use_lock)
    acquire(&pgRef.lock);
  
  if(pgRef.pgRef[P2PG(pa)] == 0)
    panic("can't decrease pgRef");

  pgRef.pgRef[P2PG(pa)]--;

  if(pgRef.use_lock)
    release(&pgRef.lock);
}

int
get_refc(uint pa)
{
  return pgRef.pgRef[P2PG(pa)];
}

// return the num of total free page in the system
int
countfp(void)
{
  struct run *r;
  int cnt = 0;

  if(kmem.use_lock)
    acquire(&kmem.lock);

  r = kmem.freelist;
  while (r)
  {
    cnt++;
    r = r->next;
  }
  
  if(kmem.use_lock)
    release(&kmem.lock);
  
  return cnt;
}