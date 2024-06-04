
_my_countfp:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int 
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	50                   	push   %eax
    int cnt;
    cnt = countfp();
   f:	e8 77 02 00 00       	call   28b <countfp>
    printf(1, "The num of total free page in the system: %d\n", cnt);
  14:	52                   	push   %edx
  15:	50                   	push   %eax
  16:	68 ec 05 00 00       	push   $0x5ec
  1b:	6a 01                	push   $0x1
  1d:	e8 fe 02 00 00       	call   320 <printf>
    exit();
  22:	e8 c4 01 00 00       	call   1eb <exit>
  27:	90                   	nop

00000028 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  28:	55                   	push   %ebp
  29:	89 e5                	mov    %esp,%ebp
  2b:	53                   	push   %ebx
  2c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  2f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  32:	31 c0                	xor    %eax,%eax
  34:	8a 14 03             	mov    (%ebx,%eax,1),%dl
  37:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  3a:	40                   	inc    %eax
  3b:	84 d2                	test   %dl,%dl
  3d:	75 f5                	jne    34 <strcpy+0xc>
    ;
  return os;
}
  3f:	89 c8                	mov    %ecx,%eax
  41:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  44:	c9                   	leave
  45:	c3                   	ret
  46:	66 90                	xchg   %ax,%ax

00000048 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  48:	55                   	push   %ebp
  49:	89 e5                	mov    %esp,%ebp
  4b:	53                   	push   %ebx
  4c:	8b 55 08             	mov    0x8(%ebp),%edx
  4f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  52:	0f b6 02             	movzbl (%edx),%eax
  55:	84 c0                	test   %al,%al
  57:	75 10                	jne    69 <strcmp+0x21>
  59:	eb 2a                	jmp    85 <strcmp+0x3d>
  5b:	90                   	nop
    p++, q++;
  5c:	42                   	inc    %edx
  5d:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
  60:	0f b6 02             	movzbl (%edx),%eax
  63:	84 c0                	test   %al,%al
  65:	74 11                	je     78 <strcmp+0x30>
  67:	89 cb                	mov    %ecx,%ebx
  69:	0f b6 0b             	movzbl (%ebx),%ecx
  6c:	38 c1                	cmp    %al,%cl
  6e:	74 ec                	je     5c <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  70:	29 c8                	sub    %ecx,%eax
}
  72:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  75:	c9                   	leave
  76:	c3                   	ret
  77:	90                   	nop
  return (uchar)*p - (uchar)*q;
  78:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  7c:	31 c0                	xor    %eax,%eax
  7e:	29 c8                	sub    %ecx,%eax
}
  80:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  83:	c9                   	leave
  84:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  85:	0f b6 0b             	movzbl (%ebx),%ecx
  88:	31 c0                	xor    %eax,%eax
  8a:	eb e4                	jmp    70 <strcmp+0x28>

0000008c <strlen>:

uint
strlen(const char *s)
{
  8c:	55                   	push   %ebp
  8d:	89 e5                	mov    %esp,%ebp
  8f:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  92:	80 3a 00             	cmpb   $0x0,(%edx)
  95:	74 15                	je     ac <strlen+0x20>
  97:	31 c0                	xor    %eax,%eax
  99:	8d 76 00             	lea    0x0(%esi),%esi
  9c:	40                   	inc    %eax
  9d:	89 c1                	mov    %eax,%ecx
  9f:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  a3:	75 f7                	jne    9c <strlen+0x10>
    ;
  return n;
}
  a5:	89 c8                	mov    %ecx,%eax
  a7:	5d                   	pop    %ebp
  a8:	c3                   	ret
  a9:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  ac:	31 c9                	xor    %ecx,%ecx
}
  ae:	89 c8                	mov    %ecx,%eax
  b0:	5d                   	pop    %ebp
  b1:	c3                   	ret
  b2:	66 90                	xchg   %ax,%ax

