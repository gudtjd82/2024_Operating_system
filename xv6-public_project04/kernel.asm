
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 54 11 80       	mov    $0x801154d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 74 2c 10 80       	mov    $0x80102c74,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	53                   	push   %ebx
80100038:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003b:	68 a0 68 10 80       	push   $0x801068a0
80100040:	68 20 a5 10 80       	push   $0x8010a520
80100045:	e8 0a 3e 00 00       	call   80103e54 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004a:	c7 05 6c ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec6c
80100051:	ec 10 80 
  bcache.head.next = &bcache.head;
80100054:	c7 05 70 ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec70
8010005b:	ec 10 80 
8010005e:	83 c4 10             	add    $0x10,%esp
80100061:	b8 1c ec 10 80       	mov    $0x8010ec1c,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100066:	bb 54 a5 10 80       	mov    $0x8010a554,%ebx
8010006b:	eb 05                	jmp    80100072 <binit+0x3e>
8010006d:	8d 76 00             	lea    0x0(%esi),%esi
80100070:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100072:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
80100075:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
8010007c:	83 ec 08             	sub    $0x8,%esp
8010007f:	68 a7 68 10 80       	push   $0x801068a7
80100084:	8d 43 0c             	lea    0xc(%ebx),%eax
80100087:	50                   	push   %eax
80100088:	e8 bb 3c 00 00       	call   80103d48 <initsleeplock>
    bcache.head.next->prev = b;
8010008d:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
80100092:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100095:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009b:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a1:	89 d8                	mov    %ebx,%eax
801000a3:	83 c4 10             	add    $0x10,%esp
801000a6:	81 fb c0 e9 10 80    	cmp    $0x8010e9c0,%ebx
801000ac:	75 c2                	jne    80100070 <binit+0x3c>
  }
}
801000ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000b1:	c9                   	leave
801000b2:	c3                   	ret
801000b3:	90                   	nop

801000b4 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000b4:	55                   	push   %ebp
801000b5:	89 e5                	mov    %esp,%ebp
801000b7:	57                   	push   %edi
801000b8:	56                   	push   %esi
801000b9:	53                   	push   %ebx
801000ba:	83 ec 18             	sub    $0x18,%esp
801000bd:	8b 75 08             	mov    0x8(%ebp),%esi
801000c0:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000c3:	68 20 a5 10 80       	push   $0x8010a520
801000c8:	e8 5f 3f 00 00       	call   8010402c <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000cd:	8b 1d 70 ec 10 80    	mov    0x8010ec70,%ebx
801000d3:	83 c4 10             	add    $0x10,%esp
801000d6:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
801000dc:	75 0d                	jne    801000eb <bread+0x37>
801000de:	eb 1c                	jmp    801000fc <bread+0x48>
801000e0:	8b 5b 54             	mov    0x54(%ebx),%ebx
801000e3:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
801000e9:	74 11                	je     801000fc <bread+0x48>
    if(b->dev == dev && b->blockno == blockno){
801000eb:	3b 73 04             	cmp    0x4(%ebx),%esi
801000ee:	75 f0                	jne    801000e0 <bread+0x2c>
801000f0:	3b 7b 08             	cmp    0x8(%ebx),%edi
801000f3:	75 eb                	jne    801000e0 <bread+0x2c>
      b->refcnt++;
801000f5:	ff 43 4c             	incl   0x4c(%ebx)
      release(&bcache.lock);
801000f8:	eb 3c                	jmp    80100136 <bread+0x82>
801000fa:	66 90                	xchg   %ax,%ax
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
801000fc:	8b 1d 6c ec 10 80    	mov    0x8010ec6c,%ebx
80100102:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
80100108:	75 0d                	jne    80100117 <bread+0x63>
8010010a:	eb 6a                	jmp    80100176 <bread+0xc2>
8010010c:	8b 5b 50             	mov    0x50(%ebx),%ebx
8010010f:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
80100115:	74 5f                	je     80100176 <bread+0xc2>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
80100117:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010011a:	85 c0                	test   %eax,%eax
8010011c:	75 ee                	jne    8010010c <bread+0x58>
8010011e:	f6 03 04             	testb  $0x4,(%ebx)
80100121:	75 e9                	jne    8010010c <bread+0x58>
      b->dev = dev;
80100123:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
80100126:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
80100129:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
8010012f:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100136:	83 ec 0c             	sub    $0xc,%esp
80100139:	68 20 a5 10 80       	push   $0x8010a520
8010013e:	e8 89 3e 00 00       	call   80103fcc <release>
      acquiresleep(&b->lock);
80100143:	8d 43 0c             	lea    0xc(%ebx),%eax
80100146:	89 04 24             	mov    %eax,(%esp)
80100149:	e8 2e 3c 00 00       	call   80103d7c <acquiresleep>
      return b;
8010014e:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100151:	f6 03 02             	testb  $0x2,(%ebx)
80100154:	74 0a                	je     80100160 <bread+0xac>
    iderw(b);
  }
  return b;
}
80100156:	89 d8                	mov    %ebx,%eax
80100158:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010015b:	5b                   	pop    %ebx
8010015c:	5e                   	pop    %esi
8010015d:	5f                   	pop    %edi
8010015e:	5d                   	pop    %ebp
8010015f:	c3                   	ret
    iderw(b);
80100160:	83 ec 0c             	sub    $0xc,%esp
80100163:	53                   	push   %ebx
80100164:	e8 a7 1e 00 00       	call   80102010 <iderw>
80100169:	83 c4 10             	add    $0x10,%esp
}
8010016c:	89 d8                	mov    %ebx,%eax
8010016e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100171:	5b                   	pop    %ebx
80100172:	5e                   	pop    %esi
80100173:	5f                   	pop    %edi
80100174:	5d                   	pop    %ebp
80100175:	c3                   	ret
  panic("bget: no buffers");
80100176:	83 ec 0c             	sub    $0xc,%esp
80100179:	68 ae 68 10 80       	push   $0x801068ae
8010017e:	e8 b5 01 00 00       	call   80100338 <panic>
80100183:	90                   	nop

80100184 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
80100184:	55                   	push   %ebp
80100185:	89 e5                	mov    %esp,%ebp
80100187:	53                   	push   %ebx
80100188:	83 ec 10             	sub    $0x10,%esp
8010018b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
8010018e:	8d 43 0c             	lea    0xc(%ebx),%eax
80100191:	50                   	push   %eax
80100192:	e8 75 3c 00 00       	call   80103e0c <holdingsleep>
80100197:	83 c4 10             	add    $0x10,%esp
8010019a:	85 c0                	test   %eax,%eax
8010019c:	74 0f                	je     801001ad <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
8010019e:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001a1:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001a7:	c9                   	leave
  iderw(b);
801001a8:	e9 63 1e 00 00       	jmp    80102010 <iderw>
    panic("bwrite");
801001ad:	83 ec 0c             	sub    $0xc,%esp
801001b0:	68 bf 68 10 80       	push   $0x801068bf
801001b5:	e8 7e 01 00 00       	call   80100338 <panic>
801001ba:	66 90                	xchg   %ax,%ax

801001bc <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001bc:	55                   	push   %ebp
801001bd:	89 e5                	mov    %esp,%ebp
801001bf:	56                   	push   %esi
801001c0:	53                   	push   %ebx
801001c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001c4:	8d 73 0c             	lea    0xc(%ebx),%esi
801001c7:	83 ec 0c             	sub    $0xc,%esp
801001ca:	56                   	push   %esi
801001cb:	e8 3c 3c 00 00       	call   80103e0c <holdingsleep>
801001d0:	83 c4 10             	add    $0x10,%esp
801001d3:	85 c0                	test   %eax,%eax
801001d5:	74 61                	je     80100238 <brelse+0x7c>
    panic("brelse");

  releasesleep(&b->lock);
801001d7:	83 ec 0c             	sub    $0xc,%esp
801001da:	56                   	push   %esi
801001db:	e8 f0 3b 00 00       	call   80103dd0 <releasesleep>

  acquire(&bcache.lock);
801001e0:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801001e7:	e8 40 3e 00 00       	call   8010402c <acquire>
  b->refcnt--;
801001ec:	8b 43 4c             	mov    0x4c(%ebx),%eax
801001ef:	48                   	dec    %eax
801001f0:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
801001f3:	83 c4 10             	add    $0x10,%esp
801001f6:	85 c0                	test   %eax,%eax
801001f8:	75 2c                	jne    80100226 <brelse+0x6a>
    // no one is waiting for it.
    b->next->prev = b->prev;
801001fa:	8b 53 54             	mov    0x54(%ebx),%edx
801001fd:	8b 43 50             	mov    0x50(%ebx),%eax
80100200:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
80100203:	8b 53 54             	mov    0x54(%ebx),%edx
80100206:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100209:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
8010020e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
80100211:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    bcache.head.next->prev = b;
80100218:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
8010021d:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100220:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  }
  
  release(&bcache.lock);
80100226:	c7 45 08 20 a5 10 80 	movl   $0x8010a520,0x8(%ebp)
}
8010022d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100230:	5b                   	pop    %ebx
80100231:	5e                   	pop    %esi
80100232:	5d                   	pop    %ebp
  release(&bcache.lock);
80100233:	e9 94 3d 00 00       	jmp    80103fcc <release>
    panic("brelse");
80100238:	83 ec 0c             	sub    $0xc,%esp
8010023b:	68 c6 68 10 80       	push   $0x801068c6
80100240:	e8 f3 00 00 00       	call   80100338 <panic>
80100245:	66 90                	xchg   %ax,%ax
80100247:	90                   	nop

80100248 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100248:	55                   	push   %ebp
80100249:	89 e5                	mov    %esp,%ebp
8010024b:	57                   	push   %edi
8010024c:	56                   	push   %esi
8010024d:	53                   	push   %ebx
8010024e:	83 ec 18             	sub    $0x18,%esp
80100251:	8b 7d 08             	mov    0x8(%ebp),%edi
80100254:	8b 5d 10             	mov    0x10(%ebp),%ebx
  uint target;
  int c;

  iunlock(ip);
80100257:	57                   	push   %edi
80100258:	e8 47 14 00 00       	call   801016a4 <iunlock>
  target = n;
8010025d:	89 de                	mov    %ebx,%esi
  acquire(&cons.lock);
8010025f:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
80100266:	e8 c1 3d 00 00       	call   8010402c <acquire>
  while(n > 0){
8010026b:	83 c4 10             	add    $0x10,%esp
8010026e:	85 db                	test   %ebx,%ebx
80100270:	0f 8e 93 00 00 00    	jle    80100309 <consoleread+0xc1>
    while(input.r == input.w){
80100276:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
8010027b:	39 05 04 ef 10 80    	cmp    %eax,0x8010ef04
80100281:	74 27                	je     801002aa <consoleread+0x62>
80100283:	eb 57                	jmp    801002dc <consoleread+0x94>
80100285:	8d 76 00             	lea    0x0(%esi),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
80100288:	83 ec 08             	sub    $0x8,%esp
8010028b:	68 20 ef 10 80       	push   $0x8010ef20
80100290:	68 00 ef 10 80       	push   $0x8010ef00
80100295:	e8 76 38 00 00       	call   80103b10 <sleep>
    while(input.r == input.w){
8010029a:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
8010029f:	83 c4 10             	add    $0x10,%esp
801002a2:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
801002a8:	75 32                	jne    801002dc <consoleread+0x94>
      if(myproc()->killed){
801002aa:	e8 59 32 00 00       	call   80103508 <myproc>
801002af:	8b 40 24             	mov    0x24(%eax),%eax
801002b2:	85 c0                	test   %eax,%eax
801002b4:	74 d2                	je     80100288 <consoleread+0x40>
        release(&cons.lock);
801002b6:	83 ec 0c             	sub    $0xc,%esp
801002b9:	68 20 ef 10 80       	push   $0x8010ef20
801002be:	e8 09 3d 00 00       	call   80103fcc <release>
        ilock(ip);
801002c3:	89 3c 24             	mov    %edi,(%esp)
801002c6:	e8 11 13 00 00       	call   801015dc <ilock>
        return -1;
801002cb:	83 c4 10             	add    $0x10,%esp
801002ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002d6:	5b                   	pop    %ebx
801002d7:	5e                   	pop    %esi
801002d8:	5f                   	pop    %edi
801002d9:	5d                   	pop    %ebp
801002da:	c3                   	ret
801002db:	90                   	nop
    c = input.buf[input.r++ % INPUT_BUF];
801002dc:	8d 50 01             	lea    0x1(%eax),%edx
801002df:	89 15 00 ef 10 80    	mov    %edx,0x8010ef00
801002e5:	89 c2                	mov    %eax,%edx
801002e7:	83 e2 7f             	and    $0x7f,%edx
801002ea:	0f be 8a 80 ee 10 80 	movsbl -0x7fef1180(%edx),%ecx
    if(c == C('D')){  // EOF
801002f1:	80 f9 04             	cmp    $0x4,%cl
801002f4:	74 37                	je     8010032d <consoleread+0xe5>
    *dst++ = c;
801002f6:	ff 45 0c             	incl   0xc(%ebp)
801002f9:	8b 45 0c             	mov    0xc(%ebp),%eax
801002fc:	88 48 ff             	mov    %cl,-0x1(%eax)
    --n;
801002ff:	4b                   	dec    %ebx
    if(c == '\n')
80100300:	83 f9 0a             	cmp    $0xa,%ecx
80100303:	0f 85 65 ff ff ff    	jne    8010026e <consoleread+0x26>
  release(&cons.lock);
80100309:	83 ec 0c             	sub    $0xc,%esp
8010030c:	68 20 ef 10 80       	push   $0x8010ef20
80100311:	e8 b6 3c 00 00       	call   80103fcc <release>
  ilock(ip);
80100316:	89 3c 24             	mov    %edi,(%esp)
80100319:	e8 be 12 00 00       	call   801015dc <ilock>
  return target - n;
8010031e:	89 f0                	mov    %esi,%eax
80100320:	29 d8                	sub    %ebx,%eax
80100322:	83 c4 10             	add    $0x10,%esp
}
80100325:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100328:	5b                   	pop    %ebx
80100329:	5e                   	pop    %esi
8010032a:	5f                   	pop    %edi
8010032b:	5d                   	pop    %ebp
8010032c:	c3                   	ret
      if(n < target){
8010032d:	39 f3                	cmp    %esi,%ebx
8010032f:	73 d8                	jae    80100309 <consoleread+0xc1>
        input.r--;
80100331:	a3 00 ef 10 80       	mov    %eax,0x8010ef00
80100336:	eb d1                	jmp    80100309 <consoleread+0xc1>

80100338 <panic>:
{
80100338:	55                   	push   %ebp
80100339:	89 e5                	mov    %esp,%ebp
8010033b:	56                   	push   %esi
8010033c:	53                   	push   %ebx
8010033d:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100340:	fa                   	cli
  cons.locking = 0;
80100341:	c7 05 54 ef 10 80 00 	movl   $0x0,0x8010ef54
80100348:	00 00 00 
  cprintf("lapicid %d: panic: ", lapicid());
8010034b:	e8 90 22 00 00       	call   801025e0 <lapicid>
80100350:	83 ec 08             	sub    $0x8,%esp
80100353:	50                   	push   %eax
80100354:	68 cd 68 10 80       	push   $0x801068cd
80100359:	e8 ca 02 00 00       	call   80100628 <cprintf>
  cprintf(s);
8010035e:	58                   	pop    %eax
8010035f:	ff 75 08             	push   0x8(%ebp)
80100362:	e8 c1 02 00 00       	call   80100628 <cprintf>
  cprintf("\n");
80100367:	c7 04 24 9e 6c 10 80 	movl   $0x80106c9e,(%esp)
8010036e:	e8 b5 02 00 00       	call   80100628 <cprintf>
  getcallerpcs(&s, pcs);
80100373:	5a                   	pop    %edx
80100374:	59                   	pop    %ecx
80100375:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100378:	53                   	push   %ebx
80100379:	8d 45 08             	lea    0x8(%ebp),%eax
8010037c:	50                   	push   %eax
8010037d:	e8 ee 3a 00 00       	call   80103e70 <getcallerpcs>
  for(i=0; i<10; i++)
80100382:	8d 75 f8             	lea    -0x8(%ebp),%esi
80100385:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
80100388:	83 ec 08             	sub    $0x8,%esp
8010038b:	ff 33                	push   (%ebx)
8010038d:	68 e1 68 10 80       	push   $0x801068e1
80100392:	e8 91 02 00 00       	call   80100628 <cprintf>
  for(i=0; i<10; i++)
80100397:	83 c3 04             	add    $0x4,%ebx
8010039a:	83 c4 10             	add    $0x10,%esp
8010039d:	39 f3                	cmp    %esi,%ebx
8010039f:	75 e7                	jne    80100388 <panic+0x50>
  panicked = 1; // freeze other CPU
801003a1:	c7 05 58 ef 10 80 01 	movl   $0x1,0x8010ef58
801003a8:	00 00 00 
  for(;;)
801003ab:	eb fe                	jmp    801003ab <panic+0x73>
801003ad:	8d 76 00             	lea    0x0(%esi),%esi

801003b0 <consputc.part.0>:
consputc(int c)
801003b0:	55                   	push   %ebp
801003b1:	89 e5                	mov    %esp,%ebp
801003b3:	57                   	push   %edi
801003b4:	56                   	push   %esi
801003b5:	53                   	push   %ebx
801003b6:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
801003b9:	3d 00 01 00 00       	cmp    $0x100,%eax
801003be:	0f 84 b4 00 00 00    	je     80100478 <consputc.part.0+0xc8>
801003c4:	89 c6                	mov    %eax,%esi
    uartputc(c);
801003c6:	83 ec 0c             	sub    $0xc,%esp
801003c9:	50                   	push   %eax
801003ca:	e8 01 51 00 00       	call   801054d0 <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003cf:	bf d4 03 00 00       	mov    $0x3d4,%edi
801003d4:	b0 0e                	mov    $0xe,%al
801003d6:	89 fa                	mov    %edi,%edx
801003d8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003d9:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801003de:	89 ca                	mov    %ecx,%edx
801003e0:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
801003e1:	0f b6 d8             	movzbl %al,%ebx
801003e4:	c1 e3 08             	shl    $0x8,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003e7:	b0 0f                	mov    $0xf,%al
801003e9:	89 fa                	mov    %edi,%edx
801003eb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003ec:	89 ca                	mov    %ecx,%edx
801003ee:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
801003ef:	0f b6 c8             	movzbl %al,%ecx
801003f2:	09 d9                	or     %ebx,%ecx
  if(c == '\n')
801003f4:	83 c4 10             	add    $0x10,%esp
801003f7:	83 fe 0a             	cmp    $0xa,%esi
801003fa:	75 64                	jne    80100460 <consputc.part.0+0xb0>
    pos += 80 - pos%80;
801003fc:	bb 50 00 00 00       	mov    $0x50,%ebx
80100401:	89 c8                	mov    %ecx,%eax
80100403:	99                   	cltd
80100404:	f7 fb                	idiv   %ebx
80100406:	29 d3                	sub    %edx,%ebx
80100408:	01 cb                	add    %ecx,%ebx
  if(pos < 0 || pos > 25*80)
8010040a:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
80100410:	0f 8f 0e 01 00 00    	jg     80100524 <consputc.part.0+0x174>
  if((pos/80) >= 24){  // Scroll up.
80100416:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
8010041c:	0f 8f aa 00 00 00    	jg     801004cc <consputc.part.0+0x11c>
  outb(CRTPORT+1, pos>>8);
80100422:	0f b6 c7             	movzbl %bh,%eax
80100425:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  outb(CRTPORT+1, pos);
80100428:	88 d9                	mov    %bl,%cl
  crt[pos] = ' ' | 0x0700;
8010042a:	01 db                	add    %ebx,%ebx
8010042c:	8d bb 00 80 0b 80    	lea    -0x7ff48000(%ebx),%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100432:	be d4 03 00 00       	mov    $0x3d4,%esi
80100437:	b0 0e                	mov    $0xe,%al
80100439:	89 f2                	mov    %esi,%edx
8010043b:	ee                   	out    %al,(%dx)
8010043c:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100441:	8a 45 e4             	mov    -0x1c(%ebp),%al
80100444:	89 da                	mov    %ebx,%edx
80100446:	ee                   	out    %al,(%dx)
80100447:	b0 0f                	mov    $0xf,%al
80100449:	89 f2                	mov    %esi,%edx
8010044b:	ee                   	out    %al,(%dx)
8010044c:	88 c8                	mov    %cl,%al
8010044e:	89 da                	mov    %ebx,%edx
80100450:	ee                   	out    %al,(%dx)
80100451:	66 c7 07 20 07       	movw   $0x720,(%edi)
}
80100456:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100459:	5b                   	pop    %ebx
8010045a:	5e                   	pop    %esi
8010045b:	5f                   	pop    %edi
8010045c:	5d                   	pop    %ebp
8010045d:	c3                   	ret
8010045e:	66 90                	xchg   %ax,%ax
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100460:	8d 59 01             	lea    0x1(%ecx),%ebx
80100463:	89 f0                	mov    %esi,%eax
80100465:	0f b6 f0             	movzbl %al,%esi
80100468:	81 ce 00 07 00 00    	or     $0x700,%esi
8010046e:	66 89 b4 09 00 80 0b 	mov    %si,-0x7ff48000(%ecx,%ecx,1)
80100475:	80 
80100476:	eb 92                	jmp    8010040a <consputc.part.0+0x5a>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100478:	83 ec 0c             	sub    $0xc,%esp
8010047b:	6a 08                	push   $0x8
8010047d:	e8 4e 50 00 00       	call   801054d0 <uartputc>
80100482:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100489:	e8 42 50 00 00       	call   801054d0 <uartputc>
8010048e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100495:	e8 36 50 00 00       	call   801054d0 <uartputc>
8010049a:	be d4 03 00 00       	mov    $0x3d4,%esi
8010049f:	b0 0e                	mov    $0xe,%al
801004a1:	89 f2                	mov    %esi,%edx
801004a3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801004a4:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801004a9:	89 da                	mov    %ebx,%edx
801004ab:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
801004ac:	0f b6 c8             	movzbl %al,%ecx
801004af:	c1 e1 08             	shl    $0x8,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004b2:	b0 0f                	mov    $0xf,%al
801004b4:	89 f2                	mov    %esi,%edx
801004b6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801004b7:	89 da                	mov    %ebx,%edx
801004b9:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
801004ba:	0f b6 d8             	movzbl %al,%ebx
    if(pos > 0) --pos;
801004bd:	83 c4 10             	add    $0x10,%esp
801004c0:	09 cb                	or     %ecx,%ebx
801004c2:	74 50                	je     80100514 <consputc.part.0+0x164>
801004c4:	4b                   	dec    %ebx
801004c5:	e9 40 ff ff ff       	jmp    8010040a <consputc.part.0+0x5a>
801004ca:	66 90                	xchg   %ax,%ax
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004cc:	50                   	push   %eax
801004cd:	68 60 0e 00 00       	push   $0xe60
801004d2:	68 a0 80 0b 80       	push   $0x800b80a0
801004d7:	68 00 80 0b 80       	push   $0x800b8000
801004dc:	e8 a3 3c 00 00       	call   80104184 <memmove>
    pos -= 80;
801004e1:	8d 73 b0             	lea    -0x50(%ebx),%esi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004e4:	8d 84 1b 60 ff ff ff 	lea    -0xa0(%ebx,%ebx,1),%eax
801004eb:	8d b8 00 80 0b 80    	lea    -0x7ff48000(%eax),%edi
801004f1:	83 c4 0c             	add    $0xc,%esp
801004f4:	b8 80 07 00 00       	mov    $0x780,%eax
801004f9:	29 f0                	sub    %esi,%eax
801004fb:	01 c0                	add    %eax,%eax
801004fd:	50                   	push   %eax
801004fe:	6a 00                	push   $0x0
80100500:	57                   	push   %edi
80100501:	e8 02 3c 00 00       	call   80104108 <memset>
  outb(CRTPORT+1, pos);
80100506:	89 f1                	mov    %esi,%ecx
80100508:	83 c4 10             	add    $0x10,%esp
8010050b:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
8010050f:	e9 1e ff ff ff       	jmp    80100432 <consputc.part.0+0x82>
80100514:	bf 00 80 0b 80       	mov    $0x800b8000,%edi
80100519:	31 c9                	xor    %ecx,%ecx
8010051b:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
8010051f:	e9 0e ff ff ff       	jmp    80100432 <consputc.part.0+0x82>
    panic("pos under/overflow");
80100524:	83 ec 0c             	sub    $0xc,%esp
80100527:	68 e5 68 10 80       	push   $0x801068e5
8010052c:	e8 07 fe ff ff       	call   80100338 <panic>
80100531:	8d 76 00             	lea    0x0(%esi),%esi

80100534 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100534:	55                   	push   %ebp
80100535:	89 e5                	mov    %esp,%ebp
80100537:	57                   	push   %edi
80100538:	56                   	push   %esi
80100539:	53                   	push   %ebx
8010053a:	83 ec 18             	sub    $0x18,%esp
8010053d:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
80100540:	ff 75 08             	push   0x8(%ebp)
80100543:	e8 5c 11 00 00       	call   801016a4 <iunlock>
  acquire(&cons.lock);
80100548:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
8010054f:	e8 d8 3a 00 00       	call   8010402c <acquire>
  for(i = 0; i < n; i++)
80100554:	83 c4 10             	add    $0x10,%esp
80100557:	85 f6                	test   %esi,%esi
80100559:	7e 23                	jle    8010057e <consolewrite+0x4a>
8010055b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010055e:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
    consputc(buf[i] & 0xff);
80100561:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
80100564:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
8010056a:	85 d2                	test   %edx,%edx
8010056c:	74 06                	je     80100574 <consolewrite+0x40>
  asm volatile("cli");
8010056e:	fa                   	cli
    for(;;)
8010056f:	eb fe                	jmp    8010056f <consolewrite+0x3b>
80100571:	8d 76 00             	lea    0x0(%esi),%esi
80100574:	e8 37 fe ff ff       	call   801003b0 <consputc.part.0>
  for(i = 0; i < n; i++)
80100579:	43                   	inc    %ebx
8010057a:	39 fb                	cmp    %edi,%ebx
8010057c:	75 e3                	jne    80100561 <consolewrite+0x2d>
  release(&cons.lock);
8010057e:	83 ec 0c             	sub    $0xc,%esp
80100581:	68 20 ef 10 80       	push   $0x8010ef20
80100586:	e8 41 3a 00 00       	call   80103fcc <release>
  ilock(ip);
8010058b:	58                   	pop    %eax
8010058c:	ff 75 08             	push   0x8(%ebp)
8010058f:	e8 48 10 00 00       	call   801015dc <ilock>

  return n;
}
80100594:	89 f0                	mov    %esi,%eax
80100596:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100599:	5b                   	pop    %ebx
8010059a:	5e                   	pop    %esi
8010059b:	5f                   	pop    %edi
8010059c:	5d                   	pop    %ebp
8010059d:	c3                   	ret
8010059e:	66 90                	xchg   %ax,%ax

801005a0 <printint>:
{
801005a0:	55                   	push   %ebp
801005a1:	89 e5                	mov    %esp,%ebp
801005a3:	57                   	push   %edi
801005a4:	56                   	push   %esi
801005a5:	53                   	push   %ebx
801005a6:	83 ec 2c             	sub    $0x2c,%esp
801005a9:	89 c6                	mov    %eax,%esi
801005ab:	89 d3                	mov    %edx,%ebx
  if(sign && (sign = xx < 0))
801005ad:	85 c9                	test   %ecx,%ecx
801005af:	74 04                	je     801005b5 <printint+0x15>
801005b1:	85 c0                	test   %eax,%eax
801005b3:	78 63                	js     80100618 <printint+0x78>
    x = xx;
801005b5:	89 f1                	mov    %esi,%ecx
801005b7:	31 c0                	xor    %eax,%eax
  i = 0;
801005b9:	31 f6                	xor    %esi,%esi
801005bb:	89 45 d0             	mov    %eax,-0x30(%ebp)
801005be:	66 90                	xchg   %ax,%ax
    buf[i++] = digits[x % base];
801005c0:	89 c8                	mov    %ecx,%eax
801005c2:	31 d2                	xor    %edx,%edx
801005c4:	f7 f3                	div    %ebx
801005c6:	89 f7                	mov    %esi,%edi
801005c8:	8d 76 01             	lea    0x1(%esi),%esi
801005cb:	8a 92 b0 6d 10 80    	mov    -0x7fef9250(%edx),%dl
801005d1:	88 55 d7             	mov    %dl,-0x29(%ebp)
801005d4:	88 54 3d d8          	mov    %dl,-0x28(%ebp,%edi,1)
  }while((x /= base) != 0);
801005d8:	89 ca                	mov    %ecx,%edx
801005da:	89 c1                	mov    %eax,%ecx
801005dc:	39 da                	cmp    %ebx,%edx
801005de:	73 e0                	jae    801005c0 <printint+0x20>
  if(sign)
801005e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
801005e3:	85 c0                	test   %eax,%eax
801005e5:	74 07                	je     801005ee <printint+0x4e>
    buf[i++] = '-';
801005e7:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
  while(--i >= 0)
801005ec:	89 f7                	mov    %esi,%edi
801005ee:	8d 75 d8             	lea    -0x28(%ebp),%esi
801005f1:	8d 5c 3d d8          	lea    -0x28(%ebp,%edi,1),%ebx
    consputc(buf[i]);
801005f5:	0f be 03             	movsbl (%ebx),%eax
  if(panicked){
801005f8:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
801005fe:	85 d2                	test   %edx,%edx
80100600:	74 06                	je     80100608 <printint+0x68>
80100602:	fa                   	cli
    for(;;)
80100603:	eb fe                	jmp    80100603 <printint+0x63>
80100605:	8d 76 00             	lea    0x0(%esi),%esi
80100608:	e8 a3 fd ff ff       	call   801003b0 <consputc.part.0>
  while(--i >= 0)
8010060d:	8d 43 ff             	lea    -0x1(%ebx),%eax
80100610:	39 f3                	cmp    %esi,%ebx
80100612:	74 0c                	je     80100620 <printint+0x80>
80100614:	89 c3                	mov    %eax,%ebx
80100616:	eb dd                	jmp    801005f5 <printint+0x55>
80100618:	89 c8                	mov    %ecx,%eax
    x = -xx;
8010061a:	f7 de                	neg    %esi
8010061c:	89 f1                	mov    %esi,%ecx
8010061e:	eb 99                	jmp    801005b9 <printint+0x19>
}
80100620:	83 c4 2c             	add    $0x2c,%esp
80100623:	5b                   	pop    %ebx
80100624:	5e                   	pop    %esi
80100625:	5f                   	pop    %edi
80100626:	5d                   	pop    %ebp
80100627:	c3                   	ret

80100628 <cprintf>:
{
80100628:	55                   	push   %ebp
80100629:	89 e5                	mov    %esp,%ebp
8010062b:	57                   	push   %edi
8010062c:	56                   	push   %esi
8010062d:	53                   	push   %ebx
8010062e:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100631:	8b 3d 54 ef 10 80    	mov    0x8010ef54,%edi
  if (fmt == 0)
80100637:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
8010063a:	85 ff                	test   %edi,%edi
8010063c:	0f 85 f6 00 00 00    	jne    80100738 <cprintf+0x110>
  if (fmt == 0)
80100642:	85 f6                	test   %esi,%esi
80100644:	0f 84 90 01 00 00    	je     801007da <cprintf+0x1b2>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010064a:	0f b6 06             	movzbl (%esi),%eax
8010064d:	85 c0                	test   %eax,%eax
8010064f:	74 5b                	je     801006ac <cprintf+0x84>
  argp = (uint*)(void*)(&fmt + 1);
80100651:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100654:	31 db                	xor    %ebx,%ebx
80100656:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80100659:	89 d7                	mov    %edx,%edi
    if(c != '%'){
8010065b:	83 f8 25             	cmp    $0x25,%eax
8010065e:	75 54                	jne    801006b4 <cprintf+0x8c>
    c = fmt[++i] & 0xff;
80100660:	43                   	inc    %ebx
80100661:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
80100665:	85 c9                	test   %ecx,%ecx
80100667:	74 38                	je     801006a1 <cprintf+0x79>
    switch(c){
80100669:	83 f9 70             	cmp    $0x70,%ecx
8010066c:	0f 84 aa 00 00 00    	je     8010071c <cprintf+0xf4>
80100672:	7f 6c                	jg     801006e0 <cprintf+0xb8>
80100674:	83 f9 25             	cmp    $0x25,%ecx
80100677:	74 4b                	je     801006c4 <cprintf+0x9c>
80100679:	83 f9 64             	cmp    $0x64,%ecx
8010067c:	75 70                	jne    801006ee <cprintf+0xc6>
      printint(*argp++, 10, 1);
8010067e:	8d 47 04             	lea    0x4(%edi),%eax
80100681:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100684:	8b 07                	mov    (%edi),%eax
80100686:	b9 01 00 00 00       	mov    $0x1,%ecx
8010068b:	ba 0a 00 00 00       	mov    $0xa,%edx
80100690:	e8 0b ff ff ff       	call   801005a0 <printint>
80100695:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100698:	43                   	inc    %ebx
80100699:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
8010069d:	85 c0                	test   %eax,%eax
8010069f:	75 ba                	jne    8010065b <cprintf+0x33>
801006a1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
801006a4:	85 ff                	test   %edi,%edi
801006a6:	0f 85 af 00 00 00    	jne    8010075b <cprintf+0x133>
}
801006ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006af:	5b                   	pop    %ebx
801006b0:	5e                   	pop    %esi
801006b1:	5f                   	pop    %edi
801006b2:	5d                   	pop    %ebp
801006b3:	c3                   	ret
  if(panicked){
801006b4:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
801006ba:	85 c9                	test   %ecx,%ecx
801006bc:	74 19                	je     801006d7 <cprintf+0xaf>
801006be:	fa                   	cli
    for(;;)
801006bf:	eb fe                	jmp    801006bf <cprintf+0x97>
801006c1:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801006c4:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
801006ca:	85 c9                	test   %ecx,%ecx
801006cc:	0f 85 d6 00 00 00    	jne    801007a8 <cprintf+0x180>
801006d2:	b8 25 00 00 00       	mov    $0x25,%eax
801006d7:	e8 d4 fc ff ff       	call   801003b0 <consputc.part.0>
      break;
801006dc:	eb ba                	jmp    80100698 <cprintf+0x70>
801006de:	66 90                	xchg   %ax,%ax
    switch(c){
801006e0:	83 f9 73             	cmp    $0x73,%ecx
801006e3:	0f 84 87 00 00 00    	je     80100770 <cprintf+0x148>
801006e9:	83 f9 78             	cmp    $0x78,%ecx
801006ec:	74 2e                	je     8010071c <cprintf+0xf4>
  if(panicked){
801006ee:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
801006f4:	85 d2                	test   %edx,%edx
801006f6:	0f 85 a9 00 00 00    	jne    801007a5 <cprintf+0x17d>
801006fc:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801006ff:	b8 25 00 00 00       	mov    $0x25,%eax
80100704:	e8 a7 fc ff ff       	call   801003b0 <consputc.part.0>
80100709:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
8010070e:	85 c0                	test   %eax,%eax
80100710:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80100713:	0f 84 ae 00 00 00    	je     801007c7 <cprintf+0x19f>
80100719:	fa                   	cli
    for(;;)
8010071a:	eb fe                	jmp    8010071a <cprintf+0xf2>
      printint(*argp++, 16, 0);
8010071c:	8d 47 04             	lea    0x4(%edi),%eax
8010071f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100722:	8b 07                	mov    (%edi),%eax
80100724:	31 c9                	xor    %ecx,%ecx
80100726:	ba 10 00 00 00       	mov    $0x10,%edx
8010072b:	e8 70 fe ff ff       	call   801005a0 <printint>
80100730:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
80100733:	e9 60 ff ff ff       	jmp    80100698 <cprintf+0x70>
    acquire(&cons.lock);
80100738:	83 ec 0c             	sub    $0xc,%esp
8010073b:	68 20 ef 10 80       	push   $0x8010ef20
80100740:	e8 e7 38 00 00       	call   8010402c <acquire>
  if (fmt == 0)
80100745:	83 c4 10             	add    $0x10,%esp
80100748:	85 f6                	test   %esi,%esi
8010074a:	0f 84 8a 00 00 00    	je     801007da <cprintf+0x1b2>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100750:	0f b6 06             	movzbl (%esi),%eax
80100753:	85 c0                	test   %eax,%eax
80100755:	0f 85 f6 fe ff ff    	jne    80100651 <cprintf+0x29>
    release(&cons.lock);
8010075b:	83 ec 0c             	sub    $0xc,%esp
8010075e:	68 20 ef 10 80       	push   $0x8010ef20
80100763:	e8 64 38 00 00       	call   80103fcc <release>
80100768:	83 c4 10             	add    $0x10,%esp
8010076b:	e9 3c ff ff ff       	jmp    801006ac <cprintf+0x84>
      if((s = (char*)*argp++) == 0)
80100770:	8d 47 04             	lea    0x4(%edi),%eax
80100773:	8b 17                	mov    (%edi),%edx
80100775:	85 d2                	test   %edx,%edx
80100777:	74 23                	je     8010079c <cprintf+0x174>
80100779:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
8010077b:	8a 0a                	mov    (%edx),%cl
8010077d:	84 c9                	test   %cl,%cl
8010077f:	74 52                	je     801007d3 <cprintf+0x1ab>
80100781:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80100784:	89 fb                	mov    %edi,%ebx
80100786:	89 f7                	mov    %esi,%edi
80100788:	89 c6                	mov    %eax,%esi
8010078a:	0f be c1             	movsbl %cl,%eax
  if(panicked){
8010078d:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
80100793:	85 d2                	test   %edx,%edx
80100795:	74 15                	je     801007ac <cprintf+0x184>
80100797:	fa                   	cli
    for(;;)
80100798:	eb fe                	jmp    80100798 <cprintf+0x170>
8010079a:	66 90                	xchg   %ax,%ax
8010079c:	b1 28                	mov    $0x28,%cl
        s = "(null)";
8010079e:	bf f8 68 10 80       	mov    $0x801068f8,%edi
801007a3:	eb dc                	jmp    80100781 <cprintf+0x159>
801007a5:	fa                   	cli
    for(;;)
801007a6:	eb fe                	jmp    801007a6 <cprintf+0x17e>
801007a8:	fa                   	cli
801007a9:	eb fe                	jmp    801007a9 <cprintf+0x181>
801007ab:	90                   	nop
801007ac:	e8 ff fb ff ff       	call   801003b0 <consputc.part.0>
      for(; *s; s++)
801007b1:	43                   	inc    %ebx
801007b2:	0f be 03             	movsbl (%ebx),%eax
801007b5:	84 c0                	test   %al,%al
801007b7:	75 d4                	jne    8010078d <cprintf+0x165>
      if((s = (char*)*argp++) == 0)
801007b9:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801007bc:	89 f0                	mov    %esi,%eax
801007be:	89 fe                	mov    %edi,%esi
801007c0:	89 c7                	mov    %eax,%edi
801007c2:	e9 d1 fe ff ff       	jmp    80100698 <cprintf+0x70>
801007c7:	89 c8                	mov    %ecx,%eax
801007c9:	e8 e2 fb ff ff       	call   801003b0 <consputc.part.0>
      break;
801007ce:	e9 c5 fe ff ff       	jmp    80100698 <cprintf+0x70>
      if((s = (char*)*argp++) == 0)
801007d3:	89 c7                	mov    %eax,%edi
801007d5:	e9 be fe ff ff       	jmp    80100698 <cprintf+0x70>
    panic("null fmt");
801007da:	83 ec 0c             	sub    $0xc,%esp
801007dd:	68 ff 68 10 80       	push   $0x801068ff
801007e2:	e8 51 fb ff ff       	call   80100338 <panic>
801007e7:	90                   	nop

801007e8 <consoleintr>:
{
801007e8:	55                   	push   %ebp
801007e9:	89 e5                	mov    %esp,%ebp
801007eb:	57                   	push   %edi
801007ec:	56                   	push   %esi
801007ed:	53                   	push   %ebx
801007ee:	83 ec 28             	sub    $0x28,%esp
801007f1:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
801007f4:	68 20 ef 10 80       	push   $0x8010ef20
801007f9:	e8 2e 38 00 00       	call   8010402c <acquire>
  while((c = getc()) >= 0){
801007fe:	83 c4 10             	add    $0x10,%esp
  int c, doprocdump = 0;
80100801:	31 ff                	xor    %edi,%edi
  while((c = getc()) >= 0){
80100803:	ff d6                	call   *%esi
80100805:	85 c0                	test   %eax,%eax
80100807:	78 20                	js     80100829 <consoleintr+0x41>
    switch(c){
80100809:	83 f8 15             	cmp    $0x15,%eax
8010080c:	74 45                	je     80100853 <consoleintr+0x6b>
8010080e:	7f 74                	jg     80100884 <consoleintr+0x9c>
80100810:	83 f8 08             	cmp    $0x8,%eax
80100813:	74 74                	je     80100889 <consoleintr+0xa1>
80100815:	83 f8 10             	cmp    $0x10,%eax
80100818:	0f 85 fa 00 00 00    	jne    80100918 <consoleintr+0x130>
8010081e:	bf 01 00 00 00       	mov    $0x1,%edi
  while((c = getc()) >= 0){
80100823:	ff d6                	call   *%esi
80100825:	85 c0                	test   %eax,%eax
80100827:	79 e0                	jns    80100809 <consoleintr+0x21>
  release(&cons.lock);
80100829:	83 ec 0c             	sub    $0xc,%esp
8010082c:	68 20 ef 10 80       	push   $0x8010ef20
80100831:	e8 96 37 00 00       	call   80103fcc <release>
  if(doprocdump) {
80100836:	83 c4 10             	add    $0x10,%esp
80100839:	85 ff                	test   %edi,%edi
8010083b:	0f 85 52 01 00 00    	jne    80100993 <consoleintr+0x1ab>
}
80100841:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100844:	5b                   	pop    %ebx
80100845:	5e                   	pop    %esi
80100846:	5f                   	pop    %edi
80100847:	5d                   	pop    %ebp
80100848:	c3                   	ret
80100849:	b8 00 01 00 00       	mov    $0x100,%eax
8010084e:	e8 5d fb ff ff       	call   801003b0 <consputc.part.0>
      while(input.e != input.w &&
80100853:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100858:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
8010085e:	74 a3                	je     80100803 <consoleintr+0x1b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100860:	48                   	dec    %eax
80100861:	89 c2                	mov    %eax,%edx
80100863:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100866:	80 ba 80 ee 10 80 0a 	cmpb   $0xa,-0x7fef1180(%edx)
8010086d:	74 94                	je     80100803 <consoleintr+0x1b>
        input.e--;
8010086f:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if(panicked){
80100874:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
8010087a:	85 d2                	test   %edx,%edx
8010087c:	74 cb                	je     80100849 <consoleintr+0x61>
8010087e:	fa                   	cli
    for(;;)
8010087f:	eb fe                	jmp    8010087f <consoleintr+0x97>
80100881:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100884:	83 f8 7f             	cmp    $0x7f,%eax
80100887:	75 27                	jne    801008b0 <consoleintr+0xc8>
      if(input.e != input.w){
80100889:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
8010088e:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100894:	0f 84 69 ff ff ff    	je     80100803 <consoleintr+0x1b>
        input.e--;
8010089a:	48                   	dec    %eax
8010089b:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if(panicked){
801008a0:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
801008a5:	85 c0                	test   %eax,%eax
801008a7:	0f 84 d7 00 00 00    	je     80100984 <consoleintr+0x19c>
801008ad:	fa                   	cli
    for(;;)
801008ae:	eb fe                	jmp    801008ae <consoleintr+0xc6>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008b0:	8b 1d 08 ef 10 80    	mov    0x8010ef08,%ebx
801008b6:	89 da                	mov    %ebx,%edx
801008b8:	2b 15 00 ef 10 80    	sub    0x8010ef00,%edx
801008be:	83 fa 7f             	cmp    $0x7f,%edx
801008c1:	0f 87 3c ff ff ff    	ja     80100803 <consoleintr+0x1b>
  if(panicked){
801008c7:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
801008cd:	8d 53 01             	lea    0x1(%ebx),%edx
801008d0:	83 e3 7f             	and    $0x7f,%ebx
801008d3:	89 15 08 ef 10 80    	mov    %edx,0x8010ef08
801008d9:	88 83 80 ee 10 80    	mov    %al,-0x7fef1180(%ebx)
  if(panicked){
801008df:	85 c9                	test   %ecx,%ecx
801008e1:	0f 85 b8 00 00 00    	jne    8010099f <consoleintr+0x1b7>
801008e7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801008ea:	e8 c1 fa ff ff       	call   801003b0 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801008f2:	8b 0d 08 ef 10 80    	mov    0x8010ef08,%ecx
801008f8:	83 f8 0a             	cmp    $0xa,%eax
801008fb:	74 6c                	je     80100969 <consoleintr+0x181>
801008fd:	83 f8 04             	cmp    $0x4,%eax
80100900:	74 67                	je     80100969 <consoleintr+0x181>
80100902:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
80100907:	8d 90 80 00 00 00    	lea    0x80(%eax),%edx
8010090d:	39 ca                	cmp    %ecx,%edx
8010090f:	0f 85 ee fe ff ff    	jne    80100803 <consoleintr+0x1b>
80100915:	eb 52                	jmp    80100969 <consoleintr+0x181>
80100917:	90                   	nop
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100918:	85 c0                	test   %eax,%eax
8010091a:	0f 84 e3 fe ff ff    	je     80100803 <consoleintr+0x1b>
80100920:	8b 1d 08 ef 10 80    	mov    0x8010ef08,%ebx
80100926:	89 da                	mov    %ebx,%edx
80100928:	2b 15 00 ef 10 80    	sub    0x8010ef00,%edx
8010092e:	83 fa 7f             	cmp    $0x7f,%edx
80100931:	0f 87 cc fe ff ff    	ja     80100803 <consoleintr+0x1b>
  if(panicked){
80100937:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
8010093d:	8d 53 01             	lea    0x1(%ebx),%edx
80100940:	83 e3 7f             	and    $0x7f,%ebx
        c = (c == '\r') ? '\n' : c;
80100943:	83 f8 0d             	cmp    $0xd,%eax
80100946:	75 8b                	jne    801008d3 <consoleintr+0xeb>
        input.buf[input.e++ % INPUT_BUF] = c;
80100948:	89 15 08 ef 10 80    	mov    %edx,0x8010ef08
8010094e:	c6 83 80 ee 10 80 0a 	movb   $0xa,-0x7fef1180(%ebx)
  if(panicked){
80100955:	85 c9                	test   %ecx,%ecx
80100957:	75 46                	jne    8010099f <consoleintr+0x1b7>
80100959:	b8 0a 00 00 00       	mov    $0xa,%eax
8010095e:	e8 4d fa ff ff       	call   801003b0 <consputc.part.0>
          input.w = input.e;
80100963:	8b 0d 08 ef 10 80    	mov    0x8010ef08,%ecx
80100969:	89 0d 04 ef 10 80    	mov    %ecx,0x8010ef04
          wakeup(&input.r);
8010096f:	83 ec 0c             	sub    $0xc,%esp
80100972:	68 00 ef 10 80       	push   $0x8010ef00
80100977:	e8 50 32 00 00       	call   80103bcc <wakeup>
8010097c:	83 c4 10             	add    $0x10,%esp
8010097f:	e9 7f fe ff ff       	jmp    80100803 <consoleintr+0x1b>
80100984:	b8 00 01 00 00       	mov    $0x100,%eax
80100989:	e8 22 fa ff ff       	call   801003b0 <consputc.part.0>
8010098e:	e9 70 fe ff ff       	jmp    80100803 <consoleintr+0x1b>
}
80100993:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100996:	5b                   	pop    %ebx
80100997:	5e                   	pop    %esi
80100998:	5f                   	pop    %edi
80100999:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
8010099a:	e9 fd 32 00 00       	jmp    80103c9c <procdump>
8010099f:	fa                   	cli
    for(;;)
801009a0:	eb fe                	jmp    801009a0 <consoleintr+0x1b8>
801009a2:	66 90                	xchg   %ax,%ax

801009a4 <consoleinit>:

void
consoleinit(void)
{
801009a4:	55                   	push   %ebp
801009a5:	89 e5                	mov    %esp,%ebp
801009a7:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009aa:	68 08 69 10 80       	push   $0x80106908
801009af:	68 20 ef 10 80       	push   $0x8010ef20
801009b4:	e8 9b 34 00 00       	call   80103e54 <initlock>

  devsw[CONSOLE].write = consolewrite;
801009b9:	c7 05 0c f9 10 80 34 	movl   $0x80100534,0x8010f90c
801009c0:	05 10 80 
  devsw[CONSOLE].read = consoleread;
801009c3:	c7 05 08 f9 10 80 48 	movl   $0x80100248,0x8010f908
801009ca:	02 10 80 
  cons.locking = 1;
801009cd:	c7 05 54 ef 10 80 01 	movl   $0x1,0x8010ef54
801009d4:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
801009d7:	58                   	pop    %eax
801009d8:	5a                   	pop    %edx
801009d9:	6a 00                	push   $0x0
801009db:	6a 01                	push   $0x1
801009dd:	e8 ae 17 00 00       	call   80102190 <ioapicenable>
}
801009e2:	83 c4 10             	add    $0x10,%esp
801009e5:	c9                   	leave
801009e6:	c3                   	ret
801009e7:	90                   	nop

801009e8 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009e8:	55                   	push   %ebp
801009e9:	89 e5                	mov    %esp,%ebp
801009eb:	57                   	push   %edi
801009ec:	56                   	push   %esi
801009ed:	53                   	push   %ebx
801009ee:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009f4:	e8 0f 2b 00 00       	call   80103508 <myproc>
801009f9:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
801009ff:	e8 bc 1f 00 00       	call   801029c0 <begin_op>

  if((ip = namei(path)) == 0){
80100a04:	83 ec 0c             	sub    $0xc,%esp
80100a07:	ff 75 08             	push   0x8(%ebp)
80100a0a:	e8 1d 14 00 00       	call   80101e2c <namei>
80100a0f:	83 c4 10             	add    $0x10,%esp
80100a12:	85 c0                	test   %eax,%eax
80100a14:	0f 84 10 03 00 00    	je     80100d2a <exec+0x342>
80100a1a:	89 c7                	mov    %eax,%edi
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a1c:	83 ec 0c             	sub    $0xc,%esp
80100a1f:	50                   	push   %eax
80100a20:	e8 b7 0b 00 00       	call   801015dc <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a25:	6a 34                	push   $0x34
80100a27:	6a 00                	push   $0x0
80100a29:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a2f:	50                   	push   %eax
80100a30:	57                   	push   %edi
80100a31:	e8 76 0e 00 00       	call   801018ac <readi>
80100a36:	83 c4 20             	add    $0x20,%esp
80100a39:	83 f8 34             	cmp    $0x34,%eax
80100a3c:	0f 85 f9 00 00 00    	jne    80100b3b <exec+0x153>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a42:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a49:	45 4c 46 
80100a4c:	0f 85 e9 00 00 00    	jne    80100b3b <exec+0x153>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a52:	e8 35 5b 00 00       	call   8010658c <setupkvm>
80100a57:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a5d:	85 c0                	test   %eax,%eax
80100a5f:	0f 84 d6 00 00 00    	je     80100b3b <exec+0x153>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a65:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a6b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a72:	00 
80100a73:	0f 84 81 02 00 00    	je     80100cfa <exec+0x312>
  sz = 0;
80100a79:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100a80:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a83:	31 db                	xor    %ebx,%ebx
80100a85:	e9 84 00 00 00       	jmp    80100b0e <exec+0x126>
80100a8a:	66 90                	xchg   %ax,%ax
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100a8c:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100a93:	75 6a                	jne    80100aff <exec+0x117>
      continue;
    if(ph.memsz < ph.filesz)
80100a95:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100a9b:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100aa1:	0f 82 83 00 00 00    	jb     80100b2a <exec+0x142>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100aa7:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100aad:	72 7b                	jb     80100b2a <exec+0x142>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aaf:	51                   	push   %ecx
80100ab0:	50                   	push   %eax
80100ab1:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100ab7:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100abd:	e8 3e 59 00 00       	call   80106400 <allocuvm>
80100ac2:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ac8:	83 c4 10             	add    $0x10,%esp
80100acb:	85 c0                	test   %eax,%eax
80100acd:	74 5b                	je     80100b2a <exec+0x142>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100acf:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100ad5:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100ada:	75 4e                	jne    80100b2a <exec+0x142>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100adc:	83 ec 0c             	sub    $0xc,%esp
80100adf:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100ae5:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100aeb:	57                   	push   %edi
80100aec:	50                   	push   %eax
80100aed:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100af3:	e8 44 58 00 00       	call   8010633c <loaduvm>
80100af8:	83 c4 20             	add    $0x20,%esp
80100afb:	85 c0                	test   %eax,%eax
80100afd:	78 2b                	js     80100b2a <exec+0x142>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aff:	43                   	inc    %ebx
80100b00:	83 c6 20             	add    $0x20,%esi
80100b03:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b0a:	39 d8                	cmp    %ebx,%eax
80100b0c:	7e 4e                	jle    80100b5c <exec+0x174>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b0e:	6a 20                	push   $0x20
80100b10:	56                   	push   %esi
80100b11:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b17:	50                   	push   %eax
80100b18:	57                   	push   %edi
80100b19:	e8 8e 0d 00 00       	call   801018ac <readi>
80100b1e:	83 c4 10             	add    $0x10,%esp
80100b21:	83 f8 20             	cmp    $0x20,%eax
80100b24:	0f 84 62 ff ff ff    	je     80100a8c <exec+0xa4>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b2a:	83 ec 0c             	sub    $0xc,%esp
80100b2d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100b33:	e8 e4 59 00 00       	call   8010651c <freevm>
  if(ip){
80100b38:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80100b3b:	83 ec 0c             	sub    $0xc,%esp
80100b3e:	57                   	push   %edi
80100b3f:	e8 ec 0c 00 00       	call   80101830 <iunlockput>
    end_op();
80100b44:	e8 df 1e 00 00       	call   80102a28 <end_op>
80100b49:	83 c4 10             	add    $0x10,%esp
    return -1;
80100b4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100b51:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b54:	5b                   	pop    %ebx
80100b55:	5e                   	pop    %esi
80100b56:	5f                   	pop    %edi
80100b57:	5d                   	pop    %ebp
80100b58:	c3                   	ret
80100b59:	8d 76 00             	lea    0x0(%esi),%esi
  sz = PGROUNDUP(sz);
80100b5c:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100b62:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100b68:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b6e:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100b74:	83 ec 0c             	sub    $0xc,%esp
80100b77:	57                   	push   %edi
80100b78:	e8 b3 0c 00 00       	call   80101830 <iunlockput>
  end_op();
80100b7d:	e8 a6 1e 00 00       	call   80102a28 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b82:	83 c4 0c             	add    $0xc,%esp
80100b85:	53                   	push   %ebx
80100b86:	56                   	push   %esi
80100b87:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100b8d:	56                   	push   %esi
80100b8e:	e8 6d 58 00 00       	call   80106400 <allocuvm>
80100b93:	89 c7                	mov    %eax,%edi
80100b95:	83 c4 10             	add    $0x10,%esp
80100b98:	85 c0                	test   %eax,%eax
80100b9a:	74 7e                	je     80100c1a <exec+0x232>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100b9c:	83 ec 08             	sub    $0x8,%esp
80100b9f:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100ba5:	50                   	push   %eax
80100ba6:	56                   	push   %esi
80100ba7:	e8 70 5a 00 00       	call   8010661c <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100bac:	8b 45 0c             	mov    0xc(%ebp),%eax
80100baf:	8b 10                	mov    (%eax),%edx
80100bb1:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100bb4:	89 fb                	mov    %edi,%ebx
  for(argc = 0; argv[argc]; argc++) {
80100bb6:	85 d2                	test   %edx,%edx
80100bb8:	0f 84 48 01 00 00    	je     80100d06 <exec+0x31e>
80100bbe:	31 f6                	xor    %esi,%esi
80100bc0:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100bc6:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100bc9:	eb 1f                	jmp    80100bea <exec+0x202>
80100bcb:	90                   	nop
    ustack[3+argc] = sp;
80100bcc:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100bd2:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
  for(argc = 0; argv[argc]; argc++) {
80100bd9:	8d 46 01             	lea    0x1(%esi),%eax
80100bdc:	8b 14 87             	mov    (%edi,%eax,4),%edx
80100bdf:	85 d2                	test   %edx,%edx
80100be1:	74 4d                	je     80100c30 <exec+0x248>
    if(argc >= MAXARG)
80100be3:	83 f8 20             	cmp    $0x20,%eax
80100be6:	74 32                	je     80100c1a <exec+0x232>
80100be8:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100bea:	83 ec 0c             	sub    $0xc,%esp
80100bed:	52                   	push   %edx
80100bee:	e8 91 36 00 00       	call   80104284 <strlen>
80100bf3:	29 c3                	sub    %eax,%ebx
80100bf5:	4b                   	dec    %ebx
80100bf6:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100bf9:	5a                   	pop    %edx
80100bfa:	ff 34 b7             	push   (%edi,%esi,4)
80100bfd:	e8 82 36 00 00       	call   80104284 <strlen>
80100c02:	40                   	inc    %eax
80100c03:	50                   	push   %eax
80100c04:	ff 34 b7             	push   (%edi,%esi,4)
80100c07:	53                   	push   %ebx
80100c08:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c0e:	e8 ad 5b 00 00       	call   801067c0 <copyout>
80100c13:	83 c4 20             	add    $0x20,%esp
80100c16:	85 c0                	test   %eax,%eax
80100c18:	79 b2                	jns    80100bcc <exec+0x1e4>
    freevm(pgdir);
80100c1a:	83 ec 0c             	sub    $0xc,%esp
80100c1d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c23:	e8 f4 58 00 00       	call   8010651c <freevm>
80100c28:	83 c4 10             	add    $0x10,%esp
80100c2b:	e9 1c ff ff ff       	jmp    80100b4c <exec+0x164>
  ustack[3+argc] = 0;
80100c30:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100c36:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100c3c:	8d 46 04             	lea    0x4(%esi),%eax
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c3f:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  sp -= (3+argc+1) * 4;
80100c46:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80100c49:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80100c50:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100c54:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c5b:	ff ff ff 
  ustack[1] = argc;
80100c5e:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c64:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c6a:	89 d8                	mov    %ebx,%eax
80100c6c:	29 d0                	sub    %edx,%eax
80100c6e:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  sp -= (3+argc+1) * 4;
80100c74:	29 f3                	sub    %esi,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c76:	56                   	push   %esi
80100c77:	51                   	push   %ecx
80100c78:	53                   	push   %ebx
80100c79:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c7f:	e8 3c 5b 00 00       	call   801067c0 <copyout>
80100c84:	83 c4 10             	add    $0x10,%esp
80100c87:	85 c0                	test   %eax,%eax
80100c89:	78 8f                	js     80100c1a <exec+0x232>
  for(last=s=path; *s; s++)
80100c8b:	8b 45 08             	mov    0x8(%ebp),%eax
80100c8e:	8a 00                	mov    (%eax),%al
80100c90:	8b 55 08             	mov    0x8(%ebp),%edx
80100c93:	84 c0                	test   %al,%al
80100c95:	74 12                	je     80100ca9 <exec+0x2c1>
80100c97:	89 d1                	mov    %edx,%ecx
80100c99:	8d 76 00             	lea    0x0(%esi),%esi
      last = s+1;
80100c9c:	41                   	inc    %ecx
    if(*s == '/')
80100c9d:	3c 2f                	cmp    $0x2f,%al
80100c9f:	75 02                	jne    80100ca3 <exec+0x2bb>
      last = s+1;
80100ca1:	89 ca                	mov    %ecx,%edx
  for(last=s=path; *s; s++)
80100ca3:	8a 01                	mov    (%ecx),%al
80100ca5:	84 c0                	test   %al,%al
80100ca7:	75 f3                	jne    80100c9c <exec+0x2b4>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100ca9:	50                   	push   %eax
80100caa:	6a 10                	push   $0x10
80100cac:	52                   	push   %edx
80100cad:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100cb3:	8d 46 6c             	lea    0x6c(%esi),%eax
80100cb6:	50                   	push   %eax
80100cb7:	e8 94 35 00 00       	call   80104250 <safestrcpy>
  oldpgdir = curproc->pgdir;
80100cbc:	89 f0                	mov    %esi,%eax
80100cbe:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->pgdir = pgdir;
80100cc1:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100cc7:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
80100cca:	89 38                	mov    %edi,(%eax)
  curproc->tf->eip = elf.entry;  // main
80100ccc:	89 c1                	mov    %eax,%ecx
80100cce:	8b 40 18             	mov    0x18(%eax),%eax
80100cd1:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100cd7:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100cda:	8b 41 18             	mov    0x18(%ecx),%eax
80100cdd:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100ce0:	89 0c 24             	mov    %ecx,(%esp)
80100ce3:	e8 e4 54 00 00       	call   801061cc <switchuvm>
  freevm(oldpgdir);
80100ce8:	89 34 24             	mov    %esi,(%esp)
80100ceb:	e8 2c 58 00 00       	call   8010651c <freevm>
  return 0;
80100cf0:	83 c4 10             	add    $0x10,%esp
80100cf3:	31 c0                	xor    %eax,%eax
80100cf5:	e9 57 fe ff ff       	jmp    80100b51 <exec+0x169>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100cfa:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100cff:	31 f6                	xor    %esi,%esi
80100d01:	e9 6e fe ff ff       	jmp    80100b74 <exec+0x18c>
  for(argc = 0; argv[argc]; argc++) {
80100d06:	be 10 00 00 00       	mov    $0x10,%esi
80100d0b:	ba 04 00 00 00       	mov    $0x4,%edx
80100d10:	b8 03 00 00 00       	mov    $0x3,%eax
80100d15:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100d1c:	00 00 00 
80100d1f:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100d25:	e9 1f ff ff ff       	jmp    80100c49 <exec+0x261>
    end_op();
80100d2a:	e8 f9 1c 00 00       	call   80102a28 <end_op>
    cprintf("exec: fail\n");
80100d2f:	83 ec 0c             	sub    $0xc,%esp
80100d32:	68 10 69 10 80       	push   $0x80106910
80100d37:	e8 ec f8 ff ff       	call   80100628 <cprintf>
    return -1;
80100d3c:	83 c4 10             	add    $0x10,%esp
80100d3f:	e9 08 fe ff ff       	jmp    80100b4c <exec+0x164>

80100d44 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d44:	55                   	push   %ebp
80100d45:	89 e5                	mov    %esp,%ebp
80100d47:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d4a:	68 1c 69 10 80       	push   $0x8010691c
80100d4f:	68 60 ef 10 80       	push   $0x8010ef60
80100d54:	e8 fb 30 00 00       	call   80103e54 <initlock>
}
80100d59:	83 c4 10             	add    $0x10,%esp
80100d5c:	c9                   	leave
80100d5d:	c3                   	ret
80100d5e:	66 90                	xchg   %ax,%ax

80100d60 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	53                   	push   %ebx
80100d64:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d67:	68 60 ef 10 80       	push   $0x8010ef60
80100d6c:	e8 bb 32 00 00       	call   8010402c <acquire>
80100d71:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d74:	bb 94 ef 10 80       	mov    $0x8010ef94,%ebx
80100d79:	eb 0c                	jmp    80100d87 <filealloc+0x27>
80100d7b:	90                   	nop
80100d7c:	83 c3 18             	add    $0x18,%ebx
80100d7f:	81 fb f4 f8 10 80    	cmp    $0x8010f8f4,%ebx
80100d85:	74 25                	je     80100dac <filealloc+0x4c>
    if(f->ref == 0){
80100d87:	8b 43 04             	mov    0x4(%ebx),%eax
80100d8a:	85 c0                	test   %eax,%eax
80100d8c:	75 ee                	jne    80100d7c <filealloc+0x1c>
      f->ref = 1;
80100d8e:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100d95:	83 ec 0c             	sub    $0xc,%esp
80100d98:	68 60 ef 10 80       	push   $0x8010ef60
80100d9d:	e8 2a 32 00 00       	call   80103fcc <release>
      return f;
80100da2:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100da5:	89 d8                	mov    %ebx,%eax
80100da7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100daa:	c9                   	leave
80100dab:	c3                   	ret
  release(&ftable.lock);
80100dac:	83 ec 0c             	sub    $0xc,%esp
80100daf:	68 60 ef 10 80       	push   $0x8010ef60
80100db4:	e8 13 32 00 00       	call   80103fcc <release>
  return 0;
80100db9:	83 c4 10             	add    $0x10,%esp
80100dbc:	31 db                	xor    %ebx,%ebx
}
80100dbe:	89 d8                	mov    %ebx,%eax
80100dc0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dc3:	c9                   	leave
80100dc4:	c3                   	ret
80100dc5:	8d 76 00             	lea    0x0(%esi),%esi

80100dc8 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100dc8:	55                   	push   %ebp
80100dc9:	89 e5                	mov    %esp,%ebp
80100dcb:	53                   	push   %ebx
80100dcc:	83 ec 10             	sub    $0x10,%esp
80100dcf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dd2:	68 60 ef 10 80       	push   $0x8010ef60
80100dd7:	e8 50 32 00 00       	call   8010402c <acquire>
  if(f->ref < 1)
80100ddc:	8b 43 04             	mov    0x4(%ebx),%eax
80100ddf:	83 c4 10             	add    $0x10,%esp
80100de2:	85 c0                	test   %eax,%eax
80100de4:	7e 18                	jle    80100dfe <filedup+0x36>
    panic("filedup");
  f->ref++;
80100de6:	40                   	inc    %eax
80100de7:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100dea:	83 ec 0c             	sub    $0xc,%esp
80100ded:	68 60 ef 10 80       	push   $0x8010ef60
80100df2:	e8 d5 31 00 00       	call   80103fcc <release>
  return f;
}
80100df7:	89 d8                	mov    %ebx,%eax
80100df9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dfc:	c9                   	leave
80100dfd:	c3                   	ret
    panic("filedup");
80100dfe:	83 ec 0c             	sub    $0xc,%esp
80100e01:	68 23 69 10 80       	push   $0x80106923
80100e06:	e8 2d f5 ff ff       	call   80100338 <panic>
80100e0b:	90                   	nop

80100e0c <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e0c:	55                   	push   %ebp
80100e0d:	89 e5                	mov    %esp,%ebp
80100e0f:	57                   	push   %edi
80100e10:	56                   	push   %esi
80100e11:	53                   	push   %ebx
80100e12:	83 ec 28             	sub    $0x28,%esp
80100e15:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e18:	68 60 ef 10 80       	push   $0x8010ef60
80100e1d:	e8 0a 32 00 00       	call   8010402c <acquire>
  if(f->ref < 1)
80100e22:	8b 57 04             	mov    0x4(%edi),%edx
80100e25:	83 c4 10             	add    $0x10,%esp
80100e28:	85 d2                	test   %edx,%edx
80100e2a:	0f 8e 8d 00 00 00    	jle    80100ebd <fileclose+0xb1>
    panic("fileclose");
  if(--f->ref > 0){
80100e30:	4a                   	dec    %edx
80100e31:	89 57 04             	mov    %edx,0x4(%edi)
80100e34:	75 3a                	jne    80100e70 <fileclose+0x64>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e36:	8b 1f                	mov    (%edi),%ebx
80100e38:	8a 47 09             	mov    0x9(%edi),%al
80100e3b:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e3e:	8b 77 0c             	mov    0xc(%edi),%esi
80100e41:	8b 47 10             	mov    0x10(%edi),%eax
80100e44:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
80100e47:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  release(&ftable.lock);
80100e4d:	83 ec 0c             	sub    $0xc,%esp
80100e50:	68 60 ef 10 80       	push   $0x8010ef60
80100e55:	e8 72 31 00 00       	call   80103fcc <release>

  if(ff.type == FD_PIPE)
80100e5a:	83 c4 10             	add    $0x10,%esp
80100e5d:	83 fb 01             	cmp    $0x1,%ebx
80100e60:	74 42                	je     80100ea4 <fileclose+0x98>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100e62:	83 fb 02             	cmp    $0x2,%ebx
80100e65:	74 1d                	je     80100e84 <fileclose+0x78>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e6a:	5b                   	pop    %ebx
80100e6b:	5e                   	pop    %esi
80100e6c:	5f                   	pop    %edi
80100e6d:	5d                   	pop    %ebp
80100e6e:	c3                   	ret
80100e6f:	90                   	nop
    release(&ftable.lock);
80100e70:	c7 45 08 60 ef 10 80 	movl   $0x8010ef60,0x8(%ebp)
}
80100e77:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e7a:	5b                   	pop    %ebx
80100e7b:	5e                   	pop    %esi
80100e7c:	5f                   	pop    %edi
80100e7d:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e7e:	e9 49 31 00 00       	jmp    80103fcc <release>
80100e83:	90                   	nop
    begin_op();
80100e84:	e8 37 1b 00 00       	call   801029c0 <begin_op>
    iput(ff.ip);
80100e89:	83 ec 0c             	sub    $0xc,%esp
80100e8c:	ff 75 e0             	push   -0x20(%ebp)
80100e8f:	e8 54 08 00 00       	call   801016e8 <iput>
    end_op();
80100e94:	83 c4 10             	add    $0x10,%esp
}
80100e97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e9a:	5b                   	pop    %ebx
80100e9b:	5e                   	pop    %esi
80100e9c:	5f                   	pop    %edi
80100e9d:	5d                   	pop    %ebp
    end_op();
80100e9e:	e9 85 1b 00 00       	jmp    80102a28 <end_op>
80100ea3:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80100ea4:	83 ec 08             	sub    $0x8,%esp
80100ea7:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
80100eab:	50                   	push   %eax
80100eac:	56                   	push   %esi
80100ead:	e8 1e 22 00 00       	call   801030d0 <pipeclose>
80100eb2:	83 c4 10             	add    $0x10,%esp
}
80100eb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100eb8:	5b                   	pop    %ebx
80100eb9:	5e                   	pop    %esi
80100eba:	5f                   	pop    %edi
80100ebb:	5d                   	pop    %ebp
80100ebc:	c3                   	ret
    panic("fileclose");
80100ebd:	83 ec 0c             	sub    $0xc,%esp
80100ec0:	68 2b 69 10 80       	push   $0x8010692b
80100ec5:	e8 6e f4 ff ff       	call   80100338 <panic>
80100eca:	66 90                	xchg   %ax,%ax

80100ecc <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100ecc:	55                   	push   %ebp
80100ecd:	89 e5                	mov    %esp,%ebp
80100ecf:	53                   	push   %ebx
80100ed0:	53                   	push   %ebx
80100ed1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100ed4:	83 3b 02             	cmpl   $0x2,(%ebx)
80100ed7:	75 2b                	jne    80100f04 <filestat+0x38>
    ilock(f->ip);
80100ed9:	83 ec 0c             	sub    $0xc,%esp
80100edc:	ff 73 10             	push   0x10(%ebx)
80100edf:	e8 f8 06 00 00       	call   801015dc <ilock>
    stati(f->ip, st);
80100ee4:	58                   	pop    %eax
80100ee5:	5a                   	pop    %edx
80100ee6:	ff 75 0c             	push   0xc(%ebp)
80100ee9:	ff 73 10             	push   0x10(%ebx)
80100eec:	e8 8f 09 00 00       	call   80101880 <stati>
    iunlock(f->ip);
80100ef1:	59                   	pop    %ecx
80100ef2:	ff 73 10             	push   0x10(%ebx)
80100ef5:	e8 aa 07 00 00       	call   801016a4 <iunlock>
    return 0;
80100efa:	83 c4 10             	add    $0x10,%esp
80100efd:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100eff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f02:	c9                   	leave
80100f03:	c3                   	ret
  return -1;
80100f04:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f09:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f0c:	c9                   	leave
80100f0d:	c3                   	ret
80100f0e:	66 90                	xchg   %ax,%ax

80100f10 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	57                   	push   %edi
80100f14:	56                   	push   %esi
80100f15:	53                   	push   %ebx
80100f16:	83 ec 1c             	sub    $0x1c,%esp
80100f19:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f1c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f1f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f22:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f26:	74 60                	je     80100f88 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f28:	8b 03                	mov    (%ebx),%eax
80100f2a:	83 f8 01             	cmp    $0x1,%eax
80100f2d:	74 45                	je     80100f74 <fileread+0x64>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f2f:	83 f8 02             	cmp    $0x2,%eax
80100f32:	75 5b                	jne    80100f8f <fileread+0x7f>
    ilock(f->ip);
80100f34:	83 ec 0c             	sub    $0xc,%esp
80100f37:	ff 73 10             	push   0x10(%ebx)
80100f3a:	e8 9d 06 00 00       	call   801015dc <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f3f:	57                   	push   %edi
80100f40:	ff 73 14             	push   0x14(%ebx)
80100f43:	56                   	push   %esi
80100f44:	ff 73 10             	push   0x10(%ebx)
80100f47:	e8 60 09 00 00       	call   801018ac <readi>
80100f4c:	83 c4 20             	add    $0x20,%esp
80100f4f:	85 c0                	test   %eax,%eax
80100f51:	7e 03                	jle    80100f56 <fileread+0x46>
      f->off += r;
80100f53:	01 43 14             	add    %eax,0x14(%ebx)
80100f56:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    iunlock(f->ip);
80100f59:	83 ec 0c             	sub    $0xc,%esp
80100f5c:	ff 73 10             	push   0x10(%ebx)
80100f5f:	e8 40 07 00 00       	call   801016a4 <iunlock>
    return r;
80100f64:	83 c4 10             	add    $0x10,%esp
80100f67:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  panic("fileread");
}
80100f6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f6d:	5b                   	pop    %ebx
80100f6e:	5e                   	pop    %esi
80100f6f:	5f                   	pop    %edi
80100f70:	5d                   	pop    %ebp
80100f71:	c3                   	ret
80100f72:	66 90                	xchg   %ax,%ax
    return piperead(f->pipe, addr, n);
80100f74:	8b 43 0c             	mov    0xc(%ebx),%eax
80100f77:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100f7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f7d:	5b                   	pop    %ebx
80100f7e:	5e                   	pop    %esi
80100f7f:	5f                   	pop    %edi
80100f80:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100f81:	e9 ea 22 00 00       	jmp    80103270 <piperead>
80100f86:	66 90                	xchg   %ax,%ax
    return -1;
80100f88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f8d:	eb db                	jmp    80100f6a <fileread+0x5a>
  panic("fileread");
80100f8f:	83 ec 0c             	sub    $0xc,%esp
80100f92:	68 35 69 10 80       	push   $0x80106935
80100f97:	e8 9c f3 ff ff       	call   80100338 <panic>

80100f9c <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100f9c:	55                   	push   %ebp
80100f9d:	89 e5                	mov    %esp,%ebp
80100f9f:	57                   	push   %edi
80100fa0:	56                   	push   %esi
80100fa1:	53                   	push   %ebx
80100fa2:	83 ec 1c             	sub    $0x1c,%esp
80100fa5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100fa8:	8b 45 0c             	mov    0xc(%ebp),%eax
80100fab:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100fae:	8b 45 10             	mov    0x10(%ebp),%eax
80100fb1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100fb4:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
80100fb8:	0f 84 b3 00 00 00    	je     80101071 <filewrite+0xd5>
    return -1;
  if(f->type == FD_PIPE)
80100fbe:	8b 03                	mov    (%ebx),%eax
80100fc0:	83 f8 01             	cmp    $0x1,%eax
80100fc3:	0f 84 b7 00 00 00    	je     80101080 <filewrite+0xe4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100fc9:	83 f8 02             	cmp    $0x2,%eax
80100fcc:	0f 85 c0 00 00 00    	jne    80101092 <filewrite+0xf6>
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
80100fd2:	31 f6                	xor    %esi,%esi
    while(i < n){
80100fd4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100fd7:	85 c0                	test   %eax,%eax
80100fd9:	7f 2c                	jg     80101007 <filewrite+0x6b>
80100fdb:	e9 8c 00 00 00       	jmp    8010106c <filewrite+0xd0>
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80100fe0:	01 43 14             	add    %eax,0x14(%ebx)
80100fe3:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80100fe6:	83 ec 0c             	sub    $0xc,%esp
80100fe9:	ff 73 10             	push   0x10(%ebx)
80100fec:	e8 b3 06 00 00       	call   801016a4 <iunlock>
      end_op();
80100ff1:	e8 32 1a 00 00       	call   80102a28 <end_op>

      if(r < 0)
        break;
      if(r != n1)
80100ff6:	83 c4 10             	add    $0x10,%esp
80100ff9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ffc:	39 c7                	cmp    %eax,%edi
80100ffe:	75 5f                	jne    8010105f <filewrite+0xc3>
        panic("short filewrite");
      i += r;
80101000:	01 fe                	add    %edi,%esi
    while(i < n){
80101002:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101005:	7e 65                	jle    8010106c <filewrite+0xd0>
      int n1 = n - i;
80101007:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010100a:	29 f7                	sub    %esi,%edi
      if(n1 > max)
8010100c:	81 ff 00 06 00 00    	cmp    $0x600,%edi
80101012:	7e 05                	jle    80101019 <filewrite+0x7d>
80101014:	bf 00 06 00 00       	mov    $0x600,%edi
      begin_op();
80101019:	e8 a2 19 00 00       	call   801029c0 <begin_op>
      ilock(f->ip);
8010101e:	83 ec 0c             	sub    $0xc,%esp
80101021:	ff 73 10             	push   0x10(%ebx)
80101024:	e8 b3 05 00 00       	call   801015dc <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101029:	57                   	push   %edi
8010102a:	ff 73 14             	push   0x14(%ebx)
8010102d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101030:	01 f0                	add    %esi,%eax
80101032:	50                   	push   %eax
80101033:	ff 73 10             	push   0x10(%ebx)
80101036:	e8 71 09 00 00       	call   801019ac <writei>
8010103b:	83 c4 20             	add    $0x20,%esp
8010103e:	85 c0                	test   %eax,%eax
80101040:	7f 9e                	jg     80100fe0 <filewrite+0x44>
80101042:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101045:	83 ec 0c             	sub    $0xc,%esp
80101048:	ff 73 10             	push   0x10(%ebx)
8010104b:	e8 54 06 00 00       	call   801016a4 <iunlock>
      end_op();
80101050:	e8 d3 19 00 00       	call   80102a28 <end_op>
      if(r < 0)
80101055:	83 c4 10             	add    $0x10,%esp
80101058:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010105b:	85 c0                	test   %eax,%eax
8010105d:	75 0d                	jne    8010106c <filewrite+0xd0>
        panic("short filewrite");
8010105f:	83 ec 0c             	sub    $0xc,%esp
80101062:	68 3e 69 10 80       	push   $0x8010693e
80101067:	e8 cc f2 ff ff       	call   80100338 <panic>
    }
    return i == n ? n : -1;
8010106c:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010106f:	74 05                	je     80101076 <filewrite+0xda>
80101071:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
80101076:	89 f0                	mov    %esi,%eax
80101078:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010107b:	5b                   	pop    %ebx
8010107c:	5e                   	pop    %esi
8010107d:	5f                   	pop    %edi
8010107e:	5d                   	pop    %ebp
8010107f:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
80101080:	8b 43 0c             	mov    0xc(%ebx),%eax
80101083:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101086:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101089:	5b                   	pop    %ebx
8010108a:	5e                   	pop    %esi
8010108b:	5f                   	pop    %edi
8010108c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010108d:	e9 d6 20 00 00       	jmp    80103168 <pipewrite>
  panic("filewrite");
80101092:	83 ec 0c             	sub    $0xc,%esp
80101095:	68 44 69 10 80       	push   $0x80106944
8010109a:	e8 99 f2 ff ff       	call   80100338 <panic>
8010109f:	90                   	nop

801010a0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801010a0:	55                   	push   %ebp
801010a1:	89 e5                	mov    %esp,%ebp
801010a3:	57                   	push   %edi
801010a4:	56                   	push   %esi
801010a5:	53                   	push   %ebx
801010a6:	83 ec 1c             	sub    $0x1c,%esp
801010a9:	89 45 dc             	mov    %eax,-0x24(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801010ac:	8b 0d b4 15 11 80    	mov    0x801115b4,%ecx
801010b2:	85 c9                	test   %ecx,%ecx
801010b4:	74 7f                	je     80101135 <balloc+0x95>
801010b6:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
801010b8:	83 ec 08             	sub    $0x8,%esp
801010bb:	89 f8                	mov    %edi,%eax
801010bd:	c1 f8 0c             	sar    $0xc,%eax
801010c0:	03 05 cc 15 11 80    	add    0x801115cc,%eax
801010c6:	50                   	push   %eax
801010c7:	ff 75 dc             	push   -0x24(%ebp)
801010ca:	e8 e5 ef ff ff       	call   801000b4 <bread>
801010cf:	89 c3                	mov    %eax,%ebx
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801010d1:	a1 b4 15 11 80       	mov    0x801115b4,%eax
801010d6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010d9:	89 fe                	mov    %edi,%esi
801010db:	83 c4 10             	add    $0x10,%esp
801010de:	31 c0                	xor    %eax,%eax
801010e0:	89 7d d8             	mov    %edi,-0x28(%ebp)
801010e3:	eb 2c                	jmp    80101111 <balloc+0x71>
801010e5:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801010e8:	89 c1                	mov    %eax,%ecx
801010ea:	83 e1 07             	and    $0x7,%ecx
801010ed:	ba 01 00 00 00       	mov    $0x1,%edx
801010f2:	d3 e2                	shl    %cl,%edx
801010f4:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801010f7:	89 c1                	mov    %eax,%ecx
801010f9:	c1 f9 03             	sar    $0x3,%ecx
801010fc:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101101:	89 fa                	mov    %edi,%edx
80101103:	85 7d e4             	test   %edi,-0x1c(%ebp)
80101106:	74 3c                	je     80101144 <balloc+0xa4>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101108:	40                   	inc    %eax
80101109:	46                   	inc    %esi
8010110a:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010110f:	74 07                	je     80101118 <balloc+0x78>
80101111:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101114:	39 fe                	cmp    %edi,%esi
80101116:	72 d0                	jb     801010e8 <balloc+0x48>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101118:	8b 7d d8             	mov    -0x28(%ebp),%edi
8010111b:	83 ec 0c             	sub    $0xc,%esp
8010111e:	53                   	push   %ebx
8010111f:	e8 98 f0 ff ff       	call   801001bc <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101124:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010112a:	83 c4 10             	add    $0x10,%esp
8010112d:	3b 3d b4 15 11 80    	cmp    0x801115b4,%edi
80101133:	72 83                	jb     801010b8 <balloc+0x18>
  }
  panic("balloc: out of blocks");
80101135:	83 ec 0c             	sub    $0xc,%esp
80101138:	68 4e 69 10 80       	push   $0x8010694e
8010113d:	e8 f6 f1 ff ff       	call   80100338 <panic>
80101142:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101144:	0b 55 e4             	or     -0x1c(%ebp),%edx
80101147:	88 54 0b 5c          	mov    %dl,0x5c(%ebx,%ecx,1)
        log_write(bp);
8010114b:	83 ec 0c             	sub    $0xc,%esp
8010114e:	53                   	push   %ebx
8010114f:	e8 28 1a 00 00       	call   80102b7c <log_write>
        brelse(bp);
80101154:	89 1c 24             	mov    %ebx,(%esp)
80101157:	e8 60 f0 ff ff       	call   801001bc <brelse>
  bp = bread(dev, bno);
8010115c:	58                   	pop    %eax
8010115d:	5a                   	pop    %edx
8010115e:	56                   	push   %esi
8010115f:	ff 75 dc             	push   -0x24(%ebp)
80101162:	e8 4d ef ff ff       	call   801000b4 <bread>
80101167:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101169:	83 c4 0c             	add    $0xc,%esp
8010116c:	68 00 02 00 00       	push   $0x200
80101171:	6a 00                	push   $0x0
80101173:	8d 40 5c             	lea    0x5c(%eax),%eax
80101176:	50                   	push   %eax
80101177:	e8 8c 2f 00 00       	call   80104108 <memset>
  log_write(bp);
8010117c:	89 1c 24             	mov    %ebx,(%esp)
8010117f:	e8 f8 19 00 00       	call   80102b7c <log_write>
  brelse(bp);
80101184:	89 1c 24             	mov    %ebx,(%esp)
80101187:	e8 30 f0 ff ff       	call   801001bc <brelse>
}
8010118c:	89 f0                	mov    %esi,%eax
8010118e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101191:	5b                   	pop    %ebx
80101192:	5e                   	pop    %esi
80101193:	5f                   	pop    %edi
80101194:	5d                   	pop    %ebp
80101195:	c3                   	ret
80101196:	66 90                	xchg   %ax,%ax

80101198 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101198:	55                   	push   %ebp
80101199:	89 e5                	mov    %esp,%ebp
8010119b:	57                   	push   %edi
8010119c:	56                   	push   %esi
8010119d:	53                   	push   %ebx
8010119e:	83 ec 28             	sub    $0x28,%esp
801011a1:	89 c6                	mov    %eax,%esi
801011a3:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
801011a6:	68 60 f9 10 80       	push   $0x8010f960
801011ab:	e8 7c 2e 00 00       	call   8010402c <acquire>
801011b0:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
801011b3:	31 ff                	xor    %edi,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801011b5:	bb 94 f9 10 80       	mov    $0x8010f994,%ebx
801011ba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801011bd:	eb 13                	jmp    801011d2 <iget+0x3a>
801011bf:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801011c0:	39 33                	cmp    %esi,(%ebx)
801011c2:	74 64                	je     80101228 <iget+0x90>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801011c4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801011ca:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
801011d0:	74 22                	je     801011f4 <iget+0x5c>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801011d2:	8b 43 08             	mov    0x8(%ebx),%eax
801011d5:	85 c0                	test   %eax,%eax
801011d7:	7f e7                	jg     801011c0 <iget+0x28>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801011d9:	85 ff                	test   %edi,%edi
801011db:	75 e7                	jne    801011c4 <iget+0x2c>
801011dd:	85 c0                	test   %eax,%eax
801011df:	75 6c                	jne    8010124d <iget+0xb5>
      empty = ip;
801011e1:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801011e3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801011e9:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
801011ef:	75 e1                	jne    801011d2 <iget+0x3a>
801011f1:	8d 76 00             	lea    0x0(%esi),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801011f4:	85 ff                	test   %edi,%edi
801011f6:	74 73                	je     8010126b <iget+0xd3>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
801011f8:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
801011fa:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
801011fd:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
80101204:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
8010120b:	83 ec 0c             	sub    $0xc,%esp
8010120e:	68 60 f9 10 80       	push   $0x8010f960
80101213:	e8 b4 2d 00 00       	call   80103fcc <release>

  return ip;
80101218:	83 c4 10             	add    $0x10,%esp
}
8010121b:	89 f8                	mov    %edi,%eax
8010121d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101220:	5b                   	pop    %ebx
80101221:	5e                   	pop    %esi
80101222:	5f                   	pop    %edi
80101223:	5d                   	pop    %ebp
80101224:	c3                   	ret
80101225:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101228:	39 53 04             	cmp    %edx,0x4(%ebx)
8010122b:	75 97                	jne    801011c4 <iget+0x2c>
      ip->ref++;
8010122d:	40                   	inc    %eax
8010122e:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101231:	83 ec 0c             	sub    $0xc,%esp
80101234:	68 60 f9 10 80       	push   $0x8010f960
80101239:	e8 8e 2d 00 00       	call   80103fcc <release>
      return ip;
8010123e:	83 c4 10             	add    $0x10,%esp
80101241:	89 df                	mov    %ebx,%edi
}
80101243:	89 f8                	mov    %edi,%eax
80101245:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101248:	5b                   	pop    %ebx
80101249:	5e                   	pop    %esi
8010124a:	5f                   	pop    %edi
8010124b:	5d                   	pop    %ebp
8010124c:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010124d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101253:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
80101259:	74 10                	je     8010126b <iget+0xd3>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010125b:	8b 43 08             	mov    0x8(%ebx),%eax
8010125e:	85 c0                	test   %eax,%eax
80101260:	0f 8f 5a ff ff ff    	jg     801011c0 <iget+0x28>
80101266:	e9 72 ff ff ff       	jmp    801011dd <iget+0x45>
    panic("iget: no inodes");
8010126b:	83 ec 0c             	sub    $0xc,%esp
8010126e:	68 64 69 10 80       	push   $0x80106964
80101273:	e8 c0 f0 ff ff       	call   80100338 <panic>

80101278 <bfree>:
{
80101278:	55                   	push   %ebp
80101279:	89 e5                	mov    %esp,%ebp
8010127b:	56                   	push   %esi
8010127c:	53                   	push   %ebx
8010127d:	89 c1                	mov    %eax,%ecx
8010127f:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101281:	83 ec 08             	sub    $0x8,%esp
80101284:	89 d0                	mov    %edx,%eax
80101286:	c1 e8 0c             	shr    $0xc,%eax
80101289:	03 05 cc 15 11 80    	add    0x801115cc,%eax
8010128f:	50                   	push   %eax
80101290:	51                   	push   %ecx
80101291:	e8 1e ee ff ff       	call   801000b4 <bread>
80101296:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101298:	89 d9                	mov    %ebx,%ecx
8010129a:	83 e1 07             	and    $0x7,%ecx
8010129d:	b8 01 00 00 00       	mov    $0x1,%eax
801012a2:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801012a4:	c1 fb 03             	sar    $0x3,%ebx
801012a7:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801012ad:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801012b2:	83 c4 10             	add    $0x10,%esp
801012b5:	85 c1                	test   %eax,%ecx
801012b7:	74 23                	je     801012dc <bfree+0x64>
  bp->data[bi/8] &= ~m;
801012b9:	f7 d0                	not    %eax
801012bb:	21 c8                	and    %ecx,%eax
801012bd:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801012c1:	83 ec 0c             	sub    $0xc,%esp
801012c4:	56                   	push   %esi
801012c5:	e8 b2 18 00 00       	call   80102b7c <log_write>
  brelse(bp);
801012ca:	89 34 24             	mov    %esi,(%esp)
801012cd:	e8 ea ee ff ff       	call   801001bc <brelse>
}
801012d2:	83 c4 10             	add    $0x10,%esp
801012d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801012d8:	5b                   	pop    %ebx
801012d9:	5e                   	pop    %esi
801012da:	5d                   	pop    %ebp
801012db:	c3                   	ret
    panic("freeing free block");
801012dc:	83 ec 0c             	sub    $0xc,%esp
801012df:	68 74 69 10 80       	push   $0x80106974
801012e4:	e8 4f f0 ff ff       	call   80100338 <panic>
801012e9:	8d 76 00             	lea    0x0(%esi),%esi

801012ec <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012ec:	55                   	push   %ebp
801012ed:	89 e5                	mov    %esp,%ebp
801012ef:	57                   	push   %edi
801012f0:	56                   	push   %esi
801012f1:	53                   	push   %ebx
801012f2:	83 ec 1c             	sub    $0x1c,%esp
801012f5:	89 c6                	mov    %eax,%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012f7:	83 fa 0b             	cmp    $0xb,%edx
801012fa:	76 7c                	jbe    80101378 <bmap+0x8c>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801012fc:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801012ff:	83 fb 7f             	cmp    $0x7f,%ebx
80101302:	0f 87 8e 00 00 00    	ja     80101396 <bmap+0xaa>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101308:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010130e:	85 c0                	test   %eax,%eax
80101310:	74 56                	je     80101368 <bmap+0x7c>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101312:	83 ec 08             	sub    $0x8,%esp
80101315:	50                   	push   %eax
80101316:	ff 36                	push   (%esi)
80101318:	e8 97 ed ff ff       	call   801000b4 <bread>
8010131d:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
8010131f:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
80101323:	8b 03                	mov    (%ebx),%eax
80101325:	83 c4 10             	add    $0x10,%esp
80101328:	85 c0                	test   %eax,%eax
8010132a:	74 1c                	je     80101348 <bmap+0x5c>
8010132c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
8010132f:	83 ec 0c             	sub    $0xc,%esp
80101332:	57                   	push   %edi
80101333:	e8 84 ee ff ff       	call   801001bc <brelse>
80101338:	83 c4 10             	add    $0x10,%esp
8010133b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    return addr;
  }

  panic("bmap: out of range");
}
8010133e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101341:	5b                   	pop    %ebx
80101342:	5e                   	pop    %esi
80101343:	5f                   	pop    %edi
80101344:	5d                   	pop    %ebp
80101345:	c3                   	ret
80101346:	66 90                	xchg   %ax,%ax
      a[bn] = addr = balloc(ip->dev);
80101348:	8b 06                	mov    (%esi),%eax
8010134a:	e8 51 fd ff ff       	call   801010a0 <balloc>
8010134f:	89 03                	mov    %eax,(%ebx)
80101351:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      log_write(bp);
80101354:	83 ec 0c             	sub    $0xc,%esp
80101357:	57                   	push   %edi
80101358:	e8 1f 18 00 00       	call   80102b7c <log_write>
8010135d:	83 c4 10             	add    $0x10,%esp
80101360:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101363:	eb c7                	jmp    8010132c <bmap+0x40>
80101365:	8d 76 00             	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101368:	8b 06                	mov    (%esi),%eax
8010136a:	e8 31 fd ff ff       	call   801010a0 <balloc>
8010136f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101375:	eb 9b                	jmp    80101312 <bmap+0x26>
80101377:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80101378:	8d 5a 14             	lea    0x14(%edx),%ebx
8010137b:	8b 44 98 0c          	mov    0xc(%eax,%ebx,4),%eax
8010137f:	85 c0                	test   %eax,%eax
80101381:	75 bb                	jne    8010133e <bmap+0x52>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101383:	8b 06                	mov    (%esi),%eax
80101385:	e8 16 fd ff ff       	call   801010a0 <balloc>
8010138a:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
}
8010138e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101391:	5b                   	pop    %ebx
80101392:	5e                   	pop    %esi
80101393:	5f                   	pop    %edi
80101394:	5d                   	pop    %ebp
80101395:	c3                   	ret
  panic("bmap: out of range");
80101396:	83 ec 0c             	sub    $0xc,%esp
80101399:	68 87 69 10 80       	push   $0x80106987
8010139e:	e8 95 ef ff ff       	call   80100338 <panic>
801013a3:	90                   	nop

801013a4 <readsb>:
{
801013a4:	55                   	push   %ebp
801013a5:	89 e5                	mov    %esp,%ebp
801013a7:	56                   	push   %esi
801013a8:	53                   	push   %ebx
801013a9:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013ac:	83 ec 08             	sub    $0x8,%esp
801013af:	6a 01                	push   $0x1
801013b1:	ff 75 08             	push   0x8(%ebp)
801013b4:	e8 fb ec ff ff       	call   801000b4 <bread>
801013b9:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013bb:	83 c4 0c             	add    $0xc,%esp
801013be:	6a 1c                	push   $0x1c
801013c0:	8d 40 5c             	lea    0x5c(%eax),%eax
801013c3:	50                   	push   %eax
801013c4:	56                   	push   %esi
801013c5:	e8 ba 2d 00 00       	call   80104184 <memmove>
  brelse(bp);
801013ca:	83 c4 10             	add    $0x10,%esp
801013cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801013d0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013d3:	5b                   	pop    %ebx
801013d4:	5e                   	pop    %esi
801013d5:	5d                   	pop    %ebp
  brelse(bp);
801013d6:	e9 e1 ed ff ff       	jmp    801001bc <brelse>
801013db:	90                   	nop

801013dc <iinit>:
{
801013dc:	55                   	push   %ebp
801013dd:	89 e5                	mov    %esp,%ebp
801013df:	53                   	push   %ebx
801013e0:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801013e3:	68 9a 69 10 80       	push   $0x8010699a
801013e8:	68 60 f9 10 80       	push   $0x8010f960
801013ed:	e8 62 2a 00 00       	call   80103e54 <initlock>
  for(i = 0; i < NINODE; i++) {
801013f2:	bb a0 f9 10 80       	mov    $0x8010f9a0,%ebx
801013f7:	83 c4 10             	add    $0x10,%esp
801013fa:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801013fc:	83 ec 08             	sub    $0x8,%esp
801013ff:	68 a1 69 10 80       	push   $0x801069a1
80101404:	53                   	push   %ebx
80101405:	e8 3e 29 00 00       	call   80103d48 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
8010140a:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101410:	83 c4 10             	add    $0x10,%esp
80101413:	81 fb c0 15 11 80    	cmp    $0x801115c0,%ebx
80101419:	75 e1                	jne    801013fc <iinit+0x20>
  bp = bread(dev, 1);
8010141b:	83 ec 08             	sub    $0x8,%esp
8010141e:	6a 01                	push   $0x1
80101420:	ff 75 08             	push   0x8(%ebp)
80101423:	e8 8c ec ff ff       	call   801000b4 <bread>
80101428:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010142a:	83 c4 0c             	add    $0xc,%esp
8010142d:	6a 1c                	push   $0x1c
8010142f:	8d 40 5c             	lea    0x5c(%eax),%eax
80101432:	50                   	push   %eax
80101433:	68 b4 15 11 80       	push   $0x801115b4
80101438:	e8 47 2d 00 00       	call   80104184 <memmove>
  brelse(bp);
8010143d:	89 1c 24             	mov    %ebx,(%esp)
80101440:	e8 77 ed ff ff       	call   801001bc <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101445:	ff 35 cc 15 11 80    	push   0x801115cc
8010144b:	ff 35 c8 15 11 80    	push   0x801115c8
80101451:	ff 35 c4 15 11 80    	push   0x801115c4
80101457:	ff 35 c0 15 11 80    	push   0x801115c0
8010145d:	ff 35 bc 15 11 80    	push   0x801115bc
80101463:	ff 35 b8 15 11 80    	push   0x801115b8
80101469:	ff 35 b4 15 11 80    	push   0x801115b4
8010146f:	68 c4 6d 10 80       	push   $0x80106dc4
80101474:	e8 af f1 ff ff       	call   80100628 <cprintf>
}
80101479:	83 c4 30             	add    $0x30,%esp
8010147c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010147f:	c9                   	leave
80101480:	c3                   	ret
80101481:	8d 76 00             	lea    0x0(%esi),%esi

80101484 <ialloc>:
{
80101484:	55                   	push   %ebp
80101485:	89 e5                	mov    %esp,%ebp
80101487:	57                   	push   %edi
80101488:	56                   	push   %esi
80101489:	53                   	push   %ebx
8010148a:	83 ec 1c             	sub    $0x1c,%esp
8010148d:	8b 75 08             	mov    0x8(%ebp),%esi
80101490:	8b 45 0c             	mov    0xc(%ebp),%eax
80101493:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101496:	83 3d bc 15 11 80 01 	cmpl   $0x1,0x801115bc
8010149d:	0f 86 84 00 00 00    	jbe    80101527 <ialloc+0xa3>
801014a3:	bf 01 00 00 00       	mov    $0x1,%edi
801014a8:	eb 17                	jmp    801014c1 <ialloc+0x3d>
801014aa:	66 90                	xchg   %ax,%ax
    brelse(bp);
801014ac:	83 ec 0c             	sub    $0xc,%esp
801014af:	53                   	push   %ebx
801014b0:	e8 07 ed ff ff       	call   801001bc <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801014b5:	47                   	inc    %edi
801014b6:	83 c4 10             	add    $0x10,%esp
801014b9:	3b 3d bc 15 11 80    	cmp    0x801115bc,%edi
801014bf:	73 66                	jae    80101527 <ialloc+0xa3>
    bp = bread(dev, IBLOCK(inum, sb));
801014c1:	83 ec 08             	sub    $0x8,%esp
801014c4:	89 f8                	mov    %edi,%eax
801014c6:	c1 e8 03             	shr    $0x3,%eax
801014c9:	03 05 c8 15 11 80    	add    0x801115c8,%eax
801014cf:	50                   	push   %eax
801014d0:	56                   	push   %esi
801014d1:	e8 de eb ff ff       	call   801000b4 <bread>
801014d6:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801014d8:	89 f8                	mov    %edi,%eax
801014da:	83 e0 07             	and    $0x7,%eax
801014dd:	c1 e0 06             	shl    $0x6,%eax
801014e0:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801014e4:	83 c4 10             	add    $0x10,%esp
801014e7:	66 83 39 00          	cmpw   $0x0,(%ecx)
801014eb:	75 bf                	jne    801014ac <ialloc+0x28>
      memset(dip, 0, sizeof(*dip));
801014ed:	50                   	push   %eax
801014ee:	6a 40                	push   $0x40
801014f0:	6a 00                	push   $0x0
801014f2:	51                   	push   %ecx
801014f3:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801014f6:	e8 0d 2c 00 00       	call   80104108 <memset>
      dip->type = type;
801014fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801014fe:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101501:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101504:	89 1c 24             	mov    %ebx,(%esp)
80101507:	e8 70 16 00 00       	call   80102b7c <log_write>
      brelse(bp);
8010150c:	89 1c 24             	mov    %ebx,(%esp)
8010150f:	e8 a8 ec ff ff       	call   801001bc <brelse>
      return iget(dev, inum);
80101514:	83 c4 10             	add    $0x10,%esp
80101517:	89 fa                	mov    %edi,%edx
80101519:	89 f0                	mov    %esi,%eax
}
8010151b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010151e:	5b                   	pop    %ebx
8010151f:	5e                   	pop    %esi
80101520:	5f                   	pop    %edi
80101521:	5d                   	pop    %ebp
      return iget(dev, inum);
80101522:	e9 71 fc ff ff       	jmp    80101198 <iget>
  panic("ialloc: no inodes");
80101527:	83 ec 0c             	sub    $0xc,%esp
8010152a:	68 a7 69 10 80       	push   $0x801069a7
8010152f:	e8 04 ee ff ff       	call   80100338 <panic>

80101534 <iupdate>:
{
80101534:	55                   	push   %ebp
80101535:	89 e5                	mov    %esp,%ebp
80101537:	56                   	push   %esi
80101538:	53                   	push   %ebx
80101539:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010153c:	83 ec 08             	sub    $0x8,%esp
8010153f:	8b 43 04             	mov    0x4(%ebx),%eax
80101542:	c1 e8 03             	shr    $0x3,%eax
80101545:	03 05 c8 15 11 80    	add    0x801115c8,%eax
8010154b:	50                   	push   %eax
8010154c:	ff 33                	push   (%ebx)
8010154e:	e8 61 eb ff ff       	call   801000b4 <bread>
80101553:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101555:	8b 43 04             	mov    0x4(%ebx),%eax
80101558:	83 e0 07             	and    $0x7,%eax
8010155b:	c1 e0 06             	shl    $0x6,%eax
8010155e:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101562:	8b 53 50             	mov    0x50(%ebx),%edx
80101565:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101568:	66 8b 53 52          	mov    0x52(%ebx),%dx
8010156c:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
80101570:	8b 53 54             	mov    0x54(%ebx),%edx
80101573:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101577:	66 8b 53 56          	mov    0x56(%ebx),%dx
8010157b:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
8010157f:	8b 53 58             	mov    0x58(%ebx),%edx
80101582:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101585:	83 c4 0c             	add    $0xc,%esp
80101588:	6a 34                	push   $0x34
8010158a:	83 c3 5c             	add    $0x5c,%ebx
8010158d:	53                   	push   %ebx
8010158e:	83 c0 0c             	add    $0xc,%eax
80101591:	50                   	push   %eax
80101592:	e8 ed 2b 00 00       	call   80104184 <memmove>
  log_write(bp);
80101597:	89 34 24             	mov    %esi,(%esp)
8010159a:	e8 dd 15 00 00       	call   80102b7c <log_write>
  brelse(bp);
8010159f:	83 c4 10             	add    $0x10,%esp
801015a2:	89 75 08             	mov    %esi,0x8(%ebp)
}
801015a5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015a8:	5b                   	pop    %ebx
801015a9:	5e                   	pop    %esi
801015aa:	5d                   	pop    %ebp
  brelse(bp);
801015ab:	e9 0c ec ff ff       	jmp    801001bc <brelse>

801015b0 <idup>:
{
801015b0:	55                   	push   %ebp
801015b1:	89 e5                	mov    %esp,%ebp
801015b3:	53                   	push   %ebx
801015b4:	83 ec 10             	sub    $0x10,%esp
801015b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801015ba:	68 60 f9 10 80       	push   $0x8010f960
801015bf:	e8 68 2a 00 00       	call   8010402c <acquire>
  ip->ref++;
801015c4:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801015c7:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
801015ce:	e8 f9 29 00 00       	call   80103fcc <release>
}
801015d3:	89 d8                	mov    %ebx,%eax
801015d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015d8:	c9                   	leave
801015d9:	c3                   	ret
801015da:	66 90                	xchg   %ax,%ax

801015dc <ilock>:
{
801015dc:	55                   	push   %ebp
801015dd:	89 e5                	mov    %esp,%ebp
801015df:	56                   	push   %esi
801015e0:	53                   	push   %ebx
801015e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801015e4:	85 db                	test   %ebx,%ebx
801015e6:	0f 84 a9 00 00 00    	je     80101695 <ilock+0xb9>
801015ec:	8b 53 08             	mov    0x8(%ebx),%edx
801015ef:	85 d2                	test   %edx,%edx
801015f1:	0f 8e 9e 00 00 00    	jle    80101695 <ilock+0xb9>
  acquiresleep(&ip->lock);
801015f7:	83 ec 0c             	sub    $0xc,%esp
801015fa:	8d 43 0c             	lea    0xc(%ebx),%eax
801015fd:	50                   	push   %eax
801015fe:	e8 79 27 00 00       	call   80103d7c <acquiresleep>
  if(ip->valid == 0){
80101603:	83 c4 10             	add    $0x10,%esp
80101606:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101609:	85 c0                	test   %eax,%eax
8010160b:	74 07                	je     80101614 <ilock+0x38>
}
8010160d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101610:	5b                   	pop    %ebx
80101611:	5e                   	pop    %esi
80101612:	5d                   	pop    %ebp
80101613:	c3                   	ret
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101614:	83 ec 08             	sub    $0x8,%esp
80101617:	8b 43 04             	mov    0x4(%ebx),%eax
8010161a:	c1 e8 03             	shr    $0x3,%eax
8010161d:	03 05 c8 15 11 80    	add    0x801115c8,%eax
80101623:	50                   	push   %eax
80101624:	ff 33                	push   (%ebx)
80101626:	e8 89 ea ff ff       	call   801000b4 <bread>
8010162b:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010162d:	8b 43 04             	mov    0x4(%ebx),%eax
80101630:	83 e0 07             	and    $0x7,%eax
80101633:	c1 e0 06             	shl    $0x6,%eax
80101636:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
8010163a:	8b 10                	mov    (%eax),%edx
8010163c:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101640:	66 8b 50 02          	mov    0x2(%eax),%dx
80101644:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101648:	8b 50 04             	mov    0x4(%eax),%edx
8010164b:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
8010164f:	66 8b 50 06          	mov    0x6(%eax),%dx
80101653:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101657:	8b 50 08             	mov    0x8(%eax),%edx
8010165a:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010165d:	83 c4 0c             	add    $0xc,%esp
80101660:	6a 34                	push   $0x34
80101662:	83 c0 0c             	add    $0xc,%eax
80101665:	50                   	push   %eax
80101666:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101669:	50                   	push   %eax
8010166a:	e8 15 2b 00 00       	call   80104184 <memmove>
    brelse(bp);
8010166f:	89 34 24             	mov    %esi,(%esp)
80101672:	e8 45 eb ff ff       	call   801001bc <brelse>
    ip->valid = 1;
80101677:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
8010167e:	83 c4 10             	add    $0x10,%esp
80101681:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
80101686:	75 85                	jne    8010160d <ilock+0x31>
      panic("ilock: no type");
80101688:	83 ec 0c             	sub    $0xc,%esp
8010168b:	68 bf 69 10 80       	push   $0x801069bf
80101690:	e8 a3 ec ff ff       	call   80100338 <panic>
    panic("ilock");
80101695:	83 ec 0c             	sub    $0xc,%esp
80101698:	68 b9 69 10 80       	push   $0x801069b9
8010169d:	e8 96 ec ff ff       	call   80100338 <panic>
801016a2:	66 90                	xchg   %ax,%ax

801016a4 <iunlock>:
{
801016a4:	55                   	push   %ebp
801016a5:	89 e5                	mov    %esp,%ebp
801016a7:	56                   	push   %esi
801016a8:	53                   	push   %ebx
801016a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801016ac:	85 db                	test   %ebx,%ebx
801016ae:	74 28                	je     801016d8 <iunlock+0x34>
801016b0:	8d 73 0c             	lea    0xc(%ebx),%esi
801016b3:	83 ec 0c             	sub    $0xc,%esp
801016b6:	56                   	push   %esi
801016b7:	e8 50 27 00 00       	call   80103e0c <holdingsleep>
801016bc:	83 c4 10             	add    $0x10,%esp
801016bf:	85 c0                	test   %eax,%eax
801016c1:	74 15                	je     801016d8 <iunlock+0x34>
801016c3:	8b 43 08             	mov    0x8(%ebx),%eax
801016c6:	85 c0                	test   %eax,%eax
801016c8:	7e 0e                	jle    801016d8 <iunlock+0x34>
  releasesleep(&ip->lock);
801016ca:	89 75 08             	mov    %esi,0x8(%ebp)
}
801016cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016d0:	5b                   	pop    %ebx
801016d1:	5e                   	pop    %esi
801016d2:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801016d3:	e9 f8 26 00 00       	jmp    80103dd0 <releasesleep>
    panic("iunlock");
801016d8:	83 ec 0c             	sub    $0xc,%esp
801016db:	68 ce 69 10 80       	push   $0x801069ce
801016e0:	e8 53 ec ff ff       	call   80100338 <panic>
801016e5:	8d 76 00             	lea    0x0(%esi),%esi

801016e8 <iput>:
{
801016e8:	55                   	push   %ebp
801016e9:	89 e5                	mov    %esp,%ebp
801016eb:	57                   	push   %edi
801016ec:	56                   	push   %esi
801016ed:	53                   	push   %ebx
801016ee:	83 ec 28             	sub    $0x28,%esp
801016f1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801016f4:	8d 7b 0c             	lea    0xc(%ebx),%edi
801016f7:	57                   	push   %edi
801016f8:	e8 7f 26 00 00       	call   80103d7c <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801016fd:	83 c4 10             	add    $0x10,%esp
80101700:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101703:	85 c0                	test   %eax,%eax
80101705:	74 07                	je     8010170e <iput+0x26>
80101707:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010170c:	74 2e                	je     8010173c <iput+0x54>
  releasesleep(&ip->lock);
8010170e:	83 ec 0c             	sub    $0xc,%esp
80101711:	57                   	push   %edi
80101712:	e8 b9 26 00 00       	call   80103dd0 <releasesleep>
  acquire(&icache.lock);
80101717:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
8010171e:	e8 09 29 00 00       	call   8010402c <acquire>
  ip->ref--;
80101723:	ff 4b 08             	decl   0x8(%ebx)
  release(&icache.lock);
80101726:	83 c4 10             	add    $0x10,%esp
80101729:	c7 45 08 60 f9 10 80 	movl   $0x8010f960,0x8(%ebp)
}
80101730:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101733:	5b                   	pop    %ebx
80101734:	5e                   	pop    %esi
80101735:	5f                   	pop    %edi
80101736:	5d                   	pop    %ebp
  release(&icache.lock);
80101737:	e9 90 28 00 00       	jmp    80103fcc <release>
    acquire(&icache.lock);
8010173c:	83 ec 0c             	sub    $0xc,%esp
8010173f:	68 60 f9 10 80       	push   $0x8010f960
80101744:	e8 e3 28 00 00       	call   8010402c <acquire>
    int r = ip->ref;
80101749:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
8010174c:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101753:	e8 74 28 00 00       	call   80103fcc <release>
    if(r == 1){
80101758:	83 c4 10             	add    $0x10,%esp
8010175b:	4e                   	dec    %esi
8010175c:	75 b0                	jne    8010170e <iput+0x26>
8010175e:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101761:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101767:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010176a:	89 df                	mov    %ebx,%edi
8010176c:	89 cb                	mov    %ecx,%ebx
8010176e:	eb 07                	jmp    80101777 <iput+0x8f>
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101770:	83 c6 04             	add    $0x4,%esi
80101773:	39 de                	cmp    %ebx,%esi
80101775:	74 15                	je     8010178c <iput+0xa4>
    if(ip->addrs[i]){
80101777:	8b 16                	mov    (%esi),%edx
80101779:	85 d2                	test   %edx,%edx
8010177b:	74 f3                	je     80101770 <iput+0x88>
      bfree(ip->dev, ip->addrs[i]);
8010177d:	8b 07                	mov    (%edi),%eax
8010177f:	e8 f4 fa ff ff       	call   80101278 <bfree>
      ip->addrs[i] = 0;
80101784:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010178a:	eb e4                	jmp    80101770 <iput+0x88>
    }
  }

  if(ip->addrs[NDIRECT]){
8010178c:	89 fb                	mov    %edi,%ebx
8010178e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101791:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101797:	85 c0                	test   %eax,%eax
80101799:	75 2d                	jne    801017c8 <iput+0xe0>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
8010179b:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801017a2:	83 ec 0c             	sub    $0xc,%esp
801017a5:	53                   	push   %ebx
801017a6:	e8 89 fd ff ff       	call   80101534 <iupdate>
      ip->type = 0;
801017ab:	66 c7 43 50 00 00    	movw   $0x0,0x50(%ebx)
      iupdate(ip);
801017b1:	89 1c 24             	mov    %ebx,(%esp)
801017b4:	e8 7b fd ff ff       	call   80101534 <iupdate>
      ip->valid = 0;
801017b9:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801017c0:	83 c4 10             	add    $0x10,%esp
801017c3:	e9 46 ff ff ff       	jmp    8010170e <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801017c8:	83 ec 08             	sub    $0x8,%esp
801017cb:	50                   	push   %eax
801017cc:	ff 33                	push   (%ebx)
801017ce:	e8 e1 e8 ff ff       	call   801000b4 <bread>
    for(j = 0; j < NINDIRECT; j++){
801017d3:	8d 70 5c             	lea    0x5c(%eax),%esi
801017d6:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801017dc:	83 c4 10             	add    $0x10,%esp
801017df:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801017e2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801017e5:	89 cf                	mov    %ecx,%edi
801017e7:	eb 0a                	jmp    801017f3 <iput+0x10b>
801017e9:	8d 76 00             	lea    0x0(%esi),%esi
801017ec:	83 c6 04             	add    $0x4,%esi
801017ef:	39 fe                	cmp    %edi,%esi
801017f1:	74 0f                	je     80101802 <iput+0x11a>
      if(a[j])
801017f3:	8b 16                	mov    (%esi),%edx
801017f5:	85 d2                	test   %edx,%edx
801017f7:	74 f3                	je     801017ec <iput+0x104>
        bfree(ip->dev, a[j]);
801017f9:	8b 03                	mov    (%ebx),%eax
801017fb:	e8 78 fa ff ff       	call   80101278 <bfree>
80101800:	eb ea                	jmp    801017ec <iput+0x104>
    brelse(bp);
80101802:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101805:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101808:	83 ec 0c             	sub    $0xc,%esp
8010180b:	50                   	push   %eax
8010180c:	e8 ab e9 ff ff       	call   801001bc <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101811:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101817:	8b 03                	mov    (%ebx),%eax
80101819:	e8 5a fa ff ff       	call   80101278 <bfree>
    ip->addrs[NDIRECT] = 0;
8010181e:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101825:	00 00 00 
80101828:	83 c4 10             	add    $0x10,%esp
8010182b:	e9 6b ff ff ff       	jmp    8010179b <iput+0xb3>

80101830 <iunlockput>:
{
80101830:	55                   	push   %ebp
80101831:	89 e5                	mov    %esp,%ebp
80101833:	56                   	push   %esi
80101834:	53                   	push   %ebx
80101835:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101838:	85 db                	test   %ebx,%ebx
8010183a:	74 34                	je     80101870 <iunlockput+0x40>
8010183c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010183f:	83 ec 0c             	sub    $0xc,%esp
80101842:	56                   	push   %esi
80101843:	e8 c4 25 00 00       	call   80103e0c <holdingsleep>
80101848:	83 c4 10             	add    $0x10,%esp
8010184b:	85 c0                	test   %eax,%eax
8010184d:	74 21                	je     80101870 <iunlockput+0x40>
8010184f:	8b 43 08             	mov    0x8(%ebx),%eax
80101852:	85 c0                	test   %eax,%eax
80101854:	7e 1a                	jle    80101870 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101856:	83 ec 0c             	sub    $0xc,%esp
80101859:	56                   	push   %esi
8010185a:	e8 71 25 00 00       	call   80103dd0 <releasesleep>
  iput(ip);
8010185f:	83 c4 10             	add    $0x10,%esp
80101862:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101865:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101868:	5b                   	pop    %ebx
80101869:	5e                   	pop    %esi
8010186a:	5d                   	pop    %ebp
  iput(ip);
8010186b:	e9 78 fe ff ff       	jmp    801016e8 <iput>
    panic("iunlock");
80101870:	83 ec 0c             	sub    $0xc,%esp
80101873:	68 ce 69 10 80       	push   $0x801069ce
80101878:	e8 bb ea ff ff       	call   80100338 <panic>
8010187d:	8d 76 00             	lea    0x0(%esi),%esi

80101880 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101880:	55                   	push   %ebp
80101881:	89 e5                	mov    %esp,%ebp
80101883:	8b 55 08             	mov    0x8(%ebp),%edx
80101886:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101889:	8b 0a                	mov    (%edx),%ecx
8010188b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010188e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101891:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101894:	8b 4a 50             	mov    0x50(%edx),%ecx
80101897:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010189a:	66 8b 4a 56          	mov    0x56(%edx),%cx
8010189e:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801018a2:	8b 52 58             	mov    0x58(%edx),%edx
801018a5:	89 50 10             	mov    %edx,0x10(%eax)
}
801018a8:	5d                   	pop    %ebp
801018a9:	c3                   	ret
801018aa:	66 90                	xchg   %ax,%ax

801018ac <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801018ac:	55                   	push   %ebp
801018ad:	89 e5                	mov    %esp,%ebp
801018af:	57                   	push   %edi
801018b0:	56                   	push   %esi
801018b1:	53                   	push   %ebx
801018b2:	83 ec 1c             	sub    $0x1c,%esp
801018b5:	8b 45 08             	mov    0x8(%ebp),%eax
801018b8:	89 45 d8             	mov    %eax,-0x28(%ebp)
801018bb:	8b 75 0c             	mov    0xc(%ebp),%esi
801018be:	89 75 e0             	mov    %esi,-0x20(%ebp)
801018c1:	8b 7d 10             	mov    0x10(%ebp),%edi
801018c4:	8b 75 14             	mov    0x14(%ebp),%esi
801018c7:	89 75 e4             	mov    %esi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801018ca:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
801018cf:	0f 84 af 00 00 00    	je     80101984 <readi+0xd8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801018d5:	8b 45 d8             	mov    -0x28(%ebp),%eax
801018d8:	8b 50 58             	mov    0x58(%eax),%edx
801018db:	39 fa                	cmp    %edi,%edx
801018dd:	0f 82 c2 00 00 00    	jb     801019a5 <readi+0xf9>
801018e3:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801018e6:	31 c0                	xor    %eax,%eax
801018e8:	01 f9                	add    %edi,%ecx
801018ea:	0f 92 c0             	setb   %al
801018ed:	89 c3                	mov    %eax,%ebx
801018ef:	0f 82 b0 00 00 00    	jb     801019a5 <readi+0xf9>
    return -1;
  if(off + n > ip->size)
801018f5:	39 ca                	cmp    %ecx,%edx
801018f7:	72 7f                	jb     80101978 <readi+0xcc>
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801018f9:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801018fc:	85 f6                	test   %esi,%esi
801018fe:	74 6a                	je     8010196a <readi+0xbe>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101900:	89 de                	mov    %ebx,%esi
80101902:	66 90                	xchg   %ax,%ax
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101904:	89 fa                	mov    %edi,%edx
80101906:	c1 ea 09             	shr    $0x9,%edx
80101909:	8b 5d d8             	mov    -0x28(%ebp),%ebx
8010190c:	89 d8                	mov    %ebx,%eax
8010190e:	e8 d9 f9 ff ff       	call   801012ec <bmap>
80101913:	83 ec 08             	sub    $0x8,%esp
80101916:	50                   	push   %eax
80101917:	ff 33                	push   (%ebx)
80101919:	e8 96 e7 ff ff       	call   801000b4 <bread>
8010191e:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101920:	89 f8                	mov    %edi,%eax
80101922:	25 ff 01 00 00       	and    $0x1ff,%eax
80101927:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010192a:	29 f1                	sub    %esi,%ecx
8010192c:	bb 00 02 00 00       	mov    $0x200,%ebx
80101931:	29 c3                	sub    %eax,%ebx
80101933:	83 c4 10             	add    $0x10,%esp
80101936:	39 d9                	cmp    %ebx,%ecx
80101938:	73 02                	jae    8010193c <readi+0x90>
8010193a:	89 cb                	mov    %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
8010193c:	51                   	push   %ecx
8010193d:	53                   	push   %ebx
8010193e:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101942:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101945:	50                   	push   %eax
80101946:	ff 75 e0             	push   -0x20(%ebp)
80101949:	e8 36 28 00 00       	call   80104184 <memmove>
    brelse(bp);
8010194e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101951:	89 14 24             	mov    %edx,(%esp)
80101954:	e8 63 e8 ff ff       	call   801001bc <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101959:	01 de                	add    %ebx,%esi
8010195b:	01 df                	add    %ebx,%edi
8010195d:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101960:	83 c4 10             	add    $0x10,%esp
80101963:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101966:	39 c6                	cmp    %eax,%esi
80101968:	72 9a                	jb     80101904 <readi+0x58>
  }
  return n;
8010196a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
8010196d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101970:	5b                   	pop    %ebx
80101971:	5e                   	pop    %esi
80101972:	5f                   	pop    %edi
80101973:	5d                   	pop    %ebp
80101974:	c3                   	ret
80101975:	8d 76 00             	lea    0x0(%esi),%esi
    n = ip->size - off;
80101978:	29 fa                	sub    %edi,%edx
8010197a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010197d:	e9 77 ff ff ff       	jmp    801018f9 <readi+0x4d>
80101982:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101984:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101988:	66 83 f8 09          	cmp    $0x9,%ax
8010198c:	77 17                	ja     801019a5 <readi+0xf9>
8010198e:	8b 04 c5 00 f9 10 80 	mov    -0x7fef0700(,%eax,8),%eax
80101995:	85 c0                	test   %eax,%eax
80101997:	74 0c                	je     801019a5 <readi+0xf9>
    return devsw[ip->major].read(ip, dst, n);
80101999:	89 75 10             	mov    %esi,0x10(%ebp)
}
8010199c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010199f:	5b                   	pop    %ebx
801019a0:	5e                   	pop    %esi
801019a1:	5f                   	pop    %edi
801019a2:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
801019a3:	ff e0                	jmp    *%eax
      return -1;
801019a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801019aa:	eb c1                	jmp    8010196d <readi+0xc1>

801019ac <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801019ac:	55                   	push   %ebp
801019ad:	89 e5                	mov    %esp,%ebp
801019af:	57                   	push   %edi
801019b0:	56                   	push   %esi
801019b1:	53                   	push   %ebx
801019b2:	83 ec 1c             	sub    $0x1c,%esp
801019b5:	8b 45 08             	mov    0x8(%ebp),%eax
801019b8:	89 45 d8             	mov    %eax,-0x28(%ebp)
801019bb:	8b 75 0c             	mov    0xc(%ebp),%esi
801019be:	89 75 dc             	mov    %esi,-0x24(%ebp)
801019c1:	8b 7d 10             	mov    0x10(%ebp),%edi
801019c4:	8b 75 14             	mov    0x14(%ebp),%esi
801019c7:	89 75 e4             	mov    %esi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019ca:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
801019cf:	0f 84 b7 00 00 00    	je     80101a8c <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
801019d5:	8b 45 d8             	mov    -0x28(%ebp),%eax
801019d8:	39 78 58             	cmp    %edi,0x58(%eax)
801019db:	0f 82 e0 00 00 00    	jb     80101ac1 <writei+0x115>
801019e1:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801019e4:	89 f2                	mov    %esi,%edx
801019e6:	31 c0                	xor    %eax,%eax
801019e8:	01 fa                	add    %edi,%edx
801019ea:	0f 92 c0             	setb   %al
801019ed:	0f 82 ce 00 00 00    	jb     80101ac1 <writei+0x115>
    return -1;
  if(off + n > MAXFILE*BSIZE)
801019f3:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
801019f9:	0f 87 c2 00 00 00    	ja     80101ac1 <writei+0x115>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801019ff:	85 f6                	test   %esi,%esi
80101a01:	74 7c                	je     80101a7f <writei+0xd3>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101a03:	89 c6                	mov    %eax,%esi
80101a05:	89 7d e0             	mov    %edi,-0x20(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a08:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101a0b:	89 da                	mov    %ebx,%edx
80101a0d:	c1 ea 09             	shr    $0x9,%edx
80101a10:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101a13:	89 f8                	mov    %edi,%eax
80101a15:	e8 d2 f8 ff ff       	call   801012ec <bmap>
80101a1a:	83 ec 08             	sub    $0x8,%esp
80101a1d:	50                   	push   %eax
80101a1e:	ff 37                	push   (%edi)
80101a20:	e8 8f e6 ff ff       	call   801000b4 <bread>
80101a25:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101a27:	89 d8                	mov    %ebx,%eax
80101a29:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a2e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101a31:	29 f1                	sub    %esi,%ecx
80101a33:	bb 00 02 00 00       	mov    $0x200,%ebx
80101a38:	29 c3                	sub    %eax,%ebx
80101a3a:	83 c4 10             	add    $0x10,%esp
80101a3d:	39 d9                	cmp    %ebx,%ecx
80101a3f:	73 02                	jae    80101a43 <writei+0x97>
80101a41:	89 cb                	mov    %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101a43:	52                   	push   %edx
80101a44:	53                   	push   %ebx
80101a45:	ff 75 dc             	push   -0x24(%ebp)
80101a48:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
80101a4c:	50                   	push   %eax
80101a4d:	e8 32 27 00 00       	call   80104184 <memmove>
    log_write(bp);
80101a52:	89 3c 24             	mov    %edi,(%esp)
80101a55:	e8 22 11 00 00       	call   80102b7c <log_write>
    brelse(bp);
80101a5a:	89 3c 24             	mov    %edi,(%esp)
80101a5d:	e8 5a e7 ff ff       	call   801001bc <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a62:	01 de                	add    %ebx,%esi
80101a64:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a67:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101a6a:	83 c4 10             	add    $0x10,%esp
80101a6d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101a70:	39 c6                	cmp    %eax,%esi
80101a72:	72 94                	jb     80101a08 <writei+0x5c>
  }

  if(n > 0 && off > ip->size){
80101a74:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a77:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a7a:	39 78 58             	cmp    %edi,0x58(%eax)
80101a7d:	72 31                	jb     80101ab0 <writei+0x104>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101a7f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a82:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a85:	5b                   	pop    %ebx
80101a86:	5e                   	pop    %esi
80101a87:	5f                   	pop    %edi
80101a88:	5d                   	pop    %ebp
80101a89:	c3                   	ret
80101a8a:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101a8c:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a90:	66 83 f8 09          	cmp    $0x9,%ax
80101a94:	77 2b                	ja     80101ac1 <writei+0x115>
80101a96:	8b 04 c5 04 f9 10 80 	mov    -0x7fef06fc(,%eax,8),%eax
80101a9d:	85 c0                	test   %eax,%eax
80101a9f:	74 20                	je     80101ac1 <writei+0x115>
    return devsw[ip->major].write(ip, src, n);
80101aa1:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101aa4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101aa7:	5b                   	pop    %ebx
80101aa8:	5e                   	pop    %esi
80101aa9:	5f                   	pop    %edi
80101aaa:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101aab:	ff e0                	jmp    *%eax
80101aad:	8d 76 00             	lea    0x0(%esi),%esi
    ip->size = off;
80101ab0:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80101ab3:	83 ec 0c             	sub    $0xc,%esp
80101ab6:	50                   	push   %eax
80101ab7:	e8 78 fa ff ff       	call   80101534 <iupdate>
80101abc:	83 c4 10             	add    $0x10,%esp
80101abf:	eb be                	jmp    80101a7f <writei+0xd3>
      return -1;
80101ac1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ac6:	eb ba                	jmp    80101a82 <writei+0xd6>

80101ac8 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101ac8:	55                   	push   %ebp
80101ac9:	89 e5                	mov    %esp,%ebp
80101acb:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101ace:	6a 0e                	push   $0xe
80101ad0:	ff 75 0c             	push   0xc(%ebp)
80101ad3:	ff 75 08             	push   0x8(%ebp)
80101ad6:	e8 f5 26 00 00       	call   801041d0 <strncmp>
}
80101adb:	c9                   	leave
80101adc:	c3                   	ret
80101add:	8d 76 00             	lea    0x0(%esi),%esi

80101ae0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101ae0:	55                   	push   %ebp
80101ae1:	89 e5                	mov    %esp,%ebp
80101ae3:	57                   	push   %edi
80101ae4:	56                   	push   %esi
80101ae5:	53                   	push   %ebx
80101ae6:	83 ec 1c             	sub    $0x1c,%esp
80101ae9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101aec:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101af1:	75 7d                	jne    80101b70 <dirlookup+0x90>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101af3:	8b 4b 58             	mov    0x58(%ebx),%ecx
80101af6:	85 c9                	test   %ecx,%ecx
80101af8:	74 3d                	je     80101b37 <dirlookup+0x57>
80101afa:	31 ff                	xor    %edi,%edi
80101afc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101aff:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101b00:	6a 10                	push   $0x10
80101b02:	57                   	push   %edi
80101b03:	56                   	push   %esi
80101b04:	53                   	push   %ebx
80101b05:	e8 a2 fd ff ff       	call   801018ac <readi>
80101b0a:	83 c4 10             	add    $0x10,%esp
80101b0d:	83 f8 10             	cmp    $0x10,%eax
80101b10:	75 51                	jne    80101b63 <dirlookup+0x83>
      panic("dirlookup read");
    if(de.inum == 0)
80101b12:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101b17:	74 16                	je     80101b2f <dirlookup+0x4f>
  return strncmp(s, t, DIRSIZ);
80101b19:	52                   	push   %edx
80101b1a:	6a 0e                	push   $0xe
80101b1c:	8d 45 da             	lea    -0x26(%ebp),%eax
80101b1f:	50                   	push   %eax
80101b20:	ff 75 0c             	push   0xc(%ebp)
80101b23:	e8 a8 26 00 00       	call   801041d0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101b28:	83 c4 10             	add    $0x10,%esp
80101b2b:	85 c0                	test   %eax,%eax
80101b2d:	74 15                	je     80101b44 <dirlookup+0x64>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101b2f:	83 c7 10             	add    $0x10,%edi
80101b32:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101b35:	72 c9                	jb     80101b00 <dirlookup+0x20>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101b37:	31 c0                	xor    %eax,%eax
}
80101b39:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b3c:	5b                   	pop    %ebx
80101b3d:	5e                   	pop    %esi
80101b3e:	5f                   	pop    %edi
80101b3f:	5d                   	pop    %ebp
80101b40:	c3                   	ret
80101b41:	8d 76 00             	lea    0x0(%esi),%esi
      if(poff)
80101b44:	8b 45 10             	mov    0x10(%ebp),%eax
80101b47:	85 c0                	test   %eax,%eax
80101b49:	74 05                	je     80101b50 <dirlookup+0x70>
        *poff = off;
80101b4b:	8b 45 10             	mov    0x10(%ebp),%eax
80101b4e:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101b50:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101b54:	8b 03                	mov    (%ebx),%eax
80101b56:	e8 3d f6 ff ff       	call   80101198 <iget>
}
80101b5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b5e:	5b                   	pop    %ebx
80101b5f:	5e                   	pop    %esi
80101b60:	5f                   	pop    %edi
80101b61:	5d                   	pop    %ebp
80101b62:	c3                   	ret
      panic("dirlookup read");
80101b63:	83 ec 0c             	sub    $0xc,%esp
80101b66:	68 e8 69 10 80       	push   $0x801069e8
80101b6b:	e8 c8 e7 ff ff       	call   80100338 <panic>
    panic("dirlookup not DIR");
80101b70:	83 ec 0c             	sub    $0xc,%esp
80101b73:	68 d6 69 10 80       	push   $0x801069d6
80101b78:	e8 bb e7 ff ff       	call   80100338 <panic>
80101b7d:	8d 76 00             	lea    0x0(%esi),%esi

80101b80 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101b80:	55                   	push   %ebp
80101b81:	89 e5                	mov    %esp,%ebp
80101b83:	57                   	push   %edi
80101b84:	56                   	push   %esi
80101b85:	53                   	push   %ebx
80101b86:	83 ec 1c             	sub    $0x1c,%esp
80101b89:	89 c3                	mov    %eax,%ebx
80101b8b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101b8e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101b91:	80 38 2f             	cmpb   $0x2f,(%eax)
80101b94:	0f 84 7c 01 00 00    	je     80101d16 <namex+0x196>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101b9a:	e8 69 19 00 00       	call   80103508 <myproc>
80101b9f:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101ba2:	83 ec 0c             	sub    $0xc,%esp
80101ba5:	68 60 f9 10 80       	push   $0x8010f960
80101baa:	e8 7d 24 00 00       	call   8010402c <acquire>
  ip->ref++;
80101baf:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101bb2:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101bb9:	e8 0e 24 00 00       	call   80103fcc <release>
80101bbe:	83 c4 10             	add    $0x10,%esp
80101bc1:	eb 02                	jmp    80101bc5 <namex+0x45>
80101bc3:	90                   	nop
    path++;
80101bc4:	43                   	inc    %ebx
  while(*path == '/')
80101bc5:	8a 03                	mov    (%ebx),%al
80101bc7:	3c 2f                	cmp    $0x2f,%al
80101bc9:	74 f9                	je     80101bc4 <namex+0x44>
  if(*path == 0)
80101bcb:	84 c0                	test   %al,%al
80101bcd:	0f 84 e9 00 00 00    	je     80101cbc <namex+0x13c>
  while(*path != '/' && *path != 0)
80101bd3:	8a 03                	mov    (%ebx),%al
80101bd5:	89 df                	mov    %ebx,%edi
80101bd7:	3c 2f                	cmp    $0x2f,%al
80101bd9:	75 0c                	jne    80101be7 <namex+0x67>
80101bdb:	e9 2f 01 00 00       	jmp    80101d0f <namex+0x18f>
    path++;
80101be0:	47                   	inc    %edi
  while(*path != '/' && *path != 0)
80101be1:	8a 07                	mov    (%edi),%al
80101be3:	3c 2f                	cmp    $0x2f,%al
80101be5:	74 04                	je     80101beb <namex+0x6b>
80101be7:	84 c0                	test   %al,%al
80101be9:	75 f5                	jne    80101be0 <namex+0x60>
  len = path - s;
80101beb:	89 f8                	mov    %edi,%eax
80101bed:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101bef:	83 f8 0d             	cmp    $0xd,%eax
80101bf2:	0f 8e a0 00 00 00    	jle    80101c98 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101bf8:	51                   	push   %ecx
80101bf9:	6a 0e                	push   $0xe
80101bfb:	53                   	push   %ebx
80101bfc:	ff 75 e4             	push   -0x1c(%ebp)
80101bff:	e8 80 25 00 00       	call   80104184 <memmove>
80101c04:	83 c4 10             	add    $0x10,%esp
80101c07:	89 fb                	mov    %edi,%ebx
  while(*path == '/')
80101c09:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101c0c:	75 08                	jne    80101c16 <namex+0x96>
80101c0e:	66 90                	xchg   %ax,%ax
    path++;
80101c10:	43                   	inc    %ebx
  while(*path == '/')
80101c11:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101c14:	74 fa                	je     80101c10 <namex+0x90>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101c16:	83 ec 0c             	sub    $0xc,%esp
80101c19:	56                   	push   %esi
80101c1a:	e8 bd f9 ff ff       	call   801015dc <ilock>
    if(ip->type != T_DIR){
80101c1f:	83 c4 10             	add    $0x10,%esp
80101c22:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101c27:	0f 85 a4 00 00 00    	jne    80101cd1 <namex+0x151>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101c2d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101c30:	85 c0                	test   %eax,%eax
80101c32:	74 09                	je     80101c3d <namex+0xbd>
80101c34:	80 3b 00             	cmpb   $0x0,(%ebx)
80101c37:	0f 84 ef 00 00 00    	je     80101d2c <namex+0x1ac>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101c3d:	50                   	push   %eax
80101c3e:	6a 00                	push   $0x0
80101c40:	ff 75 e4             	push   -0x1c(%ebp)
80101c43:	56                   	push   %esi
80101c44:	e8 97 fe ff ff       	call   80101ae0 <dirlookup>
80101c49:	89 c7                	mov    %eax,%edi
80101c4b:	83 c4 10             	add    $0x10,%esp
80101c4e:	85 c0                	test   %eax,%eax
80101c50:	74 7f                	je     80101cd1 <namex+0x151>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101c52:	8d 4e 0c             	lea    0xc(%esi),%ecx
80101c55:	83 ec 0c             	sub    $0xc,%esp
80101c58:	51                   	push   %ecx
80101c59:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101c5c:	e8 ab 21 00 00       	call   80103e0c <holdingsleep>
80101c61:	83 c4 10             	add    $0x10,%esp
80101c64:	85 c0                	test   %eax,%eax
80101c66:	0f 84 00 01 00 00    	je     80101d6c <namex+0x1ec>
80101c6c:	8b 46 08             	mov    0x8(%esi),%eax
80101c6f:	85 c0                	test   %eax,%eax
80101c71:	0f 8e f5 00 00 00    	jle    80101d6c <namex+0x1ec>
  releasesleep(&ip->lock);
80101c77:	83 ec 0c             	sub    $0xc,%esp
80101c7a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101c7d:	51                   	push   %ecx
80101c7e:	e8 4d 21 00 00       	call   80103dd0 <releasesleep>
  iput(ip);
80101c83:	89 34 24             	mov    %esi,(%esp)
80101c86:	e8 5d fa ff ff       	call   801016e8 <iput>
80101c8b:	83 c4 10             	add    $0x10,%esp
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101c8e:	89 fe                	mov    %edi,%esi
  while(*path == '/')
80101c90:	e9 30 ff ff ff       	jmp    80101bc5 <namex+0x45>
80101c95:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101c98:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101c9b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80101c9e:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    memmove(name, s, len);
80101ca1:	52                   	push   %edx
80101ca2:	50                   	push   %eax
80101ca3:	53                   	push   %ebx
80101ca4:	ff 75 e4             	push   -0x1c(%ebp)
80101ca7:	e8 d8 24 00 00       	call   80104184 <memmove>
    name[len] = 0;
80101cac:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101caf:	c6 01 00             	movb   $0x0,(%ecx)
80101cb2:	83 c4 10             	add    $0x10,%esp
80101cb5:	89 fb                	mov    %edi,%ebx
80101cb7:	e9 4d ff ff ff       	jmp    80101c09 <namex+0x89>
  }
  if(nameiparent){
80101cbc:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80101cbf:	85 db                	test   %ebx,%ebx
80101cc1:	0f 85 95 00 00 00    	jne    80101d5c <namex+0x1dc>
    iput(ip);
    return 0;
  }
  return ip;
}
80101cc7:	89 f0                	mov    %esi,%eax
80101cc9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ccc:	5b                   	pop    %ebx
80101ccd:	5e                   	pop    %esi
80101cce:	5f                   	pop    %edi
80101ccf:	5d                   	pop    %ebp
80101cd0:	c3                   	ret
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101cd1:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101cd4:	83 ec 0c             	sub    $0xc,%esp
80101cd7:	53                   	push   %ebx
80101cd8:	e8 2f 21 00 00       	call   80103e0c <holdingsleep>
80101cdd:	83 c4 10             	add    $0x10,%esp
80101ce0:	85 c0                	test   %eax,%eax
80101ce2:	0f 84 84 00 00 00    	je     80101d6c <namex+0x1ec>
80101ce8:	8b 46 08             	mov    0x8(%esi),%eax
80101ceb:	85 c0                	test   %eax,%eax
80101ced:	7e 7d                	jle    80101d6c <namex+0x1ec>
  releasesleep(&ip->lock);
80101cef:	83 ec 0c             	sub    $0xc,%esp
80101cf2:	53                   	push   %ebx
80101cf3:	e8 d8 20 00 00       	call   80103dd0 <releasesleep>
  iput(ip);
80101cf8:	89 34 24             	mov    %esi,(%esp)
80101cfb:	e8 e8 f9 ff ff       	call   801016e8 <iput>
      return 0;
80101d00:	83 c4 10             	add    $0x10,%esp
      return 0;
80101d03:	31 f6                	xor    %esi,%esi
}
80101d05:	89 f0                	mov    %esi,%eax
80101d07:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d0a:	5b                   	pop    %ebx
80101d0b:	5e                   	pop    %esi
80101d0c:	5f                   	pop    %edi
80101d0d:	5d                   	pop    %ebp
80101d0e:	c3                   	ret
  while(*path != '/' && *path != 0)
80101d0f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d12:	31 c0                	xor    %eax,%eax
80101d14:	eb 88                	jmp    80101c9e <namex+0x11e>
    ip = iget(ROOTDEV, ROOTINO);
80101d16:	ba 01 00 00 00       	mov    $0x1,%edx
80101d1b:	b8 01 00 00 00       	mov    $0x1,%eax
80101d20:	e8 73 f4 ff ff       	call   80101198 <iget>
80101d25:	89 c6                	mov    %eax,%esi
80101d27:	e9 99 fe ff ff       	jmp    80101bc5 <namex+0x45>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101d2c:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101d2f:	83 ec 0c             	sub    $0xc,%esp
80101d32:	53                   	push   %ebx
80101d33:	e8 d4 20 00 00       	call   80103e0c <holdingsleep>
80101d38:	83 c4 10             	add    $0x10,%esp
80101d3b:	85 c0                	test   %eax,%eax
80101d3d:	74 2d                	je     80101d6c <namex+0x1ec>
80101d3f:	8b 46 08             	mov    0x8(%esi),%eax
80101d42:	85 c0                	test   %eax,%eax
80101d44:	7e 26                	jle    80101d6c <namex+0x1ec>
  releasesleep(&ip->lock);
80101d46:	83 ec 0c             	sub    $0xc,%esp
80101d49:	53                   	push   %ebx
80101d4a:	e8 81 20 00 00       	call   80103dd0 <releasesleep>
}
80101d4f:	83 c4 10             	add    $0x10,%esp
}
80101d52:	89 f0                	mov    %esi,%eax
80101d54:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d57:	5b                   	pop    %ebx
80101d58:	5e                   	pop    %esi
80101d59:	5f                   	pop    %edi
80101d5a:	5d                   	pop    %ebp
80101d5b:	c3                   	ret
    iput(ip);
80101d5c:	83 ec 0c             	sub    $0xc,%esp
80101d5f:	56                   	push   %esi
80101d60:	e8 83 f9 ff ff       	call   801016e8 <iput>
    return 0;
80101d65:	83 c4 10             	add    $0x10,%esp
      return 0;
80101d68:	31 f6                	xor    %esi,%esi
80101d6a:	eb 99                	jmp    80101d05 <namex+0x185>
    panic("iunlock");
80101d6c:	83 ec 0c             	sub    $0xc,%esp
80101d6f:	68 ce 69 10 80       	push   $0x801069ce
80101d74:	e8 bf e5 ff ff       	call   80100338 <panic>
80101d79:	8d 76 00             	lea    0x0(%esi),%esi

80101d7c <dirlink>:
{
80101d7c:	55                   	push   %ebp
80101d7d:	89 e5                	mov    %esp,%ebp
80101d7f:	57                   	push   %edi
80101d80:	56                   	push   %esi
80101d81:	53                   	push   %ebx
80101d82:	83 ec 20             	sub    $0x20,%esp
80101d85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101d88:	6a 00                	push   $0x0
80101d8a:	ff 75 0c             	push   0xc(%ebp)
80101d8d:	53                   	push   %ebx
80101d8e:	e8 4d fd ff ff       	call   80101ae0 <dirlookup>
80101d93:	83 c4 10             	add    $0x10,%esp
80101d96:	85 c0                	test   %eax,%eax
80101d98:	75 65                	jne    80101dff <dirlink+0x83>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d9a:	8b 7b 58             	mov    0x58(%ebx),%edi
80101d9d:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101da0:	85 ff                	test   %edi,%edi
80101da2:	74 29                	je     80101dcd <dirlink+0x51>
80101da4:	31 ff                	xor    %edi,%edi
80101da6:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101da9:	eb 09                	jmp    80101db4 <dirlink+0x38>
80101dab:	90                   	nop
80101dac:	83 c7 10             	add    $0x10,%edi
80101daf:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101db2:	73 19                	jae    80101dcd <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101db4:	6a 10                	push   $0x10
80101db6:	57                   	push   %edi
80101db7:	56                   	push   %esi
80101db8:	53                   	push   %ebx
80101db9:	e8 ee fa ff ff       	call   801018ac <readi>
80101dbe:	83 c4 10             	add    $0x10,%esp
80101dc1:	83 f8 10             	cmp    $0x10,%eax
80101dc4:	75 4c                	jne    80101e12 <dirlink+0x96>
    if(de.inum == 0)
80101dc6:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101dcb:	75 df                	jne    80101dac <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101dcd:	50                   	push   %eax
80101dce:	6a 0e                	push   $0xe
80101dd0:	ff 75 0c             	push   0xc(%ebp)
80101dd3:	8d 45 da             	lea    -0x26(%ebp),%eax
80101dd6:	50                   	push   %eax
80101dd7:	e8 2c 24 00 00       	call   80104208 <strncpy>
  de.inum = inum;
80101ddc:	8b 45 10             	mov    0x10(%ebp),%eax
80101ddf:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101de3:	6a 10                	push   $0x10
80101de5:	57                   	push   %edi
80101de6:	56                   	push   %esi
80101de7:	53                   	push   %ebx
80101de8:	e8 bf fb ff ff       	call   801019ac <writei>
80101ded:	83 c4 20             	add    $0x20,%esp
80101df0:	83 f8 10             	cmp    $0x10,%eax
80101df3:	75 2a                	jne    80101e1f <dirlink+0xa3>
  return 0;
80101df5:	31 c0                	xor    %eax,%eax
}
80101df7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dfa:	5b                   	pop    %ebx
80101dfb:	5e                   	pop    %esi
80101dfc:	5f                   	pop    %edi
80101dfd:	5d                   	pop    %ebp
80101dfe:	c3                   	ret
    iput(ip);
80101dff:	83 ec 0c             	sub    $0xc,%esp
80101e02:	50                   	push   %eax
80101e03:	e8 e0 f8 ff ff       	call   801016e8 <iput>
    return -1;
80101e08:	83 c4 10             	add    $0x10,%esp
80101e0b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e10:	eb e5                	jmp    80101df7 <dirlink+0x7b>
      panic("dirlink read");
80101e12:	83 ec 0c             	sub    $0xc,%esp
80101e15:	68 f7 69 10 80       	push   $0x801069f7
80101e1a:	e8 19 e5 ff ff       	call   80100338 <panic>
    panic("dirlink");
80101e1f:	83 ec 0c             	sub    $0xc,%esp
80101e22:	68 53 6c 10 80       	push   $0x80106c53
80101e27:	e8 0c e5 ff ff       	call   80100338 <panic>

80101e2c <namei>:

struct inode*
namei(char *path)
{
80101e2c:	55                   	push   %ebp
80101e2d:	89 e5                	mov    %esp,%ebp
80101e2f:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101e32:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101e35:	31 d2                	xor    %edx,%edx
80101e37:	8b 45 08             	mov    0x8(%ebp),%eax
80101e3a:	e8 41 fd ff ff       	call   80101b80 <namex>
}
80101e3f:	c9                   	leave
80101e40:	c3                   	ret
80101e41:	8d 76 00             	lea    0x0(%esi),%esi

80101e44 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101e44:	55                   	push   %ebp
80101e45:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101e47:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101e4a:	ba 01 00 00 00       	mov    $0x1,%edx
80101e4f:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101e52:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101e53:	e9 28 fd ff ff       	jmp    80101b80 <namex>

80101e58 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101e58:	55                   	push   %ebp
80101e59:	89 e5                	mov    %esp,%ebp
80101e5b:	57                   	push   %edi
80101e5c:	56                   	push   %esi
80101e5d:	53                   	push   %ebx
80101e5e:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101e61:	85 c0                	test   %eax,%eax
80101e63:	0f 84 99 00 00 00    	je     80101f02 <idestart+0xaa>
80101e69:	89 c3                	mov    %eax,%ebx
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101e6b:	8b 70 08             	mov    0x8(%eax),%esi
80101e6e:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
80101e74:	77 7f                	ja     80101ef5 <idestart+0x9d>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101e76:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101e7b:	90                   	nop
80101e7c:	89 ca                	mov    %ecx,%edx
80101e7e:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101e7f:	83 e0 c0             	and    $0xffffffc0,%eax
80101e82:	3c 40                	cmp    $0x40,%al
80101e84:	75 f6                	jne    80101e7c <idestart+0x24>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101e86:	31 ff                	xor    %edi,%edi
80101e88:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101e8d:	89 f8                	mov    %edi,%eax
80101e8f:	ee                   	out    %al,(%dx)
80101e90:	b0 01                	mov    $0x1,%al
80101e92:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101e97:	ee                   	out    %al,(%dx)
80101e98:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101e9d:	89 f0                	mov    %esi,%eax
80101e9f:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101ea0:	89 f0                	mov    %esi,%eax
80101ea2:	c1 f8 08             	sar    $0x8,%eax
80101ea5:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101eaa:	ee                   	out    %al,(%dx)
80101eab:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101eb0:	89 f8                	mov    %edi,%eax
80101eb2:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101eb3:	8a 43 04             	mov    0x4(%ebx),%al
80101eb6:	c1 e0 04             	shl    $0x4,%eax
80101eb9:	83 e0 10             	and    $0x10,%eax
80101ebc:	83 c8 e0             	or     $0xffffffe0,%eax
80101ebf:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101ec4:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101ec5:	f6 03 04             	testb  $0x4,(%ebx)
80101ec8:	75 0e                	jne    80101ed8 <idestart+0x80>
80101eca:	b0 20                	mov    $0x20,%al
80101ecc:	89 ca                	mov    %ecx,%edx
80101ece:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101ecf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ed2:	5b                   	pop    %ebx
80101ed3:	5e                   	pop    %esi
80101ed4:	5f                   	pop    %edi
80101ed5:	5d                   	pop    %ebp
80101ed6:	c3                   	ret
80101ed7:	90                   	nop
80101ed8:	b0 30                	mov    $0x30,%al
80101eda:	89 ca                	mov    %ecx,%edx
80101edc:	ee                   	out    %al,(%dx)
    outsl(0x1f0, b->data, BSIZE/4);
80101edd:	8d 73 5c             	lea    0x5c(%ebx),%esi
  asm volatile("cld; rep outsl" :
80101ee0:	b9 80 00 00 00       	mov    $0x80,%ecx
80101ee5:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101eea:	fc                   	cld
80101eeb:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101eed:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ef0:	5b                   	pop    %ebx
80101ef1:	5e                   	pop    %esi
80101ef2:	5f                   	pop    %edi
80101ef3:	5d                   	pop    %ebp
80101ef4:	c3                   	ret
    panic("incorrect blockno");
80101ef5:	83 ec 0c             	sub    $0xc,%esp
80101ef8:	68 0d 6a 10 80       	push   $0x80106a0d
80101efd:	e8 36 e4 ff ff       	call   80100338 <panic>
    panic("idestart");
80101f02:	83 ec 0c             	sub    $0xc,%esp
80101f05:	68 04 6a 10 80       	push   $0x80106a04
80101f0a:	e8 29 e4 ff ff       	call   80100338 <panic>
80101f0f:	90                   	nop

80101f10 <ideinit>:
{
80101f10:	55                   	push   %ebp
80101f11:	89 e5                	mov    %esp,%ebp
80101f13:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80101f16:	68 1f 6a 10 80       	push   $0x80106a1f
80101f1b:	68 00 16 11 80       	push   $0x80111600
80101f20:	e8 2f 1f 00 00       	call   80103e54 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101f25:	58                   	pop    %eax
80101f26:	5a                   	pop    %edx
80101f27:	a1 84 17 11 80       	mov    0x80111784,%eax
80101f2c:	48                   	dec    %eax
80101f2d:	50                   	push   %eax
80101f2e:	6a 0e                	push   $0xe
80101f30:	e8 5b 02 00 00       	call   80102190 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f35:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f38:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f3d:	8d 76 00             	lea    0x0(%esi),%esi
80101f40:	89 ca                	mov    %ecx,%edx
80101f42:	ec                   	in     (%dx),%al
80101f43:	83 e0 c0             	and    $0xffffffc0,%eax
80101f46:	3c 40                	cmp    $0x40,%al
80101f48:	75 f6                	jne    80101f40 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f4a:	b0 f0                	mov    $0xf0,%al
80101f4c:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f51:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f52:	89 ca                	mov    %ecx,%edx
80101f54:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80101f55:	84 c0                	test   %al,%al
80101f57:	75 13                	jne    80101f6c <ideinit+0x5c>
80101f59:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80101f5e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f63:	90                   	nop
  for(i=0; i<1000; i++){
80101f64:	49                   	dec    %ecx
80101f65:	74 0f                	je     80101f76 <ideinit+0x66>
80101f67:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80101f68:	84 c0                	test   %al,%al
80101f6a:	74 f8                	je     80101f64 <ideinit+0x54>
      havedisk1 = 1;
80101f6c:	c7 05 e0 15 11 80 01 	movl   $0x1,0x801115e0
80101f73:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f76:	b0 e0                	mov    $0xe0,%al
80101f78:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f7d:	ee                   	out    %al,(%dx)
}
80101f7e:	c9                   	leave
80101f7f:	c3                   	ret

80101f80 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80101f80:	55                   	push   %ebp
80101f81:	89 e5                	mov    %esp,%ebp
80101f83:	57                   	push   %edi
80101f84:	56                   	push   %esi
80101f85:	53                   	push   %ebx
80101f86:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80101f89:	68 00 16 11 80       	push   $0x80111600
80101f8e:	e8 99 20 00 00       	call   8010402c <acquire>

  if((b = idequeue) == 0){
80101f93:	8b 1d e4 15 11 80    	mov    0x801115e4,%ebx
80101f99:	83 c4 10             	add    $0x10,%esp
80101f9c:	85 db                	test   %ebx,%ebx
80101f9e:	74 5b                	je     80101ffb <ideintr+0x7b>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80101fa0:	8b 43 58             	mov    0x58(%ebx),%eax
80101fa3:	a3 e4 15 11 80       	mov    %eax,0x801115e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80101fa8:	8b 33                	mov    (%ebx),%esi
80101faa:	f7 c6 04 00 00 00    	test   $0x4,%esi
80101fb0:	75 27                	jne    80101fd9 <ideintr+0x59>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101fb2:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fb7:	90                   	nop
80101fb8:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101fb9:	88 c1                	mov    %al,%cl
80101fbb:	83 e1 c0             	and    $0xffffffc0,%ecx
80101fbe:	80 f9 40             	cmp    $0x40,%cl
80101fc1:	75 f5                	jne    80101fb8 <ideintr+0x38>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80101fc3:	a8 21                	test   $0x21,%al
80101fc5:	75 12                	jne    80101fd9 <ideintr+0x59>
    insl(0x1f0, b->data, BSIZE/4);
80101fc7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80101fca:	b9 80 00 00 00       	mov    $0x80,%ecx
80101fcf:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fd4:	fc                   	cld
80101fd5:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80101fd7:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80101fd9:	83 e6 fb             	and    $0xfffffffb,%esi
80101fdc:	83 ce 02             	or     $0x2,%esi
80101fdf:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80101fe1:	83 ec 0c             	sub    $0xc,%esp
80101fe4:	53                   	push   %ebx
80101fe5:	e8 e2 1b 00 00       	call   80103bcc <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80101fea:	a1 e4 15 11 80       	mov    0x801115e4,%eax
80101fef:	83 c4 10             	add    $0x10,%esp
80101ff2:	85 c0                	test   %eax,%eax
80101ff4:	74 05                	je     80101ffb <ideintr+0x7b>
    idestart(idequeue);
80101ff6:	e8 5d fe ff ff       	call   80101e58 <idestart>
    release(&idelock);
80101ffb:	83 ec 0c             	sub    $0xc,%esp
80101ffe:	68 00 16 11 80       	push   $0x80111600
80102003:	e8 c4 1f 00 00       	call   80103fcc <release>

  release(&idelock);
}
80102008:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010200b:	5b                   	pop    %ebx
8010200c:	5e                   	pop    %esi
8010200d:	5f                   	pop    %edi
8010200e:	5d                   	pop    %ebp
8010200f:	c3                   	ret

80102010 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102010:	55                   	push   %ebp
80102011:	89 e5                	mov    %esp,%ebp
80102013:	53                   	push   %ebx
80102014:	83 ec 10             	sub    $0x10,%esp
80102017:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010201a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010201d:	50                   	push   %eax
8010201e:	e8 e9 1d 00 00       	call   80103e0c <holdingsleep>
80102023:	83 c4 10             	add    $0x10,%esp
80102026:	85 c0                	test   %eax,%eax
80102028:	0f 84 b7 00 00 00    	je     801020e5 <iderw+0xd5>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010202e:	8b 03                	mov    (%ebx),%eax
80102030:	83 e0 06             	and    $0x6,%eax
80102033:	83 f8 02             	cmp    $0x2,%eax
80102036:	0f 84 9c 00 00 00    	je     801020d8 <iderw+0xc8>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010203c:	8b 53 04             	mov    0x4(%ebx),%edx
8010203f:	85 d2                	test   %edx,%edx
80102041:	74 09                	je     8010204c <iderw+0x3c>
80102043:	a1 e0 15 11 80       	mov    0x801115e0,%eax
80102048:	85 c0                	test   %eax,%eax
8010204a:	74 7f                	je     801020cb <iderw+0xbb>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
8010204c:	83 ec 0c             	sub    $0xc,%esp
8010204f:	68 00 16 11 80       	push   $0x80111600
80102054:	e8 d3 1f 00 00       	call   8010402c <acquire>

  // Append b to idequeue.
  b->qnext = 0;
80102059:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102060:	a1 e4 15 11 80       	mov    0x801115e4,%eax
80102065:	83 c4 10             	add    $0x10,%esp
80102068:	85 c0                	test   %eax,%eax
8010206a:	74 58                	je     801020c4 <iderw+0xb4>
8010206c:	89 c2                	mov    %eax,%edx
8010206e:	8b 40 58             	mov    0x58(%eax),%eax
80102071:	85 c0                	test   %eax,%eax
80102073:	75 f7                	jne    8010206c <iderw+0x5c>
80102075:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102078:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010207a:	39 1d e4 15 11 80    	cmp    %ebx,0x801115e4
80102080:	74 36                	je     801020b8 <iderw+0xa8>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102082:	8b 03                	mov    (%ebx),%eax
80102084:	83 e0 06             	and    $0x6,%eax
80102087:	83 f8 02             	cmp    $0x2,%eax
8010208a:	74 1b                	je     801020a7 <iderw+0x97>
    sleep(b, &idelock);
8010208c:	83 ec 08             	sub    $0x8,%esp
8010208f:	68 00 16 11 80       	push   $0x80111600
80102094:	53                   	push   %ebx
80102095:	e8 76 1a 00 00       	call   80103b10 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010209a:	8b 03                	mov    (%ebx),%eax
8010209c:	83 e0 06             	and    $0x6,%eax
8010209f:	83 c4 10             	add    $0x10,%esp
801020a2:	83 f8 02             	cmp    $0x2,%eax
801020a5:	75 e5                	jne    8010208c <iderw+0x7c>
  }


  release(&idelock);
801020a7:	c7 45 08 00 16 11 80 	movl   $0x80111600,0x8(%ebp)
}
801020ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801020b1:	c9                   	leave
  release(&idelock);
801020b2:	e9 15 1f 00 00       	jmp    80103fcc <release>
801020b7:	90                   	nop
    idestart(b);
801020b8:	89 d8                	mov    %ebx,%eax
801020ba:	e8 99 fd ff ff       	call   80101e58 <idestart>
801020bf:	eb c1                	jmp    80102082 <iderw+0x72>
801020c1:	8d 76 00             	lea    0x0(%esi),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801020c4:	ba e4 15 11 80       	mov    $0x801115e4,%edx
801020c9:	eb ad                	jmp    80102078 <iderw+0x68>
    panic("iderw: ide disk 1 not present");
801020cb:	83 ec 0c             	sub    $0xc,%esp
801020ce:	68 4e 6a 10 80       	push   $0x80106a4e
801020d3:	e8 60 e2 ff ff       	call   80100338 <panic>
    panic("iderw: nothing to do");
801020d8:	83 ec 0c             	sub    $0xc,%esp
801020db:	68 39 6a 10 80       	push   $0x80106a39
801020e0:	e8 53 e2 ff ff       	call   80100338 <panic>
    panic("iderw: buf not locked");
801020e5:	83 ec 0c             	sub    $0xc,%esp
801020e8:	68 23 6a 10 80       	push   $0x80106a23
801020ed:	e8 46 e2 ff ff       	call   80100338 <panic>
801020f2:	66 90                	xchg   %ax,%ax

801020f4 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801020f4:	55                   	push   %ebp
801020f5:	89 e5                	mov    %esp,%ebp
801020f7:	56                   	push   %esi
801020f8:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801020f9:	c7 05 34 16 11 80 00 	movl   $0xfec00000,0x80111634
80102100:	00 c0 fe 
  ioapic->reg = reg;
80102103:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
8010210a:	00 00 00 
  return ioapic->data;
8010210d:	8b 15 34 16 11 80    	mov    0x80111634,%edx
80102113:	8b 72 10             	mov    0x10(%edx),%esi
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102116:	c1 ee 10             	shr    $0x10,%esi
80102119:	89 f0                	mov    %esi,%eax
8010211b:	0f b6 f0             	movzbl %al,%esi
  ioapic->reg = reg;
8010211e:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102124:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx
8010212a:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010212d:	0f b6 15 80 17 11 80 	movzbl 0x80111780,%edx
  id = ioapicread(REG_ID) >> 24;
80102134:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102137:	39 c2                	cmp    %eax,%edx
80102139:	74 16                	je     80102151 <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
8010213b:	83 ec 0c             	sub    $0xc,%esp
8010213e:	68 18 6e 10 80       	push   $0x80106e18
80102143:	e8 e0 e4 ff ff       	call   80100628 <cprintf>
  ioapic->reg = reg;
80102148:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx
8010214e:	83 c4 10             	add    $0x10,%esp
{
80102151:	ba 10 00 00 00       	mov    $0x10,%edx
80102156:	31 c0                	xor    %eax,%eax

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102158:	8d 48 20             	lea    0x20(%eax),%ecx
8010215b:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->reg = reg;
80102161:	89 13                	mov    %edx,(%ebx)
  ioapic->data = data;
80102163:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx
80102169:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
8010216c:	8d 4a 01             	lea    0x1(%edx),%ecx
8010216f:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80102171:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx
80102177:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
8010217e:	40                   	inc    %eax
8010217f:	83 c2 02             	add    $0x2,%edx
80102182:	39 c6                	cmp    %eax,%esi
80102184:	7d d2                	jge    80102158 <ioapicinit+0x64>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102186:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102189:	5b                   	pop    %ebx
8010218a:	5e                   	pop    %esi
8010218b:	5d                   	pop    %ebp
8010218c:	c3                   	ret
8010218d:	8d 76 00             	lea    0x0(%esi),%esi

80102190 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102190:	55                   	push   %ebp
80102191:	89 e5                	mov    %esp,%ebp
80102193:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102196:	8d 50 20             	lea    0x20(%eax),%edx
80102199:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
8010219d:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
801021a3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801021a5:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
801021ab:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801021ae:	8b 55 0c             	mov    0xc(%ebp),%edx
801021b1:	c1 e2 18             	shl    $0x18,%edx
801021b4:	40                   	inc    %eax
  ioapic->reg = reg;
801021b5:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801021b7:	a1 34 16 11 80       	mov    0x80111634,%eax
801021bc:	89 50 10             	mov    %edx,0x10(%eax)
}
801021bf:	5d                   	pop    %ebp
801021c0:	c3                   	ret
801021c1:	66 90                	xchg   %ax,%ax
801021c3:	90                   	nop

801021c4 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801021c4:	55                   	push   %ebp
801021c5:	89 e5                	mov    %esp,%ebp
801021c7:	53                   	push   %ebx
801021c8:	53                   	push   %ebx
801021c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801021cc:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801021d2:	75 70                	jne    80102244 <kfree+0x80>
801021d4:	81 fb d0 54 11 80    	cmp    $0x801154d0,%ebx
801021da:	72 68                	jb     80102244 <kfree+0x80>
801021dc:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801021e2:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801021e7:	77 5b                	ja     80102244 <kfree+0x80>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801021e9:	52                   	push   %edx
801021ea:	68 00 10 00 00       	push   $0x1000
801021ef:	6a 01                	push   $0x1
801021f1:	53                   	push   %ebx
801021f2:	e8 11 1f 00 00       	call   80104108 <memset>

  if(kmem.use_lock)
801021f7:	83 c4 10             	add    $0x10,%esp
801021fa:	8b 0d 74 16 11 80    	mov    0x80111674,%ecx
80102200:	85 c9                	test   %ecx,%ecx
80102202:	75 1c                	jne    80102220 <kfree+0x5c>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102204:	a1 78 16 11 80       	mov    0x80111678,%eax
80102209:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
8010220b:	89 1d 78 16 11 80    	mov    %ebx,0x80111678
  if(kmem.use_lock)
80102211:	a1 74 16 11 80       	mov    0x80111674,%eax
80102216:	85 c0                	test   %eax,%eax
80102218:	75 1a                	jne    80102234 <kfree+0x70>
    release(&kmem.lock);
}
8010221a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010221d:	c9                   	leave
8010221e:	c3                   	ret
8010221f:	90                   	nop
    acquire(&kmem.lock);
80102220:	83 ec 0c             	sub    $0xc,%esp
80102223:	68 40 16 11 80       	push   $0x80111640
80102228:	e8 ff 1d 00 00       	call   8010402c <acquire>
8010222d:	83 c4 10             	add    $0x10,%esp
80102230:	eb d2                	jmp    80102204 <kfree+0x40>
80102232:	66 90                	xchg   %ax,%ax
    release(&kmem.lock);
80102234:	c7 45 08 40 16 11 80 	movl   $0x80111640,0x8(%ebp)
}
8010223b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010223e:	c9                   	leave
    release(&kmem.lock);
8010223f:	e9 88 1d 00 00       	jmp    80103fcc <release>
    panic("kfree");
80102244:	83 ec 0c             	sub    $0xc,%esp
80102247:	68 6c 6a 10 80       	push   $0x80106a6c
8010224c:	e8 e7 e0 ff ff       	call   80100338 <panic>
80102251:	8d 76 00             	lea    0x0(%esi),%esi

80102254 <freerange>:
{
80102254:	55                   	push   %ebp
80102255:	89 e5                	mov    %esp,%ebp
80102257:	56                   	push   %esi
80102258:	53                   	push   %ebx
80102259:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010225c:	8b 45 08             	mov    0x8(%ebp),%eax
8010225f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102265:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010226b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102271:	39 de                	cmp    %ebx,%esi
80102273:	72 1f                	jb     80102294 <freerange+0x40>
80102275:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102278:	83 ec 0c             	sub    $0xc,%esp
8010227b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102281:	50                   	push   %eax
80102282:	e8 3d ff ff ff       	call   801021c4 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102287:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010228d:	83 c4 10             	add    $0x10,%esp
80102290:	39 de                	cmp    %ebx,%esi
80102292:	73 e4                	jae    80102278 <freerange+0x24>
}
80102294:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102297:	5b                   	pop    %ebx
80102298:	5e                   	pop    %esi
80102299:	5d                   	pop    %ebp
8010229a:	c3                   	ret
8010229b:	90                   	nop

8010229c <kinit2>:
{
8010229c:	55                   	push   %ebp
8010229d:	89 e5                	mov    %esp,%ebp
8010229f:	56                   	push   %esi
801022a0:	53                   	push   %ebx
801022a1:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801022a4:	8b 45 08             	mov    0x8(%ebp),%eax
801022a7:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801022ad:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801022b3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801022b9:	39 de                	cmp    %ebx,%esi
801022bb:	72 1f                	jb     801022dc <kinit2+0x40>
801022bd:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
801022c0:	83 ec 0c             	sub    $0xc,%esp
801022c3:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801022c9:	50                   	push   %eax
801022ca:	e8 f5 fe ff ff       	call   801021c4 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801022cf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801022d5:	83 c4 10             	add    $0x10,%esp
801022d8:	39 de                	cmp    %ebx,%esi
801022da:	73 e4                	jae    801022c0 <kinit2+0x24>
  kmem.use_lock = 1;
801022dc:	c7 05 74 16 11 80 01 	movl   $0x1,0x80111674
801022e3:	00 00 00 
}
801022e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022e9:	5b                   	pop    %ebx
801022ea:	5e                   	pop    %esi
801022eb:	5d                   	pop    %ebp
801022ec:	c3                   	ret
801022ed:	8d 76 00             	lea    0x0(%esi),%esi

801022f0 <kinit1>:
{
801022f0:	55                   	push   %ebp
801022f1:	89 e5                	mov    %esp,%ebp
801022f3:	56                   	push   %esi
801022f4:	53                   	push   %ebx
801022f5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801022f8:	83 ec 08             	sub    $0x8,%esp
801022fb:	68 72 6a 10 80       	push   $0x80106a72
80102300:	68 40 16 11 80       	push   $0x80111640
80102305:	e8 4a 1b 00 00       	call   80103e54 <initlock>
  kmem.use_lock = 0;
8010230a:	c7 05 74 16 11 80 00 	movl   $0x0,0x80111674
80102311:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102314:	8b 45 08             	mov    0x8(%ebp),%eax
80102317:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
8010231d:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102323:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102329:	83 c4 10             	add    $0x10,%esp
8010232c:	39 de                	cmp    %ebx,%esi
8010232e:	72 1c                	jb     8010234c <kinit1+0x5c>
    kfree(p);
80102330:	83 ec 0c             	sub    $0xc,%esp
80102333:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102339:	50                   	push   %eax
8010233a:	e8 85 fe ff ff       	call   801021c4 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010233f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102345:	83 c4 10             	add    $0x10,%esp
80102348:	39 de                	cmp    %ebx,%esi
8010234a:	73 e4                	jae    80102330 <kinit1+0x40>
}
8010234c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010234f:	5b                   	pop    %ebx
80102350:	5e                   	pop    %esi
80102351:	5d                   	pop    %ebp
80102352:	c3                   	ret
80102353:	90                   	nop

80102354 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102354:	a1 74 16 11 80       	mov    0x80111674,%eax
80102359:	85 c0                	test   %eax,%eax
8010235b:	75 17                	jne    80102374 <kalloc+0x20>
    acquire(&kmem.lock);
  r = kmem.freelist;
8010235d:	a1 78 16 11 80       	mov    0x80111678,%eax
  if(r)
80102362:	85 c0                	test   %eax,%eax
80102364:	74 0a                	je     80102370 <kalloc+0x1c>
    kmem.freelist = r->next;
80102366:	8b 10                	mov    (%eax),%edx
80102368:	89 15 78 16 11 80    	mov    %edx,0x80111678
  if(kmem.use_lock)
8010236e:	c3                   	ret
8010236f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80102370:	c3                   	ret
80102371:	8d 76 00             	lea    0x0(%esi),%esi
{
80102374:	55                   	push   %ebp
80102375:	89 e5                	mov    %esp,%ebp
80102377:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010237a:	68 40 16 11 80       	push   $0x80111640
8010237f:	e8 a8 1c 00 00       	call   8010402c <acquire>
  r = kmem.freelist;
80102384:	a1 78 16 11 80       	mov    0x80111678,%eax
  if(r)
80102389:	83 c4 10             	add    $0x10,%esp
  if(kmem.use_lock)
8010238c:	8b 15 74 16 11 80    	mov    0x80111674,%edx
  if(r)
80102392:	85 c0                	test   %eax,%eax
80102394:	74 08                	je     8010239e <kalloc+0x4a>
    kmem.freelist = r->next;
80102396:	8b 08                	mov    (%eax),%ecx
80102398:	89 0d 78 16 11 80    	mov    %ecx,0x80111678
  if(kmem.use_lock)
8010239e:	85 d2                	test   %edx,%edx
801023a0:	74 16                	je     801023b8 <kalloc+0x64>
801023a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    release(&kmem.lock);
801023a5:	83 ec 0c             	sub    $0xc,%esp
801023a8:	68 40 16 11 80       	push   $0x80111640
801023ad:	e8 1a 1c 00 00       	call   80103fcc <release>
801023b2:	83 c4 10             	add    $0x10,%esp
801023b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801023b8:	c9                   	leave
801023b9:	c3                   	ret
801023ba:	66 90                	xchg   %ax,%ax

801023bc <countfp>:
// pj4

// return the num of total free page in the system
int
countfp(void)
{
801023bc:	55                   	push   %ebp
801023bd:	89 e5                	mov    %esp,%ebp
801023bf:	53                   	push   %ebx
801023c0:	50                   	push   %eax
  struct run *r;
  int cnt = 0;

  if(kmem.use_lock)
801023c1:	8b 15 74 16 11 80    	mov    0x80111674,%edx
801023c7:	85 d2                	test   %edx,%edx
801023c9:	75 31                	jne    801023fc <countfp+0x40>
    acquire(&kmem.lock);

  r = kmem.freelist;
801023cb:	a1 78 16 11 80       	mov    0x80111678,%eax
  while (r)
801023d0:	85 c0                	test   %eax,%eax
801023d2:	74 4b                	je     8010241f <countfp+0x63>
  int cnt = 0;
801023d4:	31 db                	xor    %ebx,%ebx
801023d6:	66 90                	xchg   %ax,%ax
  {
    cnt++;
801023d8:	43                   	inc    %ebx
    r = r->next;
801023d9:	8b 00                	mov    (%eax),%eax
  while (r)
801023db:	85 c0                	test   %eax,%eax
801023dd:	75 f9                	jne    801023d8 <countfp+0x1c>
  }
  
  if(kmem.use_lock)
801023df:	85 d2                	test   %edx,%edx
801023e1:	74 10                	je     801023f3 <countfp+0x37>
    release(&kmem.lock);
801023e3:	83 ec 0c             	sub    $0xc,%esp
801023e6:	68 40 16 11 80       	push   $0x80111640
801023eb:	e8 dc 1b 00 00       	call   80103fcc <release>
801023f0:	83 c4 10             	add    $0x10,%esp
  
  return cnt;
}
801023f3:	89 d8                	mov    %ebx,%eax
801023f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023f8:	c9                   	leave
801023f9:	c3                   	ret
801023fa:	66 90                	xchg   %ax,%ax
    acquire(&kmem.lock);
801023fc:	83 ec 0c             	sub    $0xc,%esp
801023ff:	68 40 16 11 80       	push   $0x80111640
80102404:	e8 23 1c 00 00       	call   8010402c <acquire>
  r = kmem.freelist;
80102409:	a1 78 16 11 80       	mov    0x80111678,%eax
  while (r)
8010240e:	83 c4 10             	add    $0x10,%esp
  if(kmem.use_lock)
80102411:	8b 15 74 16 11 80    	mov    0x80111674,%edx
  while (r)
80102417:	85 c0                	test   %eax,%eax
80102419:	75 b9                	jne    801023d4 <countfp+0x18>
  int cnt = 0;
8010241b:	31 db                	xor    %ebx,%ebx
8010241d:	eb c0                	jmp    801023df <countfp+0x23>
8010241f:	31 db                	xor    %ebx,%ebx
80102421:	eb d0                	jmp    801023f3 <countfp+0x37>
80102423:	90                   	nop

80102424 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102424:	ba 64 00 00 00       	mov    $0x64,%edx
80102429:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
8010242a:	a8 01                	test   $0x1,%al
8010242c:	0f 84 ae 00 00 00    	je     801024e0 <kbdgetc+0xbc>
{
80102432:	55                   	push   %ebp
80102433:	89 e5                	mov    %esp,%ebp
80102435:	53                   	push   %ebx
80102436:	ba 60 00 00 00       	mov    $0x60,%edx
8010243b:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
8010243c:	0f b6 d8             	movzbl %al,%ebx

  if(data == 0xE0){
    shift |= E0ESC;
8010243f:	8b 0d 7c 16 11 80    	mov    0x8011167c,%ecx
  if(data == 0xE0){
80102445:	3c e0                	cmp    $0xe0,%al
80102447:	74 5b                	je     801024a4 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102449:	89 ca                	mov    %ecx,%edx
8010244b:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
8010244e:	84 c0                	test   %al,%al
80102450:	78 62                	js     801024b4 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102452:	85 d2                	test   %edx,%edx
80102454:	74 09                	je     8010245f <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102456:	83 c8 80             	or     $0xffffff80,%eax
80102459:	0f b6 d8             	movzbl %al,%ebx
    shift &= ~E0ESC;
8010245c:	83 e1 bf             	and    $0xffffffbf,%ecx
  }

  shift |= shiftcode[data];
8010245f:	0f b6 93 80 70 10 80 	movzbl -0x7fef8f80(%ebx),%edx
80102466:	09 ca                	or     %ecx,%edx
  shift ^= togglecode[data];
80102468:	0f b6 83 80 6f 10 80 	movzbl -0x7fef9080(%ebx),%eax
8010246f:	31 c2                	xor    %eax,%edx
80102471:	89 15 7c 16 11 80    	mov    %edx,0x8011167c
  c = charcode[shift & (CTL | SHIFT)][data];
80102477:	89 d0                	mov    %edx,%eax
80102479:	83 e0 03             	and    $0x3,%eax
8010247c:	8b 04 85 60 6f 10 80 	mov    -0x7fef90a0(,%eax,4),%eax
80102483:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
  if(shift & CAPSLOCK){
80102487:	83 e2 08             	and    $0x8,%edx
8010248a:	74 13                	je     8010249f <kbdgetc+0x7b>
    if('a' <= c && c <= 'z')
8010248c:	8d 50 9f             	lea    -0x61(%eax),%edx
8010248f:	83 fa 19             	cmp    $0x19,%edx
80102492:	76 44                	jbe    801024d8 <kbdgetc+0xb4>
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102494:	8d 50 bf             	lea    -0x41(%eax),%edx
80102497:	83 fa 19             	cmp    $0x19,%edx
8010249a:	77 03                	ja     8010249f <kbdgetc+0x7b>
      c += 'a' - 'A';
8010249c:	83 c0 20             	add    $0x20,%eax
  }
  return c;
}
8010249f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024a2:	c9                   	leave
801024a3:	c3                   	ret
    shift |= E0ESC;
801024a4:	83 c9 40             	or     $0x40,%ecx
801024a7:	89 0d 7c 16 11 80    	mov    %ecx,0x8011167c
    return 0;
801024ad:	31 c0                	xor    %eax,%eax
}
801024af:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024b2:	c9                   	leave
801024b3:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
801024b4:	85 d2                	test   %edx,%edx
801024b6:	75 05                	jne    801024bd <kbdgetc+0x99>
801024b8:	89 c3                	mov    %eax,%ebx
801024ba:	83 e3 7f             	and    $0x7f,%ebx
    shift &= ~(shiftcode[data] | E0ESC);
801024bd:	8a 83 80 70 10 80    	mov    -0x7fef8f80(%ebx),%al
801024c3:	83 c8 40             	or     $0x40,%eax
801024c6:	0f b6 c0             	movzbl %al,%eax
801024c9:	f7 d0                	not    %eax
801024cb:	21 c8                	and    %ecx,%eax
801024cd:	a3 7c 16 11 80       	mov    %eax,0x8011167c
    return 0;
801024d2:	31 c0                	xor    %eax,%eax
801024d4:	eb d9                	jmp    801024af <kbdgetc+0x8b>
801024d6:	66 90                	xchg   %ax,%ax
      c += 'A' - 'a';
801024d8:	83 e8 20             	sub    $0x20,%eax
}
801024db:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024de:	c9                   	leave
801024df:	c3                   	ret
    return -1;
801024e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801024e5:	c3                   	ret
801024e6:	66 90                	xchg   %ax,%ax

801024e8 <kbdintr>:

void
kbdintr(void)
{
801024e8:	55                   	push   %ebp
801024e9:	89 e5                	mov    %esp,%ebp
801024eb:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801024ee:	68 24 24 10 80       	push   $0x80102424
801024f3:	e8 f0 e2 ff ff       	call   801007e8 <consoleintr>
}
801024f8:	83 c4 10             	add    $0x10,%esp
801024fb:	c9                   	leave
801024fc:	c3                   	ret
801024fd:	66 90                	xchg   %ax,%ax
801024ff:	90                   	nop

80102500 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102500:	a1 80 16 11 80       	mov    0x80111680,%eax
80102505:	85 c0                	test   %eax,%eax
80102507:	0f 84 bf 00 00 00    	je     801025cc <lapicinit+0xcc>
  lapic[index] = value;
8010250d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102514:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102517:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010251a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102521:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102524:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102527:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010252e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102531:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102534:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010253b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010253e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102541:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102548:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010254b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010254e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102555:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102558:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010255b:	8b 50 30             	mov    0x30(%eax),%edx
8010255e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80102564:	75 6a                	jne    801025d0 <lapicinit+0xd0>
  lapic[index] = value;
80102566:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
8010256d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102570:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102573:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010257a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010257d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102580:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102587:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010258a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010258d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102594:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102597:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010259a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801025a1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025a4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801025a7:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801025ae:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801025b1:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801025b4:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801025ba:	80 e6 10             	and    $0x10,%dh
801025bd:	75 f5                	jne    801025b4 <lapicinit+0xb4>
  lapic[index] = value;
801025bf:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801025c6:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025c9:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801025cc:	c3                   	ret
801025cd:	8d 76 00             	lea    0x0(%esi),%esi
  lapic[index] = value;
801025d0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801025d7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801025da:	8b 50 20             	mov    0x20(%eax),%edx
}
801025dd:	eb 87                	jmp    80102566 <lapicinit+0x66>
801025df:	90                   	nop

801025e0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801025e0:	a1 80 16 11 80       	mov    0x80111680,%eax
801025e5:	85 c0                	test   %eax,%eax
801025e7:	74 07                	je     801025f0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801025e9:	8b 40 20             	mov    0x20(%eax),%eax
801025ec:	c1 e8 18             	shr    $0x18,%eax
801025ef:	c3                   	ret
    return 0;
801025f0:	31 c0                	xor    %eax,%eax
}
801025f2:	c3                   	ret
801025f3:	90                   	nop

801025f4 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801025f4:	a1 80 16 11 80       	mov    0x80111680,%eax
801025f9:	85 c0                	test   %eax,%eax
801025fb:	74 0d                	je     8010260a <lapiceoi+0x16>
  lapic[index] = value;
801025fd:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102604:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102607:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
8010260a:	c3                   	ret
8010260b:	90                   	nop

8010260c <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
8010260c:	c3                   	ret
8010260d:	8d 76 00             	lea    0x0(%esi),%esi

80102610 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102610:	55                   	push   %ebp
80102611:	89 e5                	mov    %esp,%ebp
80102613:	53                   	push   %ebx
80102614:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102617:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010261a:	b0 0f                	mov    $0xf,%al
8010261c:	ba 70 00 00 00       	mov    $0x70,%edx
80102621:	ee                   	out    %al,(%dx)
80102622:	b0 0a                	mov    $0xa,%al
80102624:	ba 71 00 00 00       	mov    $0x71,%edx
80102629:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
8010262a:	66 c7 05 67 04 00 80 	movw   $0x0,0x80000467
80102631:	00 00 
  wrv[1] = addr >> 4;
80102633:	89 c8                	mov    %ecx,%eax
80102635:	c1 e8 04             	shr    $0x4,%eax
80102638:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010263e:	a1 80 16 11 80       	mov    0x80111680,%eax
80102643:	c1 e3 18             	shl    $0x18,%ebx
80102646:	89 da                	mov    %ebx,%edx
80102648:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010264e:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102651:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102658:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010265b:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010265e:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102665:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102668:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010266b:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102671:	8b 58 20             	mov    0x20(%eax),%ebx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102674:	c1 e9 0c             	shr    $0xc,%ecx
80102677:	80 cd 06             	or     $0x6,%ch
  lapic[index] = value;
8010267a:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102680:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102683:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102689:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010268c:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102692:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102695:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102698:	c9                   	leave
80102699:	c3                   	ret
8010269a:	66 90                	xchg   %ax,%ax

8010269c <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
8010269c:	55                   	push   %ebp
8010269d:	89 e5                	mov    %esp,%ebp
8010269f:	57                   	push   %edi
801026a0:	56                   	push   %esi
801026a1:	53                   	push   %ebx
801026a2:	83 ec 4c             	sub    $0x4c,%esp
801026a5:	b0 0b                	mov    $0xb,%al
801026a7:	ba 70 00 00 00       	mov    $0x70,%edx
801026ac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026ad:	ba 71 00 00 00       	mov    $0x71,%edx
801026b2:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801026b3:	83 e0 04             	and    $0x4,%eax
801026b6:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026b8:	bb 70 00 00 00       	mov    $0x70,%ebx
801026bd:	8d 76 00             	lea    0x0(%esi),%esi
801026c0:	31 c0                	xor    %eax,%eax
801026c2:	89 da                	mov    %ebx,%edx
801026c4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026c5:	bf 71 00 00 00       	mov    $0x71,%edi
801026ca:	89 fa                	mov    %edi,%edx
801026cc:	ec                   	in     (%dx),%al
801026cd:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026d0:	b0 02                	mov    $0x2,%al
801026d2:	89 da                	mov    %ebx,%edx
801026d4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026d5:	89 fa                	mov    %edi,%edx
801026d7:	ec                   	in     (%dx),%al
801026d8:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026db:	b0 04                	mov    $0x4,%al
801026dd:	89 da                	mov    %ebx,%edx
801026df:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026e0:	89 fa                	mov    %edi,%edx
801026e2:	ec                   	in     (%dx),%al
801026e3:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026e6:	b0 07                	mov    $0x7,%al
801026e8:	89 da                	mov    %ebx,%edx
801026ea:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026eb:	89 fa                	mov    %edi,%edx
801026ed:	ec                   	in     (%dx),%al
801026ee:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026f1:	b0 08                	mov    $0x8,%al
801026f3:	89 da                	mov    %ebx,%edx
801026f5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026f6:	89 fa                	mov    %edi,%edx
801026f8:	ec                   	in     (%dx),%al
801026f9:	88 45 b3             	mov    %al,-0x4d(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026fc:	b0 09                	mov    $0x9,%al
801026fe:	89 da                	mov    %ebx,%edx
80102700:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102701:	89 fa                	mov    %edi,%edx
80102703:	ec                   	in     (%dx),%al
80102704:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102707:	b0 0a                	mov    $0xa,%al
80102709:	89 da                	mov    %ebx,%edx
8010270b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010270c:	89 fa                	mov    %edi,%edx
8010270e:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
8010270f:	84 c0                	test   %al,%al
80102711:	78 ad                	js     801026c0 <cmostime+0x24>
  return inb(CMOS_RETURN);
80102713:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102717:	89 45 b8             	mov    %eax,-0x48(%ebp)
8010271a:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
8010271e:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102721:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102725:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102728:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
8010272c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
8010272f:	0f b6 45 b3          	movzbl -0x4d(%ebp),%eax
80102733:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102736:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102739:	31 c0                	xor    %eax,%eax
8010273b:	89 da                	mov    %ebx,%edx
8010273d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010273e:	89 fa                	mov    %edi,%edx
80102740:	ec                   	in     (%dx),%al
80102741:	0f b6 c0             	movzbl %al,%eax
80102744:	89 45 d0             	mov    %eax,-0x30(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102747:	b0 02                	mov    $0x2,%al
80102749:	89 da                	mov    %ebx,%edx
8010274b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010274c:	89 fa                	mov    %edi,%edx
8010274e:	ec                   	in     (%dx),%al
8010274f:	0f b6 c0             	movzbl %al,%eax
80102752:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102755:	b0 04                	mov    $0x4,%al
80102757:	89 da                	mov    %ebx,%edx
80102759:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010275a:	89 fa                	mov    %edi,%edx
8010275c:	ec                   	in     (%dx),%al
8010275d:	0f b6 c0             	movzbl %al,%eax
80102760:	89 45 d8             	mov    %eax,-0x28(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102763:	b0 07                	mov    $0x7,%al
80102765:	89 da                	mov    %ebx,%edx
80102767:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102768:	89 fa                	mov    %edi,%edx
8010276a:	ec                   	in     (%dx),%al
8010276b:	0f b6 c0             	movzbl %al,%eax
8010276e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102771:	b0 08                	mov    $0x8,%al
80102773:	89 da                	mov    %ebx,%edx
80102775:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102776:	89 fa                	mov    %edi,%edx
80102778:	ec                   	in     (%dx),%al
80102779:	0f b6 c0             	movzbl %al,%eax
8010277c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010277f:	b0 09                	mov    $0x9,%al
80102781:	89 da                	mov    %ebx,%edx
80102783:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102784:	89 fa                	mov    %edi,%edx
80102786:	ec                   	in     (%dx),%al
80102787:	0f b6 c0             	movzbl %al,%eax
8010278a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010278d:	50                   	push   %eax
8010278e:	6a 18                	push   $0x18
80102790:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102793:	50                   	push   %eax
80102794:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102797:	50                   	push   %eax
80102798:	e8 af 19 00 00       	call   8010414c <memcmp>
8010279d:	83 c4 10             	add    $0x10,%esp
801027a0:	85 c0                	test   %eax,%eax
801027a2:	0f 85 18 ff ff ff    	jne    801026c0 <cmostime+0x24>
      break;
  }

  // convert
  if(bcd) {
801027a8:	89 f0                	mov    %esi,%eax
801027aa:	84 c0                	test   %al,%al
801027ac:	75 7e                	jne    8010282c <cmostime+0x190>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801027ae:	8b 55 b8             	mov    -0x48(%ebp),%edx
801027b1:	89 d0                	mov    %edx,%eax
801027b3:	c1 e8 04             	shr    $0x4,%eax
801027b6:	8d 04 80             	lea    (%eax,%eax,4),%eax
801027b9:	01 c0                	add    %eax,%eax
801027bb:	83 e2 0f             	and    $0xf,%edx
801027be:	01 d0                	add    %edx,%eax
801027c0:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801027c3:	8b 55 bc             	mov    -0x44(%ebp),%edx
801027c6:	89 d0                	mov    %edx,%eax
801027c8:	c1 e8 04             	shr    $0x4,%eax
801027cb:	8d 04 80             	lea    (%eax,%eax,4),%eax
801027ce:	01 c0                	add    %eax,%eax
801027d0:	83 e2 0f             	and    $0xf,%edx
801027d3:	01 d0                	add    %edx,%eax
801027d5:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801027d8:	8b 55 c0             	mov    -0x40(%ebp),%edx
801027db:	89 d0                	mov    %edx,%eax
801027dd:	c1 e8 04             	shr    $0x4,%eax
801027e0:	8d 04 80             	lea    (%eax,%eax,4),%eax
801027e3:	01 c0                	add    %eax,%eax
801027e5:	83 e2 0f             	and    $0xf,%edx
801027e8:	01 d0                	add    %edx,%eax
801027ea:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801027ed:	8b 55 c4             	mov    -0x3c(%ebp),%edx
801027f0:	89 d0                	mov    %edx,%eax
801027f2:	c1 e8 04             	shr    $0x4,%eax
801027f5:	8d 04 80             	lea    (%eax,%eax,4),%eax
801027f8:	01 c0                	add    %eax,%eax
801027fa:	83 e2 0f             	and    $0xf,%edx
801027fd:	01 d0                	add    %edx,%eax
801027ff:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102802:	8b 55 c8             	mov    -0x38(%ebp),%edx
80102805:	89 d0                	mov    %edx,%eax
80102807:	c1 e8 04             	shr    $0x4,%eax
8010280a:	8d 04 80             	lea    (%eax,%eax,4),%eax
8010280d:	01 c0                	add    %eax,%eax
8010280f:	83 e2 0f             	and    $0xf,%edx
80102812:	01 d0                	add    %edx,%eax
80102814:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102817:	8b 55 cc             	mov    -0x34(%ebp),%edx
8010281a:	89 d0                	mov    %edx,%eax
8010281c:	c1 e8 04             	shr    $0x4,%eax
8010281f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80102822:	01 c0                	add    %eax,%eax
80102824:	83 e2 0f             	and    $0xf,%edx
80102827:	01 d0                	add    %edx,%eax
80102829:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
8010282c:	b9 06 00 00 00       	mov    $0x6,%ecx
80102831:	8b 7d 08             	mov    0x8(%ebp),%edi
80102834:	8d 75 b8             	lea    -0x48(%ebp),%esi
80102837:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  r->year += 2000;
80102839:	8b 45 08             	mov    0x8(%ebp),%eax
8010283c:	81 40 14 d0 07 00 00 	addl   $0x7d0,0x14(%eax)
}
80102843:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102846:	5b                   	pop    %ebx
80102847:	5e                   	pop    %esi
80102848:	5f                   	pop    %edi
80102849:	5d                   	pop    %ebp
8010284a:	c3                   	ret
8010284b:	90                   	nop

8010284c <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010284c:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
80102852:	85 c9                	test   %ecx,%ecx
80102854:	7e 7e                	jle    801028d4 <install_trans+0x88>
{
80102856:	55                   	push   %ebp
80102857:	89 e5                	mov    %esp,%ebp
80102859:	57                   	push   %edi
8010285a:	56                   	push   %esi
8010285b:	53                   	push   %ebx
8010285c:	83 ec 0c             	sub    $0xc,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
8010285f:	31 ff                	xor    %edi,%edi
80102861:	8d 76 00             	lea    0x0(%esi),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102864:	83 ec 08             	sub    $0x8,%esp
80102867:	a1 d4 16 11 80       	mov    0x801116d4,%eax
8010286c:	01 f8                	add    %edi,%eax
8010286e:	40                   	inc    %eax
8010286f:	50                   	push   %eax
80102870:	ff 35 e4 16 11 80    	push   0x801116e4
80102876:	e8 39 d8 ff ff       	call   801000b4 <bread>
8010287b:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010287d:	58                   	pop    %eax
8010287e:	5a                   	pop    %edx
8010287f:	ff 34 bd ec 16 11 80 	push   -0x7feee914(,%edi,4)
80102886:	ff 35 e4 16 11 80    	push   0x801116e4
8010288c:	e8 23 d8 ff ff       	call   801000b4 <bread>
80102891:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102893:	83 c4 0c             	add    $0xc,%esp
80102896:	68 00 02 00 00       	push   $0x200
8010289b:	8d 46 5c             	lea    0x5c(%esi),%eax
8010289e:	50                   	push   %eax
8010289f:	8d 43 5c             	lea    0x5c(%ebx),%eax
801028a2:	50                   	push   %eax
801028a3:	e8 dc 18 00 00       	call   80104184 <memmove>
    bwrite(dbuf);  // write dst to disk
801028a8:	89 1c 24             	mov    %ebx,(%esp)
801028ab:	e8 d4 d8 ff ff       	call   80100184 <bwrite>
    brelse(lbuf);
801028b0:	89 34 24             	mov    %esi,(%esp)
801028b3:	e8 04 d9 ff ff       	call   801001bc <brelse>
    brelse(dbuf);
801028b8:	89 1c 24             	mov    %ebx,(%esp)
801028bb:	e8 fc d8 ff ff       	call   801001bc <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801028c0:	47                   	inc    %edi
801028c1:	83 c4 10             	add    $0x10,%esp
801028c4:	39 3d e8 16 11 80    	cmp    %edi,0x801116e8
801028ca:	7f 98                	jg     80102864 <install_trans+0x18>
  }
}
801028cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801028cf:	5b                   	pop    %ebx
801028d0:	5e                   	pop    %esi
801028d1:	5f                   	pop    %edi
801028d2:	5d                   	pop    %ebp
801028d3:	c3                   	ret
801028d4:	c3                   	ret
801028d5:	8d 76 00             	lea    0x0(%esi),%esi

801028d8 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
801028d8:	55                   	push   %ebp
801028d9:	89 e5                	mov    %esp,%ebp
801028db:	53                   	push   %ebx
801028dc:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
801028df:	ff 35 d4 16 11 80    	push   0x801116d4
801028e5:	ff 35 e4 16 11 80    	push   0x801116e4
801028eb:	e8 c4 d7 ff ff       	call   801000b4 <bread>
801028f0:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
801028f2:	a1 e8 16 11 80       	mov    0x801116e8,%eax
801028f7:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
801028fa:	83 c4 10             	add    $0x10,%esp
801028fd:	85 c0                	test   %eax,%eax
801028ff:	7e 13                	jle    80102914 <write_head+0x3c>
80102901:	31 d2                	xor    %edx,%edx
80102903:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102904:	8b 0c 95 ec 16 11 80 	mov    -0x7feee914(,%edx,4),%ecx
8010290b:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010290f:	42                   	inc    %edx
80102910:	39 d0                	cmp    %edx,%eax
80102912:	75 f0                	jne    80102904 <write_head+0x2c>
  }
  bwrite(buf);
80102914:	83 ec 0c             	sub    $0xc,%esp
80102917:	53                   	push   %ebx
80102918:	e8 67 d8 ff ff       	call   80100184 <bwrite>
  brelse(buf);
8010291d:	89 1c 24             	mov    %ebx,(%esp)
80102920:	e8 97 d8 ff ff       	call   801001bc <brelse>
}
80102925:	83 c4 10             	add    $0x10,%esp
80102928:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010292b:	c9                   	leave
8010292c:	c3                   	ret
8010292d:	8d 76 00             	lea    0x0(%esi),%esi

80102930 <initlog>:
{
80102930:	55                   	push   %ebp
80102931:	89 e5                	mov    %esp,%ebp
80102933:	53                   	push   %ebx
80102934:	83 ec 2c             	sub    $0x2c,%esp
80102937:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010293a:	68 77 6a 10 80       	push   $0x80106a77
8010293f:	68 a0 16 11 80       	push   $0x801116a0
80102944:	e8 0b 15 00 00       	call   80103e54 <initlock>
  readsb(dev, &sb);
80102949:	58                   	pop    %eax
8010294a:	5a                   	pop    %edx
8010294b:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010294e:	50                   	push   %eax
8010294f:	53                   	push   %ebx
80102950:	e8 4f ea ff ff       	call   801013a4 <readsb>
  log.start = sb.logstart;
80102955:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102958:	a3 d4 16 11 80       	mov    %eax,0x801116d4
  log.size = sb.nlog;
8010295d:	8b 55 e8             	mov    -0x18(%ebp),%edx
80102960:	89 15 d8 16 11 80    	mov    %edx,0x801116d8
  log.dev = dev;
80102966:	89 1d e4 16 11 80    	mov    %ebx,0x801116e4
  struct buf *buf = bread(log.dev, log.start);
8010296c:	59                   	pop    %ecx
8010296d:	5a                   	pop    %edx
8010296e:	50                   	push   %eax
8010296f:	53                   	push   %ebx
80102970:	e8 3f d7 ff ff       	call   801000b4 <bread>
  log.lh.n = lh->n;
80102975:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102978:	89 1d e8 16 11 80    	mov    %ebx,0x801116e8
  for (i = 0; i < log.lh.n; i++) {
8010297e:	83 c4 10             	add    $0x10,%esp
80102981:	85 db                	test   %ebx,%ebx
80102983:	7e 13                	jle    80102998 <initlog+0x68>
80102985:	31 d2                	xor    %edx,%edx
80102987:	90                   	nop
    log.lh.block[i] = lh->block[i];
80102988:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
8010298c:	89 0c 95 ec 16 11 80 	mov    %ecx,-0x7feee914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102993:	42                   	inc    %edx
80102994:	39 d3                	cmp    %edx,%ebx
80102996:	75 f0                	jne    80102988 <initlog+0x58>
  brelse(buf);
80102998:	83 ec 0c             	sub    $0xc,%esp
8010299b:	50                   	push   %eax
8010299c:	e8 1b d8 ff ff       	call   801001bc <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
801029a1:	e8 a6 fe ff ff       	call   8010284c <install_trans>
  log.lh.n = 0;
801029a6:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
801029ad:	00 00 00 
  write_head(); // clear the log
801029b0:	e8 23 ff ff ff       	call   801028d8 <write_head>
}
801029b5:	83 c4 10             	add    $0x10,%esp
801029b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029bb:	c9                   	leave
801029bc:	c3                   	ret
801029bd:	8d 76 00             	lea    0x0(%esi),%esi

801029c0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
801029c0:	55                   	push   %ebp
801029c1:	89 e5                	mov    %esp,%ebp
801029c3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
801029c6:	68 a0 16 11 80       	push   $0x801116a0
801029cb:	e8 5c 16 00 00       	call   8010402c <acquire>
801029d0:	83 c4 10             	add    $0x10,%esp
801029d3:	eb 18                	jmp    801029ed <begin_op+0x2d>
801029d5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
801029d8:	83 ec 08             	sub    $0x8,%esp
801029db:	68 a0 16 11 80       	push   $0x801116a0
801029e0:	68 a0 16 11 80       	push   $0x801116a0
801029e5:	e8 26 11 00 00       	call   80103b10 <sleep>
801029ea:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
801029ed:	a1 e0 16 11 80       	mov    0x801116e0,%eax
801029f2:	85 c0                	test   %eax,%eax
801029f4:	75 e2                	jne    801029d8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801029f6:	a1 dc 16 11 80       	mov    0x801116dc,%eax
801029fb:	8d 50 01             	lea    0x1(%eax),%edx
801029fe:	8d 44 80 05          	lea    0x5(%eax,%eax,4),%eax
80102a02:	01 c0                	add    %eax,%eax
80102a04:	03 05 e8 16 11 80    	add    0x801116e8,%eax
80102a0a:	83 f8 1e             	cmp    $0x1e,%eax
80102a0d:	7f c9                	jg     801029d8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102a0f:	89 15 dc 16 11 80    	mov    %edx,0x801116dc
      release(&log.lock);
80102a15:	83 ec 0c             	sub    $0xc,%esp
80102a18:	68 a0 16 11 80       	push   $0x801116a0
80102a1d:	e8 aa 15 00 00       	call   80103fcc <release>
      break;
    }
  }
}
80102a22:	83 c4 10             	add    $0x10,%esp
80102a25:	c9                   	leave
80102a26:	c3                   	ret
80102a27:	90                   	nop

80102a28 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102a28:	55                   	push   %ebp
80102a29:	89 e5                	mov    %esp,%ebp
80102a2b:	57                   	push   %edi
80102a2c:	56                   	push   %esi
80102a2d:	53                   	push   %ebx
80102a2e:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102a31:	68 a0 16 11 80       	push   $0x801116a0
80102a36:	e8 f1 15 00 00       	call   8010402c <acquire>
  log.outstanding -= 1;
80102a3b:	a1 dc 16 11 80       	mov    0x801116dc,%eax
80102a40:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102a43:	89 1d dc 16 11 80    	mov    %ebx,0x801116dc
  if(log.committing)
80102a49:	83 c4 10             	add    $0x10,%esp
80102a4c:	8b 35 e0 16 11 80    	mov    0x801116e0,%esi
80102a52:	85 f6                	test   %esi,%esi
80102a54:	0f 85 12 01 00 00    	jne    80102b6c <end_op+0x144>
    panic("log.committing");
  if(log.outstanding == 0){
80102a5a:	85 db                	test   %ebx,%ebx
80102a5c:	0f 85 e6 00 00 00    	jne    80102b48 <end_op+0x120>
    do_commit = 1;
    log.committing = 1;
80102a62:	c7 05 e0 16 11 80 01 	movl   $0x1,0x801116e0
80102a69:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102a6c:	83 ec 0c             	sub    $0xc,%esp
80102a6f:	68 a0 16 11 80       	push   $0x801116a0
80102a74:	e8 53 15 00 00       	call   80103fcc <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102a79:	83 c4 10             	add    $0x10,%esp
80102a7c:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
80102a82:	85 c9                	test   %ecx,%ecx
80102a84:	7f 3a                	jg     80102ac0 <end_op+0x98>
    acquire(&log.lock);
80102a86:	83 ec 0c             	sub    $0xc,%esp
80102a89:	68 a0 16 11 80       	push   $0x801116a0
80102a8e:	e8 99 15 00 00       	call   8010402c <acquire>
    log.committing = 0;
80102a93:	c7 05 e0 16 11 80 00 	movl   $0x0,0x801116e0
80102a9a:	00 00 00 
    wakeup(&log);
80102a9d:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80102aa4:	e8 23 11 00 00       	call   80103bcc <wakeup>
    release(&log.lock);
80102aa9:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80102ab0:	e8 17 15 00 00       	call   80103fcc <release>
80102ab5:	83 c4 10             	add    $0x10,%esp
}
80102ab8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102abb:	5b                   	pop    %ebx
80102abc:	5e                   	pop    %esi
80102abd:	5f                   	pop    %edi
80102abe:	5d                   	pop    %ebp
80102abf:	c3                   	ret
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102ac0:	83 ec 08             	sub    $0x8,%esp
80102ac3:	a1 d4 16 11 80       	mov    0x801116d4,%eax
80102ac8:	01 d8                	add    %ebx,%eax
80102aca:	40                   	inc    %eax
80102acb:	50                   	push   %eax
80102acc:	ff 35 e4 16 11 80    	push   0x801116e4
80102ad2:	e8 dd d5 ff ff       	call   801000b4 <bread>
80102ad7:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ad9:	58                   	pop    %eax
80102ada:	5a                   	pop    %edx
80102adb:	ff 34 9d ec 16 11 80 	push   -0x7feee914(,%ebx,4)
80102ae2:	ff 35 e4 16 11 80    	push   0x801116e4
80102ae8:	e8 c7 d5 ff ff       	call   801000b4 <bread>
80102aed:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102aef:	83 c4 0c             	add    $0xc,%esp
80102af2:	68 00 02 00 00       	push   $0x200
80102af7:	8d 40 5c             	lea    0x5c(%eax),%eax
80102afa:	50                   	push   %eax
80102afb:	8d 46 5c             	lea    0x5c(%esi),%eax
80102afe:	50                   	push   %eax
80102aff:	e8 80 16 00 00       	call   80104184 <memmove>
    bwrite(to);  // write the log
80102b04:	89 34 24             	mov    %esi,(%esp)
80102b07:	e8 78 d6 ff ff       	call   80100184 <bwrite>
    brelse(from);
80102b0c:	89 3c 24             	mov    %edi,(%esp)
80102b0f:	e8 a8 d6 ff ff       	call   801001bc <brelse>
    brelse(to);
80102b14:	89 34 24             	mov    %esi,(%esp)
80102b17:	e8 a0 d6 ff ff       	call   801001bc <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102b1c:	43                   	inc    %ebx
80102b1d:	83 c4 10             	add    $0x10,%esp
80102b20:	3b 1d e8 16 11 80    	cmp    0x801116e8,%ebx
80102b26:	7c 98                	jl     80102ac0 <end_op+0x98>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102b28:	e8 ab fd ff ff       	call   801028d8 <write_head>
    install_trans(); // Now install writes to home locations
80102b2d:	e8 1a fd ff ff       	call   8010284c <install_trans>
    log.lh.n = 0;
80102b32:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
80102b39:	00 00 00 
    write_head();    // Erase the transaction from the log
80102b3c:	e8 97 fd ff ff       	call   801028d8 <write_head>
80102b41:	e9 40 ff ff ff       	jmp    80102a86 <end_op+0x5e>
80102b46:	66 90                	xchg   %ax,%ax
    wakeup(&log);
80102b48:	83 ec 0c             	sub    $0xc,%esp
80102b4b:	68 a0 16 11 80       	push   $0x801116a0
80102b50:	e8 77 10 00 00       	call   80103bcc <wakeup>
  release(&log.lock);
80102b55:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80102b5c:	e8 6b 14 00 00       	call   80103fcc <release>
80102b61:	83 c4 10             	add    $0x10,%esp
}
80102b64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b67:	5b                   	pop    %ebx
80102b68:	5e                   	pop    %esi
80102b69:	5f                   	pop    %edi
80102b6a:	5d                   	pop    %ebp
80102b6b:	c3                   	ret
    panic("log.committing");
80102b6c:	83 ec 0c             	sub    $0xc,%esp
80102b6f:	68 7b 6a 10 80       	push   $0x80106a7b
80102b74:	e8 bf d7 ff ff       	call   80100338 <panic>
80102b79:	8d 76 00             	lea    0x0(%esi),%esi

80102b7c <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102b7c:	55                   	push   %ebp
80102b7d:	89 e5                	mov    %esp,%ebp
80102b7f:	53                   	push   %ebx
80102b80:	52                   	push   %edx
80102b81:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102b84:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
80102b8a:	83 fa 1d             	cmp    $0x1d,%edx
80102b8d:	7f 71                	jg     80102c00 <log_write+0x84>
80102b8f:	a1 d8 16 11 80       	mov    0x801116d8,%eax
80102b94:	48                   	dec    %eax
80102b95:	39 c2                	cmp    %eax,%edx
80102b97:	7d 67                	jge    80102c00 <log_write+0x84>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102b99:	a1 dc 16 11 80       	mov    0x801116dc,%eax
80102b9e:	85 c0                	test   %eax,%eax
80102ba0:	7e 6b                	jle    80102c0d <log_write+0x91>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102ba2:	83 ec 0c             	sub    $0xc,%esp
80102ba5:	68 a0 16 11 80       	push   $0x801116a0
80102baa:	e8 7d 14 00 00       	call   8010402c <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102baf:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
80102bb5:	83 c4 10             	add    $0x10,%esp
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102bb8:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102bbb:	31 c0                	xor    %eax,%eax
80102bbd:	85 d2                	test   %edx,%edx
80102bbf:	7f 08                	jg     80102bc9 <log_write+0x4d>
80102bc1:	eb 0f                	jmp    80102bd2 <log_write+0x56>
80102bc3:	90                   	nop
80102bc4:	40                   	inc    %eax
80102bc5:	39 c2                	cmp    %eax,%edx
80102bc7:	74 27                	je     80102bf0 <log_write+0x74>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102bc9:	39 0c 85 ec 16 11 80 	cmp    %ecx,-0x7feee914(,%eax,4)
80102bd0:	75 f2                	jne    80102bc4 <log_write+0x48>
      break;
  }
  log.lh.block[i] = b->blockno;
80102bd2:	89 0c 85 ec 16 11 80 	mov    %ecx,-0x7feee914(,%eax,4)
  if (i == log.lh.n)
80102bd9:	39 c2                	cmp    %eax,%edx
80102bdb:	74 1a                	je     80102bf7 <log_write+0x7b>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102bdd:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102be0:	c7 45 08 a0 16 11 80 	movl   $0x801116a0,0x8(%ebp)
}
80102be7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bea:	c9                   	leave
  release(&log.lock);
80102beb:	e9 dc 13 00 00       	jmp    80103fcc <release>
  log.lh.block[i] = b->blockno;
80102bf0:	89 0c 95 ec 16 11 80 	mov    %ecx,-0x7feee914(,%edx,4)
    log.lh.n++;
80102bf7:	42                   	inc    %edx
80102bf8:	89 15 e8 16 11 80    	mov    %edx,0x801116e8
80102bfe:	eb dd                	jmp    80102bdd <log_write+0x61>
    panic("too big a transaction");
80102c00:	83 ec 0c             	sub    $0xc,%esp
80102c03:	68 8a 6a 10 80       	push   $0x80106a8a
80102c08:	e8 2b d7 ff ff       	call   80100338 <panic>
    panic("log_write outside of trans");
80102c0d:	83 ec 0c             	sub    $0xc,%esp
80102c10:	68 a0 6a 10 80       	push   $0x80106aa0
80102c15:	e8 1e d7 ff ff       	call   80100338 <panic>
80102c1a:	66 90                	xchg   %ax,%ax

80102c1c <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102c1c:	55                   	push   %ebp
80102c1d:	89 e5                	mov    %esp,%ebp
80102c1f:	53                   	push   %ebx
80102c20:	50                   	push   %eax
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102c21:	e8 ae 08 00 00       	call   801034d4 <cpuid>
80102c26:	89 c3                	mov    %eax,%ebx
80102c28:	e8 a7 08 00 00       	call   801034d4 <cpuid>
80102c2d:	52                   	push   %edx
80102c2e:	53                   	push   %ebx
80102c2f:	50                   	push   %eax
80102c30:	68 bb 6a 10 80       	push   $0x80106abb
80102c35:	e8 ee d9 ff ff       	call   80100628 <cprintf>
  idtinit();       // load idt register
80102c3a:	e8 f9 24 00 00       	call   80105138 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102c3f:	e8 2c 08 00 00       	call   80103470 <mycpu>
80102c44:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102c46:	b8 01 00 00 00       	mov    $0x1,%eax
80102c4b:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102c52:	e8 fd 0a 00 00       	call   80103754 <scheduler>
80102c57:	90                   	nop

80102c58 <mpenter>:
{
80102c58:	55                   	push   %ebp
80102c59:	89 e5                	mov    %esp,%ebp
80102c5b:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102c5e:	e8 59 35 00 00       	call   801061bc <switchkvm>
  seginit();
80102c63:	e8 d0 34 00 00       	call   80106138 <seginit>
  lapicinit();
80102c68:	e8 93 f8 ff ff       	call   80102500 <lapicinit>
  mpmain();
80102c6d:	e8 aa ff ff ff       	call   80102c1c <mpmain>
80102c72:	66 90                	xchg   %ax,%ax

80102c74 <main>:
{
80102c74:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102c78:	83 e4 f0             	and    $0xfffffff0,%esp
80102c7b:	ff 71 fc             	push   -0x4(%ecx)
80102c7e:	55                   	push   %ebp
80102c7f:	89 e5                	mov    %esp,%ebp
80102c81:	53                   	push   %ebx
80102c82:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102c83:	83 ec 08             	sub    $0x8,%esp
80102c86:	68 00 00 40 80       	push   $0x80400000
80102c8b:	68 d0 54 11 80       	push   $0x801154d0
80102c90:	e8 5b f6 ff ff       	call   801022f0 <kinit1>
  kvmalloc();      // kernel page table
80102c95:	e8 66 39 00 00       	call   80106600 <kvmalloc>
  mpinit();        // detect other processors
80102c9a:	e8 61 01 00 00       	call   80102e00 <mpinit>
  lapicinit();     // interrupt controller
80102c9f:	e8 5c f8 ff ff       	call   80102500 <lapicinit>
  seginit();       // segment descriptors
80102ca4:	e8 8f 34 00 00       	call   80106138 <seginit>
  picinit();       // disable pic
80102ca9:	e8 22 03 00 00       	call   80102fd0 <picinit>
  ioapicinit();    // another interrupt controller
80102cae:	e8 41 f4 ff ff       	call   801020f4 <ioapicinit>
  consoleinit();   // console hardware
80102cb3:	e8 ec dc ff ff       	call   801009a4 <consoleinit>
  uartinit();      // serial port
80102cb8:	e8 4b 27 00 00       	call   80105408 <uartinit>
  pinit();         // process table
80102cbd:	e8 92 07 00 00       	call   80103454 <pinit>
  tvinit();        // trap vectors
80102cc2:	e8 05 24 00 00       	call   801050cc <tvinit>
  binit();         // buffer cache
80102cc7:	e8 68 d3 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80102ccc:	e8 73 e0 ff ff       	call   80100d44 <fileinit>
  ideinit();       // disk 
80102cd1:	e8 3a f2 ff ff       	call   80101f10 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102cd6:	83 c4 0c             	add    $0xc,%esp
80102cd9:	68 8a 00 00 00       	push   $0x8a
80102cde:	68 8c a4 10 80       	push   $0x8010a48c
80102ce3:	68 00 70 00 80       	push   $0x80007000
80102ce8:	e8 97 14 00 00       	call   80104184 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102ced:	8b 15 84 17 11 80    	mov    0x80111784,%edx
80102cf3:	8d 04 92             	lea    (%edx,%edx,4),%eax
80102cf6:	01 c0                	add    %eax,%eax
80102cf8:	01 d0                	add    %edx,%eax
80102cfa:	c1 e0 04             	shl    $0x4,%eax
80102cfd:	05 a0 17 11 80       	add    $0x801117a0,%eax
80102d02:	83 c4 10             	add    $0x10,%esp
80102d05:	3d a0 17 11 80       	cmp    $0x801117a0,%eax
80102d0a:	76 74                	jbe    80102d80 <main+0x10c>
80102d0c:	bb a0 17 11 80       	mov    $0x801117a0,%ebx
80102d11:	eb 20                	jmp    80102d33 <main+0xbf>
80102d13:	90                   	nop
80102d14:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102d1a:	8b 15 84 17 11 80    	mov    0x80111784,%edx
80102d20:	8d 04 92             	lea    (%edx,%edx,4),%eax
80102d23:	01 c0                	add    %eax,%eax
80102d25:	01 d0                	add    %edx,%eax
80102d27:	c1 e0 04             	shl    $0x4,%eax
80102d2a:	05 a0 17 11 80       	add    $0x801117a0,%eax
80102d2f:	39 c3                	cmp    %eax,%ebx
80102d31:	73 4d                	jae    80102d80 <main+0x10c>
    if(c == mycpu())  // We've started already.
80102d33:	e8 38 07 00 00       	call   80103470 <mycpu>
80102d38:	39 c3                	cmp    %eax,%ebx
80102d3a:	74 d8                	je     80102d14 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102d3c:	e8 13 f6 ff ff       	call   80102354 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102d41:	05 00 10 00 00       	add    $0x1000,%eax
80102d46:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
80102d4b:	c7 05 f8 6f 00 80 58 	movl   $0x80102c58,0x80006ff8
80102d52:	2c 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102d55:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102d5c:	90 10 00 

    lapicstartap(c->apicid, V2P(code));
80102d5f:	83 ec 08             	sub    $0x8,%esp
80102d62:	68 00 70 00 00       	push   $0x7000
80102d67:	0f b6 03             	movzbl (%ebx),%eax
80102d6a:	50                   	push   %eax
80102d6b:	e8 a0 f8 ff ff       	call   80102610 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102d70:	83 c4 10             	add    $0x10,%esp
80102d73:	90                   	nop
80102d74:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102d7a:	85 c0                	test   %eax,%eax
80102d7c:	74 f6                	je     80102d74 <main+0x100>
80102d7e:	eb 94                	jmp    80102d14 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102d80:	83 ec 08             	sub    $0x8,%esp
80102d83:	68 00 00 00 8e       	push   $0x8e000000
80102d88:	68 00 00 40 80       	push   $0x80400000
80102d8d:	e8 0a f5 ff ff       	call   8010229c <kinit2>
  userinit();      // first user process
80102d92:	e8 95 07 00 00       	call   8010352c <userinit>
  mpmain();        // finish this processor's setup
80102d97:	e8 80 fe ff ff       	call   80102c1c <mpmain>

80102d9c <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102d9c:	55                   	push   %ebp
80102d9d:	89 e5                	mov    %esp,%ebp
80102d9f:	57                   	push   %edi
80102da0:	56                   	push   %esi
80102da1:	53                   	push   %ebx
80102da2:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
80102da5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
  e = addr+len;
80102dab:	8d 9c 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%ebx
  for(p = addr; p < e; p += sizeof(struct mp))
80102db2:	39 de                	cmp    %ebx,%esi
80102db4:	72 0b                	jb     80102dc1 <mpsearch1+0x25>
80102db6:	eb 3c                	jmp    80102df4 <mpsearch1+0x58>
80102db8:	8d 7e 10             	lea    0x10(%esi),%edi
80102dbb:	89 fe                	mov    %edi,%esi
80102dbd:	39 df                	cmp    %ebx,%edi
80102dbf:	73 33                	jae    80102df4 <mpsearch1+0x58>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102dc1:	50                   	push   %eax
80102dc2:	6a 04                	push   $0x4
80102dc4:	68 cf 6a 10 80       	push   $0x80106acf
80102dc9:	56                   	push   %esi
80102dca:	e8 7d 13 00 00       	call   8010414c <memcmp>
80102dcf:	83 c4 10             	add    $0x10,%esp
80102dd2:	85 c0                	test   %eax,%eax
80102dd4:	75 e2                	jne    80102db8 <mpsearch1+0x1c>
80102dd6:	89 f2                	mov    %esi,%edx
80102dd8:	8d 7e 10             	lea    0x10(%esi),%edi
80102ddb:	90                   	nop
    sum += addr[i];
80102ddc:	0f b6 0a             	movzbl (%edx),%ecx
80102ddf:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80102de1:	42                   	inc    %edx
80102de2:	39 fa                	cmp    %edi,%edx
80102de4:	75 f6                	jne    80102ddc <mpsearch1+0x40>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102de6:	84 c0                	test   %al,%al
80102de8:	75 d1                	jne    80102dbb <mpsearch1+0x1f>
      return (struct mp*)p;
  return 0;
}
80102dea:	89 f0                	mov    %esi,%eax
80102dec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102def:	5b                   	pop    %ebx
80102df0:	5e                   	pop    %esi
80102df1:	5f                   	pop    %edi
80102df2:	5d                   	pop    %ebp
80102df3:	c3                   	ret
  return 0;
80102df4:	31 f6                	xor    %esi,%esi
}
80102df6:	89 f0                	mov    %esi,%eax
80102df8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102dfb:	5b                   	pop    %ebx
80102dfc:	5e                   	pop    %esi
80102dfd:	5f                   	pop    %edi
80102dfe:	5d                   	pop    %ebp
80102dff:	c3                   	ret

80102e00 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80102e00:	55                   	push   %ebp
80102e01:	89 e5                	mov    %esp,%ebp
80102e03:	57                   	push   %edi
80102e04:	56                   	push   %esi
80102e05:	53                   	push   %ebx
80102e06:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80102e09:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80102e10:	c1 e0 08             	shl    $0x8,%eax
80102e13:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80102e1a:	09 d0                	or     %edx,%eax
80102e1c:	c1 e0 04             	shl    $0x4,%eax
80102e1f:	75 1b                	jne    80102e3c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80102e21:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80102e28:	c1 e0 08             	shl    $0x8,%eax
80102e2b:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80102e32:	09 d0                	or     %edx,%eax
80102e34:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80102e37:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80102e3c:	ba 00 04 00 00       	mov    $0x400,%edx
80102e41:	e8 56 ff ff ff       	call   80102d9c <mpsearch1>
80102e46:	89 c3                	mov    %eax,%ebx
80102e48:	85 c0                	test   %eax,%eax
80102e4a:	0f 84 30 01 00 00    	je     80102f80 <mpinit+0x180>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80102e50:	8b 73 04             	mov    0x4(%ebx),%esi
80102e53:	85 f6                	test   %esi,%esi
80102e55:	0f 84 15 01 00 00    	je     80102f70 <mpinit+0x170>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80102e5b:	8d 8e 00 00 00 80    	lea    -0x80000000(%esi),%ecx
  if(memcmp(conf, "PCMP", 4) != 0)
80102e61:	50                   	push   %eax
80102e62:	6a 04                	push   $0x4
80102e64:	68 d4 6a 10 80       	push   $0x80106ad4
80102e69:	51                   	push   %ecx
80102e6a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102e6d:	e8 da 12 00 00       	call   8010414c <memcmp>
80102e72:	83 c4 10             	add    $0x10,%esp
80102e75:	85 c0                	test   %eax,%eax
80102e77:	0f 85 f3 00 00 00    	jne    80102f70 <mpinit+0x170>
  if(conf->version != 1 && conf->version != 4)
80102e7d:	8a 86 06 00 00 80    	mov    -0x7ffffffa(%esi),%al
80102e83:	3c 01                	cmp    $0x1,%al
80102e85:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102e88:	74 08                	je     80102e92 <mpinit+0x92>
80102e8a:	3c 04                	cmp    $0x4,%al
80102e8c:	0f 85 de 00 00 00    	jne    80102f70 <mpinit+0x170>
  if(sum((uchar*)conf, conf->length) != 0)
80102e92:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80102e99:	66 85 d2             	test   %dx,%dx
80102e9c:	74 1f                	je     80102ebd <mpinit+0xbd>
80102e9e:	89 c8                	mov    %ecx,%eax
80102ea0:	8d 3c 11             	lea    (%ecx,%edx,1),%edi
  sum = 0;
80102ea3:	31 d2                	xor    %edx,%edx
80102ea5:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    sum += addr[i];
80102ea8:	0f b6 30             	movzbl (%eax),%esi
80102eab:	01 f2                	add    %esi,%edx
  for(i=0; i<len; i++)
80102ead:	40                   	inc    %eax
80102eae:	39 f8                	cmp    %edi,%eax
80102eb0:	75 f6                	jne    80102ea8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80102eb2:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80102eb5:	84 d2                	test   %dl,%dl
80102eb7:	0f 85 b3 00 00 00    	jne    80102f70 <mpinit+0x170>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80102ebd:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80102ec3:	a3 80 16 11 80       	mov    %eax,0x80111680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102ec8:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80102ece:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80102ed5:	01 d1                	add    %edx,%ecx
  ismp = 1;
80102ed7:	be 01 00 00 00       	mov    $0x1,%esi
80102edc:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80102edf:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102ee0:	39 c8                	cmp    %ecx,%eax
80102ee2:	73 14                	jae    80102ef8 <mpinit+0xf8>
    switch(*p){
80102ee4:	8a 10                	mov    (%eax),%dl
80102ee6:	80 fa 02             	cmp    $0x2,%dl
80102ee9:	74 71                	je     80102f5c <mpinit+0x15c>
80102eeb:	77 63                	ja     80102f50 <mpinit+0x150>
80102eed:	84 d2                	test   %dl,%dl
80102eef:	74 33                	je     80102f24 <mpinit+0x124>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80102ef1:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80102ef4:	39 c8                	cmp    %ecx,%eax
80102ef6:	72 ec                	jb     80102ee4 <mpinit+0xe4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80102ef8:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80102efb:	85 f6                	test   %esi,%esi
80102efd:	0f 84 c0 00 00 00    	je     80102fc3 <mpinit+0x1c3>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80102f03:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80102f07:	74 12                	je     80102f1b <mpinit+0x11b>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f09:	b0 70                	mov    $0x70,%al
80102f0b:	ba 22 00 00 00       	mov    $0x22,%edx
80102f10:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f11:	ba 23 00 00 00       	mov    $0x23,%edx
80102f16:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80102f17:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f1a:	ee                   	out    %al,(%dx)
  }
}
80102f1b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f1e:	5b                   	pop    %ebx
80102f1f:	5e                   	pop    %esi
80102f20:	5f                   	pop    %edi
80102f21:	5d                   	pop    %ebp
80102f22:	c3                   	ret
80102f23:	90                   	nop
      if(ncpu < NCPU) {
80102f24:	8b 15 84 17 11 80    	mov    0x80111784,%edx
80102f2a:	83 fa 07             	cmp    $0x7,%edx
80102f2d:	7f 1a                	jg     80102f49 <mpinit+0x149>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80102f2f:	8d 3c 92             	lea    (%edx,%edx,4),%edi
80102f32:	01 ff                	add    %edi,%edi
80102f34:	01 d7                	add    %edx,%edi
80102f36:	c1 e7 04             	shl    $0x4,%edi
80102f39:	8a 58 01             	mov    0x1(%eax),%bl
80102f3c:	88 9f a0 17 11 80    	mov    %bl,-0x7feee860(%edi)
        ncpu++;
80102f42:	42                   	inc    %edx
80102f43:	89 15 84 17 11 80    	mov    %edx,0x80111784
      p += sizeof(struct mpproc);
80102f49:	83 c0 14             	add    $0x14,%eax
      continue;
80102f4c:	eb 92                	jmp    80102ee0 <mpinit+0xe0>
80102f4e:	66 90                	xchg   %ax,%ax
    switch(*p){
80102f50:	83 ea 03             	sub    $0x3,%edx
80102f53:	80 fa 01             	cmp    $0x1,%dl
80102f56:	76 99                	jbe    80102ef1 <mpinit+0xf1>
80102f58:	31 f6                	xor    %esi,%esi
80102f5a:	eb 84                	jmp    80102ee0 <mpinit+0xe0>
      ioapicid = ioapic->apicno;
80102f5c:	8a 50 01             	mov    0x1(%eax),%dl
80102f5f:	88 15 80 17 11 80    	mov    %dl,0x80111780
      p += sizeof(struct mpioapic);
80102f65:	83 c0 08             	add    $0x8,%eax
      continue;
80102f68:	e9 73 ff ff ff       	jmp    80102ee0 <mpinit+0xe0>
80102f6d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80102f70:	83 ec 0c             	sub    $0xc,%esp
80102f73:	68 d9 6a 10 80       	push   $0x80106ad9
80102f78:	e8 bb d3 ff ff       	call   80100338 <panic>
80102f7d:	8d 76 00             	lea    0x0(%esi),%esi
{
80102f80:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80102f85:	eb 0e                	jmp    80102f95 <mpinit+0x195>
80102f87:	90                   	nop
80102f88:	8d 73 10             	lea    0x10(%ebx),%esi
  for(p = addr; p < e; p += sizeof(struct mp))
80102f8b:	89 f3                	mov    %esi,%ebx
80102f8d:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80102f93:	74 db                	je     80102f70 <mpinit+0x170>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102f95:	52                   	push   %edx
80102f96:	6a 04                	push   $0x4
80102f98:	68 cf 6a 10 80       	push   $0x80106acf
80102f9d:	53                   	push   %ebx
80102f9e:	e8 a9 11 00 00       	call   8010414c <memcmp>
80102fa3:	83 c4 10             	add    $0x10,%esp
80102fa6:	85 c0                	test   %eax,%eax
80102fa8:	75 de                	jne    80102f88 <mpinit+0x188>
80102faa:	89 da                	mov    %ebx,%edx
80102fac:	8d 73 10             	lea    0x10(%ebx),%esi
80102faf:	90                   	nop
    sum += addr[i];
80102fb0:	0f b6 0a             	movzbl (%edx),%ecx
80102fb3:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80102fb5:	42                   	inc    %edx
80102fb6:	39 f2                	cmp    %esi,%edx
80102fb8:	75 f6                	jne    80102fb0 <mpinit+0x1b0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102fba:	84 c0                	test   %al,%al
80102fbc:	75 cd                	jne    80102f8b <mpinit+0x18b>
80102fbe:	e9 8d fe ff ff       	jmp    80102e50 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80102fc3:	83 ec 0c             	sub    $0xc,%esp
80102fc6:	68 4c 6e 10 80       	push   $0x80106e4c
80102fcb:	e8 68 d3 ff ff       	call   80100338 <panic>

80102fd0 <picinit>:
80102fd0:	b0 ff                	mov    $0xff,%al
80102fd2:	ba 21 00 00 00       	mov    $0x21,%edx
80102fd7:	ee                   	out    %al,(%dx)
80102fd8:	ba a1 00 00 00       	mov    $0xa1,%edx
80102fdd:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80102fde:	c3                   	ret
80102fdf:	90                   	nop

80102fe0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80102fe0:	55                   	push   %ebp
80102fe1:	89 e5                	mov    %esp,%ebp
80102fe3:	57                   	push   %edi
80102fe4:	56                   	push   %esi
80102fe5:	53                   	push   %ebx
80102fe6:	83 ec 0c             	sub    $0xc,%esp
80102fe9:	8b 75 08             	mov    0x8(%ebp),%esi
80102fec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80102fef:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80102ff5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80102ffb:	e8 60 dd ff ff       	call   80100d60 <filealloc>
80103000:	89 06                	mov    %eax,(%esi)
80103002:	85 c0                	test   %eax,%eax
80103004:	0f 84 a5 00 00 00    	je     801030af <pipealloc+0xcf>
8010300a:	e8 51 dd ff ff       	call   80100d60 <filealloc>
8010300f:	89 07                	mov    %eax,(%edi)
80103011:	85 c0                	test   %eax,%eax
80103013:	0f 84 84 00 00 00    	je     8010309d <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103019:	e8 36 f3 ff ff       	call   80102354 <kalloc>
8010301e:	89 c3                	mov    %eax,%ebx
80103020:	85 c0                	test   %eax,%eax
80103022:	0f 84 a0 00 00 00    	je     801030c8 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
80103028:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010302f:	00 00 00 
  p->writeopen = 1;
80103032:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103039:	00 00 00 
  p->nwrite = 0;
8010303c:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103043:	00 00 00 
  p->nread = 0;
80103046:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
8010304d:	00 00 00 
  initlock(&p->lock, "pipe");
80103050:	83 ec 08             	sub    $0x8,%esp
80103053:	68 f1 6a 10 80       	push   $0x80106af1
80103058:	50                   	push   %eax
80103059:	e8 f6 0d 00 00       	call   80103e54 <initlock>
  (*f0)->type = FD_PIPE;
8010305e:	8b 06                	mov    (%esi),%eax
80103060:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103066:	8b 06                	mov    (%esi),%eax
80103068:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010306c:	8b 06                	mov    (%esi),%eax
8010306e:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103072:	8b 06                	mov    (%esi),%eax
80103074:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103077:	8b 07                	mov    (%edi),%eax
80103079:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010307f:	8b 07                	mov    (%edi),%eax
80103081:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103085:	8b 07                	mov    (%edi),%eax
80103087:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010308b:	8b 07                	mov    (%edi),%eax
8010308d:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
80103090:	83 c4 10             	add    $0x10,%esp
80103093:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103095:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103098:	5b                   	pop    %ebx
80103099:	5e                   	pop    %esi
8010309a:	5f                   	pop    %edi
8010309b:	5d                   	pop    %ebp
8010309c:	c3                   	ret
  if(*f0)
8010309d:	8b 06                	mov    (%esi),%eax
8010309f:	85 c0                	test   %eax,%eax
801030a1:	74 1e                	je     801030c1 <pipealloc+0xe1>
    fileclose(*f0);
801030a3:	83 ec 0c             	sub    $0xc,%esp
801030a6:	50                   	push   %eax
801030a7:	e8 60 dd ff ff       	call   80100e0c <fileclose>
801030ac:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801030af:	8b 07                	mov    (%edi),%eax
801030b1:	85 c0                	test   %eax,%eax
801030b3:	74 0c                	je     801030c1 <pipealloc+0xe1>
    fileclose(*f1);
801030b5:	83 ec 0c             	sub    $0xc,%esp
801030b8:	50                   	push   %eax
801030b9:	e8 4e dd ff ff       	call   80100e0c <fileclose>
801030be:	83 c4 10             	add    $0x10,%esp
  return -1;
801030c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801030c6:	eb cd                	jmp    80103095 <pipealloc+0xb5>
  if(*f0)
801030c8:	8b 06                	mov    (%esi),%eax
801030ca:	85 c0                	test   %eax,%eax
801030cc:	75 d5                	jne    801030a3 <pipealloc+0xc3>
801030ce:	eb df                	jmp    801030af <pipealloc+0xcf>

801030d0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801030d0:	55                   	push   %ebp
801030d1:	89 e5                	mov    %esp,%ebp
801030d3:	56                   	push   %esi
801030d4:	53                   	push   %ebx
801030d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801030d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801030db:	83 ec 0c             	sub    $0xc,%esp
801030de:	53                   	push   %ebx
801030df:	e8 48 0f 00 00       	call   8010402c <acquire>
  if(writable){
801030e4:	83 c4 10             	add    $0x10,%esp
801030e7:	85 f6                	test   %esi,%esi
801030e9:	74 5d                	je     80103148 <pipeclose+0x78>
    p->writeopen = 0;
801030eb:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801030f2:	00 00 00 
    wakeup(&p->nread);
801030f5:	83 ec 0c             	sub    $0xc,%esp
801030f8:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801030fe:	50                   	push   %eax
801030ff:	e8 c8 0a 00 00       	call   80103bcc <wakeup>
80103104:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103107:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010310d:	85 d2                	test   %edx,%edx
8010310f:	75 0a                	jne    8010311b <pipeclose+0x4b>
80103111:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103117:	85 c0                	test   %eax,%eax
80103119:	74 11                	je     8010312c <pipeclose+0x5c>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010311b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010311e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103121:	5b                   	pop    %ebx
80103122:	5e                   	pop    %esi
80103123:	5d                   	pop    %ebp
    release(&p->lock);
80103124:	e9 a3 0e 00 00       	jmp    80103fcc <release>
80103129:	8d 76 00             	lea    0x0(%esi),%esi
    release(&p->lock);
8010312c:	83 ec 0c             	sub    $0xc,%esp
8010312f:	53                   	push   %ebx
80103130:	e8 97 0e 00 00       	call   80103fcc <release>
    kfree((char*)p);
80103135:	83 c4 10             	add    $0x10,%esp
80103138:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010313b:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010313e:	5b                   	pop    %ebx
8010313f:	5e                   	pop    %esi
80103140:	5d                   	pop    %ebp
    kfree((char*)p);
80103141:	e9 7e f0 ff ff       	jmp    801021c4 <kfree>
80103146:	66 90                	xchg   %ax,%ax
    p->readopen = 0;
80103148:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
8010314f:	00 00 00 
    wakeup(&p->nwrite);
80103152:	83 ec 0c             	sub    $0xc,%esp
80103155:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010315b:	50                   	push   %eax
8010315c:	e8 6b 0a 00 00       	call   80103bcc <wakeup>
80103161:	83 c4 10             	add    $0x10,%esp
80103164:	eb a1                	jmp    80103107 <pipeclose+0x37>
80103166:	66 90                	xchg   %ax,%ax

80103168 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103168:	55                   	push   %ebp
80103169:	89 e5                	mov    %esp,%ebp
8010316b:	57                   	push   %edi
8010316c:	56                   	push   %esi
8010316d:	53                   	push   %ebx
8010316e:	83 ec 28             	sub    $0x28,%esp
80103171:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103174:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
80103177:	53                   	push   %ebx
80103178:	e8 af 0e 00 00       	call   8010402c <acquire>
  for(i = 0; i < n; i++){
8010317d:	83 c4 10             	add    $0x10,%esp
80103180:	85 ff                	test   %edi,%edi
80103182:	0f 8e c2 00 00 00    	jle    8010324a <pipewrite+0xe2>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103188:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
8010318e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103191:	8d 34 39             	lea    (%ecx,%edi,1),%esi
80103194:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103197:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
8010319d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801031a0:	89 7d 10             	mov    %edi,0x10(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801031a3:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801031a9:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801031af:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801031b5:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
801031b8:	0f 85 aa 00 00 00    	jne    80103268 <pipewrite+0x100>
801031be:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801031c1:	eb 37                	jmp    801031fa <pipewrite+0x92>
801031c3:	90                   	nop
      if(p->readopen == 0 || myproc()->killed){
801031c4:	e8 3f 03 00 00       	call   80103508 <myproc>
801031c9:	8b 48 24             	mov    0x24(%eax),%ecx
801031cc:	85 c9                	test   %ecx,%ecx
801031ce:	75 34                	jne    80103204 <pipewrite+0x9c>
      wakeup(&p->nread);
801031d0:	83 ec 0c             	sub    $0xc,%esp
801031d3:	56                   	push   %esi
801031d4:	e8 f3 09 00 00       	call   80103bcc <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801031d9:	58                   	pop    %eax
801031da:	5a                   	pop    %edx
801031db:	53                   	push   %ebx
801031dc:	57                   	push   %edi
801031dd:	e8 2e 09 00 00       	call   80103b10 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801031e2:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801031e8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801031ee:	05 00 02 00 00       	add    $0x200,%eax
801031f3:	83 c4 10             	add    $0x10,%esp
801031f6:	39 c2                	cmp    %eax,%edx
801031f8:	75 26                	jne    80103220 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
801031fa:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103200:	85 c0                	test   %eax,%eax
80103202:	75 c0                	jne    801031c4 <pipewrite+0x5c>
        release(&p->lock);
80103204:	83 ec 0c             	sub    $0xc,%esp
80103207:	53                   	push   %ebx
80103208:	e8 bf 0d 00 00       	call   80103fcc <release>
        return -1;
8010320d:	83 c4 10             	add    $0x10,%esp
80103210:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103215:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103218:	5b                   	pop    %ebx
80103219:	5e                   	pop    %esi
8010321a:	5f                   	pop    %edi
8010321b:	5d                   	pop    %ebp
8010321c:	c3                   	ret
8010321d:	8d 76 00             	lea    0x0(%esi),%esi
80103220:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103223:	8d 42 01             	lea    0x1(%edx),%eax
80103226:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103229:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
8010322f:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103235:	8a 01                	mov    (%ecx),%al
80103237:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
8010323b:	41                   	inc    %ecx
8010323c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010323f:	39 c1                	cmp    %eax,%ecx
80103241:	0f 85 5c ff ff ff    	jne    801031a3 <pipewrite+0x3b>
80103247:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010324a:	83 ec 0c             	sub    $0xc,%esp
8010324d:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103253:	50                   	push   %eax
80103254:	e8 73 09 00 00       	call   80103bcc <wakeup>
  release(&p->lock);
80103259:	89 1c 24             	mov    %ebx,(%esp)
8010325c:	e8 6b 0d 00 00       	call   80103fcc <release>
  return n;
80103261:	83 c4 10             	add    $0x10,%esp
80103264:	89 f8                	mov    %edi,%eax
80103266:	eb ad                	jmp    80103215 <pipewrite+0xad>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103268:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010326b:	eb b6                	jmp    80103223 <pipewrite+0xbb>
8010326d:	8d 76 00             	lea    0x0(%esi),%esi

80103270 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103270:	55                   	push   %ebp
80103271:	89 e5                	mov    %esp,%ebp
80103273:	57                   	push   %edi
80103274:	56                   	push   %esi
80103275:	53                   	push   %ebx
80103276:	83 ec 18             	sub    $0x18,%esp
80103279:	8b 75 08             	mov    0x8(%ebp),%esi
8010327c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010327f:	56                   	push   %esi
80103280:	e8 a7 0d 00 00       	call   8010402c <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103285:	83 c4 10             	add    $0x10,%esp
80103288:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
8010328e:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103294:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010329a:	74 2f                	je     801032cb <piperead+0x5b>
8010329c:	eb 37                	jmp    801032d5 <piperead+0x65>
8010329e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
801032a0:	e8 63 02 00 00       	call   80103508 <myproc>
801032a5:	8b 40 24             	mov    0x24(%eax),%eax
801032a8:	85 c0                	test   %eax,%eax
801032aa:	0f 85 80 00 00 00    	jne    80103330 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801032b0:	83 ec 08             	sub    $0x8,%esp
801032b3:	56                   	push   %esi
801032b4:	53                   	push   %ebx
801032b5:	e8 56 08 00 00       	call   80103b10 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801032ba:	83 c4 10             	add    $0x10,%esp
801032bd:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801032c3:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801032c9:	75 0a                	jne    801032d5 <piperead+0x65>
801032cb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801032d1:	85 d2                	test   %edx,%edx
801032d3:	75 cb                	jne    801032a0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801032d5:	31 db                	xor    %ebx,%ebx
801032d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801032da:	85 c9                	test   %ecx,%ecx
801032dc:	7f 23                	jg     80103301 <piperead+0x91>
801032de:	eb 29                	jmp    80103309 <piperead+0x99>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801032e0:	8d 48 01             	lea    0x1(%eax),%ecx
801032e3:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
801032e9:	25 ff 01 00 00       	and    $0x1ff,%eax
801032ee:	8a 44 06 34          	mov    0x34(%esi,%eax,1),%al
801032f2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801032f5:	43                   	inc    %ebx
801032f6:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801032f9:	74 0e                	je     80103309 <piperead+0x99>
801032fb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80103301:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103307:	75 d7                	jne    801032e0 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103309:	83 ec 0c             	sub    $0xc,%esp
8010330c:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103312:	50                   	push   %eax
80103313:	e8 b4 08 00 00       	call   80103bcc <wakeup>
  release(&p->lock);
80103318:	89 34 24             	mov    %esi,(%esp)
8010331b:	e8 ac 0c 00 00       	call   80103fcc <release>
  return i;
80103320:	83 c4 10             	add    $0x10,%esp
}
80103323:	89 d8                	mov    %ebx,%eax
80103325:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103328:	5b                   	pop    %ebx
80103329:	5e                   	pop    %esi
8010332a:	5f                   	pop    %edi
8010332b:	5d                   	pop    %ebp
8010332c:	c3                   	ret
8010332d:	8d 76 00             	lea    0x0(%esi),%esi
      release(&p->lock);
80103330:	83 ec 0c             	sub    $0xc,%esp
80103333:	56                   	push   %esi
80103334:	e8 93 0c 00 00       	call   80103fcc <release>
      return -1;
80103339:	83 c4 10             	add    $0x10,%esp
8010333c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80103341:	89 d8                	mov    %ebx,%eax
80103343:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103346:	5b                   	pop    %ebx
80103347:	5e                   	pop    %esi
80103348:	5f                   	pop    %edi
80103349:	5d                   	pop    %ebp
8010334a:	c3                   	ret
8010334b:	90                   	nop

8010334c <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
8010334c:	55                   	push   %ebp
8010334d:	89 e5                	mov    %esp,%ebp
8010334f:	53                   	push   %ebx
80103350:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80103353:	68 20 1d 11 80       	push   $0x80111d20
80103358:	e8 cf 0c 00 00       	call   8010402c <acquire>
8010335d:	83 c4 10             	add    $0x10,%esp

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103360:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
80103365:	eb 0c                	jmp    80103373 <allocproc+0x27>
80103367:	90                   	nop
80103368:	83 c3 7c             	add    $0x7c,%ebx
8010336b:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103371:	74 75                	je     801033e8 <allocproc+0x9c>
    if(p->state == UNUSED)
80103373:	8b 4b 0c             	mov    0xc(%ebx),%ecx
80103376:	85 c9                	test   %ecx,%ecx
80103378:	75 ee                	jne    80103368 <allocproc+0x1c>

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
8010337a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103381:	a1 04 a0 10 80       	mov    0x8010a004,%eax
80103386:	8d 50 01             	lea    0x1(%eax),%edx
80103389:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
8010338f:	89 43 10             	mov    %eax,0x10(%ebx)

  release(&ptable.lock);
80103392:	83 ec 0c             	sub    $0xc,%esp
80103395:	68 20 1d 11 80       	push   $0x80111d20
8010339a:	e8 2d 0c 00 00       	call   80103fcc <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010339f:	e8 b0 ef ff ff       	call   80102354 <kalloc>
801033a4:	89 43 08             	mov    %eax,0x8(%ebx)
801033a7:	83 c4 10             	add    $0x10,%esp
801033aa:	85 c0                	test   %eax,%eax
801033ac:	74 53                	je     80103401 <allocproc+0xb5>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801033ae:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
801033b4:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
801033b7:	c7 80 b0 0f 00 00 c1 	movl   $0x801050c1,0xfb0(%eax)
801033be:	50 10 80 

  sp -= sizeof *p->context;
801033c1:	05 9c 0f 00 00       	add    $0xf9c,%eax
  p->context = (struct context*)sp;
801033c6:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801033c9:	52                   	push   %edx
801033ca:	6a 14                	push   $0x14
801033cc:	6a 00                	push   $0x0
801033ce:	50                   	push   %eax
801033cf:	e8 34 0d 00 00       	call   80104108 <memset>
  p->context->eip = (uint)forkret;
801033d4:	8b 43 1c             	mov    0x1c(%ebx),%eax
801033d7:	c7 40 10 0c 34 10 80 	movl   $0x8010340c,0x10(%eax)

  return p;
801033de:	83 c4 10             	add    $0x10,%esp
}
801033e1:	89 d8                	mov    %ebx,%eax
801033e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801033e6:	c9                   	leave
801033e7:	c3                   	ret
  release(&ptable.lock);
801033e8:	83 ec 0c             	sub    $0xc,%esp
801033eb:	68 20 1d 11 80       	push   $0x80111d20
801033f0:	e8 d7 0b 00 00       	call   80103fcc <release>
  return 0;
801033f5:	83 c4 10             	add    $0x10,%esp
801033f8:	31 db                	xor    %ebx,%ebx
}
801033fa:	89 d8                	mov    %ebx,%eax
801033fc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801033ff:	c9                   	leave
80103400:	c3                   	ret
    p->state = UNUSED;
80103401:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103408:	31 db                	xor    %ebx,%ebx
8010340a:	eb ee                	jmp    801033fa <allocproc+0xae>

8010340c <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
8010340c:	55                   	push   %ebp
8010340d:	89 e5                	mov    %esp,%ebp
8010340f:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103412:	68 20 1d 11 80       	push   $0x80111d20
80103417:	e8 b0 0b 00 00       	call   80103fcc <release>

  if (first) {
8010341c:	83 c4 10             	add    $0x10,%esp
8010341f:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103424:	85 c0                	test   %eax,%eax
80103426:	75 04                	jne    8010342c <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103428:	c9                   	leave
80103429:	c3                   	ret
8010342a:	66 90                	xchg   %ax,%ax
    first = 0;
8010342c:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
80103433:	00 00 00 
    iinit(ROOTDEV);
80103436:	83 ec 0c             	sub    $0xc,%esp
80103439:	6a 01                	push   $0x1
8010343b:	e8 9c df ff ff       	call   801013dc <iinit>
    initlog(ROOTDEV);
80103440:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103447:	e8 e4 f4 ff ff       	call   80102930 <initlog>
}
8010344c:	83 c4 10             	add    $0x10,%esp
8010344f:	c9                   	leave
80103450:	c3                   	ret
80103451:	8d 76 00             	lea    0x0(%esi),%esi

80103454 <pinit>:
{
80103454:	55                   	push   %ebp
80103455:	89 e5                	mov    %esp,%ebp
80103457:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
8010345a:	68 f6 6a 10 80       	push   $0x80106af6
8010345f:	68 20 1d 11 80       	push   $0x80111d20
80103464:	e8 eb 09 00 00       	call   80103e54 <initlock>
}
80103469:	83 c4 10             	add    $0x10,%esp
8010346c:	c9                   	leave
8010346d:	c3                   	ret
8010346e:	66 90                	xchg   %ax,%ax

80103470 <mycpu>:
{
80103470:	55                   	push   %ebp
80103471:	89 e5                	mov    %esp,%ebp
80103473:	56                   	push   %esi
80103474:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103475:	9c                   	pushf
80103476:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103477:	f6 c4 02             	test   $0x2,%ah
8010347a:	75 4b                	jne    801034c7 <mycpu+0x57>
  apicid = lapicid();
8010347c:	e8 5f f1 ff ff       	call   801025e0 <lapicid>
80103481:	89 c1                	mov    %eax,%ecx
  for (i = 0; i < ncpu; ++i) {
80103483:	8b 1d 84 17 11 80    	mov    0x80111784,%ebx
80103489:	85 db                	test   %ebx,%ebx
8010348b:	7e 2d                	jle    801034ba <mycpu+0x4a>
8010348d:	31 d2                	xor    %edx,%edx
8010348f:	eb 08                	jmp    80103499 <mycpu+0x29>
80103491:	8d 76 00             	lea    0x0(%esi),%esi
80103494:	42                   	inc    %edx
80103495:	39 da                	cmp    %ebx,%edx
80103497:	74 21                	je     801034ba <mycpu+0x4a>
    if (cpus[i].apicid == apicid)
80103499:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010349c:	01 c0                	add    %eax,%eax
8010349e:	01 d0                	add    %edx,%eax
801034a0:	c1 e0 04             	shl    $0x4,%eax
801034a3:	0f b6 b0 a0 17 11 80 	movzbl -0x7feee860(%eax),%esi
801034aa:	39 ce                	cmp    %ecx,%esi
801034ac:	75 e6                	jne    80103494 <mycpu+0x24>
      return &cpus[i];
801034ae:	05 a0 17 11 80       	add    $0x801117a0,%eax
}
801034b3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034b6:	5b                   	pop    %ebx
801034b7:	5e                   	pop    %esi
801034b8:	5d                   	pop    %ebp
801034b9:	c3                   	ret
  panic("unknown apicid\n");
801034ba:	83 ec 0c             	sub    $0xc,%esp
801034bd:	68 fd 6a 10 80       	push   $0x80106afd
801034c2:	e8 71 ce ff ff       	call   80100338 <panic>
    panic("mycpu called with interrupts enabled\n");
801034c7:	83 ec 0c             	sub    $0xc,%esp
801034ca:	68 6c 6e 10 80       	push   $0x80106e6c
801034cf:	e8 64 ce ff ff       	call   80100338 <panic>

801034d4 <cpuid>:
cpuid() {
801034d4:	55                   	push   %ebp
801034d5:	89 e5                	mov    %esp,%ebp
801034d7:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801034da:	e8 91 ff ff ff       	call   80103470 <mycpu>
801034df:	2d a0 17 11 80       	sub    $0x801117a0,%eax
801034e4:	c1 f8 04             	sar    $0x4,%eax
801034e7:	8d 0c c0             	lea    (%eax,%eax,8),%ecx
801034ea:	89 ca                	mov    %ecx,%edx
801034ec:	c1 e2 05             	shl    $0x5,%edx
801034ef:	29 ca                	sub    %ecx,%edx
801034f1:	8d 14 90             	lea    (%eax,%edx,4),%edx
801034f4:	8d 0c d0             	lea    (%eax,%edx,8),%ecx
801034f7:	89 ca                	mov    %ecx,%edx
801034f9:	c1 e2 0f             	shl    $0xf,%edx
801034fc:	29 ca                	sub    %ecx,%edx
801034fe:	8d 04 90             	lea    (%eax,%edx,4),%eax
80103501:	f7 d8                	neg    %eax
}
80103503:	c9                   	leave
80103504:	c3                   	ret
80103505:	8d 76 00             	lea    0x0(%esi),%esi

80103508 <myproc>:
myproc(void) {
80103508:	55                   	push   %ebp
80103509:	89 e5                	mov    %esp,%ebp
8010350b:	53                   	push   %ebx
8010350c:	50                   	push   %eax
  pushcli();
8010350d:	e8 d6 09 00 00       	call   80103ee8 <pushcli>
  c = mycpu();
80103512:	e8 59 ff ff ff       	call   80103470 <mycpu>
  p = c->proc;
80103517:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010351d:	e8 12 0a 00 00       	call   80103f34 <popcli>
}
80103522:	89 d8                	mov    %ebx,%eax
80103524:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103527:	c9                   	leave
80103528:	c3                   	ret
80103529:	8d 76 00             	lea    0x0(%esi),%esi

8010352c <userinit>:
{
8010352c:	55                   	push   %ebp
8010352d:	89 e5                	mov    %esp,%ebp
8010352f:	53                   	push   %ebx
80103530:	51                   	push   %ecx
  p = allocproc();
80103531:	e8 16 fe ff ff       	call   8010334c <allocproc>
80103536:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103538:	a3 54 3c 11 80       	mov    %eax,0x80113c54
  if((p->pgdir = setupkvm()) == 0)
8010353d:	e8 4a 30 00 00       	call   8010658c <setupkvm>
80103542:	89 43 04             	mov    %eax,0x4(%ebx)
80103545:	85 c0                	test   %eax,%eax
80103547:	0f 84 b3 00 00 00    	je     80103600 <userinit+0xd4>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
8010354d:	52                   	push   %edx
8010354e:	68 2c 00 00 00       	push   $0x2c
80103553:	68 60 a4 10 80       	push   $0x8010a460
80103558:	50                   	push   %eax
80103559:	e8 6a 2d 00 00       	call   801062c8 <inituvm>
  p->sz = PGSIZE;
8010355e:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103564:	83 c4 0c             	add    $0xc,%esp
80103567:	6a 4c                	push   $0x4c
80103569:	6a 00                	push   $0x0
8010356b:	ff 73 18             	push   0x18(%ebx)
8010356e:	e8 95 0b 00 00       	call   80104108 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103573:	8b 43 18             	mov    0x18(%ebx),%eax
80103576:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010357c:	8b 43 18             	mov    0x18(%ebx),%eax
8010357f:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103585:	8b 43 18             	mov    0x18(%ebx),%eax
80103588:	8b 50 2c             	mov    0x2c(%eax),%edx
8010358b:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
8010358f:	8b 43 18             	mov    0x18(%ebx),%eax
80103592:	8b 50 2c             	mov    0x2c(%eax),%edx
80103595:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103599:	8b 43 18             	mov    0x18(%ebx),%eax
8010359c:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801035a3:	8b 43 18             	mov    0x18(%ebx),%eax
801035a6:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801035ad:	8b 43 18             	mov    0x18(%ebx),%eax
801035b0:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801035b7:	83 c4 0c             	add    $0xc,%esp
801035ba:	6a 10                	push   $0x10
801035bc:	68 26 6b 10 80       	push   $0x80106b26
801035c1:	8d 43 6c             	lea    0x6c(%ebx),%eax
801035c4:	50                   	push   %eax
801035c5:	e8 86 0c 00 00       	call   80104250 <safestrcpy>
  p->cwd = namei("/");
801035ca:	c7 04 24 2f 6b 10 80 	movl   $0x80106b2f,(%esp)
801035d1:	e8 56 e8 ff ff       	call   80101e2c <namei>
801035d6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801035d9:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801035e0:	e8 47 0a 00 00       	call   8010402c <acquire>
  p->state = RUNNABLE;
801035e5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801035ec:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801035f3:	e8 d4 09 00 00       	call   80103fcc <release>
}
801035f8:	83 c4 10             	add    $0x10,%esp
801035fb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801035fe:	c9                   	leave
801035ff:	c3                   	ret
    panic("userinit: out of memory?");
80103600:	83 ec 0c             	sub    $0xc,%esp
80103603:	68 0d 6b 10 80       	push   $0x80106b0d
80103608:	e8 2b cd ff ff       	call   80100338 <panic>
8010360d:	8d 76 00             	lea    0x0(%esi),%esi

80103610 <growproc>:
{
80103610:	55                   	push   %ebp
80103611:	89 e5                	mov    %esp,%ebp
80103613:	56                   	push   %esi
80103614:	53                   	push   %ebx
80103615:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103618:	e8 cb 08 00 00       	call   80103ee8 <pushcli>
  c = mycpu();
8010361d:	e8 4e fe ff ff       	call   80103470 <mycpu>
  p = c->proc;
80103622:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103628:	e8 07 09 00 00       	call   80103f34 <popcli>
  sz = curproc->sz;
8010362d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
8010362f:	85 f6                	test   %esi,%esi
80103631:	7f 19                	jg     8010364c <growproc+0x3c>
  } else if(n < 0){
80103633:	75 33                	jne    80103668 <growproc+0x58>
  curproc->sz = sz;
80103635:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103637:	83 ec 0c             	sub    $0xc,%esp
8010363a:	53                   	push   %ebx
8010363b:	e8 8c 2b 00 00       	call   801061cc <switchuvm>
  return 0;
80103640:	83 c4 10             	add    $0x10,%esp
80103643:	31 c0                	xor    %eax,%eax
}
80103645:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103648:	5b                   	pop    %ebx
80103649:	5e                   	pop    %esi
8010364a:	5d                   	pop    %ebp
8010364b:	c3                   	ret
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010364c:	51                   	push   %ecx
8010364d:	01 c6                	add    %eax,%esi
8010364f:	56                   	push   %esi
80103650:	50                   	push   %eax
80103651:	ff 73 04             	push   0x4(%ebx)
80103654:	e8 a7 2d 00 00       	call   80106400 <allocuvm>
80103659:	83 c4 10             	add    $0x10,%esp
8010365c:	85 c0                	test   %eax,%eax
8010365e:	75 d5                	jne    80103635 <growproc+0x25>
      return -1;
80103660:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103665:	eb de                	jmp    80103645 <growproc+0x35>
80103667:	90                   	nop
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103668:	52                   	push   %edx
80103669:	01 c6                	add    %eax,%esi
8010366b:	56                   	push   %esi
8010366c:	50                   	push   %eax
8010366d:	ff 73 04             	push   0x4(%ebx)
80103670:	e8 8b 2e 00 00       	call   80106500 <deallocuvm>
80103675:	83 c4 10             	add    $0x10,%esp
80103678:	85 c0                	test   %eax,%eax
8010367a:	75 b9                	jne    80103635 <growproc+0x25>
8010367c:	eb e2                	jmp    80103660 <growproc+0x50>
8010367e:	66 90                	xchg   %ax,%ax

80103680 <fork>:
{
80103680:	55                   	push   %ebp
80103681:	89 e5                	mov    %esp,%ebp
80103683:	57                   	push   %edi
80103684:	56                   	push   %esi
80103685:	53                   	push   %ebx
80103686:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103689:	e8 5a 08 00 00       	call   80103ee8 <pushcli>
  c = mycpu();
8010368e:	e8 dd fd ff ff       	call   80103470 <mycpu>
  p = c->proc;
80103693:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103699:	e8 96 08 00 00       	call   80103f34 <popcli>
  if((np = allocproc()) == 0){
8010369e:	e8 a9 fc ff ff       	call   8010334c <allocproc>
801036a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801036a6:	85 c0                	test   %eax,%eax
801036a8:	0f 84 9d 00 00 00    	je     8010374b <fork+0xcb>
801036ae:	89 c1                	mov    %eax,%ecx
  np->pgdir = curproc->pgdir;
801036b0:	8b 43 04             	mov    0x4(%ebx),%eax
801036b3:	89 41 04             	mov    %eax,0x4(%ecx)
  np->sz = curproc->sz;
801036b6:	8b 03                	mov    (%ebx),%eax
801036b8:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
801036ba:	89 c8                	mov    %ecx,%eax
801036bc:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
801036bf:	8b 73 18             	mov    0x18(%ebx),%esi
801036c2:	8b 79 18             	mov    0x18(%ecx),%edi
801036c5:	b9 13 00 00 00       	mov    $0x13,%ecx
801036ca:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  np->tf->eax = 0;
801036cc:	8b 40 18             	mov    0x18(%eax),%eax
801036cf:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
801036d6:	31 f6                	xor    %esi,%esi
    if(curproc->ofile[i])
801036d8:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801036dc:	85 c0                	test   %eax,%eax
801036de:	74 13                	je     801036f3 <fork+0x73>
      np->ofile[i] = filedup(curproc->ofile[i]);
801036e0:	83 ec 0c             	sub    $0xc,%esp
801036e3:	50                   	push   %eax
801036e4:	e8 df d6 ff ff       	call   80100dc8 <filedup>
801036e9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801036ec:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
801036f0:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NOFILE; i++)
801036f3:	46                   	inc    %esi
801036f4:	83 fe 10             	cmp    $0x10,%esi
801036f7:	75 df                	jne    801036d8 <fork+0x58>
  np->cwd = idup(curproc->cwd);
801036f9:	83 ec 0c             	sub    $0xc,%esp
801036fc:	ff 73 68             	push   0x68(%ebx)
801036ff:	e8 ac de ff ff       	call   801015b0 <idup>
80103704:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103707:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010370a:	83 c4 0c             	add    $0xc,%esp
8010370d:	6a 10                	push   $0x10
8010370f:	83 c3 6c             	add    $0x6c,%ebx
80103712:	53                   	push   %ebx
80103713:	8d 47 6c             	lea    0x6c(%edi),%eax
80103716:	50                   	push   %eax
80103717:	e8 34 0b 00 00       	call   80104250 <safestrcpy>
  pid = np->pid;
8010371c:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
8010371f:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103726:	e8 01 09 00 00       	call   8010402c <acquire>
  np->state = RUNNABLE;
8010372b:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103732:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103739:	e8 8e 08 00 00       	call   80103fcc <release>
  return pid;
8010373e:	83 c4 10             	add    $0x10,%esp
}
80103741:	89 d8                	mov    %ebx,%eax
80103743:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103746:	5b                   	pop    %ebx
80103747:	5e                   	pop    %esi
80103748:	5f                   	pop    %edi
80103749:	5d                   	pop    %ebp
8010374a:	c3                   	ret
    return -1;
8010374b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103750:	eb ef                	jmp    80103741 <fork+0xc1>
80103752:	66 90                	xchg   %ax,%ax

80103754 <scheduler>:
{
80103754:	55                   	push   %ebp
80103755:	89 e5                	mov    %esp,%ebp
80103757:	57                   	push   %edi
80103758:	56                   	push   %esi
80103759:	53                   	push   %ebx
8010375a:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
8010375d:	e8 0e fd ff ff       	call   80103470 <mycpu>
80103762:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103764:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010376b:	00 00 00 
8010376e:	8d 78 04             	lea    0x4(%eax),%edi
80103771:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103774:	fb                   	sti
    acquire(&ptable.lock);
80103775:	83 ec 0c             	sub    $0xc,%esp
80103778:	68 20 1d 11 80       	push   $0x80111d20
8010377d:	e8 aa 08 00 00       	call   8010402c <acquire>
80103782:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103785:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
8010378a:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
8010378c:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103790:	75 33                	jne    801037c5 <scheduler+0x71>
      c->proc = p;
80103792:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103798:	83 ec 0c             	sub    $0xc,%esp
8010379b:	53                   	push   %ebx
8010379c:	e8 2b 2a 00 00       	call   801061cc <switchuvm>
      p->state = RUNNING;
801037a1:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
801037a8:	58                   	pop    %eax
801037a9:	5a                   	pop    %edx
801037aa:	ff 73 1c             	push   0x1c(%ebx)
801037ad:	57                   	push   %edi
801037ae:	e8 ea 0a 00 00       	call   8010429d <swtch>
      switchkvm();
801037b3:	e8 04 2a 00 00       	call   801061bc <switchkvm>
      c->proc = 0;
801037b8:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801037bf:	00 00 00 
801037c2:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801037c5:	83 c3 7c             	add    $0x7c,%ebx
801037c8:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801037ce:	75 bc                	jne    8010378c <scheduler+0x38>
    release(&ptable.lock);
801037d0:	83 ec 0c             	sub    $0xc,%esp
801037d3:	68 20 1d 11 80       	push   $0x80111d20
801037d8:	e8 ef 07 00 00       	call   80103fcc <release>
    sti();
801037dd:	83 c4 10             	add    $0x10,%esp
801037e0:	eb 92                	jmp    80103774 <scheduler+0x20>
801037e2:	66 90                	xchg   %ax,%ax

801037e4 <sched>:
{
801037e4:	55                   	push   %ebp
801037e5:	89 e5                	mov    %esp,%ebp
801037e7:	56                   	push   %esi
801037e8:	53                   	push   %ebx
  pushcli();
801037e9:	e8 fa 06 00 00       	call   80103ee8 <pushcli>
  c = mycpu();
801037ee:	e8 7d fc ff ff       	call   80103470 <mycpu>
  p = c->proc;
801037f3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801037f9:	e8 36 07 00 00       	call   80103f34 <popcli>
  if(!holding(&ptable.lock))
801037fe:	83 ec 0c             	sub    $0xc,%esp
80103801:	68 20 1d 11 80       	push   $0x80111d20
80103806:	e8 81 07 00 00       	call   80103f8c <holding>
8010380b:	83 c4 10             	add    $0x10,%esp
8010380e:	85 c0                	test   %eax,%eax
80103810:	74 4f                	je     80103861 <sched+0x7d>
  if(mycpu()->ncli != 1)
80103812:	e8 59 fc ff ff       	call   80103470 <mycpu>
80103817:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010381e:	75 68                	jne    80103888 <sched+0xa4>
  if(p->state == RUNNING)
80103820:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103824:	74 55                	je     8010387b <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103826:	9c                   	pushf
80103827:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103828:	f6 c4 02             	test   $0x2,%ah
8010382b:	75 41                	jne    8010386e <sched+0x8a>
  intena = mycpu()->intena;
8010382d:	e8 3e fc ff ff       	call   80103470 <mycpu>
80103832:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103838:	e8 33 fc ff ff       	call   80103470 <mycpu>
8010383d:	83 ec 08             	sub    $0x8,%esp
80103840:	ff 70 04             	push   0x4(%eax)
80103843:	83 c3 1c             	add    $0x1c,%ebx
80103846:	53                   	push   %ebx
80103847:	e8 51 0a 00 00       	call   8010429d <swtch>
  mycpu()->intena = intena;
8010384c:	e8 1f fc ff ff       	call   80103470 <mycpu>
80103851:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103857:	83 c4 10             	add    $0x10,%esp
8010385a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010385d:	5b                   	pop    %ebx
8010385e:	5e                   	pop    %esi
8010385f:	5d                   	pop    %ebp
80103860:	c3                   	ret
    panic("sched ptable.lock");
80103861:	83 ec 0c             	sub    $0xc,%esp
80103864:	68 31 6b 10 80       	push   $0x80106b31
80103869:	e8 ca ca ff ff       	call   80100338 <panic>
    panic("sched interruptible");
8010386e:	83 ec 0c             	sub    $0xc,%esp
80103871:	68 5d 6b 10 80       	push   $0x80106b5d
80103876:	e8 bd ca ff ff       	call   80100338 <panic>
    panic("sched running");
8010387b:	83 ec 0c             	sub    $0xc,%esp
8010387e:	68 4f 6b 10 80       	push   $0x80106b4f
80103883:	e8 b0 ca ff ff       	call   80100338 <panic>
    panic("sched locks");
80103888:	83 ec 0c             	sub    $0xc,%esp
8010388b:	68 43 6b 10 80       	push   $0x80106b43
80103890:	e8 a3 ca ff ff       	call   80100338 <panic>
80103895:	8d 76 00             	lea    0x0(%esi),%esi

80103898 <exit>:
{
80103898:	55                   	push   %ebp
80103899:	89 e5                	mov    %esp,%ebp
8010389b:	57                   	push   %edi
8010389c:	56                   	push   %esi
8010389d:	53                   	push   %ebx
8010389e:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
801038a1:	e8 62 fc ff ff       	call   80103508 <myproc>
  if(curproc == initproc)
801038a6:	39 05 54 3c 11 80    	cmp    %eax,0x80113c54
801038ac:	0f 84 e9 00 00 00    	je     8010399b <exit+0x103>
801038b2:	89 c3                	mov    %eax,%ebx
801038b4:	8d 70 28             	lea    0x28(%eax),%esi
801038b7:	8d 78 68             	lea    0x68(%eax),%edi
801038ba:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd]){
801038bc:	8b 06                	mov    (%esi),%eax
801038be:	85 c0                	test   %eax,%eax
801038c0:	74 12                	je     801038d4 <exit+0x3c>
      fileclose(curproc->ofile[fd]);
801038c2:	83 ec 0c             	sub    $0xc,%esp
801038c5:	50                   	push   %eax
801038c6:	e8 41 d5 ff ff       	call   80100e0c <fileclose>
      curproc->ofile[fd] = 0;
801038cb:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801038d1:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
801038d4:	83 c6 04             	add    $0x4,%esi
801038d7:	39 f7                	cmp    %esi,%edi
801038d9:	75 e1                	jne    801038bc <exit+0x24>
  begin_op();
801038db:	e8 e0 f0 ff ff       	call   801029c0 <begin_op>
  iput(curproc->cwd);
801038e0:	83 ec 0c             	sub    $0xc,%esp
801038e3:	ff 73 68             	push   0x68(%ebx)
801038e6:	e8 fd dd ff ff       	call   801016e8 <iput>
  end_op();
801038eb:	e8 38 f1 ff ff       	call   80102a28 <end_op>
  curproc->cwd = 0;
801038f0:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
801038f7:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801038fe:	e8 29 07 00 00       	call   8010402c <acquire>
  wakeup1(curproc->parent);
80103903:	8b 53 14             	mov    0x14(%ebx),%edx
80103906:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103909:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
8010390e:	eb 0a                	jmp    8010391a <exit+0x82>
80103910:	83 c0 7c             	add    $0x7c,%eax
80103913:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103918:	74 1c                	je     80103936 <exit+0x9e>
    if(p->state == SLEEPING && p->chan == chan)
8010391a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010391e:	75 f0                	jne    80103910 <exit+0x78>
80103920:	3b 50 20             	cmp    0x20(%eax),%edx
80103923:	75 eb                	jne    80103910 <exit+0x78>
      p->state = RUNNABLE;
80103925:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010392c:	83 c0 7c             	add    $0x7c,%eax
8010392f:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103934:	75 e4                	jne    8010391a <exit+0x82>
      p->parent = initproc;
80103936:	8b 0d 54 3c 11 80    	mov    0x80113c54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010393c:	ba 54 1d 11 80       	mov    $0x80111d54,%edx
80103941:	eb 0c                	jmp    8010394f <exit+0xb7>
80103943:	90                   	nop
80103944:	83 c2 7c             	add    $0x7c,%edx
80103947:	81 fa 54 3c 11 80    	cmp    $0x80113c54,%edx
8010394d:	74 33                	je     80103982 <exit+0xea>
    if(p->parent == curproc){
8010394f:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103952:	75 f0                	jne    80103944 <exit+0xac>
      p->parent = initproc;
80103954:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103957:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
8010395b:	75 e7                	jne    80103944 <exit+0xac>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010395d:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80103962:	eb 0a                	jmp    8010396e <exit+0xd6>
80103964:	83 c0 7c             	add    $0x7c,%eax
80103967:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
8010396c:	74 d6                	je     80103944 <exit+0xac>
    if(p->state == SLEEPING && p->chan == chan)
8010396e:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103972:	75 f0                	jne    80103964 <exit+0xcc>
80103974:	3b 48 20             	cmp    0x20(%eax),%ecx
80103977:	75 eb                	jne    80103964 <exit+0xcc>
      p->state = RUNNABLE;
80103979:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103980:	eb e2                	jmp    80103964 <exit+0xcc>
  curproc->state = ZOMBIE;
80103982:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103989:	e8 56 fe ff ff       	call   801037e4 <sched>
  panic("zombie exit");
8010398e:	83 ec 0c             	sub    $0xc,%esp
80103991:	68 7e 6b 10 80       	push   $0x80106b7e
80103996:	e8 9d c9 ff ff       	call   80100338 <panic>
    panic("init exiting");
8010399b:	83 ec 0c             	sub    $0xc,%esp
8010399e:	68 71 6b 10 80       	push   $0x80106b71
801039a3:	e8 90 c9 ff ff       	call   80100338 <panic>

801039a8 <wait>:
{
801039a8:	55                   	push   %ebp
801039a9:	89 e5                	mov    %esp,%ebp
801039ab:	56                   	push   %esi
801039ac:	53                   	push   %ebx
  pushcli();
801039ad:	e8 36 05 00 00       	call   80103ee8 <pushcli>
  c = mycpu();
801039b2:	e8 b9 fa ff ff       	call   80103470 <mycpu>
  p = c->proc;
801039b7:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801039bd:	e8 72 05 00 00       	call   80103f34 <popcli>
  acquire(&ptable.lock);
801039c2:	83 ec 0c             	sub    $0xc,%esp
801039c5:	68 20 1d 11 80       	push   $0x80111d20
801039ca:	e8 5d 06 00 00       	call   8010402c <acquire>
801039cf:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801039d2:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801039d4:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
801039d9:	eb 0c                	jmp    801039e7 <wait+0x3f>
801039db:	90                   	nop
801039dc:	83 c3 7c             	add    $0x7c,%ebx
801039df:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801039e5:	74 1b                	je     80103a02 <wait+0x5a>
      if(p->parent != curproc)
801039e7:	39 73 14             	cmp    %esi,0x14(%ebx)
801039ea:	75 f0                	jne    801039dc <wait+0x34>
      if(p->state == ZOMBIE){
801039ec:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801039f0:	74 5a                	je     80103a4c <wait+0xa4>
      havekids = 1;
801039f2:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801039f7:	83 c3 7c             	add    $0x7c,%ebx
801039fa:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103a00:	75 e5                	jne    801039e7 <wait+0x3f>
    if(!havekids || curproc->killed){
80103a02:	85 c0                	test   %eax,%eax
80103a04:	0f 84 98 00 00 00    	je     80103aa2 <wait+0xfa>
80103a0a:	8b 46 24             	mov    0x24(%esi),%eax
80103a0d:	85 c0                	test   %eax,%eax
80103a0f:	0f 85 8d 00 00 00    	jne    80103aa2 <wait+0xfa>
  pushcli();
80103a15:	e8 ce 04 00 00       	call   80103ee8 <pushcli>
  c = mycpu();
80103a1a:	e8 51 fa ff ff       	call   80103470 <mycpu>
  p = c->proc;
80103a1f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a25:	e8 0a 05 00 00       	call   80103f34 <popcli>
  if(p == 0)
80103a2a:	85 db                	test   %ebx,%ebx
80103a2c:	0f 84 87 00 00 00    	je     80103ab9 <wait+0x111>
  p->chan = chan;
80103a32:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80103a35:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103a3c:	e8 a3 fd ff ff       	call   801037e4 <sched>
  p->chan = 0;
80103a41:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103a48:	eb 88                	jmp    801039d2 <wait+0x2a>
80103a4a:	66 90                	xchg   %ax,%ax
        pid = p->pid;
80103a4c:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103a4f:	83 ec 0c             	sub    $0xc,%esp
80103a52:	ff 73 08             	push   0x8(%ebx)
80103a55:	e8 6a e7 ff ff       	call   801021c4 <kfree>
        p->kstack = 0;
80103a5a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103a61:	5a                   	pop    %edx
80103a62:	ff 73 04             	push   0x4(%ebx)
80103a65:	e8 b2 2a 00 00       	call   8010651c <freevm>
        p->pid = 0;
80103a6a:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103a71:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103a78:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103a7c:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103a83:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103a8a:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103a91:	e8 36 05 00 00       	call   80103fcc <release>
        return pid;
80103a96:	83 c4 10             	add    $0x10,%esp
}
80103a99:	89 f0                	mov    %esi,%eax
80103a9b:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a9e:	5b                   	pop    %ebx
80103a9f:	5e                   	pop    %esi
80103aa0:	5d                   	pop    %ebp
80103aa1:	c3                   	ret
      release(&ptable.lock);
80103aa2:	83 ec 0c             	sub    $0xc,%esp
80103aa5:	68 20 1d 11 80       	push   $0x80111d20
80103aaa:	e8 1d 05 00 00       	call   80103fcc <release>
      return -1;
80103aaf:	83 c4 10             	add    $0x10,%esp
80103ab2:	be ff ff ff ff       	mov    $0xffffffff,%esi
80103ab7:	eb e0                	jmp    80103a99 <wait+0xf1>
    panic("sleep");
80103ab9:	83 ec 0c             	sub    $0xc,%esp
80103abc:	68 8a 6b 10 80       	push   $0x80106b8a
80103ac1:	e8 72 c8 ff ff       	call   80100338 <panic>
80103ac6:	66 90                	xchg   %ax,%ax

80103ac8 <yield>:
{
80103ac8:	55                   	push   %ebp
80103ac9:	89 e5                	mov    %esp,%ebp
80103acb:	53                   	push   %ebx
80103acc:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103acf:	68 20 1d 11 80       	push   $0x80111d20
80103ad4:	e8 53 05 00 00       	call   8010402c <acquire>
  pushcli();
80103ad9:	e8 0a 04 00 00       	call   80103ee8 <pushcli>
  c = mycpu();
80103ade:	e8 8d f9 ff ff       	call   80103470 <mycpu>
  p = c->proc;
80103ae3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ae9:	e8 46 04 00 00       	call   80103f34 <popcli>
  myproc()->state = RUNNABLE;
80103aee:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103af5:	e8 ea fc ff ff       	call   801037e4 <sched>
  release(&ptable.lock);
80103afa:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103b01:	e8 c6 04 00 00       	call   80103fcc <release>
}
80103b06:	83 c4 10             	add    $0x10,%esp
80103b09:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b0c:	c9                   	leave
80103b0d:	c3                   	ret
80103b0e:	66 90                	xchg   %ax,%ax

80103b10 <sleep>:
{
80103b10:	55                   	push   %ebp
80103b11:	89 e5                	mov    %esp,%ebp
80103b13:	57                   	push   %edi
80103b14:	56                   	push   %esi
80103b15:	53                   	push   %ebx
80103b16:	83 ec 0c             	sub    $0xc,%esp
80103b19:	8b 7d 08             	mov    0x8(%ebp),%edi
80103b1c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103b1f:	e8 c4 03 00 00       	call   80103ee8 <pushcli>
  c = mycpu();
80103b24:	e8 47 f9 ff ff       	call   80103470 <mycpu>
  p = c->proc;
80103b29:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b2f:	e8 00 04 00 00       	call   80103f34 <popcli>
  if(p == 0)
80103b34:	85 db                	test   %ebx,%ebx
80103b36:	0f 84 83 00 00 00    	je     80103bbf <sleep+0xaf>
  if(lk == 0)
80103b3c:	85 f6                	test   %esi,%esi
80103b3e:	74 72                	je     80103bb2 <sleep+0xa2>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103b40:	81 fe 20 1d 11 80    	cmp    $0x80111d20,%esi
80103b46:	74 4c                	je     80103b94 <sleep+0x84>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103b48:	83 ec 0c             	sub    $0xc,%esp
80103b4b:	68 20 1d 11 80       	push   $0x80111d20
80103b50:	e8 d7 04 00 00       	call   8010402c <acquire>
    release(lk);
80103b55:	89 34 24             	mov    %esi,(%esp)
80103b58:	e8 6f 04 00 00       	call   80103fcc <release>
  p->chan = chan;
80103b5d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103b60:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103b67:	e8 78 fc ff ff       	call   801037e4 <sched>
  p->chan = 0;
80103b6c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103b73:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103b7a:	e8 4d 04 00 00       	call   80103fcc <release>
    acquire(lk);
80103b7f:	83 c4 10             	add    $0x10,%esp
80103b82:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103b85:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b88:	5b                   	pop    %ebx
80103b89:	5e                   	pop    %esi
80103b8a:	5f                   	pop    %edi
80103b8b:	5d                   	pop    %ebp
    acquire(lk);
80103b8c:	e9 9b 04 00 00       	jmp    8010402c <acquire>
80103b91:	8d 76 00             	lea    0x0(%esi),%esi
  p->chan = chan;
80103b94:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103b97:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103b9e:	e8 41 fc ff ff       	call   801037e4 <sched>
  p->chan = 0;
80103ba3:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103baa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bad:	5b                   	pop    %ebx
80103bae:	5e                   	pop    %esi
80103baf:	5f                   	pop    %edi
80103bb0:	5d                   	pop    %ebp
80103bb1:	c3                   	ret
    panic("sleep without lk");
80103bb2:	83 ec 0c             	sub    $0xc,%esp
80103bb5:	68 90 6b 10 80       	push   $0x80106b90
80103bba:	e8 79 c7 ff ff       	call   80100338 <panic>
    panic("sleep");
80103bbf:	83 ec 0c             	sub    $0xc,%esp
80103bc2:	68 8a 6b 10 80       	push   $0x80106b8a
80103bc7:	e8 6c c7 ff ff       	call   80100338 <panic>

80103bcc <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103bcc:	55                   	push   %ebp
80103bcd:	89 e5                	mov    %esp,%ebp
80103bcf:	53                   	push   %ebx
80103bd0:	83 ec 10             	sub    $0x10,%esp
80103bd3:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103bd6:	68 20 1d 11 80       	push   $0x80111d20
80103bdb:	e8 4c 04 00 00       	call   8010402c <acquire>
80103be0:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103be3:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80103be8:	eb 0c                	jmp    80103bf6 <wakeup+0x2a>
80103bea:	66 90                	xchg   %ax,%ax
80103bec:	83 c0 7c             	add    $0x7c,%eax
80103bef:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103bf4:	74 1c                	je     80103c12 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80103bf6:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103bfa:	75 f0                	jne    80103bec <wakeup+0x20>
80103bfc:	3b 58 20             	cmp    0x20(%eax),%ebx
80103bff:	75 eb                	jne    80103bec <wakeup+0x20>
      p->state = RUNNABLE;
80103c01:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c08:	83 c0 7c             	add    $0x7c,%eax
80103c0b:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103c10:	75 e4                	jne    80103bf6 <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80103c12:	c7 45 08 20 1d 11 80 	movl   $0x80111d20,0x8(%ebp)
}
80103c19:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c1c:	c9                   	leave
  release(&ptable.lock);
80103c1d:	e9 aa 03 00 00       	jmp    80103fcc <release>
80103c22:	66 90                	xchg   %ax,%ax

80103c24 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103c24:	55                   	push   %ebp
80103c25:	89 e5                	mov    %esp,%ebp
80103c27:	53                   	push   %ebx
80103c28:	83 ec 10             	sub    $0x10,%esp
80103c2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103c2e:	68 20 1d 11 80       	push   $0x80111d20
80103c33:	e8 f4 03 00 00       	call   8010402c <acquire>
80103c38:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c3b:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80103c40:	eb 0c                	jmp    80103c4e <kill+0x2a>
80103c42:	66 90                	xchg   %ax,%ax
80103c44:	83 c0 7c             	add    $0x7c,%eax
80103c47:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103c4c:	74 32                	je     80103c80 <kill+0x5c>
    if(p->pid == pid){
80103c4e:	39 58 10             	cmp    %ebx,0x10(%eax)
80103c51:	75 f1                	jne    80103c44 <kill+0x20>
      p->killed = 1;
80103c53:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103c5a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103c5e:	75 07                	jne    80103c67 <kill+0x43>
        p->state = RUNNABLE;
80103c60:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80103c67:	83 ec 0c             	sub    $0xc,%esp
80103c6a:	68 20 1d 11 80       	push   $0x80111d20
80103c6f:	e8 58 03 00 00       	call   80103fcc <release>
      return 0;
80103c74:	83 c4 10             	add    $0x10,%esp
80103c77:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80103c79:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c7c:	c9                   	leave
80103c7d:	c3                   	ret
80103c7e:	66 90                	xchg   %ax,%ax
  release(&ptable.lock);
80103c80:	83 ec 0c             	sub    $0xc,%esp
80103c83:	68 20 1d 11 80       	push   $0x80111d20
80103c88:	e8 3f 03 00 00       	call   80103fcc <release>
  return -1;
80103c8d:	83 c4 10             	add    $0x10,%esp
80103c90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103c95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c98:	c9                   	leave
80103c99:	c3                   	ret
80103c9a:	66 90                	xchg   %ax,%ax

80103c9c <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103c9c:	55                   	push   %ebp
80103c9d:	89 e5                	mov    %esp,%ebp
80103c9f:	57                   	push   %edi
80103ca0:	56                   	push   %esi
80103ca1:	53                   	push   %ebx
80103ca2:	83 ec 3c             	sub    $0x3c,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ca5:	bb c0 1d 11 80       	mov    $0x80111dc0,%ebx
80103caa:	8d 75 e8             	lea    -0x18(%ebp),%esi
80103cad:	eb 3f                	jmp    80103cee <procdump+0x52>
80103caf:	90                   	nop
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103cb0:	8b 04 85 80 71 10 80 	mov    -0x7fef8e80(,%eax,4),%eax
80103cb7:	85 c0                	test   %eax,%eax
80103cb9:	74 3f                	je     80103cfa <procdump+0x5e>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
80103cbb:	53                   	push   %ebx
80103cbc:	50                   	push   %eax
80103cbd:	ff 73 a4             	push   -0x5c(%ebx)
80103cc0:	68 a5 6b 10 80       	push   $0x80106ba5
80103cc5:	e8 5e c9 ff ff       	call   80100628 <cprintf>
    if(p->state == SLEEPING){
80103cca:	83 c4 10             	add    $0x10,%esp
80103ccd:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80103cd1:	74 31                	je     80103d04 <procdump+0x68>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103cd3:	83 ec 0c             	sub    $0xc,%esp
80103cd6:	68 9e 6c 10 80       	push   $0x80106c9e
80103cdb:	e8 48 c9 ff ff       	call   80100628 <cprintf>
80103ce0:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ce3:	83 c3 7c             	add    $0x7c,%ebx
80103ce6:	81 fb c0 3c 11 80    	cmp    $0x80113cc0,%ebx
80103cec:	74 52                	je     80103d40 <procdump+0xa4>
    if(p->state == UNUSED)
80103cee:	8b 43 a0             	mov    -0x60(%ebx),%eax
80103cf1:	85 c0                	test   %eax,%eax
80103cf3:	74 ee                	je     80103ce3 <procdump+0x47>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103cf5:	83 f8 05             	cmp    $0x5,%eax
80103cf8:	76 b6                	jbe    80103cb0 <procdump+0x14>
      state = "???";
80103cfa:	b8 a1 6b 10 80       	mov    $0x80106ba1,%eax
80103cff:	eb ba                	jmp    80103cbb <procdump+0x1f>
80103d01:	8d 76 00             	lea    0x0(%esi),%esi
      getcallerpcs((uint*)p->context->ebp+2, pc);
80103d04:	83 ec 08             	sub    $0x8,%esp
80103d07:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103d0a:	50                   	push   %eax
80103d0b:	8b 43 b0             	mov    -0x50(%ebx),%eax
80103d0e:	8b 40 0c             	mov    0xc(%eax),%eax
80103d11:	83 c0 08             	add    $0x8,%eax
80103d14:	50                   	push   %eax
80103d15:	e8 56 01 00 00       	call   80103e70 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80103d1a:	8d 7d c0             	lea    -0x40(%ebp),%edi
80103d1d:	83 c4 10             	add    $0x10,%esp
80103d20:	8b 17                	mov    (%edi),%edx
80103d22:	85 d2                	test   %edx,%edx
80103d24:	74 ad                	je     80103cd3 <procdump+0x37>
        cprintf(" %p", pc[i]);
80103d26:	83 ec 08             	sub    $0x8,%esp
80103d29:	52                   	push   %edx
80103d2a:	68 e1 68 10 80       	push   $0x801068e1
80103d2f:	e8 f4 c8 ff ff       	call   80100628 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80103d34:	83 c7 04             	add    $0x4,%edi
80103d37:	83 c4 10             	add    $0x10,%esp
80103d3a:	39 f7                	cmp    %esi,%edi
80103d3c:	75 e2                	jne    80103d20 <procdump+0x84>
80103d3e:	eb 93                	jmp    80103cd3 <procdump+0x37>
  }
}
80103d40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d43:	5b                   	pop    %ebx
80103d44:	5e                   	pop    %esi
80103d45:	5f                   	pop    %edi
80103d46:	5d                   	pop    %ebp
80103d47:	c3                   	ret

80103d48 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80103d48:	55                   	push   %ebp
80103d49:	89 e5                	mov    %esp,%ebp
80103d4b:	53                   	push   %ebx
80103d4c:	83 ec 0c             	sub    $0xc,%esp
80103d4f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80103d52:	68 d8 6b 10 80       	push   $0x80106bd8
80103d57:	8d 43 04             	lea    0x4(%ebx),%eax
80103d5a:	50                   	push   %eax
80103d5b:	e8 f4 00 00 00       	call   80103e54 <initlock>
  lk->name = name;
80103d60:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d63:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
80103d66:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80103d6c:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
}
80103d73:	83 c4 10             	add    $0x10,%esp
80103d76:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d79:	c9                   	leave
80103d7a:	c3                   	ret
80103d7b:	90                   	nop

80103d7c <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80103d7c:	55                   	push   %ebp
80103d7d:	89 e5                	mov    %esp,%ebp
80103d7f:	56                   	push   %esi
80103d80:	53                   	push   %ebx
80103d81:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80103d84:	8d 73 04             	lea    0x4(%ebx),%esi
80103d87:	83 ec 0c             	sub    $0xc,%esp
80103d8a:	56                   	push   %esi
80103d8b:	e8 9c 02 00 00       	call   8010402c <acquire>
  while (lk->locked) {
80103d90:	83 c4 10             	add    $0x10,%esp
80103d93:	8b 13                	mov    (%ebx),%edx
80103d95:	85 d2                	test   %edx,%edx
80103d97:	74 16                	je     80103daf <acquiresleep+0x33>
80103d99:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80103d9c:	83 ec 08             	sub    $0x8,%esp
80103d9f:	56                   	push   %esi
80103da0:	53                   	push   %ebx
80103da1:	e8 6a fd ff ff       	call   80103b10 <sleep>
  while (lk->locked) {
80103da6:	83 c4 10             	add    $0x10,%esp
80103da9:	8b 03                	mov    (%ebx),%eax
80103dab:	85 c0                	test   %eax,%eax
80103dad:	75 ed                	jne    80103d9c <acquiresleep+0x20>
  }
  lk->locked = 1;
80103daf:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80103db5:	e8 4e f7 ff ff       	call   80103508 <myproc>
80103dba:	8b 40 10             	mov    0x10(%eax),%eax
80103dbd:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80103dc0:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103dc3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103dc6:	5b                   	pop    %ebx
80103dc7:	5e                   	pop    %esi
80103dc8:	5d                   	pop    %ebp
  release(&lk->lk);
80103dc9:	e9 fe 01 00 00       	jmp    80103fcc <release>
80103dce:	66 90                	xchg   %ax,%ax

80103dd0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80103dd0:	55                   	push   %ebp
80103dd1:	89 e5                	mov    %esp,%ebp
80103dd3:	56                   	push   %esi
80103dd4:	53                   	push   %ebx
80103dd5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80103dd8:	8d 73 04             	lea    0x4(%ebx),%esi
80103ddb:	83 ec 0c             	sub    $0xc,%esp
80103dde:	56                   	push   %esi
80103ddf:	e8 48 02 00 00       	call   8010402c <acquire>
  lk->locked = 0;
80103de4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80103dea:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80103df1:	89 1c 24             	mov    %ebx,(%esp)
80103df4:	e8 d3 fd ff ff       	call   80103bcc <wakeup>
  release(&lk->lk);
80103df9:	83 c4 10             	add    $0x10,%esp
80103dfc:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103dff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e02:	5b                   	pop    %ebx
80103e03:	5e                   	pop    %esi
80103e04:	5d                   	pop    %ebp
  release(&lk->lk);
80103e05:	e9 c2 01 00 00       	jmp    80103fcc <release>
80103e0a:	66 90                	xchg   %ax,%ax

80103e0c <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80103e0c:	55                   	push   %ebp
80103e0d:	89 e5                	mov    %esp,%ebp
80103e0f:	56                   	push   %esi
80103e10:	53                   	push   %ebx
80103e11:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80103e14:	8d 73 04             	lea    0x4(%ebx),%esi
80103e17:	83 ec 0c             	sub    $0xc,%esp
80103e1a:	56                   	push   %esi
80103e1b:	e8 0c 02 00 00       	call   8010402c <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80103e20:	83 c4 10             	add    $0x10,%esp
80103e23:	8b 03                	mov    (%ebx),%eax
80103e25:	85 c0                	test   %eax,%eax
80103e27:	75 17                	jne    80103e40 <holdingsleep+0x34>
80103e29:	31 db                	xor    %ebx,%ebx
  release(&lk->lk);
80103e2b:	83 ec 0c             	sub    $0xc,%esp
80103e2e:	56                   	push   %esi
80103e2f:	e8 98 01 00 00       	call   80103fcc <release>
  return r;
}
80103e34:	89 d8                	mov    %ebx,%eax
80103e36:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e39:	5b                   	pop    %ebx
80103e3a:	5e                   	pop    %esi
80103e3b:	5d                   	pop    %ebp
80103e3c:	c3                   	ret
80103e3d:	8d 76 00             	lea    0x0(%esi),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80103e40:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80103e43:	e8 c0 f6 ff ff       	call   80103508 <myproc>
80103e48:	39 58 10             	cmp    %ebx,0x10(%eax)
80103e4b:	0f 94 c3             	sete   %bl
80103e4e:	0f b6 db             	movzbl %bl,%ebx
80103e51:	eb d8                	jmp    80103e2b <holdingsleep+0x1f>
80103e53:	90                   	nop

80103e54 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80103e54:	55                   	push   %ebp
80103e55:	89 e5                	mov    %esp,%ebp
80103e57:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80103e5a:	8b 55 0c             	mov    0xc(%ebp),%edx
80103e5d:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80103e60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80103e66:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80103e6d:	5d                   	pop    %ebp
80103e6e:	c3                   	ret
80103e6f:	90                   	nop

80103e70 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80103e70:	55                   	push   %ebp
80103e71:	89 e5                	mov    %esp,%ebp
80103e73:	53                   	push   %ebx
80103e74:	8b 45 08             	mov    0x8(%ebp),%eax
80103e77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80103e7a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80103e7d:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
80103e82:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
80103e87:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80103e8c:	76 10                	jbe    80103e9e <getcallerpcs+0x2e>
80103e8e:	eb 24                	jmp    80103eb4 <getcallerpcs+0x44>
80103e90:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80103e96:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80103e9c:	77 16                	ja     80103eb4 <getcallerpcs+0x44>
      break;
    pcs[i] = ebp[1];     // saved %eip
80103e9e:	8b 5a 04             	mov    0x4(%edx),%ebx
80103ea1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
    ebp = (uint*)ebp[0]; // saved %ebp
80103ea4:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80103ea6:	40                   	inc    %eax
80103ea7:	83 f8 0a             	cmp    $0xa,%eax
80103eaa:	75 e4                	jne    80103e90 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80103eac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103eaf:	c9                   	leave
80103eb0:	c3                   	ret
80103eb1:	8d 76 00             	lea    0x0(%esi),%esi
80103eb4:	8d 04 81             	lea    (%ecx,%eax,4),%eax
80103eb7:	83 c1 28             	add    $0x28,%ecx
80103eba:	89 ca                	mov    %ecx,%edx
80103ebc:	29 c2                	sub    %eax,%edx
80103ebe:	83 e2 04             	and    $0x4,%edx
80103ec1:	74 0d                	je     80103ed0 <getcallerpcs+0x60>
    pcs[i] = 0;
80103ec3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80103ec9:	83 c0 04             	add    $0x4,%eax
80103ecc:	39 c1                	cmp    %eax,%ecx
80103ece:	74 dc                	je     80103eac <getcallerpcs+0x3c>
    pcs[i] = 0;
80103ed0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103ed6:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  for(; i < 10; i++)
80103edd:	83 c0 08             	add    $0x8,%eax
80103ee0:	39 c1                	cmp    %eax,%ecx
80103ee2:	75 ec                	jne    80103ed0 <getcallerpcs+0x60>
80103ee4:	eb c6                	jmp    80103eac <getcallerpcs+0x3c>
80103ee6:	66 90                	xchg   %ax,%ax

80103ee8 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80103ee8:	55                   	push   %ebp
80103ee9:	89 e5                	mov    %esp,%ebp
80103eeb:	53                   	push   %ebx
80103eec:	50                   	push   %eax
80103eed:	9c                   	pushf
80103eee:	5b                   	pop    %ebx
  asm volatile("cli");
80103eef:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80103ef0:	e8 7b f5 ff ff       	call   80103470 <mycpu>
80103ef5:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80103efb:	85 d2                	test   %edx,%edx
80103efd:	74 11                	je     80103f10 <pushcli+0x28>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80103eff:	e8 6c f5 ff ff       	call   80103470 <mycpu>
80103f04:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80103f0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f0d:	c9                   	leave
80103f0e:	c3                   	ret
80103f0f:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80103f10:	e8 5b f5 ff ff       	call   80103470 <mycpu>
80103f15:	81 e3 00 02 00 00    	and    $0x200,%ebx
80103f1b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80103f21:	e8 4a f5 ff ff       	call   80103470 <mycpu>
80103f26:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
80103f2c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f2f:	c9                   	leave
80103f30:	c3                   	ret
80103f31:	8d 76 00             	lea    0x0(%esi),%esi

80103f34 <popcli>:

void
popcli(void)
{
80103f34:	55                   	push   %ebp
80103f35:	89 e5                	mov    %esp,%ebp
80103f37:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103f3a:	9c                   	pushf
80103f3b:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103f3c:	f6 c4 02             	test   $0x2,%ah
80103f3f:	75 31                	jne    80103f72 <popcli+0x3e>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80103f41:	e8 2a f5 ff ff       	call   80103470 <mycpu>
80103f46:	ff 88 a4 00 00 00    	decl   0xa4(%eax)
80103f4c:	78 31                	js     80103f7f <popcli+0x4b>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80103f4e:	e8 1d f5 ff ff       	call   80103470 <mycpu>
80103f53:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80103f59:	85 d2                	test   %edx,%edx
80103f5b:	74 03                	je     80103f60 <popcli+0x2c>
    sti();
}
80103f5d:	c9                   	leave
80103f5e:	c3                   	ret
80103f5f:	90                   	nop
  if(mycpu()->ncli == 0 && mycpu()->intena)
80103f60:	e8 0b f5 ff ff       	call   80103470 <mycpu>
80103f65:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103f6b:	85 c0                	test   %eax,%eax
80103f6d:	74 ee                	je     80103f5d <popcli+0x29>
  asm volatile("sti");
80103f6f:	fb                   	sti
}
80103f70:	c9                   	leave
80103f71:	c3                   	ret
    panic("popcli - interruptible");
80103f72:	83 ec 0c             	sub    $0xc,%esp
80103f75:	68 e3 6b 10 80       	push   $0x80106be3
80103f7a:	e8 b9 c3 ff ff       	call   80100338 <panic>
    panic("popcli");
80103f7f:	83 ec 0c             	sub    $0xc,%esp
80103f82:	68 fa 6b 10 80       	push   $0x80106bfa
80103f87:	e8 ac c3 ff ff       	call   80100338 <panic>

80103f8c <holding>:
{
80103f8c:	55                   	push   %ebp
80103f8d:	89 e5                	mov    %esp,%ebp
80103f8f:	53                   	push   %ebx
80103f90:	50                   	push   %eax
80103f91:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80103f94:	e8 4f ff ff ff       	call   80103ee8 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80103f99:	8b 13                	mov    (%ebx),%edx
80103f9b:	85 d2                	test   %edx,%edx
80103f9d:	75 11                	jne    80103fb0 <holding+0x24>
80103f9f:	31 db                	xor    %ebx,%ebx
  popcli();
80103fa1:	e8 8e ff ff ff       	call   80103f34 <popcli>
}
80103fa6:	89 d8                	mov    %ebx,%eax
80103fa8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fab:	c9                   	leave
80103fac:	c3                   	ret
80103fad:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80103fb0:	8b 5b 08             	mov    0x8(%ebx),%ebx
80103fb3:	e8 b8 f4 ff ff       	call   80103470 <mycpu>
80103fb8:	39 c3                	cmp    %eax,%ebx
80103fba:	0f 94 c3             	sete   %bl
80103fbd:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80103fc0:	e8 6f ff ff ff       	call   80103f34 <popcli>
}
80103fc5:	89 d8                	mov    %ebx,%eax
80103fc7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fca:	c9                   	leave
80103fcb:	c3                   	ret

80103fcc <release>:
{
80103fcc:	55                   	push   %ebp
80103fcd:	89 e5                	mov    %esp,%ebp
80103fcf:	56                   	push   %esi
80103fd0:	53                   	push   %ebx
80103fd1:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80103fd4:	e8 0f ff ff ff       	call   80103ee8 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80103fd9:	8b 03                	mov    (%ebx),%eax
80103fdb:	85 c0                	test   %eax,%eax
80103fdd:	75 15                	jne    80103ff4 <release+0x28>
  popcli();
80103fdf:	e8 50 ff ff ff       	call   80103f34 <popcli>
    panic("release");
80103fe4:	83 ec 0c             	sub    $0xc,%esp
80103fe7:	68 01 6c 10 80       	push   $0x80106c01
80103fec:	e8 47 c3 ff ff       	call   80100338 <panic>
80103ff1:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80103ff4:	8b 73 08             	mov    0x8(%ebx),%esi
80103ff7:	e8 74 f4 ff ff       	call   80103470 <mycpu>
80103ffc:	39 c6                	cmp    %eax,%esi
80103ffe:	75 df                	jne    80103fdf <release+0x13>
  popcli();
80104000:	e8 2f ff ff ff       	call   80103f34 <popcli>
  lk->pcs[0] = 0;
80104005:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010400c:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104013:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104018:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
8010401e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104021:	5b                   	pop    %ebx
80104022:	5e                   	pop    %esi
80104023:	5d                   	pop    %ebp
  popcli();
80104024:	e9 0b ff ff ff       	jmp    80103f34 <popcli>
80104029:	8d 76 00             	lea    0x0(%esi),%esi

8010402c <acquire>:
{
8010402c:	55                   	push   %ebp
8010402d:	89 e5                	mov    %esp,%ebp
8010402f:	53                   	push   %ebx
80104030:	50                   	push   %eax
  pushcli(); // disable interrupts to avoid deadlock.
80104031:	e8 b2 fe ff ff       	call   80103ee8 <pushcli>
  if(holding(lk))
80104036:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104039:	e8 aa fe ff ff       	call   80103ee8 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010403e:	8b 13                	mov    (%ebx),%edx
80104040:	85 d2                	test   %edx,%edx
80104042:	0f 85 9c 00 00 00    	jne    801040e4 <acquire+0xb8>
  popcli();
80104048:	e8 e7 fe ff ff       	call   80103f34 <popcli>
  asm volatile("lock; xchgl %0, %1" :
8010404d:	b9 01 00 00 00       	mov    $0x1,%ecx
80104052:	66 90                	xchg   %ax,%ax
  while(xchg(&lk->locked, 1) != 0)
80104054:	8b 55 08             	mov    0x8(%ebp),%edx
80104057:	89 c8                	mov    %ecx,%eax
80104059:	f0 87 02             	lock xchg %eax,(%edx)
8010405c:	85 c0                	test   %eax,%eax
8010405e:	75 f4                	jne    80104054 <acquire+0x28>
  __sync_synchronize();
80104060:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104065:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104068:	e8 03 f4 ff ff       	call   80103470 <mycpu>
8010406d:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
80104070:	8b 4d 08             	mov    0x8(%ebp),%ecx
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104073:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
  for(i = 0; i < 10; i++){
80104079:	31 d2                	xor    %edx,%edx
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010407b:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
80104080:	77 2a                	ja     801040ac <acquire+0x80>
  ebp = (uint*)v - 2;
80104082:	89 e8                	mov    %ebp,%eax
80104084:	eb 10                	jmp    80104096 <acquire+0x6a>
80104086:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104088:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010408e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104094:	77 16                	ja     801040ac <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104096:	8b 58 04             	mov    0x4(%eax),%ebx
80104099:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
    ebp = (uint*)ebp[0]; // saved %ebp
8010409d:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
8010409f:	42                   	inc    %edx
801040a0:	83 fa 0a             	cmp    $0xa,%edx
801040a3:	75 e3                	jne    80104088 <acquire+0x5c>
}
801040a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040a8:	c9                   	leave
801040a9:	c3                   	ret
801040aa:	66 90                	xchg   %ax,%ax
801040ac:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
801040b0:	83 c1 34             	add    $0x34,%ecx
801040b3:	89 ca                	mov    %ecx,%edx
801040b5:	29 c2                	sub    %eax,%edx
801040b7:	83 e2 04             	and    $0x4,%edx
801040ba:	74 10                	je     801040cc <acquire+0xa0>
    pcs[i] = 0;
801040bc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801040c2:	83 c0 04             	add    $0x4,%eax
801040c5:	39 c1                	cmp    %eax,%ecx
801040c7:	74 dc                	je     801040a5 <acquire+0x79>
801040c9:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
801040cc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801040d2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  for(; i < 10; i++)
801040d9:	83 c0 08             	add    $0x8,%eax
801040dc:	39 c1                	cmp    %eax,%ecx
801040de:	75 ec                	jne    801040cc <acquire+0xa0>
801040e0:	eb c3                	jmp    801040a5 <acquire+0x79>
801040e2:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
801040e4:	8b 5b 08             	mov    0x8(%ebx),%ebx
801040e7:	e8 84 f3 ff ff       	call   80103470 <mycpu>
801040ec:	39 c3                	cmp    %eax,%ebx
801040ee:	0f 85 54 ff ff ff    	jne    80104048 <acquire+0x1c>
  popcli();
801040f4:	e8 3b fe ff ff       	call   80103f34 <popcli>
    panic("acquire");
801040f9:	83 ec 0c             	sub    $0xc,%esp
801040fc:	68 09 6c 10 80       	push   $0x80106c09
80104101:	e8 32 c2 ff ff       	call   80100338 <panic>
80104106:	66 90                	xchg   %ax,%ax

80104108 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104108:	55                   	push   %ebp
80104109:	89 e5                	mov    %esp,%ebp
8010410b:	57                   	push   %edi
8010410c:	8b 55 08             	mov    0x8(%ebp),%edx
8010410f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104112:	89 d0                	mov    %edx,%eax
80104114:	09 c8                	or     %ecx,%eax
80104116:	a8 03                	test   $0x3,%al
80104118:	75 22                	jne    8010413c <memset+0x34>
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010411a:	c1 e9 02             	shr    $0x2,%ecx
    c &= 0xFF;
8010411d:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104121:	89 f8                	mov    %edi,%eax
80104123:	c1 e0 08             	shl    $0x8,%eax
80104126:	01 f8                	add    %edi,%eax
80104128:	89 c7                	mov    %eax,%edi
8010412a:	c1 e7 10             	shl    $0x10,%edi
8010412d:	01 f8                	add    %edi,%eax
  asm volatile("cld; rep stosl" :
8010412f:	89 d7                	mov    %edx,%edi
80104131:	fc                   	cld
80104132:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104134:	89 d0                	mov    %edx,%eax
80104136:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104139:	c9                   	leave
8010413a:	c3                   	ret
8010413b:	90                   	nop
  asm volatile("cld; rep stosb" :
8010413c:	89 d7                	mov    %edx,%edi
8010413e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104141:	fc                   	cld
80104142:	f3 aa                	rep stos %al,%es:(%edi)
80104144:	89 d0                	mov    %edx,%eax
80104146:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104149:	c9                   	leave
8010414a:	c3                   	ret
8010414b:	90                   	nop

8010414c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
8010414c:	55                   	push   %ebp
8010414d:	89 e5                	mov    %esp,%ebp
8010414f:	56                   	push   %esi
80104150:	53                   	push   %ebx
80104151:	8b 45 08             	mov    0x8(%ebp),%eax
80104154:	8b 55 0c             	mov    0xc(%ebp),%edx
80104157:	8b 75 10             	mov    0x10(%ebp),%esi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010415a:	85 f6                	test   %esi,%esi
8010415c:	74 1e                	je     8010417c <memcmp+0x30>
8010415e:	01 c6                	add    %eax,%esi
80104160:	eb 08                	jmp    8010416a <memcmp+0x1e>
80104162:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104164:	40                   	inc    %eax
80104165:	42                   	inc    %edx
  while(n-- > 0){
80104166:	39 f0                	cmp    %esi,%eax
80104168:	74 12                	je     8010417c <memcmp+0x30>
    if(*s1 != *s2)
8010416a:	8a 08                	mov    (%eax),%cl
8010416c:	0f b6 1a             	movzbl (%edx),%ebx
8010416f:	38 d9                	cmp    %bl,%cl
80104171:	74 f1                	je     80104164 <memcmp+0x18>
      return *s1 - *s2;
80104173:	0f b6 c1             	movzbl %cl,%eax
80104176:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104178:	5b                   	pop    %ebx
80104179:	5e                   	pop    %esi
8010417a:	5d                   	pop    %ebp
8010417b:	c3                   	ret
  return 0;
8010417c:	31 c0                	xor    %eax,%eax
}
8010417e:	5b                   	pop    %ebx
8010417f:	5e                   	pop    %esi
80104180:	5d                   	pop    %ebp
80104181:	c3                   	ret
80104182:	66 90                	xchg   %ax,%ax

80104184 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104184:	55                   	push   %ebp
80104185:	89 e5                	mov    %esp,%ebp
80104187:	57                   	push   %edi
80104188:	56                   	push   %esi
80104189:	8b 55 08             	mov    0x8(%ebp),%edx
8010418c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010418f:	8b 45 10             	mov    0x10(%ebp),%eax
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104192:	39 d6                	cmp    %edx,%esi
80104194:	73 22                	jae    801041b8 <memmove+0x34>
80104196:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104199:	39 ca                	cmp    %ecx,%edx
8010419b:	73 1b                	jae    801041b8 <memmove+0x34>
    s += n;
    d += n;
    while(n-- > 0)
8010419d:	85 c0                	test   %eax,%eax
8010419f:	74 0e                	je     801041af <memmove+0x2b>
801041a1:	48                   	dec    %eax
801041a2:	66 90                	xchg   %ax,%ax
      *--d = *--s;
801041a4:	8a 0c 06             	mov    (%esi,%eax,1),%cl
801041a7:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
801041aa:	83 e8 01             	sub    $0x1,%eax
801041ad:	73 f5                	jae    801041a4 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801041af:	89 d0                	mov    %edx,%eax
801041b1:	5e                   	pop    %esi
801041b2:	5f                   	pop    %edi
801041b3:	5d                   	pop    %ebp
801041b4:	c3                   	ret
801041b5:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
801041b8:	85 c0                	test   %eax,%eax
801041ba:	74 f3                	je     801041af <memmove+0x2b>
801041bc:	01 f0                	add    %esi,%eax
801041be:	89 d7                	mov    %edx,%edi
      *d++ = *s++;
801041c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
801041c1:	39 c6                	cmp    %eax,%esi
801041c3:	75 fb                	jne    801041c0 <memmove+0x3c>
}
801041c5:	89 d0                	mov    %edx,%eax
801041c7:	5e                   	pop    %esi
801041c8:	5f                   	pop    %edi
801041c9:	5d                   	pop    %ebp
801041ca:	c3                   	ret
801041cb:	90                   	nop

801041cc <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801041cc:	eb b6                	jmp    80104184 <memmove>
801041ce:	66 90                	xchg   %ax,%ax

801041d0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	53                   	push   %ebx
801041d4:	8b 45 08             	mov    0x8(%ebp),%eax
801041d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801041da:	8b 55 10             	mov    0x10(%ebp),%edx
  while(n > 0 && *p && *p == *q)
801041dd:	85 d2                	test   %edx,%edx
801041df:	75 0c                	jne    801041ed <strncmp+0x1d>
801041e1:	eb 1d                	jmp    80104200 <strncmp+0x30>
801041e3:	90                   	nop
801041e4:	3a 19                	cmp    (%ecx),%bl
801041e6:	75 0b                	jne    801041f3 <strncmp+0x23>
    n--, p++, q++;
801041e8:	40                   	inc    %eax
801041e9:	41                   	inc    %ecx
  while(n > 0 && *p && *p == *q)
801041ea:	4a                   	dec    %edx
801041eb:	74 13                	je     80104200 <strncmp+0x30>
801041ed:	8a 18                	mov    (%eax),%bl
801041ef:	84 db                	test   %bl,%bl
801041f1:	75 f1                	jne    801041e4 <strncmp+0x14>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801041f3:	0f b6 00             	movzbl (%eax),%eax
801041f6:	0f b6 11             	movzbl (%ecx),%edx
801041f9:	29 d0                	sub    %edx,%eax
}
801041fb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041fe:	c9                   	leave
801041ff:	c3                   	ret
    return 0;
80104200:	31 c0                	xor    %eax,%eax
}
80104202:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104205:	c9                   	leave
80104206:	c3                   	ret
80104207:	90                   	nop

80104208 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104208:	55                   	push   %ebp
80104209:	89 e5                	mov    %esp,%ebp
8010420b:	56                   	push   %esi
8010420c:	53                   	push   %ebx
8010420d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104210:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104213:	8b 55 08             	mov    0x8(%ebp),%edx
80104216:	eb 0c                	jmp    80104224 <strncpy+0x1c>
80104218:	43                   	inc    %ebx
80104219:	42                   	inc    %edx
8010421a:	8a 43 ff             	mov    -0x1(%ebx),%al
8010421d:	88 42 ff             	mov    %al,-0x1(%edx)
80104220:	84 c0                	test   %al,%al
80104222:	74 10                	je     80104234 <strncpy+0x2c>
80104224:	89 ce                	mov    %ecx,%esi
80104226:	49                   	dec    %ecx
80104227:	85 f6                	test   %esi,%esi
80104229:	7f ed                	jg     80104218 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
8010422b:	8b 45 08             	mov    0x8(%ebp),%eax
8010422e:	5b                   	pop    %ebx
8010422f:	5e                   	pop    %esi
80104230:	5d                   	pop    %ebp
80104231:	c3                   	ret
80104232:	66 90                	xchg   %ax,%ax
  while(n-- > 0)
80104234:	8d 5c 32 ff          	lea    -0x1(%edx,%esi,1),%ebx
80104238:	85 c9                	test   %ecx,%ecx
8010423a:	74 ef                	je     8010422b <strncpy+0x23>
    *s++ = 0;
8010423c:	42                   	inc    %edx
8010423d:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
80104241:	89 d9                	mov    %ebx,%ecx
80104243:	29 d1                	sub    %edx,%ecx
80104245:	85 c9                	test   %ecx,%ecx
80104247:	7f f3                	jg     8010423c <strncpy+0x34>
}
80104249:	8b 45 08             	mov    0x8(%ebp),%eax
8010424c:	5b                   	pop    %ebx
8010424d:	5e                   	pop    %esi
8010424e:	5d                   	pop    %ebp
8010424f:	c3                   	ret

80104250 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	56                   	push   %esi
80104254:	53                   	push   %ebx
80104255:	8b 45 08             	mov    0x8(%ebp),%eax
80104258:	8b 55 0c             	mov    0xc(%ebp),%edx
8010425b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  if(n <= 0)
8010425e:	85 c9                	test   %ecx,%ecx
80104260:	7e 1d                	jle    8010427f <safestrcpy+0x2f>
80104262:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104266:	89 c1                	mov    %eax,%ecx
80104268:	eb 0e                	jmp    80104278 <safestrcpy+0x28>
8010426a:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
8010426c:	42                   	inc    %edx
8010426d:	41                   	inc    %ecx
8010426e:	8a 5a ff             	mov    -0x1(%edx),%bl
80104271:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104274:	84 db                	test   %bl,%bl
80104276:	74 04                	je     8010427c <safestrcpy+0x2c>
80104278:	39 f2                	cmp    %esi,%edx
8010427a:	75 f0                	jne    8010426c <safestrcpy+0x1c>
    ;
  *s = 0;
8010427c:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
8010427f:	5b                   	pop    %ebx
80104280:	5e                   	pop    %esi
80104281:	5d                   	pop    %ebp
80104282:	c3                   	ret
80104283:	90                   	nop

80104284 <strlen>:

int
strlen(const char *s)
{
80104284:	55                   	push   %ebp
80104285:	89 e5                	mov    %esp,%ebp
80104287:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
8010428a:	31 c0                	xor    %eax,%eax
8010428c:	80 3a 00             	cmpb   $0x0,(%edx)
8010428f:	74 0a                	je     8010429b <strlen+0x17>
80104291:	8d 76 00             	lea    0x0(%esi),%esi
80104294:	40                   	inc    %eax
80104295:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104299:	75 f9                	jne    80104294 <strlen+0x10>
    ;
  return n;
}
8010429b:	5d                   	pop    %ebp
8010429c:	c3                   	ret

8010429d <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010429d:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801042a1:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801042a5:	55                   	push   %ebp
  pushl %ebx
801042a6:	53                   	push   %ebx
  pushl %esi
801042a7:	56                   	push   %esi
  pushl %edi
801042a8:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801042a9:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801042ab:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801042ad:	5f                   	pop    %edi
  popl %esi
801042ae:	5e                   	pop    %esi
  popl %ebx
801042af:	5b                   	pop    %ebx
  popl %ebp
801042b0:	5d                   	pop    %ebp
  ret
801042b1:	c3                   	ret
801042b2:	66 90                	xchg   %ax,%ax

801042b4 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801042b4:	55                   	push   %ebp
801042b5:	89 e5                	mov    %esp,%ebp
801042b7:	53                   	push   %ebx
801042b8:	50                   	push   %eax
801042b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801042bc:	e8 47 f2 ff ff       	call   80103508 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801042c1:	8b 00                	mov    (%eax),%eax
801042c3:	39 c3                	cmp    %eax,%ebx
801042c5:	73 15                	jae    801042dc <fetchint+0x28>
801042c7:	8d 53 04             	lea    0x4(%ebx),%edx
801042ca:	39 d0                	cmp    %edx,%eax
801042cc:	72 0e                	jb     801042dc <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
801042ce:	8b 13                	mov    (%ebx),%edx
801042d0:	8b 45 0c             	mov    0xc(%ebp),%eax
801042d3:	89 10                	mov    %edx,(%eax)
  return 0;
801042d5:	31 c0                	xor    %eax,%eax
}
801042d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042da:	c9                   	leave
801042db:	c3                   	ret
    return -1;
801042dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042e1:	eb f4                	jmp    801042d7 <fetchint+0x23>
801042e3:	90                   	nop

801042e4 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801042e4:	55                   	push   %ebp
801042e5:	89 e5                	mov    %esp,%ebp
801042e7:	53                   	push   %ebx
801042e8:	50                   	push   %eax
801042e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801042ec:	e8 17 f2 ff ff       	call   80103508 <myproc>

  if(addr >= curproc->sz)
801042f1:	3b 18                	cmp    (%eax),%ebx
801042f3:	73 23                	jae    80104318 <fetchstr+0x34>
    return -1;
  *pp = (char*)addr;
801042f5:	8b 55 0c             	mov    0xc(%ebp),%edx
801042f8:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801042fa:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801042fc:	39 d3                	cmp    %edx,%ebx
801042fe:	73 18                	jae    80104318 <fetchstr+0x34>
80104300:	89 d8                	mov    %ebx,%eax
80104302:	eb 05                	jmp    80104309 <fetchstr+0x25>
80104304:	40                   	inc    %eax
80104305:	39 d0                	cmp    %edx,%eax
80104307:	73 0f                	jae    80104318 <fetchstr+0x34>
    if(*s == 0)
80104309:	80 38 00             	cmpb   $0x0,(%eax)
8010430c:	75 f6                	jne    80104304 <fetchstr+0x20>
      return s - *pp;
8010430e:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104310:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104313:	c9                   	leave
80104314:	c3                   	ret
80104315:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104318:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010431d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104320:	c9                   	leave
80104321:	c3                   	ret
80104322:	66 90                	xchg   %ax,%ax

80104324 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104324:	55                   	push   %ebp
80104325:	89 e5                	mov    %esp,%ebp
80104327:	56                   	push   %esi
80104328:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104329:	e8 da f1 ff ff       	call   80103508 <myproc>
8010432e:	8b 40 18             	mov    0x18(%eax),%eax
80104331:	8b 40 44             	mov    0x44(%eax),%eax
80104334:	8b 55 08             	mov    0x8(%ebp),%edx
80104337:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
8010433a:	8d 73 04             	lea    0x4(%ebx),%esi
  struct proc *curproc = myproc();
8010433d:	e8 c6 f1 ff ff       	call   80103508 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104342:	8b 00                	mov    (%eax),%eax
80104344:	39 c6                	cmp    %eax,%esi
80104346:	73 18                	jae    80104360 <argint+0x3c>
80104348:	8d 53 08             	lea    0x8(%ebx),%edx
8010434b:	39 d0                	cmp    %edx,%eax
8010434d:	72 11                	jb     80104360 <argint+0x3c>
  *ip = *(int*)(addr);
8010434f:	8b 53 04             	mov    0x4(%ebx),%edx
80104352:	8b 45 0c             	mov    0xc(%ebp),%eax
80104355:	89 10                	mov    %edx,(%eax)
  return 0;
80104357:	31 c0                	xor    %eax,%eax
}
80104359:	5b                   	pop    %ebx
8010435a:	5e                   	pop    %esi
8010435b:	5d                   	pop    %ebp
8010435c:	c3                   	ret
8010435d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104360:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104365:	eb f2                	jmp    80104359 <argint+0x35>
80104367:	90                   	nop

80104368 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104368:	55                   	push   %ebp
80104369:	89 e5                	mov    %esp,%ebp
8010436b:	57                   	push   %edi
8010436c:	56                   	push   %esi
8010436d:	53                   	push   %ebx
8010436e:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104371:	e8 92 f1 ff ff       	call   80103508 <myproc>
80104376:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104378:	e8 8b f1 ff ff       	call   80103508 <myproc>
8010437d:	8b 40 18             	mov    0x18(%eax),%eax
80104380:	8b 40 44             	mov    0x44(%eax),%eax
80104383:	8b 55 08             	mov    0x8(%ebp),%edx
80104386:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80104389:	8d 7b 04             	lea    0x4(%ebx),%edi
  struct proc *curproc = myproc();
8010438c:	e8 77 f1 ff ff       	call   80103508 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104391:	8b 00                	mov    (%eax),%eax
80104393:	39 c7                	cmp    %eax,%edi
80104395:	73 31                	jae    801043c8 <argptr+0x60>
80104397:	8d 4b 08             	lea    0x8(%ebx),%ecx
8010439a:	39 c8                	cmp    %ecx,%eax
8010439c:	72 2a                	jb     801043c8 <argptr+0x60>
  *ip = *(int*)(addr);
8010439e:	8b 43 04             	mov    0x4(%ebx),%eax
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801043a1:	8b 55 10             	mov    0x10(%ebp),%edx
801043a4:	85 d2                	test   %edx,%edx
801043a6:	78 20                	js     801043c8 <argptr+0x60>
801043a8:	8b 16                	mov    (%esi),%edx
801043aa:	39 d0                	cmp    %edx,%eax
801043ac:	73 1a                	jae    801043c8 <argptr+0x60>
801043ae:	8b 5d 10             	mov    0x10(%ebp),%ebx
801043b1:	01 c3                	add    %eax,%ebx
801043b3:	39 da                	cmp    %ebx,%edx
801043b5:	72 11                	jb     801043c8 <argptr+0x60>
    return -1;
  *pp = (char*)i;
801043b7:	8b 55 0c             	mov    0xc(%ebp),%edx
801043ba:	89 02                	mov    %eax,(%edx)
  return 0;
801043bc:	31 c0                	xor    %eax,%eax
}
801043be:	83 c4 0c             	add    $0xc,%esp
801043c1:	5b                   	pop    %ebx
801043c2:	5e                   	pop    %esi
801043c3:	5f                   	pop    %edi
801043c4:	5d                   	pop    %ebp
801043c5:	c3                   	ret
801043c6:	66 90                	xchg   %ax,%ax
    return -1;
801043c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801043cd:	eb ef                	jmp    801043be <argptr+0x56>
801043cf:	90                   	nop

801043d0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	56                   	push   %esi
801043d4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801043d5:	e8 2e f1 ff ff       	call   80103508 <myproc>
801043da:	8b 40 18             	mov    0x18(%eax),%eax
801043dd:	8b 40 44             	mov    0x44(%eax),%eax
801043e0:	8b 55 08             	mov    0x8(%ebp),%edx
801043e3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
801043e6:	8d 73 04             	lea    0x4(%ebx),%esi
  struct proc *curproc = myproc();
801043e9:	e8 1a f1 ff ff       	call   80103508 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801043ee:	8b 00                	mov    (%eax),%eax
801043f0:	39 c6                	cmp    %eax,%esi
801043f2:	73 34                	jae    80104428 <argstr+0x58>
801043f4:	8d 53 08             	lea    0x8(%ebx),%edx
801043f7:	39 d0                	cmp    %edx,%eax
801043f9:	72 2d                	jb     80104428 <argstr+0x58>
  *ip = *(int*)(addr);
801043fb:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
801043fe:	e8 05 f1 ff ff       	call   80103508 <myproc>
  if(addr >= curproc->sz)
80104403:	3b 18                	cmp    (%eax),%ebx
80104405:	73 21                	jae    80104428 <argstr+0x58>
  *pp = (char*)addr;
80104407:	8b 55 0c             	mov    0xc(%ebp),%edx
8010440a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010440c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010440e:	39 d3                	cmp    %edx,%ebx
80104410:	73 16                	jae    80104428 <argstr+0x58>
80104412:	89 d8                	mov    %ebx,%eax
80104414:	eb 07                	jmp    8010441d <argstr+0x4d>
80104416:	66 90                	xchg   %ax,%ax
80104418:	40                   	inc    %eax
80104419:	39 d0                	cmp    %edx,%eax
8010441b:	73 0b                	jae    80104428 <argstr+0x58>
    if(*s == 0)
8010441d:	80 38 00             	cmpb   $0x0,(%eax)
80104420:	75 f6                	jne    80104418 <argstr+0x48>
      return s - *pp;
80104422:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104424:	5b                   	pop    %ebx
80104425:	5e                   	pop    %esi
80104426:	5d                   	pop    %ebp
80104427:	c3                   	ret
    return -1;
80104428:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010442d:	5b                   	pop    %ebx
8010442e:	5e                   	pop    %esi
8010442f:	5d                   	pop    %ebp
80104430:	c3                   	ret
80104431:	8d 76 00             	lea    0x0(%esi),%esi

80104434 <syscall>:
[SYS_countfp] sys_countfp,
};

void
syscall(void)
{
80104434:	55                   	push   %ebp
80104435:	89 e5                	mov    %esp,%ebp
80104437:	53                   	push   %ebx
80104438:	50                   	push   %eax
  int num;
  struct proc *curproc = myproc();
80104439:	e8 ca f0 ff ff       	call   80103508 <myproc>
8010443e:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104440:	8b 40 18             	mov    0x18(%eax),%eax
80104443:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104446:	8d 50 ff             	lea    -0x1(%eax),%edx
80104449:	83 fa 15             	cmp    $0x15,%edx
8010444c:	77 1a                	ja     80104468 <syscall+0x34>
8010444e:	8b 14 85 a0 71 10 80 	mov    -0x7fef8e60(,%eax,4),%edx
80104455:	85 d2                	test   %edx,%edx
80104457:	74 0f                	je     80104468 <syscall+0x34>
    curproc->tf->eax = syscalls[num]();
80104459:	ff d2                	call   *%edx
8010445b:	89 c2                	mov    %eax,%edx
8010445d:	8b 43 18             	mov    0x18(%ebx),%eax
80104460:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104463:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104466:	c9                   	leave
80104467:	c3                   	ret
    cprintf("%d %s: unknown sys call %d\n",
80104468:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104469:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
8010446c:	50                   	push   %eax
8010446d:	ff 73 10             	push   0x10(%ebx)
80104470:	68 11 6c 10 80       	push   $0x80106c11
80104475:	e8 ae c1 ff ff       	call   80100628 <cprintf>
    curproc->tf->eax = -1;
8010447a:	8b 43 18             	mov    0x18(%ebx),%eax
8010447d:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
80104484:	83 c4 10             	add    $0x10,%esp
}
80104487:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010448a:	c9                   	leave
8010448b:	c3                   	ret

8010448c <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
8010448c:	55                   	push   %ebp
8010448d:	89 e5                	mov    %esp,%ebp
8010448f:	57                   	push   %edi
80104490:	56                   	push   %esi
80104491:	53                   	push   %ebx
80104492:	83 ec 34             	sub    $0x34,%esp
80104495:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104498:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010449b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010449e:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801044a1:	8d 7d da             	lea    -0x26(%ebp),%edi
801044a4:	57                   	push   %edi
801044a5:	50                   	push   %eax
801044a6:	e8 99 d9 ff ff       	call   80101e44 <nameiparent>
801044ab:	83 c4 10             	add    $0x10,%esp
801044ae:	85 c0                	test   %eax,%eax
801044b0:	74 5a                	je     8010450c <create+0x80>
801044b2:	89 c3                	mov    %eax,%ebx
    return 0;
  ilock(dp);
801044b4:	83 ec 0c             	sub    $0xc,%esp
801044b7:	50                   	push   %eax
801044b8:	e8 1f d1 ff ff       	call   801015dc <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801044bd:	83 c4 0c             	add    $0xc,%esp
801044c0:	6a 00                	push   $0x0
801044c2:	57                   	push   %edi
801044c3:	53                   	push   %ebx
801044c4:	e8 17 d6 ff ff       	call   80101ae0 <dirlookup>
801044c9:	89 c6                	mov    %eax,%esi
801044cb:	83 c4 10             	add    $0x10,%esp
801044ce:	85 c0                	test   %eax,%eax
801044d0:	74 46                	je     80104518 <create+0x8c>
    iunlockput(dp);
801044d2:	83 ec 0c             	sub    $0xc,%esp
801044d5:	53                   	push   %ebx
801044d6:	e8 55 d3 ff ff       	call   80101830 <iunlockput>
    ilock(ip);
801044db:	89 34 24             	mov    %esi,(%esp)
801044de:	e8 f9 d0 ff ff       	call   801015dc <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801044e3:	83 c4 10             	add    $0x10,%esp
801044e6:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801044eb:	75 13                	jne    80104500 <create+0x74>
801044ed:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
801044f2:	75 0c                	jne    80104500 <create+0x74>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801044f4:	89 f0                	mov    %esi,%eax
801044f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044f9:	5b                   	pop    %ebx
801044fa:	5e                   	pop    %esi
801044fb:	5f                   	pop    %edi
801044fc:	5d                   	pop    %ebp
801044fd:	c3                   	ret
801044fe:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104500:	83 ec 0c             	sub    $0xc,%esp
80104503:	56                   	push   %esi
80104504:	e8 27 d3 ff ff       	call   80101830 <iunlockput>
    return 0;
80104509:	83 c4 10             	add    $0x10,%esp
    return 0;
8010450c:	31 f6                	xor    %esi,%esi
}
8010450e:	89 f0                	mov    %esi,%eax
80104510:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104513:	5b                   	pop    %ebx
80104514:	5e                   	pop    %esi
80104515:	5f                   	pop    %edi
80104516:	5d                   	pop    %ebp
80104517:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80104518:	83 ec 08             	sub    $0x8,%esp
8010451b:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
8010451f:	50                   	push   %eax
80104520:	ff 33                	push   (%ebx)
80104522:	e8 5d cf ff ff       	call   80101484 <ialloc>
80104527:	89 c6                	mov    %eax,%esi
80104529:	83 c4 10             	add    $0x10,%esp
8010452c:	85 c0                	test   %eax,%eax
8010452e:	0f 84 ad 00 00 00    	je     801045e1 <create+0x155>
  ilock(ip);
80104534:	83 ec 0c             	sub    $0xc,%esp
80104537:	50                   	push   %eax
80104538:	e8 9f d0 ff ff       	call   801015dc <ilock>
  ip->major = major;
8010453d:	8b 45 d0             	mov    -0x30(%ebp),%eax
80104540:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104544:	8b 45 cc             	mov    -0x34(%ebp),%eax
80104547:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
8010454b:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)
  iupdate(ip);
80104551:	89 34 24             	mov    %esi,(%esp)
80104554:	e8 db cf ff ff       	call   80101534 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104559:	83 c4 10             	add    $0x10,%esp
8010455c:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104561:	74 29                	je     8010458c <create+0x100>
  if(dirlink(dp, name, ip->inum) < 0)
80104563:	50                   	push   %eax
80104564:	ff 76 04             	push   0x4(%esi)
80104567:	57                   	push   %edi
80104568:	53                   	push   %ebx
80104569:	e8 0e d8 ff ff       	call   80101d7c <dirlink>
8010456e:	83 c4 10             	add    $0x10,%esp
80104571:	85 c0                	test   %eax,%eax
80104573:	78 5f                	js     801045d4 <create+0x148>
  iunlockput(dp);
80104575:	83 ec 0c             	sub    $0xc,%esp
80104578:	53                   	push   %ebx
80104579:	e8 b2 d2 ff ff       	call   80101830 <iunlockput>
  return ip;
8010457e:	83 c4 10             	add    $0x10,%esp
}
80104581:	89 f0                	mov    %esi,%eax
80104583:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104586:	5b                   	pop    %ebx
80104587:	5e                   	pop    %esi
80104588:	5f                   	pop    %edi
80104589:	5d                   	pop    %ebp
8010458a:	c3                   	ret
8010458b:	90                   	nop
    dp->nlink++;  // for ".."
8010458c:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80104590:	83 ec 0c             	sub    $0xc,%esp
80104593:	53                   	push   %ebx
80104594:	e8 9b cf ff ff       	call   80101534 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104599:	83 c4 0c             	add    $0xc,%esp
8010459c:	ff 76 04             	push   0x4(%esi)
8010459f:	68 49 6c 10 80       	push   $0x80106c49
801045a4:	56                   	push   %esi
801045a5:	e8 d2 d7 ff ff       	call   80101d7c <dirlink>
801045aa:	83 c4 10             	add    $0x10,%esp
801045ad:	85 c0                	test   %eax,%eax
801045af:	78 16                	js     801045c7 <create+0x13b>
801045b1:	52                   	push   %edx
801045b2:	ff 73 04             	push   0x4(%ebx)
801045b5:	68 48 6c 10 80       	push   $0x80106c48
801045ba:	56                   	push   %esi
801045bb:	e8 bc d7 ff ff       	call   80101d7c <dirlink>
801045c0:	83 c4 10             	add    $0x10,%esp
801045c3:	85 c0                	test   %eax,%eax
801045c5:	79 9c                	jns    80104563 <create+0xd7>
      panic("create dots");
801045c7:	83 ec 0c             	sub    $0xc,%esp
801045ca:	68 3c 6c 10 80       	push   $0x80106c3c
801045cf:	e8 64 bd ff ff       	call   80100338 <panic>
    panic("create: dirlink");
801045d4:	83 ec 0c             	sub    $0xc,%esp
801045d7:	68 4b 6c 10 80       	push   $0x80106c4b
801045dc:	e8 57 bd ff ff       	call   80100338 <panic>
    panic("create: ialloc");
801045e1:	83 ec 0c             	sub    $0xc,%esp
801045e4:	68 2d 6c 10 80       	push   $0x80106c2d
801045e9:	e8 4a bd ff ff       	call   80100338 <panic>
801045ee:	66 90                	xchg   %ax,%ax

801045f0 <sys_dup>:
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	56                   	push   %esi
801045f4:	53                   	push   %ebx
801045f5:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801045f8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801045fb:	50                   	push   %eax
801045fc:	6a 00                	push   $0x0
801045fe:	e8 21 fd ff ff       	call   80104324 <argint>
80104603:	83 c4 10             	add    $0x10,%esp
80104606:	85 c0                	test   %eax,%eax
80104608:	78 2c                	js     80104636 <sys_dup+0x46>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010460a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010460e:	77 26                	ja     80104636 <sys_dup+0x46>
80104610:	e8 f3 ee ff ff       	call   80103508 <myproc>
80104615:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104618:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010461c:	85 f6                	test   %esi,%esi
8010461e:	74 16                	je     80104636 <sys_dup+0x46>
  struct proc *curproc = myproc();
80104620:	e8 e3 ee ff ff       	call   80103508 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104625:	31 db                	xor    %ebx,%ebx
80104627:	90                   	nop
    if(curproc->ofile[fd] == 0){
80104628:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
8010462c:	85 d2                	test   %edx,%edx
8010462e:	74 14                	je     80104644 <sys_dup+0x54>
  for(fd = 0; fd < NOFILE; fd++){
80104630:	43                   	inc    %ebx
80104631:	83 fb 10             	cmp    $0x10,%ebx
80104634:	75 f2                	jne    80104628 <sys_dup+0x38>
    return -1;
80104636:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
8010463b:	89 d8                	mov    %ebx,%eax
8010463d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104640:	5b                   	pop    %ebx
80104641:	5e                   	pop    %esi
80104642:	5d                   	pop    %ebp
80104643:	c3                   	ret
      curproc->ofile[fd] = f;
80104644:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104648:	83 ec 0c             	sub    $0xc,%esp
8010464b:	56                   	push   %esi
8010464c:	e8 77 c7 ff ff       	call   80100dc8 <filedup>
  return fd;
80104651:	83 c4 10             	add    $0x10,%esp
}
80104654:	89 d8                	mov    %ebx,%eax
80104656:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104659:	5b                   	pop    %ebx
8010465a:	5e                   	pop    %esi
8010465b:	5d                   	pop    %ebp
8010465c:	c3                   	ret
8010465d:	8d 76 00             	lea    0x0(%esi),%esi

80104660 <sys_read>:
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	56                   	push   %esi
80104664:	53                   	push   %ebx
80104665:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104668:	8d 5d f4             	lea    -0xc(%ebp),%ebx
8010466b:	53                   	push   %ebx
8010466c:	6a 00                	push   $0x0
8010466e:	e8 b1 fc ff ff       	call   80104324 <argint>
80104673:	83 c4 10             	add    $0x10,%esp
80104676:	85 c0                	test   %eax,%eax
80104678:	78 56                	js     801046d0 <sys_read+0x70>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010467a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010467e:	77 50                	ja     801046d0 <sys_read+0x70>
80104680:	e8 83 ee ff ff       	call   80103508 <myproc>
80104685:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104688:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010468c:	85 f6                	test   %esi,%esi
8010468e:	74 40                	je     801046d0 <sys_read+0x70>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104690:	83 ec 08             	sub    $0x8,%esp
80104693:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104696:	50                   	push   %eax
80104697:	6a 02                	push   $0x2
80104699:	e8 86 fc ff ff       	call   80104324 <argint>
8010469e:	83 c4 10             	add    $0x10,%esp
801046a1:	85 c0                	test   %eax,%eax
801046a3:	78 2b                	js     801046d0 <sys_read+0x70>
801046a5:	52                   	push   %edx
801046a6:	ff 75 f0             	push   -0x10(%ebp)
801046a9:	53                   	push   %ebx
801046aa:	6a 01                	push   $0x1
801046ac:	e8 b7 fc ff ff       	call   80104368 <argptr>
801046b1:	83 c4 10             	add    $0x10,%esp
801046b4:	85 c0                	test   %eax,%eax
801046b6:	78 18                	js     801046d0 <sys_read+0x70>
  return fileread(f, p, n);
801046b8:	50                   	push   %eax
801046b9:	ff 75 f0             	push   -0x10(%ebp)
801046bc:	ff 75 f4             	push   -0xc(%ebp)
801046bf:	56                   	push   %esi
801046c0:	e8 4b c8 ff ff       	call   80100f10 <fileread>
801046c5:	83 c4 10             	add    $0x10,%esp
}
801046c8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046cb:	5b                   	pop    %ebx
801046cc:	5e                   	pop    %esi
801046cd:	5d                   	pop    %ebp
801046ce:	c3                   	ret
801046cf:	90                   	nop
    return -1;
801046d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046d5:	eb f1                	jmp    801046c8 <sys_read+0x68>
801046d7:	90                   	nop

801046d8 <sys_write>:
{
801046d8:	55                   	push   %ebp
801046d9:	89 e5                	mov    %esp,%ebp
801046db:	56                   	push   %esi
801046dc:	53                   	push   %ebx
801046dd:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801046e0:	8d 5d f4             	lea    -0xc(%ebp),%ebx
801046e3:	53                   	push   %ebx
801046e4:	6a 00                	push   $0x0
801046e6:	e8 39 fc ff ff       	call   80104324 <argint>
801046eb:	83 c4 10             	add    $0x10,%esp
801046ee:	85 c0                	test   %eax,%eax
801046f0:	78 56                	js     80104748 <sys_write+0x70>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801046f2:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801046f6:	77 50                	ja     80104748 <sys_write+0x70>
801046f8:	e8 0b ee ff ff       	call   80103508 <myproc>
801046fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104700:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104704:	85 f6                	test   %esi,%esi
80104706:	74 40                	je     80104748 <sys_write+0x70>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104708:	83 ec 08             	sub    $0x8,%esp
8010470b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010470e:	50                   	push   %eax
8010470f:	6a 02                	push   $0x2
80104711:	e8 0e fc ff ff       	call   80104324 <argint>
80104716:	83 c4 10             	add    $0x10,%esp
80104719:	85 c0                	test   %eax,%eax
8010471b:	78 2b                	js     80104748 <sys_write+0x70>
8010471d:	52                   	push   %edx
8010471e:	ff 75 f0             	push   -0x10(%ebp)
80104721:	53                   	push   %ebx
80104722:	6a 01                	push   $0x1
80104724:	e8 3f fc ff ff       	call   80104368 <argptr>
80104729:	83 c4 10             	add    $0x10,%esp
8010472c:	85 c0                	test   %eax,%eax
8010472e:	78 18                	js     80104748 <sys_write+0x70>
  return filewrite(f, p, n);
80104730:	50                   	push   %eax
80104731:	ff 75 f0             	push   -0x10(%ebp)
80104734:	ff 75 f4             	push   -0xc(%ebp)
80104737:	56                   	push   %esi
80104738:	e8 5f c8 ff ff       	call   80100f9c <filewrite>
8010473d:	83 c4 10             	add    $0x10,%esp
}
80104740:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104743:	5b                   	pop    %ebx
80104744:	5e                   	pop    %esi
80104745:	5d                   	pop    %ebp
80104746:	c3                   	ret
80104747:	90                   	nop
    return -1;
80104748:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010474d:	eb f1                	jmp    80104740 <sys_write+0x68>
8010474f:	90                   	nop

80104750 <sys_close>:
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	56                   	push   %esi
80104754:	53                   	push   %ebx
80104755:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104758:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010475b:	50                   	push   %eax
8010475c:	6a 00                	push   $0x0
8010475e:	e8 c1 fb ff ff       	call   80104324 <argint>
80104763:	83 c4 10             	add    $0x10,%esp
80104766:	85 c0                	test   %eax,%eax
80104768:	78 3e                	js     801047a8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010476a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010476e:	77 38                	ja     801047a8 <sys_close+0x58>
80104770:	e8 93 ed ff ff       	call   80103508 <myproc>
80104775:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104778:	8d 5a 08             	lea    0x8(%edx),%ebx
8010477b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
8010477f:	85 f6                	test   %esi,%esi
80104781:	74 25                	je     801047a8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80104783:	e8 80 ed ff ff       	call   80103508 <myproc>
80104788:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
8010478f:	00 
  fileclose(f);
80104790:	83 ec 0c             	sub    $0xc,%esp
80104793:	56                   	push   %esi
80104794:	e8 73 c6 ff ff       	call   80100e0c <fileclose>
  return 0;
80104799:	83 c4 10             	add    $0x10,%esp
8010479c:	31 c0                	xor    %eax,%eax
}
8010479e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047a1:	5b                   	pop    %ebx
801047a2:	5e                   	pop    %esi
801047a3:	5d                   	pop    %ebp
801047a4:	c3                   	ret
801047a5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801047a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047ad:	eb ef                	jmp    8010479e <sys_close+0x4e>
801047af:	90                   	nop

801047b0 <sys_fstat>:
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	56                   	push   %esi
801047b4:	53                   	push   %ebx
801047b5:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801047b8:	8d 5d f4             	lea    -0xc(%ebp),%ebx
801047bb:	53                   	push   %ebx
801047bc:	6a 00                	push   $0x0
801047be:	e8 61 fb ff ff       	call   80104324 <argint>
801047c3:	83 c4 10             	add    $0x10,%esp
801047c6:	85 c0                	test   %eax,%eax
801047c8:	78 3e                	js     80104808 <sys_fstat+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801047ca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801047ce:	77 38                	ja     80104808 <sys_fstat+0x58>
801047d0:	e8 33 ed ff ff       	call   80103508 <myproc>
801047d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801047d8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801047dc:	85 f6                	test   %esi,%esi
801047de:	74 28                	je     80104808 <sys_fstat+0x58>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801047e0:	50                   	push   %eax
801047e1:	6a 14                	push   $0x14
801047e3:	53                   	push   %ebx
801047e4:	6a 01                	push   $0x1
801047e6:	e8 7d fb ff ff       	call   80104368 <argptr>
801047eb:	83 c4 10             	add    $0x10,%esp
801047ee:	85 c0                	test   %eax,%eax
801047f0:	78 16                	js     80104808 <sys_fstat+0x58>
  return filestat(f, st);
801047f2:	83 ec 08             	sub    $0x8,%esp
801047f5:	ff 75 f4             	push   -0xc(%ebp)
801047f8:	56                   	push   %esi
801047f9:	e8 ce c6 ff ff       	call   80100ecc <filestat>
801047fe:	83 c4 10             	add    $0x10,%esp
}
80104801:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104804:	5b                   	pop    %ebx
80104805:	5e                   	pop    %esi
80104806:	5d                   	pop    %ebp
80104807:	c3                   	ret
    return -1;
80104808:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010480d:	eb f2                	jmp    80104801 <sys_fstat+0x51>
8010480f:	90                   	nop

80104810 <sys_link>:
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	57                   	push   %edi
80104814:	56                   	push   %esi
80104815:	53                   	push   %ebx
80104816:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104819:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010481c:	50                   	push   %eax
8010481d:	6a 00                	push   $0x0
8010481f:	e8 ac fb ff ff       	call   801043d0 <argstr>
80104824:	83 c4 10             	add    $0x10,%esp
80104827:	85 c0                	test   %eax,%eax
80104829:	0f 88 f2 00 00 00    	js     80104921 <sys_link+0x111>
8010482f:	83 ec 08             	sub    $0x8,%esp
80104832:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104835:	50                   	push   %eax
80104836:	6a 01                	push   $0x1
80104838:	e8 93 fb ff ff       	call   801043d0 <argstr>
8010483d:	83 c4 10             	add    $0x10,%esp
80104840:	85 c0                	test   %eax,%eax
80104842:	0f 88 d9 00 00 00    	js     80104921 <sys_link+0x111>
  begin_op();
80104848:	e8 73 e1 ff ff       	call   801029c0 <begin_op>
  if((ip = namei(old)) == 0){
8010484d:	83 ec 0c             	sub    $0xc,%esp
80104850:	ff 75 d4             	push   -0x2c(%ebp)
80104853:	e8 d4 d5 ff ff       	call   80101e2c <namei>
80104858:	89 c3                	mov    %eax,%ebx
8010485a:	83 c4 10             	add    $0x10,%esp
8010485d:	85 c0                	test   %eax,%eax
8010485f:	0f 84 d6 00 00 00    	je     8010493b <sys_link+0x12b>
  ilock(ip);
80104865:	83 ec 0c             	sub    $0xc,%esp
80104868:	50                   	push   %eax
80104869:	e8 6e cd ff ff       	call   801015dc <ilock>
  if(ip->type == T_DIR){
8010486e:	83 c4 10             	add    $0x10,%esp
80104871:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104876:	0f 84 ac 00 00 00    	je     80104928 <sys_link+0x118>
  ip->nlink++;
8010487c:	66 ff 43 56          	incw   0x56(%ebx)
  iupdate(ip);
80104880:	83 ec 0c             	sub    $0xc,%esp
80104883:	53                   	push   %ebx
80104884:	e8 ab cc ff ff       	call   80101534 <iupdate>
  iunlock(ip);
80104889:	89 1c 24             	mov    %ebx,(%esp)
8010488c:	e8 13 ce ff ff       	call   801016a4 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104891:	5a                   	pop    %edx
80104892:	59                   	pop    %ecx
80104893:	8d 7d da             	lea    -0x26(%ebp),%edi
80104896:	57                   	push   %edi
80104897:	ff 75 d0             	push   -0x30(%ebp)
8010489a:	e8 a5 d5 ff ff       	call   80101e44 <nameiparent>
8010489f:	89 c6                	mov    %eax,%esi
801048a1:	83 c4 10             	add    $0x10,%esp
801048a4:	85 c0                	test   %eax,%eax
801048a6:	74 54                	je     801048fc <sys_link+0xec>
  ilock(dp);
801048a8:	83 ec 0c             	sub    $0xc,%esp
801048ab:	50                   	push   %eax
801048ac:	e8 2b cd ff ff       	call   801015dc <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801048b1:	83 c4 10             	add    $0x10,%esp
801048b4:	8b 03                	mov    (%ebx),%eax
801048b6:	39 06                	cmp    %eax,(%esi)
801048b8:	75 36                	jne    801048f0 <sys_link+0xe0>
801048ba:	50                   	push   %eax
801048bb:	ff 73 04             	push   0x4(%ebx)
801048be:	57                   	push   %edi
801048bf:	56                   	push   %esi
801048c0:	e8 b7 d4 ff ff       	call   80101d7c <dirlink>
801048c5:	83 c4 10             	add    $0x10,%esp
801048c8:	85 c0                	test   %eax,%eax
801048ca:	78 24                	js     801048f0 <sys_link+0xe0>
  iunlockput(dp);
801048cc:	83 ec 0c             	sub    $0xc,%esp
801048cf:	56                   	push   %esi
801048d0:	e8 5b cf ff ff       	call   80101830 <iunlockput>
  iput(ip);
801048d5:	89 1c 24             	mov    %ebx,(%esp)
801048d8:	e8 0b ce ff ff       	call   801016e8 <iput>
  end_op();
801048dd:	e8 46 e1 ff ff       	call   80102a28 <end_op>
  return 0;
801048e2:	83 c4 10             	add    $0x10,%esp
801048e5:	31 c0                	xor    %eax,%eax
}
801048e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048ea:	5b                   	pop    %ebx
801048eb:	5e                   	pop    %esi
801048ec:	5f                   	pop    %edi
801048ed:	5d                   	pop    %ebp
801048ee:	c3                   	ret
801048ef:	90                   	nop
    iunlockput(dp);
801048f0:	83 ec 0c             	sub    $0xc,%esp
801048f3:	56                   	push   %esi
801048f4:	e8 37 cf ff ff       	call   80101830 <iunlockput>
    goto bad;
801048f9:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801048fc:	83 ec 0c             	sub    $0xc,%esp
801048ff:	53                   	push   %ebx
80104900:	e8 d7 cc ff ff       	call   801015dc <ilock>
  ip->nlink--;
80104905:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80104909:	89 1c 24             	mov    %ebx,(%esp)
8010490c:	e8 23 cc ff ff       	call   80101534 <iupdate>
  iunlockput(ip);
80104911:	89 1c 24             	mov    %ebx,(%esp)
80104914:	e8 17 cf ff ff       	call   80101830 <iunlockput>
  end_op();
80104919:	e8 0a e1 ff ff       	call   80102a28 <end_op>
  return -1;
8010491e:	83 c4 10             	add    $0x10,%esp
    return -1;
80104921:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104926:	eb bf                	jmp    801048e7 <sys_link+0xd7>
    iunlockput(ip);
80104928:	83 ec 0c             	sub    $0xc,%esp
8010492b:	53                   	push   %ebx
8010492c:	e8 ff ce ff ff       	call   80101830 <iunlockput>
    end_op();
80104931:	e8 f2 e0 ff ff       	call   80102a28 <end_op>
    return -1;
80104936:	83 c4 10             	add    $0x10,%esp
80104939:	eb e6                	jmp    80104921 <sys_link+0x111>
    end_op();
8010493b:	e8 e8 e0 ff ff       	call   80102a28 <end_op>
    return -1;
80104940:	eb df                	jmp    80104921 <sys_link+0x111>
80104942:	66 90                	xchg   %ax,%ax

80104944 <sys_unlink>:
{
80104944:	55                   	push   %ebp
80104945:	89 e5                	mov    %esp,%ebp
80104947:	57                   	push   %edi
80104948:	56                   	push   %esi
80104949:	53                   	push   %ebx
8010494a:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010494d:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104950:	50                   	push   %eax
80104951:	6a 00                	push   $0x0
80104953:	e8 78 fa ff ff       	call   801043d0 <argstr>
80104958:	83 c4 10             	add    $0x10,%esp
8010495b:	85 c0                	test   %eax,%eax
8010495d:	0f 88 50 01 00 00    	js     80104ab3 <sys_unlink+0x16f>
  begin_op();
80104963:	e8 58 e0 ff ff       	call   801029c0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104968:	83 ec 08             	sub    $0x8,%esp
8010496b:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010496e:	53                   	push   %ebx
8010496f:	ff 75 c0             	push   -0x40(%ebp)
80104972:	e8 cd d4 ff ff       	call   80101e44 <nameiparent>
80104977:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010497a:	83 c4 10             	add    $0x10,%esp
8010497d:	85 c0                	test   %eax,%eax
8010497f:	0f 84 4f 01 00 00    	je     80104ad4 <sys_unlink+0x190>
  ilock(dp);
80104985:	83 ec 0c             	sub    $0xc,%esp
80104988:	8b 7d b4             	mov    -0x4c(%ebp),%edi
8010498b:	57                   	push   %edi
8010498c:	e8 4b cc ff ff       	call   801015dc <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104991:	59                   	pop    %ecx
80104992:	5e                   	pop    %esi
80104993:	68 49 6c 10 80       	push   $0x80106c49
80104998:	53                   	push   %ebx
80104999:	e8 2a d1 ff ff       	call   80101ac8 <namecmp>
8010499e:	83 c4 10             	add    $0x10,%esp
801049a1:	85 c0                	test   %eax,%eax
801049a3:	0f 84 f7 00 00 00    	je     80104aa0 <sys_unlink+0x15c>
801049a9:	83 ec 08             	sub    $0x8,%esp
801049ac:	68 48 6c 10 80       	push   $0x80106c48
801049b1:	53                   	push   %ebx
801049b2:	e8 11 d1 ff ff       	call   80101ac8 <namecmp>
801049b7:	83 c4 10             	add    $0x10,%esp
801049ba:	85 c0                	test   %eax,%eax
801049bc:	0f 84 de 00 00 00    	je     80104aa0 <sys_unlink+0x15c>
  if((ip = dirlookup(dp, name, &off)) == 0)
801049c2:	52                   	push   %edx
801049c3:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801049c6:	50                   	push   %eax
801049c7:	53                   	push   %ebx
801049c8:	57                   	push   %edi
801049c9:	e8 12 d1 ff ff       	call   80101ae0 <dirlookup>
801049ce:	89 c3                	mov    %eax,%ebx
801049d0:	83 c4 10             	add    $0x10,%esp
801049d3:	85 c0                	test   %eax,%eax
801049d5:	0f 84 c5 00 00 00    	je     80104aa0 <sys_unlink+0x15c>
  ilock(ip);
801049db:	83 ec 0c             	sub    $0xc,%esp
801049de:	50                   	push   %eax
801049df:	e8 f8 cb ff ff       	call   801015dc <ilock>
  if(ip->nlink < 1)
801049e4:	83 c4 10             	add    $0x10,%esp
801049e7:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801049ec:	0f 8e 03 01 00 00    	jle    80104af5 <sys_unlink+0x1b1>
  if(ip->type == T_DIR && !isdirempty(ip)){
801049f2:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801049f7:	74 67                	je     80104a60 <sys_unlink+0x11c>
801049f9:	8d 7d d8             	lea    -0x28(%ebp),%edi
  memset(&de, 0, sizeof(de));
801049fc:	50                   	push   %eax
801049fd:	6a 10                	push   $0x10
801049ff:	6a 00                	push   $0x0
80104a01:	57                   	push   %edi
80104a02:	e8 01 f7 ff ff       	call   80104108 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104a07:	6a 10                	push   $0x10
80104a09:	ff 75 c4             	push   -0x3c(%ebp)
80104a0c:	57                   	push   %edi
80104a0d:	ff 75 b4             	push   -0x4c(%ebp)
80104a10:	e8 97 cf ff ff       	call   801019ac <writei>
80104a15:	83 c4 20             	add    $0x20,%esp
80104a18:	83 f8 10             	cmp    $0x10,%eax
80104a1b:	0f 85 c7 00 00 00    	jne    80104ae8 <sys_unlink+0x1a4>
  if(ip->type == T_DIR){
80104a21:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104a26:	0f 84 90 00 00 00    	je     80104abc <sys_unlink+0x178>
  iunlockput(dp);
80104a2c:	83 ec 0c             	sub    $0xc,%esp
80104a2f:	ff 75 b4             	push   -0x4c(%ebp)
80104a32:	e8 f9 cd ff ff       	call   80101830 <iunlockput>
  ip->nlink--;
80104a37:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80104a3b:	89 1c 24             	mov    %ebx,(%esp)
80104a3e:	e8 f1 ca ff ff       	call   80101534 <iupdate>
  iunlockput(ip);
80104a43:	89 1c 24             	mov    %ebx,(%esp)
80104a46:	e8 e5 cd ff ff       	call   80101830 <iunlockput>
  end_op();
80104a4b:	e8 d8 df ff ff       	call   80102a28 <end_op>
  return 0;
80104a50:	83 c4 10             	add    $0x10,%esp
80104a53:	31 c0                	xor    %eax,%eax
}
80104a55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a58:	5b                   	pop    %ebx
80104a59:	5e                   	pop    %esi
80104a5a:	5f                   	pop    %edi
80104a5b:	5d                   	pop    %ebp
80104a5c:	c3                   	ret
80104a5d:	8d 76 00             	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104a60:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80104a64:	76 93                	jbe    801049f9 <sys_unlink+0xb5>
80104a66:	be 20 00 00 00       	mov    $0x20,%esi
80104a6b:	8d 7d d8             	lea    -0x28(%ebp),%edi
80104a6e:	eb 08                	jmp    80104a78 <sys_unlink+0x134>
80104a70:	83 c6 10             	add    $0x10,%esi
80104a73:	3b 73 58             	cmp    0x58(%ebx),%esi
80104a76:	73 84                	jae    801049fc <sys_unlink+0xb8>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104a78:	6a 10                	push   $0x10
80104a7a:	56                   	push   %esi
80104a7b:	57                   	push   %edi
80104a7c:	53                   	push   %ebx
80104a7d:	e8 2a ce ff ff       	call   801018ac <readi>
80104a82:	83 c4 10             	add    $0x10,%esp
80104a85:	83 f8 10             	cmp    $0x10,%eax
80104a88:	75 51                	jne    80104adb <sys_unlink+0x197>
    if(de.inum != 0)
80104a8a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104a8f:	74 df                	je     80104a70 <sys_unlink+0x12c>
    iunlockput(ip);
80104a91:	83 ec 0c             	sub    $0xc,%esp
80104a94:	53                   	push   %ebx
80104a95:	e8 96 cd ff ff       	call   80101830 <iunlockput>
    goto bad;
80104a9a:	83 c4 10             	add    $0x10,%esp
80104a9d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80104aa0:	83 ec 0c             	sub    $0xc,%esp
80104aa3:	ff 75 b4             	push   -0x4c(%ebp)
80104aa6:	e8 85 cd ff ff       	call   80101830 <iunlockput>
  end_op();
80104aab:	e8 78 df ff ff       	call   80102a28 <end_op>
  return -1;
80104ab0:	83 c4 10             	add    $0x10,%esp
    return -1;
80104ab3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ab8:	eb 9b                	jmp    80104a55 <sys_unlink+0x111>
80104aba:	66 90                	xchg   %ax,%ax
    dp->nlink--;
80104abc:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104abf:	66 ff 48 56          	decw   0x56(%eax)
    iupdate(dp);
80104ac3:	83 ec 0c             	sub    $0xc,%esp
80104ac6:	50                   	push   %eax
80104ac7:	e8 68 ca ff ff       	call   80101534 <iupdate>
80104acc:	83 c4 10             	add    $0x10,%esp
80104acf:	e9 58 ff ff ff       	jmp    80104a2c <sys_unlink+0xe8>
    end_op();
80104ad4:	e8 4f df ff ff       	call   80102a28 <end_op>
    return -1;
80104ad9:	eb d8                	jmp    80104ab3 <sys_unlink+0x16f>
      panic("isdirempty: readi");
80104adb:	83 ec 0c             	sub    $0xc,%esp
80104ade:	68 6d 6c 10 80       	push   $0x80106c6d
80104ae3:	e8 50 b8 ff ff       	call   80100338 <panic>
    panic("unlink: writei");
80104ae8:	83 ec 0c             	sub    $0xc,%esp
80104aeb:	68 7f 6c 10 80       	push   $0x80106c7f
80104af0:	e8 43 b8 ff ff       	call   80100338 <panic>
    panic("unlink: nlink < 1");
80104af5:	83 ec 0c             	sub    $0xc,%esp
80104af8:	68 5b 6c 10 80       	push   $0x80106c5b
80104afd:	e8 36 b8 ff ff       	call   80100338 <panic>
80104b02:	66 90                	xchg   %ax,%ax

80104b04 <sys_open>:

int
sys_open(void)
{
80104b04:	55                   	push   %ebp
80104b05:	89 e5                	mov    %esp,%ebp
80104b07:	57                   	push   %edi
80104b08:	56                   	push   %esi
80104b09:	53                   	push   %ebx
80104b0a:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80104b0d:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104b10:	50                   	push   %eax
80104b11:	6a 00                	push   $0x0
80104b13:	e8 b8 f8 ff ff       	call   801043d0 <argstr>
80104b18:	83 c4 10             	add    $0x10,%esp
80104b1b:	85 c0                	test   %eax,%eax
80104b1d:	0f 88 88 00 00 00    	js     80104bab <sys_open+0xa7>
80104b23:	83 ec 08             	sub    $0x8,%esp
80104b26:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104b29:	50                   	push   %eax
80104b2a:	6a 01                	push   $0x1
80104b2c:	e8 f3 f7 ff ff       	call   80104324 <argint>
80104b31:	83 c4 10             	add    $0x10,%esp
80104b34:	85 c0                	test   %eax,%eax
80104b36:	78 73                	js     80104bab <sys_open+0xa7>
    return -1;

  begin_op();
80104b38:	e8 83 de ff ff       	call   801029c0 <begin_op>

  if(omode & O_CREATE){
80104b3d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80104b41:	75 71                	jne    80104bb4 <sys_open+0xb0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80104b43:	83 ec 0c             	sub    $0xc,%esp
80104b46:	ff 75 e0             	push   -0x20(%ebp)
80104b49:	e8 de d2 ff ff       	call   80101e2c <namei>
80104b4e:	89 c6                	mov    %eax,%esi
80104b50:	83 c4 10             	add    $0x10,%esp
80104b53:	85 c0                	test   %eax,%eax
80104b55:	74 7a                	je     80104bd1 <sys_open+0xcd>
      end_op();
      return -1;
    }
    ilock(ip);
80104b57:	83 ec 0c             	sub    $0xc,%esp
80104b5a:	50                   	push   %eax
80104b5b:	e8 7c ca ff ff       	call   801015dc <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80104b60:	83 c4 10             	add    $0x10,%esp
80104b63:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80104b68:	0f 84 ae 00 00 00    	je     80104c1c <sys_open+0x118>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80104b6e:	e8 ed c1 ff ff       	call   80100d60 <filealloc>
80104b73:	89 c7                	mov    %eax,%edi
80104b75:	85 c0                	test   %eax,%eax
80104b77:	74 21                	je     80104b9a <sys_open+0x96>
  struct proc *curproc = myproc();
80104b79:	e8 8a e9 ff ff       	call   80103508 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104b7e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80104b80:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104b84:	85 d2                	test   %edx,%edx
80104b86:	74 50                	je     80104bd8 <sys_open+0xd4>
  for(fd = 0; fd < NOFILE; fd++){
80104b88:	43                   	inc    %ebx
80104b89:	83 fb 10             	cmp    $0x10,%ebx
80104b8c:	75 f2                	jne    80104b80 <sys_open+0x7c>
    if(f)
      fileclose(f);
80104b8e:	83 ec 0c             	sub    $0xc,%esp
80104b91:	57                   	push   %edi
80104b92:	e8 75 c2 ff ff       	call   80100e0c <fileclose>
80104b97:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80104b9a:	83 ec 0c             	sub    $0xc,%esp
80104b9d:	56                   	push   %esi
80104b9e:	e8 8d cc ff ff       	call   80101830 <iunlockput>
    end_op();
80104ba3:	e8 80 de ff ff       	call   80102a28 <end_op>
    return -1;
80104ba8:	83 c4 10             	add    $0x10,%esp
    return -1;
80104bab:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104bb0:	eb 5f                	jmp    80104c11 <sys_open+0x10d>
80104bb2:	66 90                	xchg   %ax,%ax
    ip = create(path, T_FILE, 0, 0);
80104bb4:	83 ec 0c             	sub    $0xc,%esp
80104bb7:	6a 00                	push   $0x0
80104bb9:	31 c9                	xor    %ecx,%ecx
80104bbb:	ba 02 00 00 00       	mov    $0x2,%edx
80104bc0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104bc3:	e8 c4 f8 ff ff       	call   8010448c <create>
80104bc8:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80104bca:	83 c4 10             	add    $0x10,%esp
80104bcd:	85 c0                	test   %eax,%eax
80104bcf:	75 9d                	jne    80104b6e <sys_open+0x6a>
      end_op();
80104bd1:	e8 52 de ff ff       	call   80102a28 <end_op>
      return -1;
80104bd6:	eb d3                	jmp    80104bab <sys_open+0xa7>
      curproc->ofile[fd] = f;
80104bd8:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  }
  iunlock(ip);
80104bdc:	83 ec 0c             	sub    $0xc,%esp
80104bdf:	56                   	push   %esi
80104be0:	e8 bf ca ff ff       	call   801016a4 <iunlock>
  end_op();
80104be5:	e8 3e de ff ff       	call   80102a28 <end_op>

  f->type = FD_INODE;
80104bea:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
80104bf0:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80104bf3:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80104bfa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104bfd:	89 d0                	mov    %edx,%eax
80104bff:	f7 d0                	not    %eax
80104c01:	83 e0 01             	and    $0x1,%eax
80104c04:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80104c07:	83 c4 10             	add    $0x10,%esp
80104c0a:	83 e2 03             	and    $0x3,%edx
80104c0d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80104c11:	89 d8                	mov    %ebx,%eax
80104c13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c16:	5b                   	pop    %ebx
80104c17:	5e                   	pop    %esi
80104c18:	5f                   	pop    %edi
80104c19:	5d                   	pop    %ebp
80104c1a:	c3                   	ret
80104c1b:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80104c1c:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104c1f:	85 c9                	test   %ecx,%ecx
80104c21:	0f 84 47 ff ff ff    	je     80104b6e <sys_open+0x6a>
80104c27:	e9 6e ff ff ff       	jmp    80104b9a <sys_open+0x96>

80104c2c <sys_mkdir>:

int
sys_mkdir(void)
{
80104c2c:	55                   	push   %ebp
80104c2d:	89 e5                	mov    %esp,%ebp
80104c2f:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80104c32:	e8 89 dd ff ff       	call   801029c0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80104c37:	83 ec 08             	sub    $0x8,%esp
80104c3a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c3d:	50                   	push   %eax
80104c3e:	6a 00                	push   $0x0
80104c40:	e8 8b f7 ff ff       	call   801043d0 <argstr>
80104c45:	83 c4 10             	add    $0x10,%esp
80104c48:	85 c0                	test   %eax,%eax
80104c4a:	78 30                	js     80104c7c <sys_mkdir+0x50>
80104c4c:	83 ec 0c             	sub    $0xc,%esp
80104c4f:	6a 00                	push   $0x0
80104c51:	31 c9                	xor    %ecx,%ecx
80104c53:	ba 01 00 00 00       	mov    $0x1,%edx
80104c58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c5b:	e8 2c f8 ff ff       	call   8010448c <create>
80104c60:	83 c4 10             	add    $0x10,%esp
80104c63:	85 c0                	test   %eax,%eax
80104c65:	74 15                	je     80104c7c <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80104c67:	83 ec 0c             	sub    $0xc,%esp
80104c6a:	50                   	push   %eax
80104c6b:	e8 c0 cb ff ff       	call   80101830 <iunlockput>
  end_op();
80104c70:	e8 b3 dd ff ff       	call   80102a28 <end_op>
  return 0;
80104c75:	83 c4 10             	add    $0x10,%esp
80104c78:	31 c0                	xor    %eax,%eax
}
80104c7a:	c9                   	leave
80104c7b:	c3                   	ret
    end_op();
80104c7c:	e8 a7 dd ff ff       	call   80102a28 <end_op>
    return -1;
80104c81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c86:	c9                   	leave
80104c87:	c3                   	ret

80104c88 <sys_mknod>:

int
sys_mknod(void)
{
80104c88:	55                   	push   %ebp
80104c89:	89 e5                	mov    %esp,%ebp
80104c8b:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80104c8e:	e8 2d dd ff ff       	call   801029c0 <begin_op>
  if((argstr(0, &path)) < 0 ||
80104c93:	83 ec 08             	sub    $0x8,%esp
80104c96:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104c99:	50                   	push   %eax
80104c9a:	6a 00                	push   $0x0
80104c9c:	e8 2f f7 ff ff       	call   801043d0 <argstr>
80104ca1:	83 c4 10             	add    $0x10,%esp
80104ca4:	85 c0                	test   %eax,%eax
80104ca6:	78 60                	js     80104d08 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80104ca8:	83 ec 08             	sub    $0x8,%esp
80104cab:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104cae:	50                   	push   %eax
80104caf:	6a 01                	push   $0x1
80104cb1:	e8 6e f6 ff ff       	call   80104324 <argint>
  if((argstr(0, &path)) < 0 ||
80104cb6:	83 c4 10             	add    $0x10,%esp
80104cb9:	85 c0                	test   %eax,%eax
80104cbb:	78 4b                	js     80104d08 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80104cbd:	83 ec 08             	sub    $0x8,%esp
80104cc0:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cc3:	50                   	push   %eax
80104cc4:	6a 02                	push   $0x2
80104cc6:	e8 59 f6 ff ff       	call   80104324 <argint>
     argint(1, &major) < 0 ||
80104ccb:	83 c4 10             	add    $0x10,%esp
80104cce:	85 c0                	test   %eax,%eax
80104cd0:	78 36                	js     80104d08 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80104cd2:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80104cd6:	83 ec 0c             	sub    $0xc,%esp
80104cd9:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80104cdd:	50                   	push   %eax
80104cde:	ba 03 00 00 00       	mov    $0x3,%edx
80104ce3:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104ce6:	e8 a1 f7 ff ff       	call   8010448c <create>
     argint(2, &minor) < 0 ||
80104ceb:	83 c4 10             	add    $0x10,%esp
80104cee:	85 c0                	test   %eax,%eax
80104cf0:	74 16                	je     80104d08 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80104cf2:	83 ec 0c             	sub    $0xc,%esp
80104cf5:	50                   	push   %eax
80104cf6:	e8 35 cb ff ff       	call   80101830 <iunlockput>
  end_op();
80104cfb:	e8 28 dd ff ff       	call   80102a28 <end_op>
  return 0;
80104d00:	83 c4 10             	add    $0x10,%esp
80104d03:	31 c0                	xor    %eax,%eax
}
80104d05:	c9                   	leave
80104d06:	c3                   	ret
80104d07:	90                   	nop
    end_op();
80104d08:	e8 1b dd ff ff       	call   80102a28 <end_op>
    return -1;
80104d0d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d12:	c9                   	leave
80104d13:	c3                   	ret

80104d14 <sys_chdir>:

int
sys_chdir(void)
{
80104d14:	55                   	push   %ebp
80104d15:	89 e5                	mov    %esp,%ebp
80104d17:	56                   	push   %esi
80104d18:	53                   	push   %ebx
80104d19:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80104d1c:	e8 e7 e7 ff ff       	call   80103508 <myproc>
80104d21:	89 c6                	mov    %eax,%esi
  
  begin_op();
80104d23:	e8 98 dc ff ff       	call   801029c0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80104d28:	83 ec 08             	sub    $0x8,%esp
80104d2b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d2e:	50                   	push   %eax
80104d2f:	6a 00                	push   $0x0
80104d31:	e8 9a f6 ff ff       	call   801043d0 <argstr>
80104d36:	83 c4 10             	add    $0x10,%esp
80104d39:	85 c0                	test   %eax,%eax
80104d3b:	78 67                	js     80104da4 <sys_chdir+0x90>
80104d3d:	83 ec 0c             	sub    $0xc,%esp
80104d40:	ff 75 f4             	push   -0xc(%ebp)
80104d43:	e8 e4 d0 ff ff       	call   80101e2c <namei>
80104d48:	89 c3                	mov    %eax,%ebx
80104d4a:	83 c4 10             	add    $0x10,%esp
80104d4d:	85 c0                	test   %eax,%eax
80104d4f:	74 53                	je     80104da4 <sys_chdir+0x90>
    end_op();
    return -1;
  }
  ilock(ip);
80104d51:	83 ec 0c             	sub    $0xc,%esp
80104d54:	50                   	push   %eax
80104d55:	e8 82 c8 ff ff       	call   801015dc <ilock>
  if(ip->type != T_DIR){
80104d5a:	83 c4 10             	add    $0x10,%esp
80104d5d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104d62:	75 28                	jne    80104d8c <sys_chdir+0x78>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104d64:	83 ec 0c             	sub    $0xc,%esp
80104d67:	53                   	push   %ebx
80104d68:	e8 37 c9 ff ff       	call   801016a4 <iunlock>
  iput(curproc->cwd);
80104d6d:	58                   	pop    %eax
80104d6e:	ff 76 68             	push   0x68(%esi)
80104d71:	e8 72 c9 ff ff       	call   801016e8 <iput>
  end_op();
80104d76:	e8 ad dc ff ff       	call   80102a28 <end_op>
  curproc->cwd = ip;
80104d7b:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80104d7e:	83 c4 10             	add    $0x10,%esp
80104d81:	31 c0                	xor    %eax,%eax
}
80104d83:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d86:	5b                   	pop    %ebx
80104d87:	5e                   	pop    %esi
80104d88:	5d                   	pop    %ebp
80104d89:	c3                   	ret
80104d8a:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104d8c:	83 ec 0c             	sub    $0xc,%esp
80104d8f:	53                   	push   %ebx
80104d90:	e8 9b ca ff ff       	call   80101830 <iunlockput>
    end_op();
80104d95:	e8 8e dc ff ff       	call   80102a28 <end_op>
    return -1;
80104d9a:	83 c4 10             	add    $0x10,%esp
    return -1;
80104d9d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104da2:	eb df                	jmp    80104d83 <sys_chdir+0x6f>
    end_op();
80104da4:	e8 7f dc ff ff       	call   80102a28 <end_op>
    return -1;
80104da9:	eb f2                	jmp    80104d9d <sys_chdir+0x89>
80104dab:	90                   	nop

80104dac <sys_exec>:

int
sys_exec(void)
{
80104dac:	55                   	push   %ebp
80104dad:	89 e5                	mov    %esp,%ebp
80104daf:	57                   	push   %edi
80104db0:	56                   	push   %esi
80104db1:	53                   	push   %ebx
80104db2:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80104db8:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80104dbe:	50                   	push   %eax
80104dbf:	6a 00                	push   $0x0
80104dc1:	e8 0a f6 ff ff       	call   801043d0 <argstr>
80104dc6:	83 c4 10             	add    $0x10,%esp
80104dc9:	85 c0                	test   %eax,%eax
80104dcb:	78 79                	js     80104e46 <sys_exec+0x9a>
80104dcd:	83 ec 08             	sub    $0x8,%esp
80104dd0:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80104dd6:	50                   	push   %eax
80104dd7:	6a 01                	push   $0x1
80104dd9:	e8 46 f5 ff ff       	call   80104324 <argint>
80104dde:	83 c4 10             	add    $0x10,%esp
80104de1:	85 c0                	test   %eax,%eax
80104de3:	78 61                	js     80104e46 <sys_exec+0x9a>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80104de5:	50                   	push   %eax
80104de6:	68 80 00 00 00       	push   $0x80
80104deb:	6a 00                	push   $0x0
80104ded:	8d bd 68 ff ff ff    	lea    -0x98(%ebp),%edi
80104df3:	57                   	push   %edi
80104df4:	e8 0f f3 ff ff       	call   80104108 <memset>
80104df9:	83 c4 10             	add    $0x10,%esp
80104dfc:	31 db                	xor    %ebx,%ebx
  for(i=0;; i++){
80104dfe:	31 f6                	xor    %esi,%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80104e00:	83 ec 08             	sub    $0x8,%esp
80104e03:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80104e09:	50                   	push   %eax
80104e0a:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80104e10:	01 d8                	add    %ebx,%eax
80104e12:	50                   	push   %eax
80104e13:	e8 9c f4 ff ff       	call   801042b4 <fetchint>
80104e18:	83 c4 10             	add    $0x10,%esp
80104e1b:	85 c0                	test   %eax,%eax
80104e1d:	78 27                	js     80104e46 <sys_exec+0x9a>
      return -1;
    if(uarg == 0){
80104e1f:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80104e25:	85 c0                	test   %eax,%eax
80104e27:	74 2b                	je     80104e54 <sys_exec+0xa8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80104e29:	83 ec 08             	sub    $0x8,%esp
80104e2c:	8d 14 1f             	lea    (%edi,%ebx,1),%edx
80104e2f:	52                   	push   %edx
80104e30:	50                   	push   %eax
80104e31:	e8 ae f4 ff ff       	call   801042e4 <fetchstr>
80104e36:	83 c4 10             	add    $0x10,%esp
80104e39:	85 c0                	test   %eax,%eax
80104e3b:	78 09                	js     80104e46 <sys_exec+0x9a>
  for(i=0;; i++){
80104e3d:	46                   	inc    %esi
    if(i >= NELEM(argv))
80104e3e:	83 c3 04             	add    $0x4,%ebx
80104e41:	83 fe 20             	cmp    $0x20,%esi
80104e44:	75 ba                	jne    80104e00 <sys_exec+0x54>
    return -1;
80104e46:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return -1;
  }
  return exec(path, argv);
}
80104e4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e4e:	5b                   	pop    %ebx
80104e4f:	5e                   	pop    %esi
80104e50:	5f                   	pop    %edi
80104e51:	5d                   	pop    %ebp
80104e52:	c3                   	ret
80104e53:	90                   	nop
      argv[i] = 0;
80104e54:	c7 84 b5 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%esi,4)
80104e5b:	00 00 00 00 
  return exec(path, argv);
80104e5f:	83 ec 08             	sub    $0x8,%esp
80104e62:	57                   	push   %edi
80104e63:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80104e69:	e8 7a bb ff ff       	call   801009e8 <exec>
80104e6e:	83 c4 10             	add    $0x10,%esp
}
80104e71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e74:	5b                   	pop    %ebx
80104e75:	5e                   	pop    %esi
80104e76:	5f                   	pop    %edi
80104e77:	5d                   	pop    %ebp
80104e78:	c3                   	ret
80104e79:	8d 76 00             	lea    0x0(%esi),%esi

80104e7c <sys_pipe>:

int
sys_pipe(void)
{
80104e7c:	55                   	push   %ebp
80104e7d:	89 e5                	mov    %esp,%ebp
80104e7f:	57                   	push   %edi
80104e80:	56                   	push   %esi
80104e81:	53                   	push   %ebx
80104e82:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80104e85:	6a 08                	push   $0x8
80104e87:	8d 45 dc             	lea    -0x24(%ebp),%eax
80104e8a:	50                   	push   %eax
80104e8b:	6a 00                	push   $0x0
80104e8d:	e8 d6 f4 ff ff       	call   80104368 <argptr>
80104e92:	83 c4 10             	add    $0x10,%esp
80104e95:	85 c0                	test   %eax,%eax
80104e97:	78 7d                	js     80104f16 <sys_pipe+0x9a>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80104e99:	83 ec 08             	sub    $0x8,%esp
80104e9c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104e9f:	50                   	push   %eax
80104ea0:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104ea3:	50                   	push   %eax
80104ea4:	e8 37 e1 ff ff       	call   80102fe0 <pipealloc>
80104ea9:	83 c4 10             	add    $0x10,%esp
80104eac:	85 c0                	test   %eax,%eax
80104eae:	78 66                	js     80104f16 <sys_pipe+0x9a>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80104eb0:	8b 7d e0             	mov    -0x20(%ebp),%edi
  struct proc *curproc = myproc();
80104eb3:	e8 50 e6 ff ff       	call   80103508 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104eb8:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80104eba:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80104ebe:	85 f6                	test   %esi,%esi
80104ec0:	74 10                	je     80104ed2 <sys_pipe+0x56>
80104ec2:	66 90                	xchg   %ax,%ax
  for(fd = 0; fd < NOFILE; fd++){
80104ec4:	43                   	inc    %ebx
80104ec5:	83 fb 10             	cmp    $0x10,%ebx
80104ec8:	74 35                	je     80104eff <sys_pipe+0x83>
    if(curproc->ofile[fd] == 0){
80104eca:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80104ece:	85 f6                	test   %esi,%esi
80104ed0:	75 f2                	jne    80104ec4 <sys_pipe+0x48>
      curproc->ofile[fd] = f;
80104ed2:	8d 73 08             	lea    0x8(%ebx),%esi
80104ed5:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80104ed9:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80104edc:	e8 27 e6 ff ff       	call   80103508 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104ee1:	31 d2                	xor    %edx,%edx
80104ee3:	90                   	nop
    if(curproc->ofile[fd] == 0){
80104ee4:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80104ee8:	85 c9                	test   %ecx,%ecx
80104eea:	74 34                	je     80104f20 <sys_pipe+0xa4>
  for(fd = 0; fd < NOFILE; fd++){
80104eec:	42                   	inc    %edx
80104eed:	83 fa 10             	cmp    $0x10,%edx
80104ef0:	75 f2                	jne    80104ee4 <sys_pipe+0x68>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80104ef2:	e8 11 e6 ff ff       	call   80103508 <myproc>
80104ef7:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80104efe:	00 
    fileclose(rf);
80104eff:	83 ec 0c             	sub    $0xc,%esp
80104f02:	ff 75 e0             	push   -0x20(%ebp)
80104f05:	e8 02 bf ff ff       	call   80100e0c <fileclose>
    fileclose(wf);
80104f0a:	58                   	pop    %eax
80104f0b:	ff 75 e4             	push   -0x1c(%ebp)
80104f0e:	e8 f9 be ff ff       	call   80100e0c <fileclose>
    return -1;
80104f13:	83 c4 10             	add    $0x10,%esp
    return -1;
80104f16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f1b:	eb 14                	jmp    80104f31 <sys_pipe+0xb5>
80104f1d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80104f20:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80104f24:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104f27:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80104f29:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104f2c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80104f2f:	31 c0                	xor    %eax,%eax
}
80104f31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f34:	5b                   	pop    %ebx
80104f35:	5e                   	pop    %esi
80104f36:	5f                   	pop    %edi
80104f37:	5d                   	pop    %ebp
80104f38:	c3                   	ret
80104f39:	66 90                	xchg   %ax,%ax
80104f3b:	90                   	nop

80104f3c <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80104f3c:	e9 3f e7 ff ff       	jmp    80103680 <fork>
80104f41:	8d 76 00             	lea    0x0(%esi),%esi

80104f44 <sys_exit>:
}

int
sys_exit(void)
{
80104f44:	55                   	push   %ebp
80104f45:	89 e5                	mov    %esp,%ebp
80104f47:	83 ec 08             	sub    $0x8,%esp
  exit();
80104f4a:	e8 49 e9 ff ff       	call   80103898 <exit>
  return 0;  // not reached
}
80104f4f:	31 c0                	xor    %eax,%eax
80104f51:	c9                   	leave
80104f52:	c3                   	ret
80104f53:	90                   	nop

80104f54 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80104f54:	e9 4f ea ff ff       	jmp    801039a8 <wait>
80104f59:	8d 76 00             	lea    0x0(%esi),%esi

80104f5c <sys_kill>:
}

int
sys_kill(void)
{
80104f5c:	55                   	push   %ebp
80104f5d:	89 e5                	mov    %esp,%ebp
80104f5f:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80104f62:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f65:	50                   	push   %eax
80104f66:	6a 00                	push   $0x0
80104f68:	e8 b7 f3 ff ff       	call   80104324 <argint>
80104f6d:	83 c4 10             	add    $0x10,%esp
80104f70:	85 c0                	test   %eax,%eax
80104f72:	78 10                	js     80104f84 <sys_kill+0x28>
    return -1;
  return kill(pid);
80104f74:	83 ec 0c             	sub    $0xc,%esp
80104f77:	ff 75 f4             	push   -0xc(%ebp)
80104f7a:	e8 a5 ec ff ff       	call   80103c24 <kill>
80104f7f:	83 c4 10             	add    $0x10,%esp
}
80104f82:	c9                   	leave
80104f83:	c3                   	ret
    return -1;
80104f84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f89:	c9                   	leave
80104f8a:	c3                   	ret
80104f8b:	90                   	nop

80104f8c <sys_getpid>:

int
sys_getpid(void)
{
80104f8c:	55                   	push   %ebp
80104f8d:	89 e5                	mov    %esp,%ebp
80104f8f:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80104f92:	e8 71 e5 ff ff       	call   80103508 <myproc>
80104f97:	8b 40 10             	mov    0x10(%eax),%eax
}
80104f9a:	c9                   	leave
80104f9b:	c3                   	ret

80104f9c <sys_sbrk>:

int
sys_sbrk(void)
{
80104f9c:	55                   	push   %ebp
80104f9d:	89 e5                	mov    %esp,%ebp
80104f9f:	53                   	push   %ebx
80104fa0:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80104fa3:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104fa6:	50                   	push   %eax
80104fa7:	6a 00                	push   $0x0
80104fa9:	e8 76 f3 ff ff       	call   80104324 <argint>
80104fae:	83 c4 10             	add    $0x10,%esp
80104fb1:	85 c0                	test   %eax,%eax
80104fb3:	78 23                	js     80104fd8 <sys_sbrk+0x3c>
    return -1;
  addr = myproc()->sz;
80104fb5:	e8 4e e5 ff ff       	call   80103508 <myproc>
80104fba:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80104fbc:	83 ec 0c             	sub    $0xc,%esp
80104fbf:	ff 75 f4             	push   -0xc(%ebp)
80104fc2:	e8 49 e6 ff ff       	call   80103610 <growproc>
80104fc7:	83 c4 10             	add    $0x10,%esp
80104fca:	85 c0                	test   %eax,%eax
80104fcc:	78 0a                	js     80104fd8 <sys_sbrk+0x3c>
    return -1;
  return addr;
}
80104fce:	89 d8                	mov    %ebx,%eax
80104fd0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fd3:	c9                   	leave
80104fd4:	c3                   	ret
80104fd5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104fd8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104fdd:	eb ef                	jmp    80104fce <sys_sbrk+0x32>
80104fdf:	90                   	nop

80104fe0 <sys_sleep>:

int
sys_sleep(void)
{
80104fe0:	55                   	push   %ebp
80104fe1:	89 e5                	mov    %esp,%ebp
80104fe3:	53                   	push   %ebx
80104fe4:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80104fe7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104fea:	50                   	push   %eax
80104feb:	6a 00                	push   $0x0
80104fed:	e8 32 f3 ff ff       	call   80104324 <argint>
80104ff2:	83 c4 10             	add    $0x10,%esp
80104ff5:	85 c0                	test   %eax,%eax
80104ff7:	78 5c                	js     80105055 <sys_sleep+0x75>
    return -1;
  acquire(&tickslock);
80104ff9:	83 ec 0c             	sub    $0xc,%esp
80104ffc:	68 80 3c 11 80       	push   $0x80113c80
80105001:	e8 26 f0 ff ff       	call   8010402c <acquire>
  ticks0 = ticks;
80105006:	8b 1d 60 3c 11 80    	mov    0x80113c60,%ebx
  while(ticks - ticks0 < n){
8010500c:	83 c4 10             	add    $0x10,%esp
8010500f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105012:	85 d2                	test   %edx,%edx
80105014:	75 23                	jne    80105039 <sys_sleep+0x59>
80105016:	eb 48                	jmp    80105060 <sys_sleep+0x80>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105018:	83 ec 08             	sub    $0x8,%esp
8010501b:	68 80 3c 11 80       	push   $0x80113c80
80105020:	68 60 3c 11 80       	push   $0x80113c60
80105025:	e8 e6 ea ff ff       	call   80103b10 <sleep>
  while(ticks - ticks0 < n){
8010502a:	a1 60 3c 11 80       	mov    0x80113c60,%eax
8010502f:	29 d8                	sub    %ebx,%eax
80105031:	83 c4 10             	add    $0x10,%esp
80105034:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105037:	73 27                	jae    80105060 <sys_sleep+0x80>
    if(myproc()->killed){
80105039:	e8 ca e4 ff ff       	call   80103508 <myproc>
8010503e:	8b 40 24             	mov    0x24(%eax),%eax
80105041:	85 c0                	test   %eax,%eax
80105043:	74 d3                	je     80105018 <sys_sleep+0x38>
      release(&tickslock);
80105045:	83 ec 0c             	sub    $0xc,%esp
80105048:	68 80 3c 11 80       	push   $0x80113c80
8010504d:	e8 7a ef ff ff       	call   80103fcc <release>
      return -1;
80105052:	83 c4 10             	add    $0x10,%esp
    return -1;
80105055:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
8010505a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010505d:	c9                   	leave
8010505e:	c3                   	ret
8010505f:	90                   	nop
  release(&tickslock);
80105060:	83 ec 0c             	sub    $0xc,%esp
80105063:	68 80 3c 11 80       	push   $0x80113c80
80105068:	e8 5f ef ff ff       	call   80103fcc <release>
  return 0;
8010506d:	83 c4 10             	add    $0x10,%esp
80105070:	31 c0                	xor    %eax,%eax
}
80105072:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105075:	c9                   	leave
80105076:	c3                   	ret
80105077:	90                   	nop

80105078 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105078:	55                   	push   %ebp
80105079:	89 e5                	mov    %esp,%ebp
8010507b:	53                   	push   %ebx
8010507c:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
8010507f:	68 80 3c 11 80       	push   $0x80113c80
80105084:	e8 a3 ef ff ff       	call   8010402c <acquire>
  xticks = ticks;
80105089:	8b 1d 60 3c 11 80    	mov    0x80113c60,%ebx
  release(&tickslock);
8010508f:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
80105096:	e8 31 ef ff ff       	call   80103fcc <release>
  return xticks;
}
8010509b:	89 d8                	mov    %ebx,%eax
8010509d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801050a0:	c9                   	leave
801050a1:	c3                   	ret
801050a2:	66 90                	xchg   %ax,%ax

801050a4 <sys_countfp>:

// pj4
int
sys_countfp(void)
{
  return countfp();
801050a4:	e9 13 d3 ff ff       	jmp    801023bc <countfp>

801050a9 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801050a9:	1e                   	push   %ds
  pushl %es
801050aa:	06                   	push   %es
  pushl %fs
801050ab:	0f a0                	push   %fs
  pushl %gs
801050ad:	0f a8                	push   %gs
  pushal
801050af:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801050b0:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801050b4:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801050b6:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801050b8:	54                   	push   %esp
  call trap
801050b9:	e8 9e 00 00 00       	call   8010515c <trap>
  addl $4, %esp
801050be:	83 c4 04             	add    $0x4,%esp

801050c1 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801050c1:	61                   	popa
  popl %gs
801050c2:	0f a9                	pop    %gs
  popl %fs
801050c4:	0f a1                	pop    %fs
  popl %es
801050c6:	07                   	pop    %es
  popl %ds
801050c7:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801050c8:	83 c4 08             	add    $0x8,%esp
  iret
801050cb:	cf                   	iret

801050cc <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801050cc:	55                   	push   %ebp
801050cd:	89 e5                	mov    %esp,%ebp
801050cf:	83 ec 08             	sub    $0x8,%esp
  int i;

  for(i = 0; i < 256; i++)
801050d2:	31 c0                	xor    %eax,%eax
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801050d4:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
801050db:	66 89 14 c5 c0 3c 11 	mov    %dx,-0x7feec340(,%eax,8)
801050e2:	80 
801050e3:	c7 04 c5 c2 3c 11 80 	movl   $0x8e000008,-0x7feec33e(,%eax,8)
801050ea:	08 00 00 8e 
801050ee:	c1 ea 10             	shr    $0x10,%edx
801050f1:	66 89 14 c5 c6 3c 11 	mov    %dx,-0x7feec33a(,%eax,8)
801050f8:	80 
  for(i = 0; i < 256; i++)
801050f9:	40                   	inc    %eax
801050fa:	3d 00 01 00 00       	cmp    $0x100,%eax
801050ff:	75 d3                	jne    801050d4 <tvinit+0x8>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105101:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105106:	66 a3 c0 3e 11 80    	mov    %ax,0x80113ec0
8010510c:	c7 05 c2 3e 11 80 08 	movl   $0xef000008,0x80113ec2
80105113:	00 00 ef 
80105116:	c1 e8 10             	shr    $0x10,%eax
80105119:	66 a3 c6 3e 11 80    	mov    %ax,0x80113ec6

  initlock(&tickslock, "time");
8010511f:	83 ec 08             	sub    $0x8,%esp
80105122:	68 8e 6c 10 80       	push   $0x80106c8e
80105127:	68 80 3c 11 80       	push   $0x80113c80
8010512c:	e8 23 ed ff ff       	call   80103e54 <initlock>
}
80105131:	83 c4 10             	add    $0x10,%esp
80105134:	c9                   	leave
80105135:	c3                   	ret
80105136:	66 90                	xchg   %ax,%ax

80105138 <idtinit>:

void
idtinit(void)
{
80105138:	55                   	push   %ebp
80105139:	89 e5                	mov    %esp,%ebp
8010513b:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
8010513e:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80105144:	b8 c0 3c 11 80       	mov    $0x80113cc0,%eax
80105149:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010514d:	c1 e8 10             	shr    $0x10,%eax
80105150:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105154:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105157:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
8010515a:	c9                   	leave
8010515b:	c3                   	ret

8010515c <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
8010515c:	55                   	push   %ebp
8010515d:	89 e5                	mov    %esp,%ebp
8010515f:	57                   	push   %edi
80105160:	56                   	push   %esi
80105161:	53                   	push   %ebx
80105162:	83 ec 1c             	sub    $0x1c,%esp
80105165:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105168:	8b 43 30             	mov    0x30(%ebx),%eax
8010516b:	83 f8 40             	cmp    $0x40,%eax
8010516e:	0f 84 20 01 00 00    	je     80105294 <trap+0x138>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105174:	83 e8 0e             	sub    $0xe,%eax
80105177:	83 f8 31             	cmp    $0x31,%eax
8010517a:	0f 87 80 00 00 00    	ja     80105200 <trap+0xa4>
80105180:	ff 24 85 fc 71 10 80 	jmp    *-0x7fef8e04(,%eax,4)
80105187:	90                   	nop
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105188:	e8 47 e3 ff ff       	call   801034d4 <cpuid>
8010518d:	85 c0                	test   %eax,%eax
8010518f:	0f 84 ef 01 00 00    	je     80105384 <trap+0x228>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105195:	e8 5a d4 ff ff       	call   801025f4 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010519a:	e8 69 e3 ff ff       	call   80103508 <myproc>
8010519f:	85 c0                	test   %eax,%eax
801051a1:	74 19                	je     801051bc <trap+0x60>
801051a3:	e8 60 e3 ff ff       	call   80103508 <myproc>
801051a8:	8b 50 24             	mov    0x24(%eax),%edx
801051ab:	85 d2                	test   %edx,%edx
801051ad:	74 0d                	je     801051bc <trap+0x60>
801051af:	8b 43 3c             	mov    0x3c(%ebx),%eax
801051b2:	f7 d0                	not    %eax
801051b4:	a8 03                	test   $0x3,%al
801051b6:	0f 84 b0 01 00 00    	je     8010536c <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801051bc:	e8 47 e3 ff ff       	call   80103508 <myproc>
801051c1:	85 c0                	test   %eax,%eax
801051c3:	74 0f                	je     801051d4 <trap+0x78>
801051c5:	e8 3e e3 ff ff       	call   80103508 <myproc>
801051ca:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801051ce:	0f 84 ac 00 00 00    	je     80105280 <trap+0x124>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801051d4:	e8 2f e3 ff ff       	call   80103508 <myproc>
801051d9:	85 c0                	test   %eax,%eax
801051db:	74 19                	je     801051f6 <trap+0x9a>
801051dd:	e8 26 e3 ff ff       	call   80103508 <myproc>
801051e2:	8b 40 24             	mov    0x24(%eax),%eax
801051e5:	85 c0                	test   %eax,%eax
801051e7:	74 0d                	je     801051f6 <trap+0x9a>
801051e9:	8b 43 3c             	mov    0x3c(%ebx),%eax
801051ec:	f7 d0                	not    %eax
801051ee:	a8 03                	test   $0x3,%al
801051f0:	0f 84 cb 00 00 00    	je     801052c1 <trap+0x165>
    exit();
}
801051f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051f9:	5b                   	pop    %ebx
801051fa:	5e                   	pop    %esi
801051fb:	5f                   	pop    %edi
801051fc:	5d                   	pop    %ebp
801051fd:	c3                   	ret
801051fe:	66 90                	xchg   %ax,%ax
    if(myproc() == 0 || (tf->cs&3) == 0){
80105200:	e8 03 e3 ff ff       	call   80103508 <myproc>
80105205:	8b 7b 38             	mov    0x38(%ebx),%edi
80105208:	85 c0                	test   %eax,%eax
8010520a:	0f 84 a7 01 00 00    	je     801053b7 <trap+0x25b>
80105210:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105214:	0f 84 9d 01 00 00    	je     801053b7 <trap+0x25b>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010521a:	0f 20 d1             	mov    %cr2,%ecx
8010521d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105220:	e8 af e2 ff ff       	call   801034d4 <cpuid>
80105225:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105228:	8b 43 34             	mov    0x34(%ebx),%eax
8010522b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010522e:	8b 73 30             	mov    0x30(%ebx),%esi
            myproc()->pid, myproc()->name, tf->trapno,
80105231:	e8 d2 e2 ff ff       	call   80103508 <myproc>
80105236:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105239:	e8 ca e2 ff ff       	call   80103508 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010523e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105241:	51                   	push   %ecx
80105242:	57                   	push   %edi
80105243:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105246:	52                   	push   %edx
80105247:	ff 75 e4             	push   -0x1c(%ebp)
8010524a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010524b:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010524e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105251:	56                   	push   %esi
80105252:	ff 70 10             	push   0x10(%eax)
80105255:	68 ec 6e 10 80       	push   $0x80106eec
8010525a:	e8 c9 b3 ff ff       	call   80100628 <cprintf>
    myproc()->killed = 1;
8010525f:	83 c4 20             	add    $0x20,%esp
80105262:	e8 a1 e2 ff ff       	call   80103508 <myproc>
80105267:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010526e:	e8 95 e2 ff ff       	call   80103508 <myproc>
80105273:	85 c0                	test   %eax,%eax
80105275:	0f 85 28 ff ff ff    	jne    801051a3 <trap+0x47>
8010527b:	e9 3c ff ff ff       	jmp    801051bc <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
80105280:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105284:	0f 85 4a ff ff ff    	jne    801051d4 <trap+0x78>
    yield();
8010528a:	e8 39 e8 ff ff       	call   80103ac8 <yield>
8010528f:	e9 40 ff ff ff       	jmp    801051d4 <trap+0x78>
    if(myproc()->killed)
80105294:	e8 6f e2 ff ff       	call   80103508 <myproc>
80105299:	8b 70 24             	mov    0x24(%eax),%esi
8010529c:	85 f6                	test   %esi,%esi
8010529e:	0f 85 d4 00 00 00    	jne    80105378 <trap+0x21c>
    myproc()->tf = tf;
801052a4:	e8 5f e2 ff ff       	call   80103508 <myproc>
801052a9:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801052ac:	e8 83 f1 ff ff       	call   80104434 <syscall>
    if(myproc()->killed)
801052b1:	e8 52 e2 ff ff       	call   80103508 <myproc>
801052b6:	8b 48 24             	mov    0x24(%eax),%ecx
801052b9:	85 c9                	test   %ecx,%ecx
801052bb:	0f 84 35 ff ff ff    	je     801051f6 <trap+0x9a>
}
801052c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052c4:	5b                   	pop    %ebx
801052c5:	5e                   	pop    %esi
801052c6:	5f                   	pop    %edi
801052c7:	5d                   	pop    %ebp
      exit();
801052c8:	e9 cb e5 ff ff       	jmp    80103898 <exit>
801052cd:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801052d0:	8b 7b 38             	mov    0x38(%ebx),%edi
801052d3:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801052d7:	e8 f8 e1 ff ff       	call   801034d4 <cpuid>
801052dc:	57                   	push   %edi
801052dd:	56                   	push   %esi
801052de:	50                   	push   %eax
801052df:	68 94 6e 10 80       	push   $0x80106e94
801052e4:	e8 3f b3 ff ff       	call   80100628 <cprintf>
    lapiceoi();
801052e9:	e8 06 d3 ff ff       	call   801025f4 <lapiceoi>
    break;
801052ee:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801052f1:	e8 12 e2 ff ff       	call   80103508 <myproc>
801052f6:	85 c0                	test   %eax,%eax
801052f8:	0f 85 a5 fe ff ff    	jne    801051a3 <trap+0x47>
801052fe:	e9 b9 fe ff ff       	jmp    801051bc <trap+0x60>
80105303:	90                   	nop
    kbdintr();
80105304:	e8 df d1 ff ff       	call   801024e8 <kbdintr>
    lapiceoi();
80105309:	e8 e6 d2 ff ff       	call   801025f4 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010530e:	e8 f5 e1 ff ff       	call   80103508 <myproc>
80105313:	85 c0                	test   %eax,%eax
80105315:	0f 85 88 fe ff ff    	jne    801051a3 <trap+0x47>
8010531b:	e9 9c fe ff ff       	jmp    801051bc <trap+0x60>
    uartintr();
80105320:	e8 fb 01 00 00       	call   80105520 <uartintr>
    lapiceoi();
80105325:	e8 ca d2 ff ff       	call   801025f4 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010532a:	e8 d9 e1 ff ff       	call   80103508 <myproc>
8010532f:	85 c0                	test   %eax,%eax
80105331:	0f 85 6c fe ff ff    	jne    801051a3 <trap+0x47>
80105337:	e9 80 fe ff ff       	jmp    801051bc <trap+0x60>
    ideintr();
8010533c:	e8 3f cc ff ff       	call   80101f80 <ideintr>
80105341:	e9 4f fe ff ff       	jmp    80105195 <trap+0x39>
80105346:	66 90                	xchg   %ax,%ax
    cprintf("page fault!\n");
80105348:	83 ec 0c             	sub    $0xc,%esp
8010534b:	68 93 6c 10 80       	push   $0x80106c93
80105350:	e8 d3 b2 ff ff       	call   80100628 <cprintf>
    break;
80105355:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105358:	e8 ab e1 ff ff       	call   80103508 <myproc>
8010535d:	85 c0                	test   %eax,%eax
8010535f:	0f 85 3e fe ff ff    	jne    801051a3 <trap+0x47>
80105365:	e9 52 fe ff ff       	jmp    801051bc <trap+0x60>
8010536a:	66 90                	xchg   %ax,%ax
    exit();
8010536c:	e8 27 e5 ff ff       	call   80103898 <exit>
80105371:	e9 46 fe ff ff       	jmp    801051bc <trap+0x60>
80105376:	66 90                	xchg   %ax,%ax
      exit();
80105378:	e8 1b e5 ff ff       	call   80103898 <exit>
8010537d:	e9 22 ff ff ff       	jmp    801052a4 <trap+0x148>
80105382:	66 90                	xchg   %ax,%ax
      acquire(&tickslock);
80105384:	83 ec 0c             	sub    $0xc,%esp
80105387:	68 80 3c 11 80       	push   $0x80113c80
8010538c:	e8 9b ec ff ff       	call   8010402c <acquire>
      ticks++;
80105391:	ff 05 60 3c 11 80    	incl   0x80113c60
      wakeup(&ticks);
80105397:	c7 04 24 60 3c 11 80 	movl   $0x80113c60,(%esp)
8010539e:	e8 29 e8 ff ff       	call   80103bcc <wakeup>
      release(&tickslock);
801053a3:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
801053aa:	e8 1d ec ff ff       	call   80103fcc <release>
801053af:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
801053b2:	e9 de fd ff ff       	jmp    80105195 <trap+0x39>
801053b7:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801053ba:	e8 15 e1 ff ff       	call   801034d4 <cpuid>
801053bf:	83 ec 0c             	sub    $0xc,%esp
801053c2:	56                   	push   %esi
801053c3:	57                   	push   %edi
801053c4:	50                   	push   %eax
801053c5:	ff 73 30             	push   0x30(%ebx)
801053c8:	68 b8 6e 10 80       	push   $0x80106eb8
801053cd:	e8 56 b2 ff ff       	call   80100628 <cprintf>
      panic("trap");
801053d2:	83 c4 14             	add    $0x14,%esp
801053d5:	68 a0 6c 10 80       	push   $0x80106ca0
801053da:	e8 59 af ff ff       	call   80100338 <panic>
801053df:	90                   	nop

801053e0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801053e0:	a1 c0 44 11 80       	mov    0x801144c0,%eax
801053e5:	85 c0                	test   %eax,%eax
801053e7:	74 17                	je     80105400 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801053e9:	ba fd 03 00 00       	mov    $0x3fd,%edx
801053ee:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801053ef:	a8 01                	test   $0x1,%al
801053f1:	74 0d                	je     80105400 <uartgetc+0x20>
801053f3:	ba f8 03 00 00       	mov    $0x3f8,%edx
801053f8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801053f9:	0f b6 c0             	movzbl %al,%eax
801053fc:	c3                   	ret
801053fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105400:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105405:	c3                   	ret
80105406:	66 90                	xchg   %ax,%ax

80105408 <uartinit>:
{
80105408:	55                   	push   %ebp
80105409:	89 e5                	mov    %esp,%ebp
8010540b:	57                   	push   %edi
8010540c:	56                   	push   %esi
8010540d:	53                   	push   %ebx
8010540e:	83 ec 1c             	sub    $0x1c,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105411:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105416:	31 c0                	xor    %eax,%eax
80105418:	89 fa                	mov    %edi,%edx
8010541a:	ee                   	out    %al,(%dx)
8010541b:	bb fb 03 00 00       	mov    $0x3fb,%ebx
80105420:	b0 80                	mov    $0x80,%al
80105422:	89 da                	mov    %ebx,%edx
80105424:	ee                   	out    %al,(%dx)
80105425:	be f8 03 00 00       	mov    $0x3f8,%esi
8010542a:	b0 0c                	mov    $0xc,%al
8010542c:	89 f2                	mov    %esi,%edx
8010542e:	ee                   	out    %al,(%dx)
8010542f:	b9 f9 03 00 00       	mov    $0x3f9,%ecx
80105434:	31 c0                	xor    %eax,%eax
80105436:	89 ca                	mov    %ecx,%edx
80105438:	ee                   	out    %al,(%dx)
80105439:	b0 03                	mov    $0x3,%al
8010543b:	89 da                	mov    %ebx,%edx
8010543d:	ee                   	out    %al,(%dx)
8010543e:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105443:	31 c0                	xor    %eax,%eax
80105445:	ee                   	out    %al,(%dx)
80105446:	b0 01                	mov    $0x1,%al
80105448:	89 ca                	mov    %ecx,%edx
8010544a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010544b:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105450:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105451:	fe c0                	inc    %al
80105453:	74 71                	je     801054c6 <uartinit+0xbe>
  uart = 1;
80105455:	c7 05 c0 44 11 80 01 	movl   $0x1,0x801144c0
8010545c:	00 00 00 
8010545f:	89 fa                	mov    %edi,%edx
80105461:	ec                   	in     (%dx),%al
80105462:	89 f2                	mov    %esi,%edx
80105464:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105465:	83 ec 08             	sub    $0x8,%esp
80105468:	6a 00                	push   $0x0
8010546a:	6a 04                	push   $0x4
8010546c:	e8 1f cd ff ff       	call   80102190 <ioapicenable>
80105471:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105474:	bf a5 6c 10 80       	mov    $0x80106ca5,%edi
80105479:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
8010547d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105482:	66 90                	xchg   %ax,%ax
  if(!uart)
80105484:	a1 c0 44 11 80       	mov    0x801144c0,%eax
80105489:	85 c0                	test   %eax,%eax
8010548b:	74 2f                	je     801054bc <uartinit+0xb4>
8010548d:	89 f2                	mov    %esi,%edx
8010548f:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105490:	a8 20                	test   $0x20,%al
80105492:	75 1f                	jne    801054b3 <uartinit+0xab>
80105494:	bb 80 00 00 00       	mov    $0x80,%ebx
80105499:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
8010549c:	83 ec 0c             	sub    $0xc,%esp
8010549f:	6a 0a                	push   $0xa
801054a1:	e8 66 d1 ff ff       	call   8010260c <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801054a6:	83 c4 10             	add    $0x10,%esp
801054a9:	4b                   	dec    %ebx
801054aa:	74 07                	je     801054b3 <uartinit+0xab>
801054ac:	89 f2                	mov    %esi,%edx
801054ae:	ec                   	in     (%dx),%al
801054af:	a8 20                	test   $0x20,%al
801054b1:	74 e9                	je     8010549c <uartinit+0x94>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801054b3:	ba f8 03 00 00       	mov    $0x3f8,%edx
801054b8:	8a 45 e7             	mov    -0x19(%ebp),%al
801054bb:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
801054bc:	47                   	inc    %edi
801054bd:	8a 07                	mov    (%edi),%al
801054bf:	88 45 e7             	mov    %al,-0x19(%ebp)
801054c2:	84 c0                	test   %al,%al
801054c4:	75 be                	jne    80105484 <uartinit+0x7c>
}
801054c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054c9:	5b                   	pop    %ebx
801054ca:	5e                   	pop    %esi
801054cb:	5f                   	pop    %edi
801054cc:	5d                   	pop    %ebp
801054cd:	c3                   	ret
801054ce:	66 90                	xchg   %ax,%ax

801054d0 <uartputc>:
  if(!uart)
801054d0:	a1 c0 44 11 80       	mov    0x801144c0,%eax
801054d5:	85 c0                	test   %eax,%eax
801054d7:	74 43                	je     8010551c <uartputc+0x4c>
{
801054d9:	55                   	push   %ebp
801054da:	89 e5                	mov    %esp,%ebp
801054dc:	56                   	push   %esi
801054dd:	53                   	push   %ebx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801054de:	ba fd 03 00 00       	mov    $0x3fd,%edx
801054e3:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801054e4:	a8 20                	test   $0x20,%al
801054e6:	75 23                	jne    8010550b <uartputc+0x3b>
801054e8:	bb 80 00 00 00       	mov    $0x80,%ebx
801054ed:	be fd 03 00 00       	mov    $0x3fd,%esi
801054f2:	66 90                	xchg   %ax,%ax
    microdelay(10);
801054f4:	83 ec 0c             	sub    $0xc,%esp
801054f7:	6a 0a                	push   $0xa
801054f9:	e8 0e d1 ff ff       	call   8010260c <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801054fe:	83 c4 10             	add    $0x10,%esp
80105501:	4b                   	dec    %ebx
80105502:	74 07                	je     8010550b <uartputc+0x3b>
80105504:	89 f2                	mov    %esi,%edx
80105506:	ec                   	in     (%dx),%al
80105507:	a8 20                	test   $0x20,%al
80105509:	74 e9                	je     801054f4 <uartputc+0x24>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010550b:	8b 45 08             	mov    0x8(%ebp),%eax
8010550e:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105513:	ee                   	out    %al,(%dx)
}
80105514:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105517:	5b                   	pop    %ebx
80105518:	5e                   	pop    %esi
80105519:	5d                   	pop    %ebp
8010551a:	c3                   	ret
8010551b:	90                   	nop
8010551c:	c3                   	ret
8010551d:	8d 76 00             	lea    0x0(%esi),%esi

80105520 <uartintr>:

void
uartintr(void)
{
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105526:	68 e0 53 10 80       	push   $0x801053e0
8010552b:	e8 b8 b2 ff ff       	call   801007e8 <consoleintr>
}
80105530:	83 c4 10             	add    $0x10,%esp
80105533:	c9                   	leave
80105534:	c3                   	ret

80105535 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105535:	6a 00                	push   $0x0
  pushl $0
80105537:	6a 00                	push   $0x0
  jmp alltraps
80105539:	e9 6b fb ff ff       	jmp    801050a9 <alltraps>

8010553e <vector1>:
.globl vector1
vector1:
  pushl $0
8010553e:	6a 00                	push   $0x0
  pushl $1
80105540:	6a 01                	push   $0x1
  jmp alltraps
80105542:	e9 62 fb ff ff       	jmp    801050a9 <alltraps>

80105547 <vector2>:
.globl vector2
vector2:
  pushl $0
80105547:	6a 00                	push   $0x0
  pushl $2
80105549:	6a 02                	push   $0x2
  jmp alltraps
8010554b:	e9 59 fb ff ff       	jmp    801050a9 <alltraps>

80105550 <vector3>:
.globl vector3
vector3:
  pushl $0
80105550:	6a 00                	push   $0x0
  pushl $3
80105552:	6a 03                	push   $0x3
  jmp alltraps
80105554:	e9 50 fb ff ff       	jmp    801050a9 <alltraps>

80105559 <vector4>:
.globl vector4
vector4:
  pushl $0
80105559:	6a 00                	push   $0x0
  pushl $4
8010555b:	6a 04                	push   $0x4
  jmp alltraps
8010555d:	e9 47 fb ff ff       	jmp    801050a9 <alltraps>

80105562 <vector5>:
.globl vector5
vector5:
  pushl $0
80105562:	6a 00                	push   $0x0
  pushl $5
80105564:	6a 05                	push   $0x5
  jmp alltraps
80105566:	e9 3e fb ff ff       	jmp    801050a9 <alltraps>

8010556b <vector6>:
.globl vector6
vector6:
  pushl $0
8010556b:	6a 00                	push   $0x0
  pushl $6
8010556d:	6a 06                	push   $0x6
  jmp alltraps
8010556f:	e9 35 fb ff ff       	jmp    801050a9 <alltraps>

80105574 <vector7>:
.globl vector7
vector7:
  pushl $0
80105574:	6a 00                	push   $0x0
  pushl $7
80105576:	6a 07                	push   $0x7
  jmp alltraps
80105578:	e9 2c fb ff ff       	jmp    801050a9 <alltraps>

8010557d <vector8>:
.globl vector8
vector8:
  pushl $8
8010557d:	6a 08                	push   $0x8
  jmp alltraps
8010557f:	e9 25 fb ff ff       	jmp    801050a9 <alltraps>

80105584 <vector9>:
.globl vector9
vector9:
  pushl $0
80105584:	6a 00                	push   $0x0
  pushl $9
80105586:	6a 09                	push   $0x9
  jmp alltraps
80105588:	e9 1c fb ff ff       	jmp    801050a9 <alltraps>

8010558d <vector10>:
.globl vector10
vector10:
  pushl $10
8010558d:	6a 0a                	push   $0xa
  jmp alltraps
8010558f:	e9 15 fb ff ff       	jmp    801050a9 <alltraps>

80105594 <vector11>:
.globl vector11
vector11:
  pushl $11
80105594:	6a 0b                	push   $0xb
  jmp alltraps
80105596:	e9 0e fb ff ff       	jmp    801050a9 <alltraps>

8010559b <vector12>:
.globl vector12
vector12:
  pushl $12
8010559b:	6a 0c                	push   $0xc
  jmp alltraps
8010559d:	e9 07 fb ff ff       	jmp    801050a9 <alltraps>

801055a2 <vector13>:
.globl vector13
vector13:
  pushl $13
801055a2:	6a 0d                	push   $0xd
  jmp alltraps
801055a4:	e9 00 fb ff ff       	jmp    801050a9 <alltraps>

801055a9 <vector14>:
.globl vector14
vector14:
  pushl $14
801055a9:	6a 0e                	push   $0xe
  jmp alltraps
801055ab:	e9 f9 fa ff ff       	jmp    801050a9 <alltraps>

801055b0 <vector15>:
.globl vector15
vector15:
  pushl $0
801055b0:	6a 00                	push   $0x0
  pushl $15
801055b2:	6a 0f                	push   $0xf
  jmp alltraps
801055b4:	e9 f0 fa ff ff       	jmp    801050a9 <alltraps>

801055b9 <vector16>:
.globl vector16
vector16:
  pushl $0
801055b9:	6a 00                	push   $0x0
  pushl $16
801055bb:	6a 10                	push   $0x10
  jmp alltraps
801055bd:	e9 e7 fa ff ff       	jmp    801050a9 <alltraps>

801055c2 <vector17>:
.globl vector17
vector17:
  pushl $17
801055c2:	6a 11                	push   $0x11
  jmp alltraps
801055c4:	e9 e0 fa ff ff       	jmp    801050a9 <alltraps>

801055c9 <vector18>:
.globl vector18
vector18:
  pushl $0
801055c9:	6a 00                	push   $0x0
  pushl $18
801055cb:	6a 12                	push   $0x12
  jmp alltraps
801055cd:	e9 d7 fa ff ff       	jmp    801050a9 <alltraps>

801055d2 <vector19>:
.globl vector19
vector19:
  pushl $0
801055d2:	6a 00                	push   $0x0
  pushl $19
801055d4:	6a 13                	push   $0x13
  jmp alltraps
801055d6:	e9 ce fa ff ff       	jmp    801050a9 <alltraps>

801055db <vector20>:
.globl vector20
vector20:
  pushl $0
801055db:	6a 00                	push   $0x0
  pushl $20
801055dd:	6a 14                	push   $0x14
  jmp alltraps
801055df:	e9 c5 fa ff ff       	jmp    801050a9 <alltraps>

801055e4 <vector21>:
.globl vector21
vector21:
  pushl $0
801055e4:	6a 00                	push   $0x0
  pushl $21
801055e6:	6a 15                	push   $0x15
  jmp alltraps
801055e8:	e9 bc fa ff ff       	jmp    801050a9 <alltraps>

801055ed <vector22>:
.globl vector22
vector22:
  pushl $0
801055ed:	6a 00                	push   $0x0
  pushl $22
801055ef:	6a 16                	push   $0x16
  jmp alltraps
801055f1:	e9 b3 fa ff ff       	jmp    801050a9 <alltraps>

801055f6 <vector23>:
.globl vector23
vector23:
  pushl $0
801055f6:	6a 00                	push   $0x0
  pushl $23
801055f8:	6a 17                	push   $0x17
  jmp alltraps
801055fa:	e9 aa fa ff ff       	jmp    801050a9 <alltraps>

801055ff <vector24>:
.globl vector24
vector24:
  pushl $0
801055ff:	6a 00                	push   $0x0
  pushl $24
80105601:	6a 18                	push   $0x18
  jmp alltraps
80105603:	e9 a1 fa ff ff       	jmp    801050a9 <alltraps>

80105608 <vector25>:
.globl vector25
vector25:
  pushl $0
80105608:	6a 00                	push   $0x0
  pushl $25
8010560a:	6a 19                	push   $0x19
  jmp alltraps
8010560c:	e9 98 fa ff ff       	jmp    801050a9 <alltraps>

80105611 <vector26>:
.globl vector26
vector26:
  pushl $0
80105611:	6a 00                	push   $0x0
  pushl $26
80105613:	6a 1a                	push   $0x1a
  jmp alltraps
80105615:	e9 8f fa ff ff       	jmp    801050a9 <alltraps>

8010561a <vector27>:
.globl vector27
vector27:
  pushl $0
8010561a:	6a 00                	push   $0x0
  pushl $27
8010561c:	6a 1b                	push   $0x1b
  jmp alltraps
8010561e:	e9 86 fa ff ff       	jmp    801050a9 <alltraps>

80105623 <vector28>:
.globl vector28
vector28:
  pushl $0
80105623:	6a 00                	push   $0x0
  pushl $28
80105625:	6a 1c                	push   $0x1c
  jmp alltraps
80105627:	e9 7d fa ff ff       	jmp    801050a9 <alltraps>

8010562c <vector29>:
.globl vector29
vector29:
  pushl $0
8010562c:	6a 00                	push   $0x0
  pushl $29
8010562e:	6a 1d                	push   $0x1d
  jmp alltraps
80105630:	e9 74 fa ff ff       	jmp    801050a9 <alltraps>

80105635 <vector30>:
.globl vector30
vector30:
  pushl $0
80105635:	6a 00                	push   $0x0
  pushl $30
80105637:	6a 1e                	push   $0x1e
  jmp alltraps
80105639:	e9 6b fa ff ff       	jmp    801050a9 <alltraps>

8010563e <vector31>:
.globl vector31
vector31:
  pushl $0
8010563e:	6a 00                	push   $0x0
  pushl $31
80105640:	6a 1f                	push   $0x1f
  jmp alltraps
80105642:	e9 62 fa ff ff       	jmp    801050a9 <alltraps>

80105647 <vector32>:
.globl vector32
vector32:
  pushl $0
80105647:	6a 00                	push   $0x0
  pushl $32
80105649:	6a 20                	push   $0x20
  jmp alltraps
8010564b:	e9 59 fa ff ff       	jmp    801050a9 <alltraps>

80105650 <vector33>:
.globl vector33
vector33:
  pushl $0
80105650:	6a 00                	push   $0x0
  pushl $33
80105652:	6a 21                	push   $0x21
  jmp alltraps
80105654:	e9 50 fa ff ff       	jmp    801050a9 <alltraps>

80105659 <vector34>:
.globl vector34
vector34:
  pushl $0
80105659:	6a 00                	push   $0x0
  pushl $34
8010565b:	6a 22                	push   $0x22
  jmp alltraps
8010565d:	e9 47 fa ff ff       	jmp    801050a9 <alltraps>

80105662 <vector35>:
.globl vector35
vector35:
  pushl $0
80105662:	6a 00                	push   $0x0
  pushl $35
80105664:	6a 23                	push   $0x23
  jmp alltraps
80105666:	e9 3e fa ff ff       	jmp    801050a9 <alltraps>

8010566b <vector36>:
.globl vector36
vector36:
  pushl $0
8010566b:	6a 00                	push   $0x0
  pushl $36
8010566d:	6a 24                	push   $0x24
  jmp alltraps
8010566f:	e9 35 fa ff ff       	jmp    801050a9 <alltraps>

80105674 <vector37>:
.globl vector37
vector37:
  pushl $0
80105674:	6a 00                	push   $0x0
  pushl $37
80105676:	6a 25                	push   $0x25
  jmp alltraps
80105678:	e9 2c fa ff ff       	jmp    801050a9 <alltraps>

8010567d <vector38>:
.globl vector38
vector38:
  pushl $0
8010567d:	6a 00                	push   $0x0
  pushl $38
8010567f:	6a 26                	push   $0x26
  jmp alltraps
80105681:	e9 23 fa ff ff       	jmp    801050a9 <alltraps>

80105686 <vector39>:
.globl vector39
vector39:
  pushl $0
80105686:	6a 00                	push   $0x0
  pushl $39
80105688:	6a 27                	push   $0x27
  jmp alltraps
8010568a:	e9 1a fa ff ff       	jmp    801050a9 <alltraps>

8010568f <vector40>:
.globl vector40
vector40:
  pushl $0
8010568f:	6a 00                	push   $0x0
  pushl $40
80105691:	6a 28                	push   $0x28
  jmp alltraps
80105693:	e9 11 fa ff ff       	jmp    801050a9 <alltraps>

80105698 <vector41>:
.globl vector41
vector41:
  pushl $0
80105698:	6a 00                	push   $0x0
  pushl $41
8010569a:	6a 29                	push   $0x29
  jmp alltraps
8010569c:	e9 08 fa ff ff       	jmp    801050a9 <alltraps>

801056a1 <vector42>:
.globl vector42
vector42:
  pushl $0
801056a1:	6a 00                	push   $0x0
  pushl $42
801056a3:	6a 2a                	push   $0x2a
  jmp alltraps
801056a5:	e9 ff f9 ff ff       	jmp    801050a9 <alltraps>

801056aa <vector43>:
.globl vector43
vector43:
  pushl $0
801056aa:	6a 00                	push   $0x0
  pushl $43
801056ac:	6a 2b                	push   $0x2b
  jmp alltraps
801056ae:	e9 f6 f9 ff ff       	jmp    801050a9 <alltraps>

801056b3 <vector44>:
.globl vector44
vector44:
  pushl $0
801056b3:	6a 00                	push   $0x0
  pushl $44
801056b5:	6a 2c                	push   $0x2c
  jmp alltraps
801056b7:	e9 ed f9 ff ff       	jmp    801050a9 <alltraps>

801056bc <vector45>:
.globl vector45
vector45:
  pushl $0
801056bc:	6a 00                	push   $0x0
  pushl $45
801056be:	6a 2d                	push   $0x2d
  jmp alltraps
801056c0:	e9 e4 f9 ff ff       	jmp    801050a9 <alltraps>

801056c5 <vector46>:
.globl vector46
vector46:
  pushl $0
801056c5:	6a 00                	push   $0x0
  pushl $46
801056c7:	6a 2e                	push   $0x2e
  jmp alltraps
801056c9:	e9 db f9 ff ff       	jmp    801050a9 <alltraps>

801056ce <vector47>:
.globl vector47
vector47:
  pushl $0
801056ce:	6a 00                	push   $0x0
  pushl $47
801056d0:	6a 2f                	push   $0x2f
  jmp alltraps
801056d2:	e9 d2 f9 ff ff       	jmp    801050a9 <alltraps>

801056d7 <vector48>:
.globl vector48
vector48:
  pushl $0
801056d7:	6a 00                	push   $0x0
  pushl $48
801056d9:	6a 30                	push   $0x30
  jmp alltraps
801056db:	e9 c9 f9 ff ff       	jmp    801050a9 <alltraps>

801056e0 <vector49>:
.globl vector49
vector49:
  pushl $0
801056e0:	6a 00                	push   $0x0
  pushl $49
801056e2:	6a 31                	push   $0x31
  jmp alltraps
801056e4:	e9 c0 f9 ff ff       	jmp    801050a9 <alltraps>

801056e9 <vector50>:
.globl vector50
vector50:
  pushl $0
801056e9:	6a 00                	push   $0x0
  pushl $50
801056eb:	6a 32                	push   $0x32
  jmp alltraps
801056ed:	e9 b7 f9 ff ff       	jmp    801050a9 <alltraps>

801056f2 <vector51>:
.globl vector51
vector51:
  pushl $0
801056f2:	6a 00                	push   $0x0
  pushl $51
801056f4:	6a 33                	push   $0x33
  jmp alltraps
801056f6:	e9 ae f9 ff ff       	jmp    801050a9 <alltraps>

801056fb <vector52>:
.globl vector52
vector52:
  pushl $0
801056fb:	6a 00                	push   $0x0
  pushl $52
801056fd:	6a 34                	push   $0x34
  jmp alltraps
801056ff:	e9 a5 f9 ff ff       	jmp    801050a9 <alltraps>

80105704 <vector53>:
.globl vector53
vector53:
  pushl $0
80105704:	6a 00                	push   $0x0
  pushl $53
80105706:	6a 35                	push   $0x35
  jmp alltraps
80105708:	e9 9c f9 ff ff       	jmp    801050a9 <alltraps>

8010570d <vector54>:
.globl vector54
vector54:
  pushl $0
8010570d:	6a 00                	push   $0x0
  pushl $54
8010570f:	6a 36                	push   $0x36
  jmp alltraps
80105711:	e9 93 f9 ff ff       	jmp    801050a9 <alltraps>

80105716 <vector55>:
.globl vector55
vector55:
  pushl $0
80105716:	6a 00                	push   $0x0
  pushl $55
80105718:	6a 37                	push   $0x37
  jmp alltraps
8010571a:	e9 8a f9 ff ff       	jmp    801050a9 <alltraps>

8010571f <vector56>:
.globl vector56
vector56:
  pushl $0
8010571f:	6a 00                	push   $0x0
  pushl $56
80105721:	6a 38                	push   $0x38
  jmp alltraps
80105723:	e9 81 f9 ff ff       	jmp    801050a9 <alltraps>

80105728 <vector57>:
.globl vector57
vector57:
  pushl $0
80105728:	6a 00                	push   $0x0
  pushl $57
8010572a:	6a 39                	push   $0x39
  jmp alltraps
8010572c:	e9 78 f9 ff ff       	jmp    801050a9 <alltraps>

80105731 <vector58>:
.globl vector58
vector58:
  pushl $0
80105731:	6a 00                	push   $0x0
  pushl $58
80105733:	6a 3a                	push   $0x3a
  jmp alltraps
80105735:	e9 6f f9 ff ff       	jmp    801050a9 <alltraps>

8010573a <vector59>:
.globl vector59
vector59:
  pushl $0
8010573a:	6a 00                	push   $0x0
  pushl $59
8010573c:	6a 3b                	push   $0x3b
  jmp alltraps
8010573e:	e9 66 f9 ff ff       	jmp    801050a9 <alltraps>

80105743 <vector60>:
.globl vector60
vector60:
  pushl $0
80105743:	6a 00                	push   $0x0
  pushl $60
80105745:	6a 3c                	push   $0x3c
  jmp alltraps
80105747:	e9 5d f9 ff ff       	jmp    801050a9 <alltraps>

8010574c <vector61>:
.globl vector61
vector61:
  pushl $0
8010574c:	6a 00                	push   $0x0
  pushl $61
8010574e:	6a 3d                	push   $0x3d
  jmp alltraps
80105750:	e9 54 f9 ff ff       	jmp    801050a9 <alltraps>

80105755 <vector62>:
.globl vector62
vector62:
  pushl $0
80105755:	6a 00                	push   $0x0
  pushl $62
80105757:	6a 3e                	push   $0x3e
  jmp alltraps
80105759:	e9 4b f9 ff ff       	jmp    801050a9 <alltraps>

8010575e <vector63>:
.globl vector63
vector63:
  pushl $0
8010575e:	6a 00                	push   $0x0
  pushl $63
80105760:	6a 3f                	push   $0x3f
  jmp alltraps
80105762:	e9 42 f9 ff ff       	jmp    801050a9 <alltraps>

80105767 <vector64>:
.globl vector64
vector64:
  pushl $0
80105767:	6a 00                	push   $0x0
  pushl $64
80105769:	6a 40                	push   $0x40
  jmp alltraps
8010576b:	e9 39 f9 ff ff       	jmp    801050a9 <alltraps>

80105770 <vector65>:
.globl vector65
vector65:
  pushl $0
80105770:	6a 00                	push   $0x0
  pushl $65
80105772:	6a 41                	push   $0x41
  jmp alltraps
80105774:	e9 30 f9 ff ff       	jmp    801050a9 <alltraps>

80105779 <vector66>:
.globl vector66
vector66:
  pushl $0
80105779:	6a 00                	push   $0x0
  pushl $66
8010577b:	6a 42                	push   $0x42
  jmp alltraps
8010577d:	e9 27 f9 ff ff       	jmp    801050a9 <alltraps>

80105782 <vector67>:
.globl vector67
vector67:
  pushl $0
80105782:	6a 00                	push   $0x0
  pushl $67
80105784:	6a 43                	push   $0x43
  jmp alltraps
80105786:	e9 1e f9 ff ff       	jmp    801050a9 <alltraps>

8010578b <vector68>:
.globl vector68
vector68:
  pushl $0
8010578b:	6a 00                	push   $0x0
  pushl $68
8010578d:	6a 44                	push   $0x44
  jmp alltraps
8010578f:	e9 15 f9 ff ff       	jmp    801050a9 <alltraps>

80105794 <vector69>:
.globl vector69
vector69:
  pushl $0
80105794:	6a 00                	push   $0x0
  pushl $69
80105796:	6a 45                	push   $0x45
  jmp alltraps
80105798:	e9 0c f9 ff ff       	jmp    801050a9 <alltraps>

8010579d <vector70>:
.globl vector70
vector70:
  pushl $0
8010579d:	6a 00                	push   $0x0
  pushl $70
8010579f:	6a 46                	push   $0x46
  jmp alltraps
801057a1:	e9 03 f9 ff ff       	jmp    801050a9 <alltraps>

801057a6 <vector71>:
.globl vector71
vector71:
  pushl $0
801057a6:	6a 00                	push   $0x0
  pushl $71
801057a8:	6a 47                	push   $0x47
  jmp alltraps
801057aa:	e9 fa f8 ff ff       	jmp    801050a9 <alltraps>

801057af <vector72>:
.globl vector72
vector72:
  pushl $0
801057af:	6a 00                	push   $0x0
  pushl $72
801057b1:	6a 48                	push   $0x48
  jmp alltraps
801057b3:	e9 f1 f8 ff ff       	jmp    801050a9 <alltraps>

801057b8 <vector73>:
.globl vector73
vector73:
  pushl $0
801057b8:	6a 00                	push   $0x0
  pushl $73
801057ba:	6a 49                	push   $0x49
  jmp alltraps
801057bc:	e9 e8 f8 ff ff       	jmp    801050a9 <alltraps>

801057c1 <vector74>:
.globl vector74
vector74:
  pushl $0
801057c1:	6a 00                	push   $0x0
  pushl $74
801057c3:	6a 4a                	push   $0x4a
  jmp alltraps
801057c5:	e9 df f8 ff ff       	jmp    801050a9 <alltraps>

801057ca <vector75>:
.globl vector75
vector75:
  pushl $0
801057ca:	6a 00                	push   $0x0
  pushl $75
801057cc:	6a 4b                	push   $0x4b
  jmp alltraps
801057ce:	e9 d6 f8 ff ff       	jmp    801050a9 <alltraps>

801057d3 <vector76>:
.globl vector76
vector76:
  pushl $0
801057d3:	6a 00                	push   $0x0
  pushl $76
801057d5:	6a 4c                	push   $0x4c
  jmp alltraps
801057d7:	e9 cd f8 ff ff       	jmp    801050a9 <alltraps>

801057dc <vector77>:
.globl vector77
vector77:
  pushl $0
801057dc:	6a 00                	push   $0x0
  pushl $77
801057de:	6a 4d                	push   $0x4d
  jmp alltraps
801057e0:	e9 c4 f8 ff ff       	jmp    801050a9 <alltraps>

801057e5 <vector78>:
.globl vector78
vector78:
  pushl $0
801057e5:	6a 00                	push   $0x0
  pushl $78
801057e7:	6a 4e                	push   $0x4e
  jmp alltraps
801057e9:	e9 bb f8 ff ff       	jmp    801050a9 <alltraps>

801057ee <vector79>:
.globl vector79
vector79:
  pushl $0
801057ee:	6a 00                	push   $0x0
  pushl $79
801057f0:	6a 4f                	push   $0x4f
  jmp alltraps
801057f2:	e9 b2 f8 ff ff       	jmp    801050a9 <alltraps>

801057f7 <vector80>:
.globl vector80
vector80:
  pushl $0
801057f7:	6a 00                	push   $0x0
  pushl $80
801057f9:	6a 50                	push   $0x50
  jmp alltraps
801057fb:	e9 a9 f8 ff ff       	jmp    801050a9 <alltraps>

80105800 <vector81>:
.globl vector81
vector81:
  pushl $0
80105800:	6a 00                	push   $0x0
  pushl $81
80105802:	6a 51                	push   $0x51
  jmp alltraps
80105804:	e9 a0 f8 ff ff       	jmp    801050a9 <alltraps>

80105809 <vector82>:
.globl vector82
vector82:
  pushl $0
80105809:	6a 00                	push   $0x0
  pushl $82
8010580b:	6a 52                	push   $0x52
  jmp alltraps
8010580d:	e9 97 f8 ff ff       	jmp    801050a9 <alltraps>

80105812 <vector83>:
.globl vector83
vector83:
  pushl $0
80105812:	6a 00                	push   $0x0
  pushl $83
80105814:	6a 53                	push   $0x53
  jmp alltraps
80105816:	e9 8e f8 ff ff       	jmp    801050a9 <alltraps>

8010581b <vector84>:
.globl vector84
vector84:
  pushl $0
8010581b:	6a 00                	push   $0x0
  pushl $84
8010581d:	6a 54                	push   $0x54
  jmp alltraps
8010581f:	e9 85 f8 ff ff       	jmp    801050a9 <alltraps>

80105824 <vector85>:
.globl vector85
vector85:
  pushl $0
80105824:	6a 00                	push   $0x0
  pushl $85
80105826:	6a 55                	push   $0x55
  jmp alltraps
80105828:	e9 7c f8 ff ff       	jmp    801050a9 <alltraps>

8010582d <vector86>:
.globl vector86
vector86:
  pushl $0
8010582d:	6a 00                	push   $0x0
  pushl $86
8010582f:	6a 56                	push   $0x56
  jmp alltraps
80105831:	e9 73 f8 ff ff       	jmp    801050a9 <alltraps>

80105836 <vector87>:
.globl vector87
vector87:
  pushl $0
80105836:	6a 00                	push   $0x0
  pushl $87
80105838:	6a 57                	push   $0x57
  jmp alltraps
8010583a:	e9 6a f8 ff ff       	jmp    801050a9 <alltraps>

8010583f <vector88>:
.globl vector88
vector88:
  pushl $0
8010583f:	6a 00                	push   $0x0
  pushl $88
80105841:	6a 58                	push   $0x58
  jmp alltraps
80105843:	e9 61 f8 ff ff       	jmp    801050a9 <alltraps>

80105848 <vector89>:
.globl vector89
vector89:
  pushl $0
80105848:	6a 00                	push   $0x0
  pushl $89
8010584a:	6a 59                	push   $0x59
  jmp alltraps
8010584c:	e9 58 f8 ff ff       	jmp    801050a9 <alltraps>

80105851 <vector90>:
.globl vector90
vector90:
  pushl $0
80105851:	6a 00                	push   $0x0
  pushl $90
80105853:	6a 5a                	push   $0x5a
  jmp alltraps
80105855:	e9 4f f8 ff ff       	jmp    801050a9 <alltraps>

8010585a <vector91>:
.globl vector91
vector91:
  pushl $0
8010585a:	6a 00                	push   $0x0
  pushl $91
8010585c:	6a 5b                	push   $0x5b
  jmp alltraps
8010585e:	e9 46 f8 ff ff       	jmp    801050a9 <alltraps>

80105863 <vector92>:
.globl vector92
vector92:
  pushl $0
80105863:	6a 00                	push   $0x0
  pushl $92
80105865:	6a 5c                	push   $0x5c
  jmp alltraps
80105867:	e9 3d f8 ff ff       	jmp    801050a9 <alltraps>

8010586c <vector93>:
.globl vector93
vector93:
  pushl $0
8010586c:	6a 00                	push   $0x0
  pushl $93
8010586e:	6a 5d                	push   $0x5d
  jmp alltraps
80105870:	e9 34 f8 ff ff       	jmp    801050a9 <alltraps>

80105875 <vector94>:
.globl vector94
vector94:
  pushl $0
80105875:	6a 00                	push   $0x0
  pushl $94
80105877:	6a 5e                	push   $0x5e
  jmp alltraps
80105879:	e9 2b f8 ff ff       	jmp    801050a9 <alltraps>

8010587e <vector95>:
.globl vector95
vector95:
  pushl $0
8010587e:	6a 00                	push   $0x0
  pushl $95
80105880:	6a 5f                	push   $0x5f
  jmp alltraps
80105882:	e9 22 f8 ff ff       	jmp    801050a9 <alltraps>

80105887 <vector96>:
.globl vector96
vector96:
  pushl $0
80105887:	6a 00                	push   $0x0
  pushl $96
80105889:	6a 60                	push   $0x60
  jmp alltraps
8010588b:	e9 19 f8 ff ff       	jmp    801050a9 <alltraps>

80105890 <vector97>:
.globl vector97
vector97:
  pushl $0
80105890:	6a 00                	push   $0x0
  pushl $97
80105892:	6a 61                	push   $0x61
  jmp alltraps
80105894:	e9 10 f8 ff ff       	jmp    801050a9 <alltraps>

80105899 <vector98>:
.globl vector98
vector98:
  pushl $0
80105899:	6a 00                	push   $0x0
  pushl $98
8010589b:	6a 62                	push   $0x62
  jmp alltraps
8010589d:	e9 07 f8 ff ff       	jmp    801050a9 <alltraps>

801058a2 <vector99>:
.globl vector99
vector99:
  pushl $0
801058a2:	6a 00                	push   $0x0
  pushl $99
801058a4:	6a 63                	push   $0x63
  jmp alltraps
801058a6:	e9 fe f7 ff ff       	jmp    801050a9 <alltraps>

801058ab <vector100>:
.globl vector100
vector100:
  pushl $0
801058ab:	6a 00                	push   $0x0
  pushl $100
801058ad:	6a 64                	push   $0x64
  jmp alltraps
801058af:	e9 f5 f7 ff ff       	jmp    801050a9 <alltraps>

801058b4 <vector101>:
.globl vector101
vector101:
  pushl $0
801058b4:	6a 00                	push   $0x0
  pushl $101
801058b6:	6a 65                	push   $0x65
  jmp alltraps
801058b8:	e9 ec f7 ff ff       	jmp    801050a9 <alltraps>

801058bd <vector102>:
.globl vector102
vector102:
  pushl $0
801058bd:	6a 00                	push   $0x0
  pushl $102
801058bf:	6a 66                	push   $0x66
  jmp alltraps
801058c1:	e9 e3 f7 ff ff       	jmp    801050a9 <alltraps>

801058c6 <vector103>:
.globl vector103
vector103:
  pushl $0
801058c6:	6a 00                	push   $0x0
  pushl $103
801058c8:	6a 67                	push   $0x67
  jmp alltraps
801058ca:	e9 da f7 ff ff       	jmp    801050a9 <alltraps>

801058cf <vector104>:
.globl vector104
vector104:
  pushl $0
801058cf:	6a 00                	push   $0x0
  pushl $104
801058d1:	6a 68                	push   $0x68
  jmp alltraps
801058d3:	e9 d1 f7 ff ff       	jmp    801050a9 <alltraps>

801058d8 <vector105>:
.globl vector105
vector105:
  pushl $0
801058d8:	6a 00                	push   $0x0
  pushl $105
801058da:	6a 69                	push   $0x69
  jmp alltraps
801058dc:	e9 c8 f7 ff ff       	jmp    801050a9 <alltraps>

801058e1 <vector106>:
.globl vector106
vector106:
  pushl $0
801058e1:	6a 00                	push   $0x0
  pushl $106
801058e3:	6a 6a                	push   $0x6a
  jmp alltraps
801058e5:	e9 bf f7 ff ff       	jmp    801050a9 <alltraps>

801058ea <vector107>:
.globl vector107
vector107:
  pushl $0
801058ea:	6a 00                	push   $0x0
  pushl $107
801058ec:	6a 6b                	push   $0x6b
  jmp alltraps
801058ee:	e9 b6 f7 ff ff       	jmp    801050a9 <alltraps>

801058f3 <vector108>:
.globl vector108
vector108:
  pushl $0
801058f3:	6a 00                	push   $0x0
  pushl $108
801058f5:	6a 6c                	push   $0x6c
  jmp alltraps
801058f7:	e9 ad f7 ff ff       	jmp    801050a9 <alltraps>

801058fc <vector109>:
.globl vector109
vector109:
  pushl $0
801058fc:	6a 00                	push   $0x0
  pushl $109
801058fe:	6a 6d                	push   $0x6d
  jmp alltraps
80105900:	e9 a4 f7 ff ff       	jmp    801050a9 <alltraps>

80105905 <vector110>:
.globl vector110
vector110:
  pushl $0
80105905:	6a 00                	push   $0x0
  pushl $110
80105907:	6a 6e                	push   $0x6e
  jmp alltraps
80105909:	e9 9b f7 ff ff       	jmp    801050a9 <alltraps>

8010590e <vector111>:
.globl vector111
vector111:
  pushl $0
8010590e:	6a 00                	push   $0x0
  pushl $111
80105910:	6a 6f                	push   $0x6f
  jmp alltraps
80105912:	e9 92 f7 ff ff       	jmp    801050a9 <alltraps>

80105917 <vector112>:
.globl vector112
vector112:
  pushl $0
80105917:	6a 00                	push   $0x0
  pushl $112
80105919:	6a 70                	push   $0x70
  jmp alltraps
8010591b:	e9 89 f7 ff ff       	jmp    801050a9 <alltraps>

80105920 <vector113>:
.globl vector113
vector113:
  pushl $0
80105920:	6a 00                	push   $0x0
  pushl $113
80105922:	6a 71                	push   $0x71
  jmp alltraps
80105924:	e9 80 f7 ff ff       	jmp    801050a9 <alltraps>

80105929 <vector114>:
.globl vector114
vector114:
  pushl $0
80105929:	6a 00                	push   $0x0
  pushl $114
8010592b:	6a 72                	push   $0x72
  jmp alltraps
8010592d:	e9 77 f7 ff ff       	jmp    801050a9 <alltraps>

80105932 <vector115>:
.globl vector115
vector115:
  pushl $0
80105932:	6a 00                	push   $0x0
  pushl $115
80105934:	6a 73                	push   $0x73
  jmp alltraps
80105936:	e9 6e f7 ff ff       	jmp    801050a9 <alltraps>

8010593b <vector116>:
.globl vector116
vector116:
  pushl $0
8010593b:	6a 00                	push   $0x0
  pushl $116
8010593d:	6a 74                	push   $0x74
  jmp alltraps
8010593f:	e9 65 f7 ff ff       	jmp    801050a9 <alltraps>

80105944 <vector117>:
.globl vector117
vector117:
  pushl $0
80105944:	6a 00                	push   $0x0
  pushl $117
80105946:	6a 75                	push   $0x75
  jmp alltraps
80105948:	e9 5c f7 ff ff       	jmp    801050a9 <alltraps>

8010594d <vector118>:
.globl vector118
vector118:
  pushl $0
8010594d:	6a 00                	push   $0x0
  pushl $118
8010594f:	6a 76                	push   $0x76
  jmp alltraps
80105951:	e9 53 f7 ff ff       	jmp    801050a9 <alltraps>

80105956 <vector119>:
.globl vector119
vector119:
  pushl $0
80105956:	6a 00                	push   $0x0
  pushl $119
80105958:	6a 77                	push   $0x77
  jmp alltraps
8010595a:	e9 4a f7 ff ff       	jmp    801050a9 <alltraps>

8010595f <vector120>:
.globl vector120
vector120:
  pushl $0
8010595f:	6a 00                	push   $0x0
  pushl $120
80105961:	6a 78                	push   $0x78
  jmp alltraps
80105963:	e9 41 f7 ff ff       	jmp    801050a9 <alltraps>

80105968 <vector121>:
.globl vector121
vector121:
  pushl $0
80105968:	6a 00                	push   $0x0
  pushl $121
8010596a:	6a 79                	push   $0x79
  jmp alltraps
8010596c:	e9 38 f7 ff ff       	jmp    801050a9 <alltraps>

80105971 <vector122>:
.globl vector122
vector122:
  pushl $0
80105971:	6a 00                	push   $0x0
  pushl $122
80105973:	6a 7a                	push   $0x7a
  jmp alltraps
80105975:	e9 2f f7 ff ff       	jmp    801050a9 <alltraps>

8010597a <vector123>:
.globl vector123
vector123:
  pushl $0
8010597a:	6a 00                	push   $0x0
  pushl $123
8010597c:	6a 7b                	push   $0x7b
  jmp alltraps
8010597e:	e9 26 f7 ff ff       	jmp    801050a9 <alltraps>

80105983 <vector124>:
.globl vector124
vector124:
  pushl $0
80105983:	6a 00                	push   $0x0
  pushl $124
80105985:	6a 7c                	push   $0x7c
  jmp alltraps
80105987:	e9 1d f7 ff ff       	jmp    801050a9 <alltraps>

8010598c <vector125>:
.globl vector125
vector125:
  pushl $0
8010598c:	6a 00                	push   $0x0
  pushl $125
8010598e:	6a 7d                	push   $0x7d
  jmp alltraps
80105990:	e9 14 f7 ff ff       	jmp    801050a9 <alltraps>

80105995 <vector126>:
.globl vector126
vector126:
  pushl $0
80105995:	6a 00                	push   $0x0
  pushl $126
80105997:	6a 7e                	push   $0x7e
  jmp alltraps
80105999:	e9 0b f7 ff ff       	jmp    801050a9 <alltraps>

8010599e <vector127>:
.globl vector127
vector127:
  pushl $0
8010599e:	6a 00                	push   $0x0
  pushl $127
801059a0:	6a 7f                	push   $0x7f
  jmp alltraps
801059a2:	e9 02 f7 ff ff       	jmp    801050a9 <alltraps>

801059a7 <vector128>:
.globl vector128
vector128:
  pushl $0
801059a7:	6a 00                	push   $0x0
  pushl $128
801059a9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801059ae:	e9 f6 f6 ff ff       	jmp    801050a9 <alltraps>

801059b3 <vector129>:
.globl vector129
vector129:
  pushl $0
801059b3:	6a 00                	push   $0x0
  pushl $129
801059b5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801059ba:	e9 ea f6 ff ff       	jmp    801050a9 <alltraps>

801059bf <vector130>:
.globl vector130
vector130:
  pushl $0
801059bf:	6a 00                	push   $0x0
  pushl $130
801059c1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801059c6:	e9 de f6 ff ff       	jmp    801050a9 <alltraps>

801059cb <vector131>:
.globl vector131
vector131:
  pushl $0
801059cb:	6a 00                	push   $0x0
  pushl $131
801059cd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801059d2:	e9 d2 f6 ff ff       	jmp    801050a9 <alltraps>

801059d7 <vector132>:
.globl vector132
vector132:
  pushl $0
801059d7:	6a 00                	push   $0x0
  pushl $132
801059d9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801059de:	e9 c6 f6 ff ff       	jmp    801050a9 <alltraps>

801059e3 <vector133>:
.globl vector133
vector133:
  pushl $0
801059e3:	6a 00                	push   $0x0
  pushl $133
801059e5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801059ea:	e9 ba f6 ff ff       	jmp    801050a9 <alltraps>

801059ef <vector134>:
.globl vector134
vector134:
  pushl $0
801059ef:	6a 00                	push   $0x0
  pushl $134
801059f1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801059f6:	e9 ae f6 ff ff       	jmp    801050a9 <alltraps>

801059fb <vector135>:
.globl vector135
vector135:
  pushl $0
801059fb:	6a 00                	push   $0x0
  pushl $135
801059fd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80105a02:	e9 a2 f6 ff ff       	jmp    801050a9 <alltraps>

80105a07 <vector136>:
.globl vector136
vector136:
  pushl $0
80105a07:	6a 00                	push   $0x0
  pushl $136
80105a09:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80105a0e:	e9 96 f6 ff ff       	jmp    801050a9 <alltraps>

80105a13 <vector137>:
.globl vector137
vector137:
  pushl $0
80105a13:	6a 00                	push   $0x0
  pushl $137
80105a15:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80105a1a:	e9 8a f6 ff ff       	jmp    801050a9 <alltraps>

80105a1f <vector138>:
.globl vector138
vector138:
  pushl $0
80105a1f:	6a 00                	push   $0x0
  pushl $138
80105a21:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80105a26:	e9 7e f6 ff ff       	jmp    801050a9 <alltraps>

80105a2b <vector139>:
.globl vector139
vector139:
  pushl $0
80105a2b:	6a 00                	push   $0x0
  pushl $139
80105a2d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80105a32:	e9 72 f6 ff ff       	jmp    801050a9 <alltraps>

80105a37 <vector140>:
.globl vector140
vector140:
  pushl $0
80105a37:	6a 00                	push   $0x0
  pushl $140
80105a39:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80105a3e:	e9 66 f6 ff ff       	jmp    801050a9 <alltraps>

80105a43 <vector141>:
.globl vector141
vector141:
  pushl $0
80105a43:	6a 00                	push   $0x0
  pushl $141
80105a45:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80105a4a:	e9 5a f6 ff ff       	jmp    801050a9 <alltraps>

80105a4f <vector142>:
.globl vector142
vector142:
  pushl $0
80105a4f:	6a 00                	push   $0x0
  pushl $142
80105a51:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80105a56:	e9 4e f6 ff ff       	jmp    801050a9 <alltraps>

80105a5b <vector143>:
.globl vector143
vector143:
  pushl $0
80105a5b:	6a 00                	push   $0x0
  pushl $143
80105a5d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80105a62:	e9 42 f6 ff ff       	jmp    801050a9 <alltraps>

80105a67 <vector144>:
.globl vector144
vector144:
  pushl $0
80105a67:	6a 00                	push   $0x0
  pushl $144
80105a69:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80105a6e:	e9 36 f6 ff ff       	jmp    801050a9 <alltraps>

80105a73 <vector145>:
.globl vector145
vector145:
  pushl $0
80105a73:	6a 00                	push   $0x0
  pushl $145
80105a75:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80105a7a:	e9 2a f6 ff ff       	jmp    801050a9 <alltraps>

80105a7f <vector146>:
.globl vector146
vector146:
  pushl $0
80105a7f:	6a 00                	push   $0x0
  pushl $146
80105a81:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80105a86:	e9 1e f6 ff ff       	jmp    801050a9 <alltraps>

80105a8b <vector147>:
.globl vector147
vector147:
  pushl $0
80105a8b:	6a 00                	push   $0x0
  pushl $147
80105a8d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80105a92:	e9 12 f6 ff ff       	jmp    801050a9 <alltraps>

80105a97 <vector148>:
.globl vector148
vector148:
  pushl $0
80105a97:	6a 00                	push   $0x0
  pushl $148
80105a99:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80105a9e:	e9 06 f6 ff ff       	jmp    801050a9 <alltraps>

80105aa3 <vector149>:
.globl vector149
vector149:
  pushl $0
80105aa3:	6a 00                	push   $0x0
  pushl $149
80105aa5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80105aaa:	e9 fa f5 ff ff       	jmp    801050a9 <alltraps>

80105aaf <vector150>:
.globl vector150
vector150:
  pushl $0
80105aaf:	6a 00                	push   $0x0
  pushl $150
80105ab1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80105ab6:	e9 ee f5 ff ff       	jmp    801050a9 <alltraps>

80105abb <vector151>:
.globl vector151
vector151:
  pushl $0
80105abb:	6a 00                	push   $0x0
  pushl $151
80105abd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80105ac2:	e9 e2 f5 ff ff       	jmp    801050a9 <alltraps>

80105ac7 <vector152>:
.globl vector152
vector152:
  pushl $0
80105ac7:	6a 00                	push   $0x0
  pushl $152
80105ac9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80105ace:	e9 d6 f5 ff ff       	jmp    801050a9 <alltraps>

80105ad3 <vector153>:
.globl vector153
vector153:
  pushl $0
80105ad3:	6a 00                	push   $0x0
  pushl $153
80105ad5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80105ada:	e9 ca f5 ff ff       	jmp    801050a9 <alltraps>

80105adf <vector154>:
.globl vector154
vector154:
  pushl $0
80105adf:	6a 00                	push   $0x0
  pushl $154
80105ae1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80105ae6:	e9 be f5 ff ff       	jmp    801050a9 <alltraps>

80105aeb <vector155>:
.globl vector155
vector155:
  pushl $0
80105aeb:	6a 00                	push   $0x0
  pushl $155
80105aed:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80105af2:	e9 b2 f5 ff ff       	jmp    801050a9 <alltraps>

80105af7 <vector156>:
.globl vector156
vector156:
  pushl $0
80105af7:	6a 00                	push   $0x0
  pushl $156
80105af9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80105afe:	e9 a6 f5 ff ff       	jmp    801050a9 <alltraps>

80105b03 <vector157>:
.globl vector157
vector157:
  pushl $0
80105b03:	6a 00                	push   $0x0
  pushl $157
80105b05:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80105b0a:	e9 9a f5 ff ff       	jmp    801050a9 <alltraps>

80105b0f <vector158>:
.globl vector158
vector158:
  pushl $0
80105b0f:	6a 00                	push   $0x0
  pushl $158
80105b11:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80105b16:	e9 8e f5 ff ff       	jmp    801050a9 <alltraps>

80105b1b <vector159>:
.globl vector159
vector159:
  pushl $0
80105b1b:	6a 00                	push   $0x0
  pushl $159
80105b1d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80105b22:	e9 82 f5 ff ff       	jmp    801050a9 <alltraps>

80105b27 <vector160>:
.globl vector160
vector160:
  pushl $0
80105b27:	6a 00                	push   $0x0
  pushl $160
80105b29:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80105b2e:	e9 76 f5 ff ff       	jmp    801050a9 <alltraps>

80105b33 <vector161>:
.globl vector161
vector161:
  pushl $0
80105b33:	6a 00                	push   $0x0
  pushl $161
80105b35:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80105b3a:	e9 6a f5 ff ff       	jmp    801050a9 <alltraps>

80105b3f <vector162>:
.globl vector162
vector162:
  pushl $0
80105b3f:	6a 00                	push   $0x0
  pushl $162
80105b41:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80105b46:	e9 5e f5 ff ff       	jmp    801050a9 <alltraps>

80105b4b <vector163>:
.globl vector163
vector163:
  pushl $0
80105b4b:	6a 00                	push   $0x0
  pushl $163
80105b4d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80105b52:	e9 52 f5 ff ff       	jmp    801050a9 <alltraps>

80105b57 <vector164>:
.globl vector164
vector164:
  pushl $0
80105b57:	6a 00                	push   $0x0
  pushl $164
80105b59:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80105b5e:	e9 46 f5 ff ff       	jmp    801050a9 <alltraps>

80105b63 <vector165>:
.globl vector165
vector165:
  pushl $0
80105b63:	6a 00                	push   $0x0
  pushl $165
80105b65:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80105b6a:	e9 3a f5 ff ff       	jmp    801050a9 <alltraps>

80105b6f <vector166>:
.globl vector166
vector166:
  pushl $0
80105b6f:	6a 00                	push   $0x0
  pushl $166
80105b71:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80105b76:	e9 2e f5 ff ff       	jmp    801050a9 <alltraps>

80105b7b <vector167>:
.globl vector167
vector167:
  pushl $0
80105b7b:	6a 00                	push   $0x0
  pushl $167
80105b7d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80105b82:	e9 22 f5 ff ff       	jmp    801050a9 <alltraps>

80105b87 <vector168>:
.globl vector168
vector168:
  pushl $0
80105b87:	6a 00                	push   $0x0
  pushl $168
80105b89:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80105b8e:	e9 16 f5 ff ff       	jmp    801050a9 <alltraps>

80105b93 <vector169>:
.globl vector169
vector169:
  pushl $0
80105b93:	6a 00                	push   $0x0
  pushl $169
80105b95:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80105b9a:	e9 0a f5 ff ff       	jmp    801050a9 <alltraps>

80105b9f <vector170>:
.globl vector170
vector170:
  pushl $0
80105b9f:	6a 00                	push   $0x0
  pushl $170
80105ba1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80105ba6:	e9 fe f4 ff ff       	jmp    801050a9 <alltraps>

80105bab <vector171>:
.globl vector171
vector171:
  pushl $0
80105bab:	6a 00                	push   $0x0
  pushl $171
80105bad:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80105bb2:	e9 f2 f4 ff ff       	jmp    801050a9 <alltraps>

80105bb7 <vector172>:
.globl vector172
vector172:
  pushl $0
80105bb7:	6a 00                	push   $0x0
  pushl $172
80105bb9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80105bbe:	e9 e6 f4 ff ff       	jmp    801050a9 <alltraps>

80105bc3 <vector173>:
.globl vector173
vector173:
  pushl $0
80105bc3:	6a 00                	push   $0x0
  pushl $173
80105bc5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80105bca:	e9 da f4 ff ff       	jmp    801050a9 <alltraps>

80105bcf <vector174>:
.globl vector174
vector174:
  pushl $0
80105bcf:	6a 00                	push   $0x0
  pushl $174
80105bd1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80105bd6:	e9 ce f4 ff ff       	jmp    801050a9 <alltraps>

80105bdb <vector175>:
.globl vector175
vector175:
  pushl $0
80105bdb:	6a 00                	push   $0x0
  pushl $175
80105bdd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80105be2:	e9 c2 f4 ff ff       	jmp    801050a9 <alltraps>

80105be7 <vector176>:
.globl vector176
vector176:
  pushl $0
80105be7:	6a 00                	push   $0x0
  pushl $176
80105be9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80105bee:	e9 b6 f4 ff ff       	jmp    801050a9 <alltraps>

80105bf3 <vector177>:
.globl vector177
vector177:
  pushl $0
80105bf3:	6a 00                	push   $0x0
  pushl $177
80105bf5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80105bfa:	e9 aa f4 ff ff       	jmp    801050a9 <alltraps>

80105bff <vector178>:
.globl vector178
vector178:
  pushl $0
80105bff:	6a 00                	push   $0x0
  pushl $178
80105c01:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80105c06:	e9 9e f4 ff ff       	jmp    801050a9 <alltraps>

80105c0b <vector179>:
.globl vector179
vector179:
  pushl $0
80105c0b:	6a 00                	push   $0x0
  pushl $179
80105c0d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80105c12:	e9 92 f4 ff ff       	jmp    801050a9 <alltraps>

80105c17 <vector180>:
.globl vector180
vector180:
  pushl $0
80105c17:	6a 00                	push   $0x0
  pushl $180
80105c19:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80105c1e:	e9 86 f4 ff ff       	jmp    801050a9 <alltraps>

80105c23 <vector181>:
.globl vector181
vector181:
  pushl $0
80105c23:	6a 00                	push   $0x0
  pushl $181
80105c25:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80105c2a:	e9 7a f4 ff ff       	jmp    801050a9 <alltraps>

80105c2f <vector182>:
.globl vector182
vector182:
  pushl $0
80105c2f:	6a 00                	push   $0x0
  pushl $182
80105c31:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80105c36:	e9 6e f4 ff ff       	jmp    801050a9 <alltraps>

80105c3b <vector183>:
.globl vector183
vector183:
  pushl $0
80105c3b:	6a 00                	push   $0x0
  pushl $183
80105c3d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80105c42:	e9 62 f4 ff ff       	jmp    801050a9 <alltraps>

80105c47 <vector184>:
.globl vector184
vector184:
  pushl $0
80105c47:	6a 00                	push   $0x0
  pushl $184
80105c49:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80105c4e:	e9 56 f4 ff ff       	jmp    801050a9 <alltraps>

80105c53 <vector185>:
.globl vector185
vector185:
  pushl $0
80105c53:	6a 00                	push   $0x0
  pushl $185
80105c55:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80105c5a:	e9 4a f4 ff ff       	jmp    801050a9 <alltraps>

80105c5f <vector186>:
.globl vector186
vector186:
  pushl $0
80105c5f:	6a 00                	push   $0x0
  pushl $186
80105c61:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80105c66:	e9 3e f4 ff ff       	jmp    801050a9 <alltraps>

80105c6b <vector187>:
.globl vector187
vector187:
  pushl $0
80105c6b:	6a 00                	push   $0x0
  pushl $187
80105c6d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80105c72:	e9 32 f4 ff ff       	jmp    801050a9 <alltraps>

80105c77 <vector188>:
.globl vector188
vector188:
  pushl $0
80105c77:	6a 00                	push   $0x0
  pushl $188
80105c79:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80105c7e:	e9 26 f4 ff ff       	jmp    801050a9 <alltraps>

80105c83 <vector189>:
.globl vector189
vector189:
  pushl $0
80105c83:	6a 00                	push   $0x0
  pushl $189
80105c85:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80105c8a:	e9 1a f4 ff ff       	jmp    801050a9 <alltraps>

80105c8f <vector190>:
.globl vector190
vector190:
  pushl $0
80105c8f:	6a 00                	push   $0x0
  pushl $190
80105c91:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80105c96:	e9 0e f4 ff ff       	jmp    801050a9 <alltraps>

80105c9b <vector191>:
.globl vector191
vector191:
  pushl $0
80105c9b:	6a 00                	push   $0x0
  pushl $191
80105c9d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80105ca2:	e9 02 f4 ff ff       	jmp    801050a9 <alltraps>

80105ca7 <vector192>:
.globl vector192
vector192:
  pushl $0
80105ca7:	6a 00                	push   $0x0
  pushl $192
80105ca9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80105cae:	e9 f6 f3 ff ff       	jmp    801050a9 <alltraps>

80105cb3 <vector193>:
.globl vector193
vector193:
  pushl $0
80105cb3:	6a 00                	push   $0x0
  pushl $193
80105cb5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80105cba:	e9 ea f3 ff ff       	jmp    801050a9 <alltraps>

80105cbf <vector194>:
.globl vector194
vector194:
  pushl $0
80105cbf:	6a 00                	push   $0x0
  pushl $194
80105cc1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80105cc6:	e9 de f3 ff ff       	jmp    801050a9 <alltraps>

80105ccb <vector195>:
.globl vector195
vector195:
  pushl $0
80105ccb:	6a 00                	push   $0x0
  pushl $195
80105ccd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80105cd2:	e9 d2 f3 ff ff       	jmp    801050a9 <alltraps>

80105cd7 <vector196>:
.globl vector196
vector196:
  pushl $0
80105cd7:	6a 00                	push   $0x0
  pushl $196
80105cd9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80105cde:	e9 c6 f3 ff ff       	jmp    801050a9 <alltraps>

80105ce3 <vector197>:
.globl vector197
vector197:
  pushl $0
80105ce3:	6a 00                	push   $0x0
  pushl $197
80105ce5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80105cea:	e9 ba f3 ff ff       	jmp    801050a9 <alltraps>

80105cef <vector198>:
.globl vector198
vector198:
  pushl $0
80105cef:	6a 00                	push   $0x0
  pushl $198
80105cf1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80105cf6:	e9 ae f3 ff ff       	jmp    801050a9 <alltraps>

80105cfb <vector199>:
.globl vector199
vector199:
  pushl $0
80105cfb:	6a 00                	push   $0x0
  pushl $199
80105cfd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80105d02:	e9 a2 f3 ff ff       	jmp    801050a9 <alltraps>

80105d07 <vector200>:
.globl vector200
vector200:
  pushl $0
80105d07:	6a 00                	push   $0x0
  pushl $200
80105d09:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80105d0e:	e9 96 f3 ff ff       	jmp    801050a9 <alltraps>

80105d13 <vector201>:
.globl vector201
vector201:
  pushl $0
80105d13:	6a 00                	push   $0x0
  pushl $201
80105d15:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80105d1a:	e9 8a f3 ff ff       	jmp    801050a9 <alltraps>

80105d1f <vector202>:
.globl vector202
vector202:
  pushl $0
80105d1f:	6a 00                	push   $0x0
  pushl $202
80105d21:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80105d26:	e9 7e f3 ff ff       	jmp    801050a9 <alltraps>

80105d2b <vector203>:
.globl vector203
vector203:
  pushl $0
80105d2b:	6a 00                	push   $0x0
  pushl $203
80105d2d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80105d32:	e9 72 f3 ff ff       	jmp    801050a9 <alltraps>

80105d37 <vector204>:
.globl vector204
vector204:
  pushl $0
80105d37:	6a 00                	push   $0x0
  pushl $204
80105d39:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80105d3e:	e9 66 f3 ff ff       	jmp    801050a9 <alltraps>

80105d43 <vector205>:
.globl vector205
vector205:
  pushl $0
80105d43:	6a 00                	push   $0x0
  pushl $205
80105d45:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80105d4a:	e9 5a f3 ff ff       	jmp    801050a9 <alltraps>

80105d4f <vector206>:
.globl vector206
vector206:
  pushl $0
80105d4f:	6a 00                	push   $0x0
  pushl $206
80105d51:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80105d56:	e9 4e f3 ff ff       	jmp    801050a9 <alltraps>

80105d5b <vector207>:
.globl vector207
vector207:
  pushl $0
80105d5b:	6a 00                	push   $0x0
  pushl $207
80105d5d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80105d62:	e9 42 f3 ff ff       	jmp    801050a9 <alltraps>

80105d67 <vector208>:
.globl vector208
vector208:
  pushl $0
80105d67:	6a 00                	push   $0x0
  pushl $208
80105d69:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80105d6e:	e9 36 f3 ff ff       	jmp    801050a9 <alltraps>

80105d73 <vector209>:
.globl vector209
vector209:
  pushl $0
80105d73:	6a 00                	push   $0x0
  pushl $209
80105d75:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80105d7a:	e9 2a f3 ff ff       	jmp    801050a9 <alltraps>

80105d7f <vector210>:
.globl vector210
vector210:
  pushl $0
80105d7f:	6a 00                	push   $0x0
  pushl $210
80105d81:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80105d86:	e9 1e f3 ff ff       	jmp    801050a9 <alltraps>

80105d8b <vector211>:
.globl vector211
vector211:
  pushl $0
80105d8b:	6a 00                	push   $0x0
  pushl $211
80105d8d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80105d92:	e9 12 f3 ff ff       	jmp    801050a9 <alltraps>

80105d97 <vector212>:
.globl vector212
vector212:
  pushl $0
80105d97:	6a 00                	push   $0x0
  pushl $212
80105d99:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80105d9e:	e9 06 f3 ff ff       	jmp    801050a9 <alltraps>

80105da3 <vector213>:
.globl vector213
vector213:
  pushl $0
80105da3:	6a 00                	push   $0x0
  pushl $213
80105da5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80105daa:	e9 fa f2 ff ff       	jmp    801050a9 <alltraps>

80105daf <vector214>:
.globl vector214
vector214:
  pushl $0
80105daf:	6a 00                	push   $0x0
  pushl $214
80105db1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80105db6:	e9 ee f2 ff ff       	jmp    801050a9 <alltraps>

80105dbb <vector215>:
.globl vector215
vector215:
  pushl $0
80105dbb:	6a 00                	push   $0x0
  pushl $215
80105dbd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80105dc2:	e9 e2 f2 ff ff       	jmp    801050a9 <alltraps>

80105dc7 <vector216>:
.globl vector216
vector216:
  pushl $0
80105dc7:	6a 00                	push   $0x0
  pushl $216
80105dc9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80105dce:	e9 d6 f2 ff ff       	jmp    801050a9 <alltraps>

80105dd3 <vector217>:
.globl vector217
vector217:
  pushl $0
80105dd3:	6a 00                	push   $0x0
  pushl $217
80105dd5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80105dda:	e9 ca f2 ff ff       	jmp    801050a9 <alltraps>

80105ddf <vector218>:
.globl vector218
vector218:
  pushl $0
80105ddf:	6a 00                	push   $0x0
  pushl $218
80105de1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80105de6:	e9 be f2 ff ff       	jmp    801050a9 <alltraps>

80105deb <vector219>:
.globl vector219
vector219:
  pushl $0
80105deb:	6a 00                	push   $0x0
  pushl $219
80105ded:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80105df2:	e9 b2 f2 ff ff       	jmp    801050a9 <alltraps>

80105df7 <vector220>:
.globl vector220
vector220:
  pushl $0
80105df7:	6a 00                	push   $0x0
  pushl $220
80105df9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80105dfe:	e9 a6 f2 ff ff       	jmp    801050a9 <alltraps>

80105e03 <vector221>:
.globl vector221
vector221:
  pushl $0
80105e03:	6a 00                	push   $0x0
  pushl $221
80105e05:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80105e0a:	e9 9a f2 ff ff       	jmp    801050a9 <alltraps>

80105e0f <vector222>:
.globl vector222
vector222:
  pushl $0
80105e0f:	6a 00                	push   $0x0
  pushl $222
80105e11:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80105e16:	e9 8e f2 ff ff       	jmp    801050a9 <alltraps>

80105e1b <vector223>:
.globl vector223
vector223:
  pushl $0
80105e1b:	6a 00                	push   $0x0
  pushl $223
80105e1d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80105e22:	e9 82 f2 ff ff       	jmp    801050a9 <alltraps>

80105e27 <vector224>:
.globl vector224
vector224:
  pushl $0
80105e27:	6a 00                	push   $0x0
  pushl $224
80105e29:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80105e2e:	e9 76 f2 ff ff       	jmp    801050a9 <alltraps>

80105e33 <vector225>:
.globl vector225
vector225:
  pushl $0
80105e33:	6a 00                	push   $0x0
  pushl $225
80105e35:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80105e3a:	e9 6a f2 ff ff       	jmp    801050a9 <alltraps>

80105e3f <vector226>:
.globl vector226
vector226:
  pushl $0
80105e3f:	6a 00                	push   $0x0
  pushl $226
80105e41:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80105e46:	e9 5e f2 ff ff       	jmp    801050a9 <alltraps>

80105e4b <vector227>:
.globl vector227
vector227:
  pushl $0
80105e4b:	6a 00                	push   $0x0
  pushl $227
80105e4d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80105e52:	e9 52 f2 ff ff       	jmp    801050a9 <alltraps>

80105e57 <vector228>:
.globl vector228
vector228:
  pushl $0
80105e57:	6a 00                	push   $0x0
  pushl $228
80105e59:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80105e5e:	e9 46 f2 ff ff       	jmp    801050a9 <alltraps>

80105e63 <vector229>:
.globl vector229
vector229:
  pushl $0
80105e63:	6a 00                	push   $0x0
  pushl $229
80105e65:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80105e6a:	e9 3a f2 ff ff       	jmp    801050a9 <alltraps>

80105e6f <vector230>:
.globl vector230
vector230:
  pushl $0
80105e6f:	6a 00                	push   $0x0
  pushl $230
80105e71:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80105e76:	e9 2e f2 ff ff       	jmp    801050a9 <alltraps>

80105e7b <vector231>:
.globl vector231
vector231:
  pushl $0
80105e7b:	6a 00                	push   $0x0
  pushl $231
80105e7d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80105e82:	e9 22 f2 ff ff       	jmp    801050a9 <alltraps>

80105e87 <vector232>:
.globl vector232
vector232:
  pushl $0
80105e87:	6a 00                	push   $0x0
  pushl $232
80105e89:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80105e8e:	e9 16 f2 ff ff       	jmp    801050a9 <alltraps>

80105e93 <vector233>:
.globl vector233
vector233:
  pushl $0
80105e93:	6a 00                	push   $0x0
  pushl $233
80105e95:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80105e9a:	e9 0a f2 ff ff       	jmp    801050a9 <alltraps>

80105e9f <vector234>:
.globl vector234
vector234:
  pushl $0
80105e9f:	6a 00                	push   $0x0
  pushl $234
80105ea1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80105ea6:	e9 fe f1 ff ff       	jmp    801050a9 <alltraps>

80105eab <vector235>:
.globl vector235
vector235:
  pushl $0
80105eab:	6a 00                	push   $0x0
  pushl $235
80105ead:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80105eb2:	e9 f2 f1 ff ff       	jmp    801050a9 <alltraps>

80105eb7 <vector236>:
.globl vector236
vector236:
  pushl $0
80105eb7:	6a 00                	push   $0x0
  pushl $236
80105eb9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80105ebe:	e9 e6 f1 ff ff       	jmp    801050a9 <alltraps>

80105ec3 <vector237>:
.globl vector237
vector237:
  pushl $0
80105ec3:	6a 00                	push   $0x0
  pushl $237
80105ec5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80105eca:	e9 da f1 ff ff       	jmp    801050a9 <alltraps>

80105ecf <vector238>:
.globl vector238
vector238:
  pushl $0
80105ecf:	6a 00                	push   $0x0
  pushl $238
80105ed1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80105ed6:	e9 ce f1 ff ff       	jmp    801050a9 <alltraps>

80105edb <vector239>:
.globl vector239
vector239:
  pushl $0
80105edb:	6a 00                	push   $0x0
  pushl $239
80105edd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80105ee2:	e9 c2 f1 ff ff       	jmp    801050a9 <alltraps>

80105ee7 <vector240>:
.globl vector240
vector240:
  pushl $0
80105ee7:	6a 00                	push   $0x0
  pushl $240
80105ee9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80105eee:	e9 b6 f1 ff ff       	jmp    801050a9 <alltraps>

80105ef3 <vector241>:
.globl vector241
vector241:
  pushl $0
80105ef3:	6a 00                	push   $0x0
  pushl $241
80105ef5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80105efa:	e9 aa f1 ff ff       	jmp    801050a9 <alltraps>

80105eff <vector242>:
.globl vector242
vector242:
  pushl $0
80105eff:	6a 00                	push   $0x0
  pushl $242
80105f01:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80105f06:	e9 9e f1 ff ff       	jmp    801050a9 <alltraps>

80105f0b <vector243>:
.globl vector243
vector243:
  pushl $0
80105f0b:	6a 00                	push   $0x0
  pushl $243
80105f0d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80105f12:	e9 92 f1 ff ff       	jmp    801050a9 <alltraps>

80105f17 <vector244>:
.globl vector244
vector244:
  pushl $0
80105f17:	6a 00                	push   $0x0
  pushl $244
80105f19:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80105f1e:	e9 86 f1 ff ff       	jmp    801050a9 <alltraps>

80105f23 <vector245>:
.globl vector245
vector245:
  pushl $0
80105f23:	6a 00                	push   $0x0
  pushl $245
80105f25:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80105f2a:	e9 7a f1 ff ff       	jmp    801050a9 <alltraps>

80105f2f <vector246>:
.globl vector246
vector246:
  pushl $0
80105f2f:	6a 00                	push   $0x0
  pushl $246
80105f31:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80105f36:	e9 6e f1 ff ff       	jmp    801050a9 <alltraps>

80105f3b <vector247>:
.globl vector247
vector247:
  pushl $0
80105f3b:	6a 00                	push   $0x0
  pushl $247
80105f3d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80105f42:	e9 62 f1 ff ff       	jmp    801050a9 <alltraps>

80105f47 <vector248>:
.globl vector248
vector248:
  pushl $0
80105f47:	6a 00                	push   $0x0
  pushl $248
80105f49:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80105f4e:	e9 56 f1 ff ff       	jmp    801050a9 <alltraps>

80105f53 <vector249>:
.globl vector249
vector249:
  pushl $0
80105f53:	6a 00                	push   $0x0
  pushl $249
80105f55:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80105f5a:	e9 4a f1 ff ff       	jmp    801050a9 <alltraps>

80105f5f <vector250>:
.globl vector250
vector250:
  pushl $0
80105f5f:	6a 00                	push   $0x0
  pushl $250
80105f61:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80105f66:	e9 3e f1 ff ff       	jmp    801050a9 <alltraps>

80105f6b <vector251>:
.globl vector251
vector251:
  pushl $0
80105f6b:	6a 00                	push   $0x0
  pushl $251
80105f6d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80105f72:	e9 32 f1 ff ff       	jmp    801050a9 <alltraps>

80105f77 <vector252>:
.globl vector252
vector252:
  pushl $0
80105f77:	6a 00                	push   $0x0
  pushl $252
80105f79:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80105f7e:	e9 26 f1 ff ff       	jmp    801050a9 <alltraps>

80105f83 <vector253>:
.globl vector253
vector253:
  pushl $0
80105f83:	6a 00                	push   $0x0
  pushl $253
80105f85:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80105f8a:	e9 1a f1 ff ff       	jmp    801050a9 <alltraps>

80105f8f <vector254>:
.globl vector254
vector254:
  pushl $0
80105f8f:	6a 00                	push   $0x0
  pushl $254
80105f91:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80105f96:	e9 0e f1 ff ff       	jmp    801050a9 <alltraps>

80105f9b <vector255>:
.globl vector255
vector255:
  pushl $0
80105f9b:	6a 00                	push   $0x0
  pushl $255
80105f9d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80105fa2:	e9 02 f1 ff ff       	jmp    801050a9 <alltraps>
80105fa7:	90                   	nop

80105fa8 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80105fa8:	55                   	push   %ebp
80105fa9:	89 e5                	mov    %esp,%ebp
80105fab:	57                   	push   %edi
80105fac:	56                   	push   %esi
80105fad:	53                   	push   %ebx
80105fae:	83 ec 1c             	sub    $0x1c,%esp
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80105fb1:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80105fb7:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80105fbd:	39 d3                	cmp    %edx,%ebx
80105fbf:	73 50                	jae    80106011 <deallocuvm.part.0+0x69>
80105fc1:	89 c6                	mov    %eax,%esi
80105fc3:	89 d7                	mov    %edx,%edi
80105fc5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80105fc8:	eb 0c                	jmp    80105fd6 <deallocuvm.part.0+0x2e>
80105fca:	66 90                	xchg   %ax,%ax
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80105fcc:	42                   	inc    %edx
80105fcd:	89 d3                	mov    %edx,%ebx
80105fcf:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80105fd2:	39 fb                	cmp    %edi,%ebx
80105fd4:	73 38                	jae    8010600e <deallocuvm.part.0+0x66>
  pde = &pgdir[PDX(va)];
80105fd6:	89 da                	mov    %ebx,%edx
80105fd8:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80105fdb:	8b 04 96             	mov    (%esi,%edx,4),%eax
80105fde:	a8 01                	test   $0x1,%al
80105fe0:	74 ea                	je     80105fcc <deallocuvm.part.0+0x24>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80105fe2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80105fe7:	89 d9                	mov    %ebx,%ecx
80105fe9:	c1 e9 0a             	shr    $0xa,%ecx
80105fec:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80105ff2:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80105ff9:	85 c0                	test   %eax,%eax
80105ffb:	74 cf                	je     80105fcc <deallocuvm.part.0+0x24>
    else if((*pte & PTE_P) != 0){
80105ffd:	8b 10                	mov    (%eax),%edx
80105fff:	f6 c2 01             	test   $0x1,%dl
80106002:	75 18                	jne    8010601c <deallocuvm.part.0+0x74>
  for(; a  < oldsz; a += PGSIZE){
80106004:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010600a:	39 fb                	cmp    %edi,%ebx
8010600c:	72 c8                	jb     80105fd6 <deallocuvm.part.0+0x2e>
8010600e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106011:	89 c8                	mov    %ecx,%eax
80106013:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106016:	5b                   	pop    %ebx
80106017:	5e                   	pop    %esi
80106018:	5f                   	pop    %edi
80106019:	5d                   	pop    %ebp
8010601a:	c3                   	ret
8010601b:	90                   	nop
      if(pa == 0)
8010601c:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106022:	74 26                	je     8010604a <deallocuvm.part.0+0xa2>
80106024:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106027:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010602a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80106030:	52                   	push   %edx
80106031:	e8 8e c1 ff ff       	call   801021c4 <kfree>
      *pte = 0;
80106036:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106039:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
8010603f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106045:	83 c4 10             	add    $0x10,%esp
80106048:	eb 88                	jmp    80105fd2 <deallocuvm.part.0+0x2a>
        panic("kfree");
8010604a:	83 ec 0c             	sub    $0xc,%esp
8010604d:	68 6c 6a 10 80       	push   $0x80106a6c
80106052:	e8 e1 a2 ff ff       	call   80100338 <panic>
80106057:	90                   	nop

80106058 <mappages>:
{
80106058:	55                   	push   %ebp
80106059:	89 e5                	mov    %esp,%ebp
8010605b:	57                   	push   %edi
8010605c:	56                   	push   %esi
8010605d:	53                   	push   %ebx
8010605e:	83 ec 1c             	sub    $0x1c,%esp
80106061:	89 45 e0             	mov    %eax,-0x20(%ebp)
  a = (char*)PGROUNDDOWN((uint)va);
80106064:	89 d3                	mov    %edx,%ebx
80106066:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010606c:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106070:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106075:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106078:	8b 45 08             	mov    0x8(%ebp),%eax
8010607b:	29 d8                	sub    %ebx,%eax
8010607d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106080:	eb 3b                	jmp    801060bd <mappages+0x65>
80106082:	66 90                	xchg   %ax,%ax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106084:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106089:	89 da                	mov    %ebx,%edx
8010608b:	c1 ea 0a             	shr    $0xa,%edx
8010608e:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106094:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010609b:	85 c0                	test   %eax,%eax
8010609d:	74 71                	je     80106110 <mappages+0xb8>
    if(*pte & PTE_P)
8010609f:	f6 00 01             	testb  $0x1,(%eax)
801060a2:	0f 85 82 00 00 00    	jne    8010612a <mappages+0xd2>
    *pte = pa | perm | PTE_P;
801060a8:	0b 75 0c             	or     0xc(%ebp),%esi
801060ab:	83 ce 01             	or     $0x1,%esi
801060ae:	89 30                	mov    %esi,(%eax)
    if(a == last)
801060b0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801060b3:	39 c3                	cmp    %eax,%ebx
801060b5:	74 69                	je     80106120 <mappages+0xc8>
    a += PGSIZE;
801060b7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
801060bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801060c0:	8d 34 03             	lea    (%ebx,%eax,1),%esi
  pde = &pgdir[PDX(va)];
801060c3:	89 d8                	mov    %ebx,%eax
801060c5:	c1 e8 16             	shr    $0x16,%eax
801060c8:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801060cb:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
801060ce:	8b 07                	mov    (%edi),%eax
801060d0:	a8 01                	test   $0x1,%al
801060d2:	75 b0                	jne    80106084 <mappages+0x2c>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801060d4:	e8 7b c2 ff ff       	call   80102354 <kalloc>
801060d9:	89 c2                	mov    %eax,%edx
801060db:	85 c0                	test   %eax,%eax
801060dd:	74 31                	je     80106110 <mappages+0xb8>
    memset(pgtab, 0, PGSIZE);
801060df:	50                   	push   %eax
801060e0:	68 00 10 00 00       	push   $0x1000
801060e5:	6a 00                	push   $0x0
801060e7:	52                   	push   %edx
801060e8:	89 55 d8             	mov    %edx,-0x28(%ebp)
801060eb:	e8 18 e0 ff ff       	call   80104108 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801060f0:	8b 55 d8             	mov    -0x28(%ebp),%edx
801060f3:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
801060f9:	83 c8 07             	or     $0x7,%eax
801060fc:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
801060fe:	89 d8                	mov    %ebx,%eax
80106100:	c1 e8 0a             	shr    $0xa,%eax
80106103:	25 fc 0f 00 00       	and    $0xffc,%eax
80106108:	01 d0                	add    %edx,%eax
8010610a:	83 c4 10             	add    $0x10,%esp
8010610d:	eb 90                	jmp    8010609f <mappages+0x47>
8010610f:	90                   	nop
      return -1;
80106110:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106115:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106118:	5b                   	pop    %ebx
80106119:	5e                   	pop    %esi
8010611a:	5f                   	pop    %edi
8010611b:	5d                   	pop    %ebp
8010611c:	c3                   	ret
8010611d:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
80106120:	31 c0                	xor    %eax,%eax
}
80106122:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106125:	5b                   	pop    %ebx
80106126:	5e                   	pop    %esi
80106127:	5f                   	pop    %edi
80106128:	5d                   	pop    %ebp
80106129:	c3                   	ret
      panic("remap");
8010612a:	83 ec 0c             	sub    $0xc,%esp
8010612d:	68 ad 6c 10 80       	push   $0x80106cad
80106132:	e8 01 a2 ff ff       	call   80100338 <panic>
80106137:	90                   	nop

80106138 <seginit>:
{
80106138:	55                   	push   %ebp
80106139:	89 e5                	mov    %esp,%ebp
8010613b:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
8010613e:	e8 91 d3 ff ff       	call   801034d4 <cpuid>
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106143:	8d 14 80             	lea    (%eax,%eax,4),%edx
80106146:	01 d2                	add    %edx,%edx
80106148:	01 d0                	add    %edx,%eax
8010614a:	c1 e0 04             	shl    $0x4,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010614d:	c7 80 18 18 11 80 ff 	movl   $0xffff,-0x7feee7e8(%eax)
80106154:	ff 00 00 
80106157:	c7 80 1c 18 11 80 00 	movl   $0xcf9a00,-0x7feee7e4(%eax)
8010615e:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106161:	c7 80 20 18 11 80 ff 	movl   $0xffff,-0x7feee7e0(%eax)
80106168:	ff 00 00 
8010616b:	c7 80 24 18 11 80 00 	movl   $0xcf9200,-0x7feee7dc(%eax)
80106172:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106175:	c7 80 28 18 11 80 ff 	movl   $0xffff,-0x7feee7d8(%eax)
8010617c:	ff 00 00 
8010617f:	c7 80 2c 18 11 80 00 	movl   $0xcffa00,-0x7feee7d4(%eax)
80106186:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106189:	c7 80 30 18 11 80 ff 	movl   $0xffff,-0x7feee7d0(%eax)
80106190:	ff 00 00 
80106193:	c7 80 34 18 11 80 00 	movl   $0xcff200,-0x7feee7cc(%eax)
8010619a:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010619d:	05 10 18 11 80       	add    $0x80111810,%eax
  pd[0] = size-1;
801061a2:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
  pd[1] = (uint)p;
801061a8:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801061ac:	c1 e8 10             	shr    $0x10,%eax
801061af:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801061b3:	8d 45 f2             	lea    -0xe(%ebp),%eax
801061b6:	0f 01 10             	lgdtl  (%eax)
}
801061b9:	c9                   	leave
801061ba:	c3                   	ret
801061bb:	90                   	nop

801061bc <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801061bc:	a1 c4 44 11 80       	mov    0x801144c4,%eax
801061c1:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801061c6:	0f 22 d8             	mov    %eax,%cr3
}
801061c9:	c3                   	ret
801061ca:	66 90                	xchg   %ax,%ax

801061cc <switchuvm>:
{
801061cc:	55                   	push   %ebp
801061cd:	89 e5                	mov    %esp,%ebp
801061cf:	57                   	push   %edi
801061d0:	56                   	push   %esi
801061d1:	53                   	push   %ebx
801061d2:	83 ec 1c             	sub    $0x1c,%esp
801061d5:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801061d8:	85 f6                	test   %esi,%esi
801061da:	0f 84 bf 00 00 00    	je     8010629f <switchuvm+0xd3>
  if(p->kstack == 0)
801061e0:	8b 56 08             	mov    0x8(%esi),%edx
801061e3:	85 d2                	test   %edx,%edx
801061e5:	0f 84 ce 00 00 00    	je     801062b9 <switchuvm+0xed>
  if(p->pgdir == 0)
801061eb:	8b 46 04             	mov    0x4(%esi),%eax
801061ee:	85 c0                	test   %eax,%eax
801061f0:	0f 84 b6 00 00 00    	je     801062ac <switchuvm+0xe0>
  pushcli();
801061f6:	e8 ed dc ff ff       	call   80103ee8 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801061fb:	e8 70 d2 ff ff       	call   80103470 <mycpu>
80106200:	89 c3                	mov    %eax,%ebx
80106202:	e8 69 d2 ff ff       	call   80103470 <mycpu>
80106207:	89 c7                	mov    %eax,%edi
80106209:	e8 62 d2 ff ff       	call   80103470 <mycpu>
8010620e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106211:	e8 5a d2 ff ff       	call   80103470 <mycpu>
80106216:	66 c7 83 98 00 00 00 	movw   $0x67,0x98(%ebx)
8010621d:	67 00 
8010621f:	83 c7 08             	add    $0x8,%edi
80106222:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106229:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010622c:	83 c1 08             	add    $0x8,%ecx
8010622f:	c1 e9 10             	shr    $0x10,%ecx
80106232:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106238:	66 c7 83 9d 00 00 00 	movw   $0x4099,0x9d(%ebx)
8010623f:	99 40 
80106241:	83 c0 08             	add    $0x8,%eax
80106244:	c1 e8 18             	shr    $0x18,%eax
80106247:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
8010624d:	e8 1e d2 ff ff       	call   80103470 <mycpu>
80106252:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106259:	e8 12 d2 ff ff       	call   80103470 <mycpu>
8010625e:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106264:	8b 5e 08             	mov    0x8(%esi),%ebx
80106267:	e8 04 d2 ff ff       	call   80103470 <mycpu>
8010626c:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106272:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106275:	e8 f6 d1 ff ff       	call   80103470 <mycpu>
8010627a:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106280:	b8 28 00 00 00       	mov    $0x28,%eax
80106285:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106288:	8b 46 04             	mov    0x4(%esi),%eax
8010628b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106290:	0f 22 d8             	mov    %eax,%cr3
}
80106293:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106296:	5b                   	pop    %ebx
80106297:	5e                   	pop    %esi
80106298:	5f                   	pop    %edi
80106299:	5d                   	pop    %ebp
  popcli();
8010629a:	e9 95 dc ff ff       	jmp    80103f34 <popcli>
    panic("switchuvm: no process");
8010629f:	83 ec 0c             	sub    $0xc,%esp
801062a2:	68 b3 6c 10 80       	push   $0x80106cb3
801062a7:	e8 8c a0 ff ff       	call   80100338 <panic>
    panic("switchuvm: no pgdir");
801062ac:	83 ec 0c             	sub    $0xc,%esp
801062af:	68 de 6c 10 80       	push   $0x80106cde
801062b4:	e8 7f a0 ff ff       	call   80100338 <panic>
    panic("switchuvm: no kstack");
801062b9:	83 ec 0c             	sub    $0xc,%esp
801062bc:	68 c9 6c 10 80       	push   $0x80106cc9
801062c1:	e8 72 a0 ff ff       	call   80100338 <panic>
801062c6:	66 90                	xchg   %ax,%ax

801062c8 <inituvm>:
{
801062c8:	55                   	push   %ebp
801062c9:	89 e5                	mov    %esp,%ebp
801062cb:	57                   	push   %edi
801062cc:	56                   	push   %esi
801062cd:	53                   	push   %ebx
801062ce:	83 ec 1c             	sub    $0x1c,%esp
801062d1:	8b 45 08             	mov    0x8(%ebp),%eax
801062d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801062d7:	8b 7d 0c             	mov    0xc(%ebp),%edi
801062da:	8b 75 10             	mov    0x10(%ebp),%esi
  if(sz >= PGSIZE)
801062dd:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801062e3:	77 47                	ja     8010632c <inituvm+0x64>
  mem = kalloc();
801062e5:	e8 6a c0 ff ff       	call   80102354 <kalloc>
801062ea:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801062ec:	50                   	push   %eax
801062ed:	68 00 10 00 00       	push   $0x1000
801062f2:	6a 00                	push   $0x0
801062f4:	53                   	push   %ebx
801062f5:	e8 0e de ff ff       	call   80104108 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801062fa:	5a                   	pop    %edx
801062fb:	59                   	pop    %ecx
801062fc:	6a 06                	push   $0x6
801062fe:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106304:	50                   	push   %eax
80106305:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010630a:	31 d2                	xor    %edx,%edx
8010630c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010630f:	e8 44 fd ff ff       	call   80106058 <mappages>
  memmove(mem, init, sz);
80106314:	83 c4 10             	add    $0x10,%esp
80106317:	89 75 10             	mov    %esi,0x10(%ebp)
8010631a:	89 7d 0c             	mov    %edi,0xc(%ebp)
8010631d:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106320:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106323:	5b                   	pop    %ebx
80106324:	5e                   	pop    %esi
80106325:	5f                   	pop    %edi
80106326:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106327:	e9 58 de ff ff       	jmp    80104184 <memmove>
    panic("inituvm: more than a page");
8010632c:	83 ec 0c             	sub    $0xc,%esp
8010632f:	68 f2 6c 10 80       	push   $0x80106cf2
80106334:	e8 ff 9f ff ff       	call   80100338 <panic>
80106339:	8d 76 00             	lea    0x0(%esi),%esi

8010633c <loaduvm>:
{
8010633c:	55                   	push   %ebp
8010633d:	89 e5                	mov    %esp,%ebp
8010633f:	57                   	push   %edi
80106340:	56                   	push   %esi
80106341:	53                   	push   %ebx
80106342:	83 ec 0c             	sub    $0xc,%esp
80106345:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
80106348:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010634b:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80106351:	0f 85 9a 00 00 00    	jne    801063f1 <loaduvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
80106357:	85 ff                	test   %edi,%edi
80106359:	74 7c                	je     801063d7 <loaduvm+0x9b>
8010635b:	90                   	nop
  pde = &pgdir[PDX(va)];
8010635c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010635f:	01 d8                	add    %ebx,%eax
80106361:	89 c2                	mov    %eax,%edx
80106363:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106366:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106369:	8b 14 91             	mov    (%ecx,%edx,4),%edx
8010636c:	f6 c2 01             	test   $0x1,%dl
8010636f:	75 0f                	jne    80106380 <loaduvm+0x44>
      panic("loaduvm: address should exist");
80106371:	83 ec 0c             	sub    $0xc,%esp
80106374:	68 0c 6d 10 80       	push   $0x80106d0c
80106379:	e8 ba 9f ff ff       	call   80100338 <panic>
8010637e:	66 90                	xchg   %ax,%ax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106380:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80106386:	c1 e8 0a             	shr    $0xa,%eax
80106389:	25 fc 0f 00 00       	and    $0xffc,%eax
8010638e:	8d 8c 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106395:	85 c9                	test   %ecx,%ecx
80106397:	74 d8                	je     80106371 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80106399:	89 fe                	mov    %edi,%esi
8010639b:	29 de                	sub    %ebx,%esi
8010639d:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
801063a3:	76 05                	jbe    801063aa <loaduvm+0x6e>
801063a5:	be 00 10 00 00       	mov    $0x1000,%esi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801063aa:	56                   	push   %esi
801063ab:	8b 45 14             	mov    0x14(%ebp),%eax
801063ae:	01 d8                	add    %ebx,%eax
801063b0:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
801063b1:	8b 01                	mov    (%ecx),%eax
801063b3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801063b8:	05 00 00 00 80       	add    $0x80000000,%eax
801063bd:	50                   	push   %eax
801063be:	ff 75 10             	push   0x10(%ebp)
801063c1:	e8 e6 b4 ff ff       	call   801018ac <readi>
801063c6:	83 c4 10             	add    $0x10,%esp
801063c9:	39 f0                	cmp    %esi,%eax
801063cb:	75 17                	jne    801063e4 <loaduvm+0xa8>
  for(i = 0; i < sz; i += PGSIZE){
801063cd:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801063d3:	39 fb                	cmp    %edi,%ebx
801063d5:	72 85                	jb     8010635c <loaduvm+0x20>
  return 0;
801063d7:	31 c0                	xor    %eax,%eax
}
801063d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801063dc:	5b                   	pop    %ebx
801063dd:	5e                   	pop    %esi
801063de:	5f                   	pop    %edi
801063df:	5d                   	pop    %ebp
801063e0:	c3                   	ret
801063e1:	8d 76 00             	lea    0x0(%esi),%esi
      return -1;
801063e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801063ec:	5b                   	pop    %ebx
801063ed:	5e                   	pop    %esi
801063ee:	5f                   	pop    %edi
801063ef:	5d                   	pop    %ebp
801063f0:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
801063f1:	83 ec 0c             	sub    $0xc,%esp
801063f4:	68 30 6f 10 80       	push   $0x80106f30
801063f9:	e8 3a 9f ff ff       	call   80100338 <panic>
801063fe:	66 90                	xchg   %ax,%ax

80106400 <allocuvm>:
{
80106400:	55                   	push   %ebp
80106401:	89 e5                	mov    %esp,%ebp
80106403:	57                   	push   %edi
80106404:	56                   	push   %esi
80106405:	53                   	push   %ebx
80106406:	83 ec 1c             	sub    $0x1c,%esp
80106409:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
8010640c:	85 f6                	test   %esi,%esi
8010640e:	0f 88 8a 00 00 00    	js     8010649e <allocuvm+0x9e>
80106414:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
80106416:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106419:	0f 82 8d 00 00 00    	jb     801064ac <allocuvm+0xac>
  a = PGROUNDUP(oldsz);
8010641f:	8b 45 0c             	mov    0xc(%ebp),%eax
80106422:	05 ff 0f 00 00       	add    $0xfff,%eax
80106427:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010642c:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
8010642e:	39 f0                	cmp    %esi,%eax
80106430:	73 7d                	jae    801064af <allocuvm+0xaf>
80106432:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80106435:	eb 3a                	jmp    80106471 <allocuvm+0x71>
80106437:	90                   	nop
    memset(mem, 0, PGSIZE);
80106438:	50                   	push   %eax
80106439:	68 00 10 00 00       	push   $0x1000
8010643e:	6a 00                	push   $0x0
80106440:	53                   	push   %ebx
80106441:	e8 c2 dc ff ff       	call   80104108 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106446:	5a                   	pop    %edx
80106447:	59                   	pop    %ecx
80106448:	6a 06                	push   $0x6
8010644a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106450:	50                   	push   %eax
80106451:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106456:	89 fa                	mov    %edi,%edx
80106458:	8b 45 08             	mov    0x8(%ebp),%eax
8010645b:	e8 f8 fb ff ff       	call   80106058 <mappages>
80106460:	83 c4 10             	add    $0x10,%esp
80106463:	85 c0                	test   %eax,%eax
80106465:	78 55                	js     801064bc <allocuvm+0xbc>
  for(; a < newsz; a += PGSIZE){
80106467:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010646d:	39 f7                	cmp    %esi,%edi
8010646f:	73 7f                	jae    801064f0 <allocuvm+0xf0>
    mem = kalloc();
80106471:	e8 de be ff ff       	call   80102354 <kalloc>
80106476:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106478:	85 c0                	test   %eax,%eax
8010647a:	75 bc                	jne    80106438 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
8010647c:	83 ec 0c             	sub    $0xc,%esp
8010647f:	68 2a 6d 10 80       	push   $0x80106d2a
80106484:	e8 9f a1 ff ff       	call   80100628 <cprintf>
  if(newsz >= oldsz)
80106489:	83 c4 10             	add    $0x10,%esp
8010648c:	3b 75 0c             	cmp    0xc(%ebp),%esi
8010648f:	74 0d                	je     8010649e <allocuvm+0x9e>
80106491:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106494:	89 f2                	mov    %esi,%edx
80106496:	8b 45 08             	mov    0x8(%ebp),%eax
80106499:	e8 0a fb ff ff       	call   80105fa8 <deallocuvm.part.0>
    return 0;
8010649e:	31 d2                	xor    %edx,%edx
}
801064a0:	89 d0                	mov    %edx,%eax
801064a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064a5:	5b                   	pop    %ebx
801064a6:	5e                   	pop    %esi
801064a7:	5f                   	pop    %edi
801064a8:	5d                   	pop    %ebp
801064a9:	c3                   	ret
801064aa:	66 90                	xchg   %ax,%ax
    return oldsz;
801064ac:	8b 55 0c             	mov    0xc(%ebp),%edx
}
801064af:	89 d0                	mov    %edx,%eax
801064b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064b4:	5b                   	pop    %ebx
801064b5:	5e                   	pop    %esi
801064b6:	5f                   	pop    %edi
801064b7:	5d                   	pop    %ebp
801064b8:	c3                   	ret
801064b9:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801064bc:	83 ec 0c             	sub    $0xc,%esp
801064bf:	68 42 6d 10 80       	push   $0x80106d42
801064c4:	e8 5f a1 ff ff       	call   80100628 <cprintf>
  if(newsz >= oldsz)
801064c9:	83 c4 10             	add    $0x10,%esp
801064cc:	3b 75 0c             	cmp    0xc(%ebp),%esi
801064cf:	74 0d                	je     801064de <allocuvm+0xde>
801064d1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801064d4:	89 f2                	mov    %esi,%edx
801064d6:	8b 45 08             	mov    0x8(%ebp),%eax
801064d9:	e8 ca fa ff ff       	call   80105fa8 <deallocuvm.part.0>
      kfree(mem);
801064de:	83 ec 0c             	sub    $0xc,%esp
801064e1:	53                   	push   %ebx
801064e2:	e8 dd bc ff ff       	call   801021c4 <kfree>
      return 0;
801064e7:	83 c4 10             	add    $0x10,%esp
    return 0;
801064ea:	31 d2                	xor    %edx,%edx
801064ec:	eb b2                	jmp    801064a0 <allocuvm+0xa0>
801064ee:	66 90                	xchg   %ax,%ax
801064f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
801064f3:	89 d0                	mov    %edx,%eax
801064f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064f8:	5b                   	pop    %ebx
801064f9:	5e                   	pop    %esi
801064fa:	5f                   	pop    %edi
801064fb:	5d                   	pop    %ebp
801064fc:	c3                   	ret
801064fd:	8d 76 00             	lea    0x0(%esi),%esi

80106500 <deallocuvm>:
{
80106500:	55                   	push   %ebp
80106501:	89 e5                	mov    %esp,%ebp
80106503:	8b 45 08             	mov    0x8(%ebp),%eax
80106506:	8b 55 0c             	mov    0xc(%ebp),%edx
80106509:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if(newsz >= oldsz)
8010650c:	39 d1                	cmp    %edx,%ecx
8010650e:	73 08                	jae    80106518 <deallocuvm+0x18>
}
80106510:	5d                   	pop    %ebp
80106511:	e9 92 fa ff ff       	jmp    80105fa8 <deallocuvm.part.0>
80106516:	66 90                	xchg   %ax,%ax
80106518:	89 d0                	mov    %edx,%eax
8010651a:	5d                   	pop    %ebp
8010651b:	c3                   	ret

8010651c <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
8010651c:	55                   	push   %ebp
8010651d:	89 e5                	mov    %esp,%ebp
8010651f:	57                   	push   %edi
80106520:	56                   	push   %esi
80106521:	53                   	push   %ebx
80106522:	83 ec 0c             	sub    $0xc,%esp
80106525:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106528:	85 f6                	test   %esi,%esi
8010652a:	74 51                	je     8010657d <freevm+0x61>
  if(newsz >= oldsz)
8010652c:	31 c9                	xor    %ecx,%ecx
8010652e:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106533:	89 f0                	mov    %esi,%eax
80106535:	e8 6e fa ff ff       	call   80105fa8 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
8010653a:	89 f3                	mov    %esi,%ebx
8010653c:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106542:	eb 07                	jmp    8010654b <freevm+0x2f>
80106544:	83 c3 04             	add    $0x4,%ebx
80106547:	39 fb                	cmp    %edi,%ebx
80106549:	74 23                	je     8010656e <freevm+0x52>
    if(pgdir[i] & PTE_P){
8010654b:	8b 03                	mov    (%ebx),%eax
8010654d:	a8 01                	test   $0x1,%al
8010654f:	74 f3                	je     80106544 <freevm+0x28>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106551:	83 ec 0c             	sub    $0xc,%esp
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106554:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106559:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010655e:	50                   	push   %eax
8010655f:	e8 60 bc ff ff       	call   801021c4 <kfree>
80106564:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106567:	83 c3 04             	add    $0x4,%ebx
8010656a:	39 fb                	cmp    %edi,%ebx
8010656c:	75 dd                	jne    8010654b <freevm+0x2f>
    }
  }
  kfree((char*)pgdir);
8010656e:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106571:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106574:	5b                   	pop    %ebx
80106575:	5e                   	pop    %esi
80106576:	5f                   	pop    %edi
80106577:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106578:	e9 47 bc ff ff       	jmp    801021c4 <kfree>
    panic("freevm: no pgdir");
8010657d:	83 ec 0c             	sub    $0xc,%esp
80106580:	68 5e 6d 10 80       	push   $0x80106d5e
80106585:	e8 ae 9d ff ff       	call   80100338 <panic>
8010658a:	66 90                	xchg   %ax,%ax

8010658c <setupkvm>:
{
8010658c:	55                   	push   %ebp
8010658d:	89 e5                	mov    %esp,%ebp
8010658f:	56                   	push   %esi
80106590:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106591:	e8 be bd ff ff       	call   80102354 <kalloc>
80106596:	85 c0                	test   %eax,%eax
80106598:	74 5a                	je     801065f4 <setupkvm+0x68>
8010659a:	89 c6                	mov    %eax,%esi
  memset(pgdir, 0, PGSIZE);
8010659c:	50                   	push   %eax
8010659d:	68 00 10 00 00       	push   $0x1000
801065a2:	6a 00                	push   $0x0
801065a4:	56                   	push   %esi
801065a5:	e8 5e db ff ff       	call   80104108 <memset>
801065aa:	83 c4 10             	add    $0x10,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801065ad:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
                (uint)k->phys_start, k->perm) < 0) {
801065b2:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801065b5:	8b 4b 08             	mov    0x8(%ebx),%ecx
801065b8:	29 c1                	sub    %eax,%ecx
801065ba:	8b 13                	mov    (%ebx),%edx
801065bc:	83 ec 08             	sub    $0x8,%esp
801065bf:	ff 73 0c             	push   0xc(%ebx)
801065c2:	50                   	push   %eax
801065c3:	89 f0                	mov    %esi,%eax
801065c5:	e8 8e fa ff ff       	call   80106058 <mappages>
801065ca:	83 c4 10             	add    $0x10,%esp
801065cd:	85 c0                	test   %eax,%eax
801065cf:	78 17                	js     801065e8 <setupkvm+0x5c>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801065d1:	83 c3 10             	add    $0x10,%ebx
801065d4:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
801065da:	75 d6                	jne    801065b2 <setupkvm+0x26>
}
801065dc:	89 f0                	mov    %esi,%eax
801065de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801065e1:	5b                   	pop    %ebx
801065e2:	5e                   	pop    %esi
801065e3:	5d                   	pop    %ebp
801065e4:	c3                   	ret
801065e5:	8d 76 00             	lea    0x0(%esi),%esi
      freevm(pgdir);
801065e8:	83 ec 0c             	sub    $0xc,%esp
801065eb:	56                   	push   %esi
801065ec:	e8 2b ff ff ff       	call   8010651c <freevm>
      return 0;
801065f1:	83 c4 10             	add    $0x10,%esp
    return 0;
801065f4:	31 f6                	xor    %esi,%esi
}
801065f6:	89 f0                	mov    %esi,%eax
801065f8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801065fb:	5b                   	pop    %ebx
801065fc:	5e                   	pop    %esi
801065fd:	5d                   	pop    %ebp
801065fe:	c3                   	ret
801065ff:	90                   	nop

80106600 <kvmalloc>:
{
80106600:	55                   	push   %ebp
80106601:	89 e5                	mov    %esp,%ebp
80106603:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106606:	e8 81 ff ff ff       	call   8010658c <setupkvm>
8010660b:	a3 c4 44 11 80       	mov    %eax,0x801144c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106610:	05 00 00 00 80       	add    $0x80000000,%eax
80106615:	0f 22 d8             	mov    %eax,%cr3
}
80106618:	c9                   	leave
80106619:	c3                   	ret
8010661a:	66 90                	xchg   %ax,%ax

8010661c <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
8010661c:	55                   	push   %ebp
8010661d:	89 e5                	mov    %esp,%ebp
8010661f:	83 ec 08             	sub    $0x8,%esp
  pde = &pgdir[PDX(va)];
80106622:	8b 55 0c             	mov    0xc(%ebp),%edx
80106625:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106628:	8b 45 08             	mov    0x8(%ebp),%eax
8010662b:	8b 04 90             	mov    (%eax,%edx,4),%eax
8010662e:	a8 01                	test   $0x1,%al
80106630:	75 0e                	jne    80106640 <clearpteu+0x24>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106632:	83 ec 0c             	sub    $0xc,%esp
80106635:	68 6f 6d 10 80       	push   $0x80106d6f
8010663a:	e8 f9 9c ff ff       	call   80100338 <panic>
8010663f:	90                   	nop
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106640:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106645:	89 c2                	mov    %eax,%edx
  return &pgtab[PTX(va)];
80106647:	8b 45 0c             	mov    0xc(%ebp),%eax
8010664a:	c1 e8 0a             	shr    $0xa,%eax
8010664d:	25 fc 0f 00 00       	and    $0xffc,%eax
80106652:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80106659:	85 c0                	test   %eax,%eax
8010665b:	74 d5                	je     80106632 <clearpteu+0x16>
  *pte &= ~PTE_U;
8010665d:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106660:	c9                   	leave
80106661:	c3                   	ret
80106662:	66 90                	xchg   %ax,%ax

80106664 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106664:	55                   	push   %ebp
80106665:	89 e5                	mov    %esp,%ebp
80106667:	57                   	push   %edi
80106668:	56                   	push   %esi
80106669:	53                   	push   %ebx
8010666a:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
8010666d:	e8 1a ff ff ff       	call   8010658c <setupkvm>
80106672:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106675:	85 c0                	test   %eax,%eax
80106677:	0f 84 d5 00 00 00    	je     80106752 <copyuvm+0xee>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010667d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80106680:	85 db                	test   %ebx,%ebx
80106682:	0f 84 a5 00 00 00    	je     8010672d <copyuvm+0xc9>
80106688:	31 ff                	xor    %edi,%edi
8010668a:	66 90                	xchg   %ax,%ax
  pde = &pgdir[PDX(va)];
8010668c:	89 f8                	mov    %edi,%eax
8010668e:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80106691:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106694:	8b 04 81             	mov    (%ecx,%eax,4),%eax
80106697:	a8 01                	test   $0x1,%al
80106699:	75 0d                	jne    801066a8 <copyuvm+0x44>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010669b:	83 ec 0c             	sub    $0xc,%esp
8010669e:	68 79 6d 10 80       	push   $0x80106d79
801066a3:	e8 90 9c ff ff       	call   80100338 <panic>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801066a8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801066ad:	89 fa                	mov    %edi,%edx
801066af:	c1 ea 0a             	shr    $0xa,%edx
801066b2:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801066b8:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801066bf:	85 c0                	test   %eax,%eax
801066c1:	74 d8                	je     8010669b <copyuvm+0x37>
    if(!(*pte & PTE_P))
801066c3:	8b 18                	mov    (%eax),%ebx
801066c5:	f6 c3 01             	test   $0x1,%bl
801066c8:	0f 84 96 00 00 00    	je     80106764 <copyuvm+0x100>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801066ce:	89 d8                	mov    %ebx,%eax
801066d0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801066d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    flags = PTE_FLAGS(*pte);
801066d8:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    if((mem = kalloc()) == 0)
801066de:	e8 71 bc ff ff       	call   80102354 <kalloc>
801066e3:	89 c6                	mov    %eax,%esi
801066e5:	85 c0                	test   %eax,%eax
801066e7:	74 5b                	je     80106744 <copyuvm+0xe0>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801066e9:	50                   	push   %eax
801066ea:	68 00 10 00 00       	push   $0x1000
801066ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801066f2:	05 00 00 00 80       	add    $0x80000000,%eax
801066f7:	50                   	push   %eax
801066f8:	56                   	push   %esi
801066f9:	e8 86 da ff ff       	call   80104184 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801066fe:	5a                   	pop    %edx
801066ff:	59                   	pop    %ecx
80106700:	53                   	push   %ebx
80106701:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106707:	50                   	push   %eax
80106708:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010670d:	89 fa                	mov    %edi,%edx
8010670f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106712:	e8 41 f9 ff ff       	call   80106058 <mappages>
80106717:	83 c4 10             	add    $0x10,%esp
8010671a:	85 c0                	test   %eax,%eax
8010671c:	78 1a                	js     80106738 <copyuvm+0xd4>
  for(i = 0; i < sz; i += PGSIZE){
8010671e:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106724:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106727:	0f 82 5f ff ff ff    	jb     8010668c <copyuvm+0x28>
  return d;

bad:
  freevm(d);
  return 0;
}
8010672d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106730:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106733:	5b                   	pop    %ebx
80106734:	5e                   	pop    %esi
80106735:	5f                   	pop    %edi
80106736:	5d                   	pop    %ebp
80106737:	c3                   	ret
      kfree(mem);
80106738:	83 ec 0c             	sub    $0xc,%esp
8010673b:	56                   	push   %esi
8010673c:	e8 83 ba ff ff       	call   801021c4 <kfree>
      goto bad;
80106741:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80106744:	83 ec 0c             	sub    $0xc,%esp
80106747:	ff 75 e0             	push   -0x20(%ebp)
8010674a:	e8 cd fd ff ff       	call   8010651c <freevm>
  return 0;
8010674f:	83 c4 10             	add    $0x10,%esp
    return 0;
80106752:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80106759:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010675c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010675f:	5b                   	pop    %ebx
80106760:	5e                   	pop    %esi
80106761:	5f                   	pop    %edi
80106762:	5d                   	pop    %ebp
80106763:	c3                   	ret
      panic("copyuvm: page not present");
80106764:	83 ec 0c             	sub    $0xc,%esp
80106767:	68 93 6d 10 80       	push   $0x80106d93
8010676c:	e8 c7 9b ff ff       	call   80100338 <panic>
80106771:	8d 76 00             	lea    0x0(%esi),%esi

80106774 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106774:	55                   	push   %ebp
80106775:	89 e5                	mov    %esp,%ebp
  pde = &pgdir[PDX(va)];
80106777:	8b 55 0c             	mov    0xc(%ebp),%edx
8010677a:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
8010677d:	8b 45 08             	mov    0x8(%ebp),%eax
80106780:	8b 04 90             	mov    (%eax,%edx,4),%eax
80106783:	a8 01                	test   $0x1,%al
80106785:	0f 84 ef 00 00 00    	je     8010687a <uva2ka.cold>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010678b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106790:	89 c2                	mov    %eax,%edx
  return &pgtab[PTX(va)];
80106792:	8b 45 0c             	mov    0xc(%ebp),%eax
80106795:	c1 e8 0c             	shr    $0xc,%eax
80106798:	25 ff 03 00 00       	and    $0x3ff,%eax
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
8010679d:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
    return 0;
  if((*pte & PTE_U) == 0)
801067a4:	89 c2                	mov    %eax,%edx
801067a6:	f7 d2                	not    %edx
801067a8:	83 e2 05             	and    $0x5,%edx
801067ab:	75 0f                	jne    801067bc <uva2ka+0x48>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801067ad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801067b2:	05 00 00 00 80       	add    $0x80000000,%eax
}
801067b7:	5d                   	pop    %ebp
801067b8:	c3                   	ret
801067b9:	8d 76 00             	lea    0x0(%esi),%esi
    return 0;
801067bc:	31 c0                	xor    %eax,%eax
}
801067be:	5d                   	pop    %ebp
801067bf:	c3                   	ret

801067c0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801067c0:	55                   	push   %ebp
801067c1:	89 e5                	mov    %esp,%ebp
801067c3:	57                   	push   %edi
801067c4:	56                   	push   %esi
801067c5:	53                   	push   %ebx
801067c6:	83 ec 0c             	sub    $0xc,%esp
801067c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801067cc:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801067cf:	8b 4d 14             	mov    0x14(%ebp),%ecx
801067d2:	85 c9                	test   %ecx,%ecx
801067d4:	0f 84 96 00 00 00    	je     80106870 <copyout+0xb0>
801067da:	89 fe                	mov    %edi,%esi
801067dc:	eb 45                	jmp    80106823 <copyout+0x63>
801067de:	66 90                	xchg   %ax,%ax
  return (char*)P2V(PTE_ADDR(*pte));
801067e0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801067e6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
801067ec:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801067f2:	74 6c                	je     80106860 <copyout+0xa0>
      return -1;
    n = PGSIZE - (va - va0);
801067f4:	89 fb                	mov    %edi,%ebx
801067f6:	29 c3                	sub    %eax,%ebx
    if(n > len)
801067f8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801067fe:	39 5d 14             	cmp    %ebx,0x14(%ebp)
80106801:	73 03                	jae    80106806 <copyout+0x46>
80106803:	8b 5d 14             	mov    0x14(%ebp),%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106806:	52                   	push   %edx
80106807:	53                   	push   %ebx
80106808:	56                   	push   %esi
80106809:	29 f8                	sub    %edi,%eax
8010680b:	01 c1                	add    %eax,%ecx
8010680d:	51                   	push   %ecx
8010680e:	e8 71 d9 ff ff       	call   80104184 <memmove>
    len -= n;
    buf += n;
80106813:	01 de                	add    %ebx,%esi
    va = va0 + PGSIZE;
80106815:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010681b:	83 c4 10             	add    $0x10,%esp
8010681e:	29 5d 14             	sub    %ebx,0x14(%ebp)
80106821:	74 4d                	je     80106870 <copyout+0xb0>
    va0 = (uint)PGROUNDDOWN(va);
80106823:	89 c7                	mov    %eax,%edi
80106825:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  pde = &pgdir[PDX(va)];
8010682b:	89 c1                	mov    %eax,%ecx
8010682d:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80106830:	8b 55 08             	mov    0x8(%ebp),%edx
80106833:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80106836:	f6 c1 01             	test   $0x1,%cl
80106839:	0f 84 42 00 00 00    	je     80106881 <copyout.cold>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010683f:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106845:	89 fb                	mov    %edi,%ebx
80106847:	c1 eb 0c             	shr    $0xc,%ebx
8010684a:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80106850:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
80106857:	89 d9                	mov    %ebx,%ecx
80106859:	f7 d1                	not    %ecx
8010685b:	83 e1 05             	and    $0x5,%ecx
8010685e:	74 80                	je     801067e0 <copyout+0x20>
      return -1;
80106860:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106865:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106868:	5b                   	pop    %ebx
80106869:	5e                   	pop    %esi
8010686a:	5f                   	pop    %edi
8010686b:	5d                   	pop    %ebp
8010686c:	c3                   	ret
8010686d:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
80106870:	31 c0                	xor    %eax,%eax
}
80106872:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106875:	5b                   	pop    %ebx
80106876:	5e                   	pop    %esi
80106877:	5f                   	pop    %edi
80106878:	5d                   	pop    %ebp
80106879:	c3                   	ret

8010687a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
8010687a:	a1 00 00 00 00       	mov    0x0,%eax
8010687f:	0f 0b                	ud2

80106881 <copyout.cold>:
80106881:	a1 00 00 00 00       	mov    0x0,%eax
80106886:	0f 0b                	ud2