000000b4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  b8:	8b 7d 08             	mov    0x8(%ebp),%edi
  bb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  be:	8b 45 0c             	mov    0xc(%ebp),%eax
  c1:	fc                   	cld
  c2:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  c4:	8b 45 08             	mov    0x8(%ebp),%eax
  c7:	8b 7d fc             	mov    -0x4(%ebp),%edi
  ca:	c9                   	leave
  cb:	c3                   	ret

000000cc <strchr>:

char*
strchr(const char *s, char c)
{
  cc:	55                   	push   %ebp
  cd:	89 e5                	mov    %esp,%ebp
  cf:	8b 45 08             	mov    0x8(%ebp),%eax
  d2:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
  d5:	8a 10                	mov    (%eax),%dl
  d7:	84 d2                	test   %dl,%dl
  d9:	75 0c                	jne    e7 <strchr+0x1b>
  db:	eb 13                	jmp    f0 <strchr+0x24>
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	40                   	inc    %eax
  e1:	8a 10                	mov    (%eax),%dl
  e3:	84 d2                	test   %dl,%dl
  e5:	74 09                	je     f0 <strchr+0x24>
    if(*s == c)
  e7:	38 d1                	cmp    %dl,%cl
  e9:	75 f5                	jne    e0 <strchr+0x14>
      return (char*)s;
  return 0;
}
  eb:	5d                   	pop    %ebp
  ec:	c3                   	ret
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
  f0:	31 c0                	xor    %eax,%eax
}
  f2:	5d                   	pop    %ebp
  f3:	c3                   	ret

000000f4 <gets>:

char*
gets(char *buf, int max)
{
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	57                   	push   %edi
  f8:	56                   	push   %esi
  f9:	53                   	push   %ebx
  fa:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  fd:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
  ff:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i=0; i+1 < max; ){
 102:	eb 24                	jmp    128 <gets+0x34>
    cc = read(0, &c, 1);
 104:	50                   	push   %eax
 105:	6a 01                	push   $0x1
 107:	56                   	push   %esi
 108:	6a 00                	push   $0x0
 10a:	e8 f4 00 00 00       	call   203 <read>
    if(cc < 1)
 10f:	83 c4 10             	add    $0x10,%esp
 112:	85 c0                	test   %eax,%eax
 114:	7e 1a                	jle    130 <gets+0x3c>
      break;
    buf[i++] = c;
 116:	8a 45 e7             	mov    -0x19(%ebp),%al
 119:	8b 55 08             	mov    0x8(%ebp),%edx
 11c:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 120:	3c 0a                	cmp    $0xa,%al
 122:	74 0e                	je     132 <gets+0x3e>
 124:	3c 0d                	cmp    $0xd,%al
 126:	74 0a                	je     132 <gets+0x3e>
  for(i=0; i+1 < max; ){
 128:	89 df                	mov    %ebx,%edi
 12a:	43                   	inc    %ebx
 12b:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 12e:	7c d4                	jl     104 <gets+0x10>
 130:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 132:	8b 45 08             	mov    0x8(%ebp),%eax
 135:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 139:	8d 65 f4             	lea    -0xc(%ebp),%esp
 13c:	5b                   	pop    %ebx
 13d:	5e                   	pop    %esi
 13e:	5f                   	pop    %edi
 13f:	5d                   	pop    %ebp
 140:	c3                   	ret
 141:	8d 76 00             	lea    0x0(%esi),%esi

00000144 <stat>:

int
stat(const char *n, struct stat *st)
{
 144:	55                   	push   %ebp
 145:	89 e5                	mov    %esp,%ebp
 147:	56                   	push   %esi
 148:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 149:	83 ec 08             	sub    $0x8,%esp
 14c:	6a 00                	push   $0x0
 14e:	ff 75 08             	push   0x8(%ebp)
 151:	e8 d5 00 00 00       	call   22b <open>
  if(fd < 0)
 156:	83 c4 10             	add    $0x10,%esp
 159:	85 c0                	test   %eax,%eax
 15b:	78 27                	js     184 <stat+0x40>
 15d:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 15f:	83 ec 08             	sub    $0x8,%esp
 162:	ff 75 0c             	push   0xc(%ebp)
 165:	50                   	push   %eax
 166:	e8 d8 00 00 00       	call   243 <fstat>
 16b:	89 c6                	mov    %eax,%esi
  close(fd);
 16d:	89 1c 24             	mov    %ebx,(%esp)
 170:	e8 9e 00 00 00       	call   213 <close>
  return r;
 175:	83 c4 10             	add    $0x10,%esp
}
 178:	89 f0                	mov    %esi,%eax
 17a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 17d:	5b                   	pop    %ebx
 17e:	5e                   	pop    %esi
 17f:	5d                   	pop    %ebp
 180:	c3                   	ret
 181:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 184:	be ff ff ff ff       	mov    $0xffffffff,%esi
 189:	eb ed                	jmp    178 <stat+0x34>
 18b:	90                   	nop

0000018c <atoi>:

int
atoi(const char *s)
{
 18c:	55                   	push   %ebp
 18d:	89 e5                	mov    %esp,%ebp
 18f:	53                   	push   %ebx
 190:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 193:	0f be 01             	movsbl (%ecx),%eax
 196:	8d 50 d0             	lea    -0x30(%eax),%edx
 199:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
 19c:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 1a1:	77 16                	ja     1b9 <atoi+0x2d>
 1a3:	90                   	nop
    n = n*10 + *s++ - '0';
 1a4:	41                   	inc    %ecx
 1a5:	8d 14 92             	lea    (%edx,%edx,4),%edx
 1a8:	01 d2                	add    %edx,%edx
 1aa:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
 1ae:	0f be 01             	movsbl (%ecx),%eax
 1b1:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1b4:	80 fb 09             	cmp    $0x9,%bl
 1b7:	76 eb                	jbe    1a4 <atoi+0x18>
  return n;
}
 1b9:	89 d0                	mov    %edx,%eax
 1bb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1be:	c9                   	leave
 1bf:	c3                   	ret

000001c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	57                   	push   %edi
 1c4:	56                   	push   %esi
 1c5:	8b 55 08             	mov    0x8(%ebp),%edx
 1c8:	8b 75 0c             	mov    0xc(%ebp),%esi
 1cb:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1ce:	85 c0                	test   %eax,%eax
 1d0:	7e 0b                	jle    1dd <memmove+0x1d>
 1d2:	01 d0                	add    %edx,%eax
  dst = vdst;
 1d4:	89 d7                	mov    %edx,%edi
 1d6:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 1d8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 1d9:	39 f8                	cmp    %edi,%eax
 1db:	75 fb                	jne    1d8 <memmove+0x18>
  return vdst;
}
 1dd:	89 d0                	mov    %edx,%eax
 1df:	5e                   	pop    %esi
 1e0:	5f                   	pop    %edi
 1e1:	5d                   	pop    %ebp
 1e2:	c3                   	ret

000001e3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1e3:	b8 01 00 00 00       	mov    $0x1,%eax
 1e8:	cd 40                	int    $0x40
 1ea:	c3                   	ret

000001eb <exit>:
SYSCALL(exit)
 1eb:	b8 02 00 00 00       	mov    $0x2,%eax
 1f0:	cd 40                	int    $0x40
 1f2:	c3                   	ret

000001f3 <wait>:
SYSCALL(wait)
 1f3:	b8 03 00 00 00       	mov    $0x3,%eax
 1f8:	cd 40                	int    $0x40
 1fa:	c3                   	ret

000001fb <pipe>:
SYSCALL(pipe)
 1fb:	b8 04 00 00 00       	mov    $0x4,%eax
 200:	cd 40                	int    $0x40
 202:	c3                   	ret

00000203 <read>:
SYSCALL(read)
 203:	b8 05 00 00 00       	mov    $0x5,%eax
 208:	cd 40                	int    $0x40
 20a:	c3                   	ret

0000020b <write>:
SYSCALL(write)
 20b:	b8 10 00 00 00       	mov    $0x10,%eax
 210:	cd 40                	int    $0x40
 212:	c3                   	ret

00000213 <close>:
SYSCALL(close)
 213:	b8 15 00 00 00       	mov    $0x15,%eax
 218:	cd 40                	int    $0x40
 21a:	c3                   	ret

0000021b <kill>:
SYSCALL(kill)
 21b:	b8 06 00 00 00       	mov    $0x6,%eax
 220:	cd 40                	int    $0x40
 222:	c3                   	ret

00000223 <exec>:
SYSCALL(exec)
 223:	b8 07 00 00 00       	mov    $0x7,%eax
 228:	cd 40                	int    $0x40
 22a:	c3                   	ret

0000022b <open>:
SYSCALL(open)
 22b:	b8 0f 00 00 00       	mov    $0xf,%eax
 230:	cd 40                	int    $0x40
 232:	c3                   	ret

00000233 <mknod>:
SYSCALL(mknod)
 233:	b8 11 00 00 00       	mov    $0x11,%eax
 238:	cd 40                	int    $0x40
 23a:	c3                   	ret

0000023b <unlink>:
SYSCALL(unlink)
 23b:	b8 12 00 00 00       	mov    $0x12,%eax
 240:	cd 40                	int    $0x40
 242:	c3                   	ret

00000243 <fstat>:
SYSCALL(fstat)
 243:	b8 08 00 00 00       	mov    $0x8,%eax
 248:	cd 40                	int    $0x40
 24a:	c3                   	ret

0000024b <link>:
SYSCALL(link)
 24b:	b8 13 00 00 00       	mov    $0x13,%eax
 250:	cd 40                	int    $0x40
 252:	c3                   	ret

00000253 <mkdir>:
SYSCALL(mkdir)
 253:	b8 14 00 00 00       	mov    $0x14,%eax
 258:	cd 40                	int    $0x40
 25a:	c3                   	ret

0000025b <chdir>:
SYSCALL(chdir)
 25b:	b8 09 00 00 00       	mov    $0x9,%eax
 260:	cd 40                	int    $0x40
 262:	c3                   	ret

00000263 <dup>:
SYSCALL(dup)
 263:	b8 0a 00 00 00       	mov    $0xa,%eax
 268:	cd 40                	int    $0x40
 26a:	c3                   	ret

0000026b <getpid>:
SYSCALL(getpid)
 26b:	b8 0b 00 00 00       	mov    $0xb,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret

00000273 <sbrk>:
SYSCALL(sbrk)
 273:	b8 0c 00 00 00       	mov    $0xc,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret

0000027b <sleep>:
SYSCALL(sleep)
 27b:	b8 0d 00 00 00       	mov    $0xd,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret

00000283 <uptime>:
SYSCALL(uptime)
 283:	b8 0e 00 00 00       	mov    $0xe,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret

0000028b <countfp>:
SYSCALL(countfp)
 28b:	b8 16 00 00 00       	mov    $0x16,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret
 293:	90                   	nop

00000294 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 294:	55                   	push   %ebp
 295:	89 e5                	mov    %esp,%ebp
 297:	57                   	push   %edi
 298:	56                   	push   %esi
 299:	53                   	push   %ebx
 29a:	83 ec 3c             	sub    $0x3c,%esp
 29d:	89 45 c0             	mov    %eax,-0x40(%ebp)
 2a0:	89 cb                	mov    %ecx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2a2:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2a5:	85 c9                	test   %ecx,%ecx
 2a7:	74 04                	je     2ad <printint+0x19>
 2a9:	85 d2                	test   %edx,%edx
 2ab:	78 6b                	js     318 <printint+0x84>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 2ad:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  neg = 0;
 2b0:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  }

  i = 0;
 2b7:	31 c9                	xor    %ecx,%ecx
 2b9:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 2bc:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 2bf:	31 d2                	xor    %edx,%edx
 2c1:	f7 f3                	div    %ebx
 2c3:	89 cf                	mov    %ecx,%edi
 2c5:	8d 49 01             	lea    0x1(%ecx),%ecx
 2c8:	8a 92 7c 06 00 00    	mov    0x67c(%edx),%dl
 2ce:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
  }while((x /= base) != 0);
 2d2:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 2d5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 2d8:	39 da                	cmp    %ebx,%edx
 2da:	73 e0                	jae    2bc <printint+0x28>
  if(neg)
 2dc:	8b 55 08             	mov    0x8(%ebp),%edx
 2df:	85 d2                	test   %edx,%edx
 2e1:	74 07                	je     2ea <printint+0x56>
    buf[i++] = '-';
 2e3:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)

  while(--i >= 0)
 2e8:	89 cf                	mov    %ecx,%edi
 2ea:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 2ed:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 2f1:	8d 76 00             	lea    0x0(%esi),%esi
    putc(fd, buf[i]);
 2f4:	8a 07                	mov    (%edi),%al
 2f6:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 2f9:	50                   	push   %eax
 2fa:	6a 01                	push   $0x1
 2fc:	56                   	push   %esi
 2fd:	ff 75 c0             	push   -0x40(%ebp)
 300:	e8 06 ff ff ff       	call   20b <write>
  while(--i >= 0)
 305:	89 f8                	mov    %edi,%eax
 307:	4f                   	dec    %edi
 308:	83 c4 10             	add    $0x10,%esp
 30b:	39 c3                	cmp    %eax,%ebx
 30d:	75 e5                	jne    2f4 <printint+0x60>
}
 30f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 312:	5b                   	pop    %ebx
 313:	5e                   	pop    %esi
 314:	5f                   	pop    %edi
 315:	5d                   	pop    %ebp
 316:	c3                   	ret
 317:	90                   	nop
    x = -xx;
 318:	f7 da                	neg    %edx
 31a:	89 55 c4             	mov    %edx,-0x3c(%ebp)
 31d:	eb 98                	jmp    2b7 <printint+0x23>
 31f:	90                   	nop

00000320 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	56                   	push   %esi
 325:	53                   	push   %ebx
 326:	83 ec 2c             	sub    $0x2c,%esp
 329:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 32c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 32f:	8a 13                	mov    (%ebx),%dl
 331:	84 d2                	test   %dl,%dl
 333:	74 5c                	je     391 <printf+0x71>
 335:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 336:	8d 45 10             	lea    0x10(%ebp),%eax
 339:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 33c:	31 ff                	xor    %edi,%edi
 33e:	eb 20                	jmp    360 <printf+0x40>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 340:	83 f8 25             	cmp    $0x25,%eax
 343:	74 3f                	je     384 <printf+0x64>
        state = '%';
      } else {
        putc(fd, c);
 345:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 348:	50                   	push   %eax
 349:	6a 01                	push   $0x1
 34b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 34e:	50                   	push   %eax
 34f:	56                   	push   %esi
 350:	e8 b6 fe ff ff       	call   20b <write>
        putc(fd, c);
 355:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 358:	43                   	inc    %ebx
 359:	8a 53 ff             	mov    -0x1(%ebx),%dl
 35c:	84 d2                	test   %dl,%dl
 35e:	74 31                	je     391 <printf+0x71>
    c = fmt[i] & 0xff;
 360:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 363:	85 ff                	test   %edi,%edi
 365:	74 d9                	je     340 <printf+0x20>
      }
    } else if(state == '%'){
 367:	83 ff 25             	cmp    $0x25,%edi
 36a:	75 ec                	jne    358 <printf+0x38>
      if(c == 'd'){
 36c:	83 f8 25             	cmp    $0x25,%eax
 36f:	0f 84 f3 00 00 00    	je     468 <printf+0x148>
 375:	83 e8 63             	sub    $0x63,%eax
 378:	83 f8 15             	cmp    $0x15,%eax
 37b:	77 1f                	ja     39c <printf+0x7c>
 37d:	ff 24 85 24 06 00 00 	jmp    *0x624(,%eax,4)
        state = '%';
 384:	bf 25 00 00 00       	mov    $0x25,%edi
  for(i = 0; fmt[i]; i++){
 389:	43                   	inc    %ebx
 38a:	8a 53 ff             	mov    -0x1(%ebx),%dl
 38d:	84 d2                	test   %dl,%dl
 38f:	75 cf                	jne    360 <printf+0x40>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 391:	8d 65 f4             	lea    -0xc(%ebp),%esp
 394:	5b                   	pop    %ebx
 395:	5e                   	pop    %esi
 396:	5f                   	pop    %edi
 397:	5d                   	pop    %ebp
 398:	c3                   	ret
 399:	8d 76 00             	lea    0x0(%esi),%esi
 39c:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 39f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 3a3:	50                   	push   %eax
 3a4:	6a 01                	push   $0x1
 3a6:	8d 7d e7             	lea    -0x19(%ebp),%edi
 3a9:	57                   	push   %edi
 3aa:	56                   	push   %esi
 3ab:	e8 5b fe ff ff       	call   20b <write>
        putc(fd, c);
 3b0:	8a 55 d0             	mov    -0x30(%ebp),%dl
 3b3:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 3b6:	83 c4 0c             	add    $0xc,%esp
 3b9:	6a 01                	push   $0x1
 3bb:	57                   	push   %edi
 3bc:	56                   	push   %esi
 3bd:	e8 49 fe ff ff       	call   20b <write>
        putc(fd, c);
 3c2:	83 c4 10             	add    $0x10,%esp
      state = 0;
 3c5:	31 ff                	xor    %edi,%edi
 3c7:	eb 8f                	jmp    358 <printf+0x38>
 3c9:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 3cc:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 3cf:	8b 17                	mov    (%edi),%edx
 3d1:	83 ec 0c             	sub    $0xc,%esp
 3d4:	6a 00                	push   $0x0
 3d6:	b9 10 00 00 00       	mov    $0x10,%ecx
 3db:	89 f0                	mov    %esi,%eax
 3dd:	e8 b2 fe ff ff       	call   294 <printint>
        ap++;
 3e2:	83 c7 04             	add    $0x4,%edi
 3e5:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 3e8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 3eb:	31 ff                	xor    %edi,%edi
        ap++;
 3ed:	e9 66 ff ff ff       	jmp    358 <printf+0x38>
        s = (char*)*ap;
 3f2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 3f5:	8b 10                	mov    (%eax),%edx
        ap++;
 3f7:	83 c0 04             	add    $0x4,%eax
 3fa:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 3fd:	85 d2                	test   %edx,%edx
 3ff:	74 77                	je     478 <printf+0x158>
        while(*s != 0){
 401:	8a 02                	mov    (%edx),%al
 403:	84 c0                	test   %al,%al
 405:	74 7a                	je     481 <printf+0x161>
 407:	8d 7d e7             	lea    -0x19(%ebp),%edi
 40a:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 40d:	89 d3                	mov    %edx,%ebx
 40f:	90                   	nop
          putc(fd, *s);
 410:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 413:	50                   	push   %eax
 414:	6a 01                	push   $0x1
 416:	57                   	push   %edi
 417:	56                   	push   %esi
 418:	e8 ee fd ff ff       	call   20b <write>
          s++;
 41d:	43                   	inc    %ebx
        while(*s != 0){
 41e:	8a 03                	mov    (%ebx),%al
 420:	83 c4 10             	add    $0x10,%esp
 423:	84 c0                	test   %al,%al
 425:	75 e9                	jne    410 <printf+0xf0>
      state = 0;
 427:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 42a:	31 ff                	xor    %edi,%edi
 42c:	e9 27 ff ff ff       	jmp    358 <printf+0x38>
        printint(fd, *ap, 10, 1);
 431:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 434:	8b 17                	mov    (%edi),%edx
 436:	83 ec 0c             	sub    $0xc,%esp
 439:	6a 01                	push   $0x1
 43b:	b9 0a 00 00 00       	mov    $0xa,%ecx
 440:	eb 99                	jmp    3db <printf+0xbb>
        putc(fd, *ap);
 442:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 445:	8b 00                	mov    (%eax),%eax
 447:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 44a:	51                   	push   %ecx
 44b:	6a 01                	push   $0x1
 44d:	8d 7d e7             	lea    -0x19(%ebp),%edi
 450:	57                   	push   %edi
 451:	56                   	push   %esi
 452:	e8 b4 fd ff ff       	call   20b <write>
        ap++;
 457:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 45b:	83 c4 10             	add    $0x10,%esp
      state = 0;
 45e:	31 ff                	xor    %edi,%edi
 460:	e9 f3 fe ff ff       	jmp    358 <printf+0x38>
 465:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 468:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 46b:	52                   	push   %edx
 46c:	6a 01                	push   $0x1
 46e:	8d 7d e7             	lea    -0x19(%ebp),%edi
 471:	e9 45 ff ff ff       	jmp    3bb <printf+0x9b>
 476:	66 90                	xchg   %ax,%ax
 478:	b0 28                	mov    $0x28,%al
          s = "(null)";
 47a:	ba 1a 06 00 00       	mov    $0x61a,%edx
 47f:	eb 86                	jmp    407 <printf+0xe7>
      state = 0;
 481:	31 ff                	xor    %edi,%edi
 483:	e9 d0 fe ff ff       	jmp    358 <printf+0x38>

00000488 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 488:	55                   	push   %ebp
 489:	89 e5                	mov    %esp,%ebp
 48b:	57                   	push   %edi
 48c:	56                   	push   %esi
 48d:	53                   	push   %ebx
 48e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 491:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 494:	a1 90 06 00 00       	mov    0x690,%eax
 499:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 49c:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 49e:	39 c8                	cmp    %ecx,%eax
 4a0:	73 2e                	jae    4d0 <free+0x48>
 4a2:	39 d1                	cmp    %edx,%ecx
 4a4:	72 04                	jb     4aa <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4a6:	39 d0                	cmp    %edx,%eax
 4a8:	72 2e                	jb     4d8 <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4aa:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4ad:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4b0:	39 fa                	cmp    %edi,%edx
 4b2:	74 28                	je     4dc <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 4b4:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 4b7:	8b 50 04             	mov    0x4(%eax),%edx
 4ba:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4bd:	39 f1                	cmp    %esi,%ecx
 4bf:	74 32                	je     4f3 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 4c1:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 4c3:	a3 90 06 00 00       	mov    %eax,0x690
}
 4c8:	5b                   	pop    %ebx
 4c9:	5e                   	pop    %esi
 4ca:	5f                   	pop    %edi
 4cb:	5d                   	pop    %ebp
 4cc:	c3                   	ret
 4cd:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4d0:	39 d0                	cmp    %edx,%eax
 4d2:	72 04                	jb     4d8 <free+0x50>
 4d4:	39 d1                	cmp    %edx,%ecx
 4d6:	72 d2                	jb     4aa <free+0x22>
{
 4d8:	89 d0                	mov    %edx,%eax
 4da:	eb c0                	jmp    49c <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 4dc:	03 72 04             	add    0x4(%edx),%esi
 4df:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 4e2:	8b 10                	mov    (%eax),%edx
 4e4:	8b 12                	mov    (%edx),%edx
 4e6:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 4e9:	8b 50 04             	mov    0x4(%eax),%edx
 4ec:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4ef:	39 f1                	cmp    %esi,%ecx
 4f1:	75 ce                	jne    4c1 <free+0x39>
    p->s.size += bp->s.size;
 4f3:	03 53 fc             	add    -0x4(%ebx),%edx
 4f6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 4f9:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 4fc:	89 08                	mov    %ecx,(%eax)
  freep = p;
 4fe:	a3 90 06 00 00       	mov    %eax,0x690
}
 503:	5b                   	pop    %ebx
 504:	5e                   	pop    %esi
 505:	5f                   	pop    %edi
 506:	5d                   	pop    %ebp
 507:	c3                   	ret

00000508 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 508:	55                   	push   %ebp
 509:	89 e5                	mov    %esp,%ebp
 50b:	57                   	push   %edi
 50c:	56                   	push   %esi
 50d:	53                   	push   %ebx
 50e:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 511:	8b 45 08             	mov    0x8(%ebp),%eax
 514:	8d 78 07             	lea    0x7(%eax),%edi
 517:	c1 ef 03             	shr    $0x3,%edi
 51a:	47                   	inc    %edi
  if((prevp = freep) == 0){
 51b:	8b 15 90 06 00 00    	mov    0x690,%edx
 521:	85 d2                	test   %edx,%edx
 523:	0f 84 93 00 00 00    	je     5bc <malloc+0xb4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 529:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 52b:	8b 48 04             	mov    0x4(%eax),%ecx
 52e:	39 f9                	cmp    %edi,%ecx
 530:	73 62                	jae    594 <malloc+0x8c>
  if(nu < 4096)
 532:	89 fb                	mov    %edi,%ebx
 534:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 53a:	72 78                	jb     5b4 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 53c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 543:	eb 0e                	jmp    553 <malloc+0x4b>
 545:	8d 76 00             	lea    0x0(%esi),%esi
 548:	89 c2                	mov    %eax,%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 54a:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 54c:	8b 48 04             	mov    0x4(%eax),%ecx
 54f:	39 f9                	cmp    %edi,%ecx
 551:	73 41                	jae    594 <malloc+0x8c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 553:	3b 05 90 06 00 00    	cmp    0x690,%eax
 559:	75 ed                	jne    548 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 55b:	83 ec 0c             	sub    $0xc,%esp
 55e:	56                   	push   %esi
 55f:	e8 0f fd ff ff       	call   273 <sbrk>
  if(p == (char*)-1)
 564:	83 c4 10             	add    $0x10,%esp
 567:	83 f8 ff             	cmp    $0xffffffff,%eax
 56a:	74 1c                	je     588 <malloc+0x80>
  hp->s.size = nu;
 56c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 56f:	83 ec 0c             	sub    $0xc,%esp
 572:	83 c0 08             	add    $0x8,%eax
 575:	50                   	push   %eax
 576:	e8 0d ff ff ff       	call   488 <free>
  return freep;
 57b:	8b 15 90 06 00 00    	mov    0x690,%edx
      if((p = morecore(nunits)) == 0)
 581:	83 c4 10             	add    $0x10,%esp
 584:	85 d2                	test   %edx,%edx
 586:	75 c2                	jne    54a <malloc+0x42>
        return 0;
 588:	31 c0                	xor    %eax,%eax
  }
}
 58a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 58d:	5b                   	pop    %ebx
 58e:	5e                   	pop    %esi
 58f:	5f                   	pop    %edi
 590:	5d                   	pop    %ebp
 591:	c3                   	ret
 592:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 594:	39 cf                	cmp    %ecx,%edi
 596:	74 4c                	je     5e4 <malloc+0xdc>
        p->s.size -= nunits;
 598:	29 f9                	sub    %edi,%ecx
 59a:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 59d:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5a0:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 5a3:	89 15 90 06 00 00    	mov    %edx,0x690
      return (void*)(p + 1);
 5a9:	83 c0 08             	add    $0x8,%eax
}
 5ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5af:	5b                   	pop    %ebx
 5b0:	5e                   	pop    %esi
 5b1:	5f                   	pop    %edi
 5b2:	5d                   	pop    %ebp
 5b3:	c3                   	ret
  if(nu < 4096)
 5b4:	bb 00 10 00 00       	mov    $0x1000,%ebx
 5b9:	eb 81                	jmp    53c <malloc+0x34>
 5bb:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 5bc:	c7 05 90 06 00 00 94 	movl   $0x694,0x690
 5c3:	06 00 00 
 5c6:	c7 05 94 06 00 00 94 	movl   $0x694,0x694
 5cd:	06 00 00 
    base.s.size = 0;
 5d0:	c7 05 98 06 00 00 00 	movl   $0x0,0x698
 5d7:	00 00 00 
 5da:	b8 94 06 00 00       	mov    $0x694,%eax
 5df:	e9 4e ff ff ff       	jmp    532 <malloc+0x2a>
        prevp->s.ptr = p->s.ptr;
 5e4:	8b 08                	mov    (%eax),%ecx
 5e6:	89 0a                	mov    %ecx,(%edx)
 5e8:	eb b9                	jmp    5a3 <malloc+0x9b>
