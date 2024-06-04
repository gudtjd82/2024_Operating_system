
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
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
  if(fork() > 0)
   f:	e8 d3 01 00 00       	call   1e7 <fork>
  14:	85 c0                	test   %eax,%eax
  16:	7e 0d                	jle    25 <main+0x25>
    sleep(5);  // Let child exit before parent.
  18:	83 ec 0c             	sub    $0xc,%esp
  1b:	6a 05                	push   $0x5
  1d:	e8 5d 02 00 00       	call   27f <sleep>
  22:	83 c4 10             	add    $0x10,%esp
  exit();
  25:	e8 c5 01 00 00       	call   1ef <exit>
  2a:	66 90                	xchg   %ax,%ax

0000002c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  2c:	55                   	push   %ebp
  2d:	89 e5                	mov    %esp,%ebp
  2f:	53                   	push   %ebx
  30:	8b 4d 08             	mov    0x8(%ebp),%ecx
  33:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  36:	31 c0                	xor    %eax,%eax
  38:	8a 14 03             	mov    (%ebx,%eax,1),%dl
  3b:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  3e:	40                   	inc    %eax
  3f:	84 d2                	test   %dl,%dl
  41:	75 f5                	jne    38 <strcpy+0xc>
    ;
  return os;
}
  43:	89 c8                	mov    %ecx,%eax
  45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  48:	c9                   	leave
  49:	c3                   	ret
  4a:	66 90                	xchg   %ax,%ax

0000004c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  4c:	55                   	push   %ebp
  4d:	89 e5                	mov    %esp,%ebp
  4f:	53                   	push   %ebx
  50:	8b 55 08             	mov    0x8(%ebp),%edx
  53:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  56:	0f b6 02             	movzbl (%edx),%eax
  59:	84 c0                	test   %al,%al
  5b:	75 10                	jne    6d <strcmp+0x21>
  5d:	eb 2a                	jmp    89 <strcmp+0x3d>
  5f:	90                   	nop
    p++, q++;
  60:	42                   	inc    %edx
  61:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
  64:	0f b6 02             	movzbl (%edx),%eax
  67:	84 c0                	test   %al,%al
  69:	74 11                	je     7c <strcmp+0x30>
  6b:	89 cb                	mov    %ecx,%ebx
  6d:	0f b6 0b             	movzbl (%ebx),%ecx
  70:	38 c1                	cmp    %al,%cl
  72:	74 ec                	je     60 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  74:	29 c8                	sub    %ecx,%eax
}
  76:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  79:	c9                   	leave
  7a:	c3                   	ret
  7b:	90                   	nop
  return (uchar)*p - (uchar)*q;
  7c:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  80:	31 c0                	xor    %eax,%eax
  82:	29 c8                	sub    %ecx,%eax
}
  84:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  87:	c9                   	leave
  88:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  89:	0f b6 0b             	movzbl (%ebx),%ecx
  8c:	31 c0                	xor    %eax,%eax
  8e:	eb e4                	jmp    74 <strcmp+0x28>

00000090 <strlen>:

uint
strlen(const char *s)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  96:	80 3a 00             	cmpb   $0x0,(%edx)
  99:	74 15                	je     b0 <strlen+0x20>
  9b:	31 c0                	xor    %eax,%eax
  9d:	8d 76 00             	lea    0x0(%esi),%esi
  a0:	40                   	inc    %eax
  a1:	89 c1                	mov    %eax,%ecx
  a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  a7:	75 f7                	jne    a0 <strlen+0x10>
    ;
  return n;
}
  a9:	89 c8                	mov    %ecx,%eax
  ab:	5d                   	pop    %ebp
  ac:	c3                   	ret
  ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  b0:	31 c9                	xor    %ecx,%ecx
}
  b2:	89 c8                	mov    %ecx,%eax
  b4:	5d                   	pop    %ebp
  b5:	c3                   	ret
  b6:	66 90                	xchg   %ax,%ax

000000b8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  b8:	55                   	push   %ebp
  b9:	89 e5                	mov    %esp,%ebp
  bb:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  bc:	8b 7d 08             	mov    0x8(%ebp),%edi
  bf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  c5:	fc                   	cld
  c6:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  c8:	8b 45 08             	mov    0x8(%ebp),%eax
  cb:	8b 7d fc             	mov    -0x4(%ebp),%edi
  ce:	c9                   	leave
  cf:	c3                   	ret

000000d0 <strchr>:

char*
strchr(const char *s, char c)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 45 08             	mov    0x8(%ebp),%eax
  d6:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
  d9:	8a 10                	mov    (%eax),%dl
  db:	84 d2                	test   %dl,%dl
  dd:	75 0c                	jne    eb <strchr+0x1b>
  df:	eb 13                	jmp    f4 <strchr+0x24>
  e1:	8d 76 00             	lea    0x0(%esi),%esi
  e4:	40                   	inc    %eax
  e5:	8a 10                	mov    (%eax),%dl
  e7:	84 d2                	test   %dl,%dl
  e9:	74 09                	je     f4 <strchr+0x24>
    if(*s == c)
  eb:	38 d1                	cmp    %dl,%cl
  ed:	75 f5                	jne    e4 <strchr+0x14>
      return (char*)s;
  return 0;
}
  ef:	5d                   	pop    %ebp
  f0:	c3                   	ret
  f1:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
  f4:	31 c0                	xor    %eax,%eax
}
  f6:	5d                   	pop    %ebp
  f7:	c3                   	ret

000000f8 <gets>:

char*
gets(char *buf, int max)
{
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	57                   	push   %edi
  fc:	56                   	push   %esi
  fd:	53                   	push   %ebx
  fe:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 101:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 103:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i=0; i+1 < max; ){
 106:	eb 24                	jmp    12c <gets+0x34>
    cc = read(0, &c, 1);
 108:	50                   	push   %eax
 109:	6a 01                	push   $0x1
 10b:	56                   	push   %esi
 10c:	6a 00                	push   $0x0
 10e:	e8 f4 00 00 00       	call   207 <read>
    if(cc < 1)
 113:	83 c4 10             	add    $0x10,%esp
 116:	85 c0                	test   %eax,%eax
 118:	7e 1a                	jle    134 <gets+0x3c>
      break;
    buf[i++] = c;
 11a:	8a 45 e7             	mov    -0x19(%ebp),%al
 11d:	8b 55 08             	mov    0x8(%ebp),%edx
 120:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 124:	3c 0a                	cmp    $0xa,%al
 126:	74 0e                	je     136 <gets+0x3e>
 128:	3c 0d                	cmp    $0xd,%al
 12a:	74 0a                	je     136 <gets+0x3e>
  for(i=0; i+1 < max; ){
 12c:	89 df                	mov    %ebx,%edi
 12e:	43                   	inc    %ebx
 12f:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 132:	7c d4                	jl     108 <gets+0x10>
 134:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 136:	8b 45 08             	mov    0x8(%ebp),%eax
 139:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 13d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 140:	5b                   	pop    %ebx
 141:	5e                   	pop    %esi
 142:	5f                   	pop    %edi
 143:	5d                   	pop    %ebp
 144:	c3                   	ret
 145:	8d 76 00             	lea    0x0(%esi),%esi

00000148 <stat>:

int
stat(const char *n, struct stat *st)
{
 148:	55                   	push   %ebp
 149:	89 e5                	mov    %esp,%ebp
 14b:	56                   	push   %esi
 14c:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 14d:	83 ec 08             	sub    $0x8,%esp
 150:	6a 00                	push   $0x0
 152:	ff 75 08             	push   0x8(%ebp)
 155:	e8 d5 00 00 00       	call   22f <open>
  if(fd < 0)
 15a:	83 c4 10             	add    $0x10,%esp
 15d:	85 c0                	test   %eax,%eax
 15f:	78 27                	js     188 <stat+0x40>
 161:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 163:	83 ec 08             	sub    $0x8,%esp
 166:	ff 75 0c             	push   0xc(%ebp)
 169:	50                   	push   %eax
 16a:	e8 d8 00 00 00       	call   247 <fstat>
 16f:	89 c6                	mov    %eax,%esi
  close(fd);
 171:	89 1c 24             	mov    %ebx,(%esp)
 174:	e8 9e 00 00 00       	call   217 <close>
  return r;
 179:	83 c4 10             	add    $0x10,%esp
}
 17c:	89 f0                	mov    %esi,%eax
 17e:	8d 65 f8             	lea    -0x8(%ebp),%esp
 181:	5b                   	pop    %ebx
 182:	5e                   	pop    %esi
 183:	5d                   	pop    %ebp
 184:	c3                   	ret
 185:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 188:	be ff ff ff ff       	mov    $0xffffffff,%esi
 18d:	eb ed                	jmp    17c <stat+0x34>
 18f:	90                   	nop

00000190 <atoi>:

int
atoi(const char *s)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	53                   	push   %ebx
 194:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 197:	0f be 01             	movsbl (%ecx),%eax
 19a:	8d 50 d0             	lea    -0x30(%eax),%edx
 19d:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
 1a0:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 1a5:	77 16                	ja     1bd <atoi+0x2d>
 1a7:	90                   	nop
    n = n*10 + *s++ - '0';
 1a8:	41                   	inc    %ecx
 1a9:	8d 14 92             	lea    (%edx,%edx,4),%edx
 1ac:	01 d2                	add    %edx,%edx
 1ae:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
 1b2:	0f be 01             	movsbl (%ecx),%eax
 1b5:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1b8:	80 fb 09             	cmp    $0x9,%bl
 1bb:	76 eb                	jbe    1a8 <atoi+0x18>
  return n;
}
 1bd:	89 d0                	mov    %edx,%eax
 1bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1c2:	c9                   	leave
 1c3:	c3                   	ret

000001c4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1c4:	55                   	push   %ebp
 1c5:	89 e5                	mov    %esp,%ebp
 1c7:	57                   	push   %edi
 1c8:	56                   	push   %esi
 1c9:	8b 55 08             	mov    0x8(%ebp),%edx
 1cc:	8b 75 0c             	mov    0xc(%ebp),%esi
 1cf:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1d2:	85 c0                	test   %eax,%eax
 1d4:	7e 0b                	jle    1e1 <memmove+0x1d>
 1d6:	01 d0                	add    %edx,%eax
  dst = vdst;
 1d8:	89 d7                	mov    %edx,%edi
 1da:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 1dc:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 1dd:	39 f8                	cmp    %edi,%eax
 1df:	75 fb                	jne    1dc <memmove+0x18>
  return vdst;
}
 1e1:	89 d0                	mov    %edx,%eax
 1e3:	5e                   	pop    %esi
 1e4:	5f                   	pop    %edi
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret

000001e7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1e7:	b8 01 00 00 00       	mov    $0x1,%eax
 1ec:	cd 40                	int    $0x40
 1ee:	c3                   	ret

000001ef <exit>:
SYSCALL(exit)
 1ef:	b8 02 00 00 00       	mov    $0x2,%eax
 1f4:	cd 40                	int    $0x40
 1f6:	c3                   	ret

000001f7 <wait>:
SYSCALL(wait)
 1f7:	b8 03 00 00 00       	mov    $0x3,%eax
 1fc:	cd 40                	int    $0x40
 1fe:	c3                   	ret

000001ff <pipe>:
SYSCALL(pipe)
 1ff:	b8 04 00 00 00       	mov    $0x4,%eax
 204:	cd 40                	int    $0x40
 206:	c3                   	ret

00000207 <read>:
SYSCALL(read)
 207:	b8 05 00 00 00       	mov    $0x5,%eax
 20c:	cd 40                	int    $0x40
 20e:	c3                   	ret

0000020f <write>:
SYSCALL(write)
 20f:	b8 10 00 00 00       	mov    $0x10,%eax
 214:	cd 40                	int    $0x40
 216:	c3                   	ret

00000217 <close>:
SYSCALL(close)
 217:	b8 15 00 00 00       	mov    $0x15,%eax
 21c:	cd 40                	int    $0x40
 21e:	c3                   	ret

0000021f <kill>:
SYSCALL(kill)
 21f:	b8 06 00 00 00       	mov    $0x6,%eax
 224:	cd 40                	int    $0x40
 226:	c3                   	ret

00000227 <exec>:
SYSCALL(exec)
 227:	b8 07 00 00 00       	mov    $0x7,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret

0000022f <open>:
SYSCALL(open)
 22f:	b8 0f 00 00 00       	mov    $0xf,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret

00000237 <mknod>:
SYSCALL(mknod)
 237:	b8 11 00 00 00       	mov    $0x11,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret

0000023f <unlink>:
SYSCALL(unlink)
 23f:	b8 12 00 00 00       	mov    $0x12,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret

00000247 <fstat>:
SYSCALL(fstat)
 247:	b8 08 00 00 00       	mov    $0x8,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret

0000024f <link>:
SYSCALL(link)
 24f:	b8 13 00 00 00       	mov    $0x13,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret

00000257 <mkdir>:
SYSCALL(mkdir)
 257:	b8 14 00 00 00       	mov    $0x14,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret

0000025f <chdir>:
SYSCALL(chdir)
 25f:	b8 09 00 00 00       	mov    $0x9,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret

00000267 <dup>:
SYSCALL(dup)
 267:	b8 0a 00 00 00       	mov    $0xa,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret

0000026f <getpid>:
SYSCALL(getpid)
 26f:	b8 0b 00 00 00       	mov    $0xb,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret

00000277 <sbrk>:
SYSCALL(sbrk)
 277:	b8 0c 00 00 00       	mov    $0xc,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret

0000027f <sleep>:
SYSCALL(sleep)
 27f:	b8 0d 00 00 00       	mov    $0xd,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret

00000287 <uptime>:
SYSCALL(uptime)
 287:	b8 0e 00 00 00       	mov    $0xe,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret

0000028f <countfp>:
SYSCALL(countfp)
 28f:	b8 16 00 00 00       	mov    $0x16,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret
 297:	90                   	nop

00000298 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 298:	55                   	push   %ebp
 299:	89 e5                	mov    %esp,%ebp
 29b:	57                   	push   %edi
 29c:	56                   	push   %esi
 29d:	53                   	push   %ebx
 29e:	83 ec 3c             	sub    $0x3c,%esp
 2a1:	89 45 c0             	mov    %eax,-0x40(%ebp)
 2a4:	89 cb                	mov    %ecx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2a9:	85 c9                	test   %ecx,%ecx
 2ab:	74 04                	je     2b1 <printint+0x19>
 2ad:	85 d2                	test   %edx,%edx
 2af:	78 6b                	js     31c <printint+0x84>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 2b1:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  neg = 0;
 2b4:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  }

  i = 0;
 2bb:	31 c9                	xor    %ecx,%ecx
 2bd:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 2c0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 2c3:	31 d2                	xor    %edx,%edx
 2c5:	f7 f3                	div    %ebx
 2c7:	89 cf                	mov    %ecx,%edi
 2c9:	8d 49 01             	lea    0x1(%ecx),%ecx
 2cc:	8a 92 50 06 00 00    	mov    0x650(%edx),%dl
 2d2:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
  }while((x /= base) != 0);
 2d6:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 2d9:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 2dc:	39 da                	cmp    %ebx,%edx
 2de:	73 e0                	jae    2c0 <printint+0x28>
  if(neg)
 2e0:	8b 55 08             	mov    0x8(%ebp),%edx
 2e3:	85 d2                	test   %edx,%edx
 2e5:	74 07                	je     2ee <printint+0x56>
    buf[i++] = '-';
 2e7:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)

  while(--i >= 0)
 2ec:	89 cf                	mov    %ecx,%edi
 2ee:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 2f1:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 2f5:	8d 76 00             	lea    0x0(%esi),%esi
    putc(fd, buf[i]);
 2f8:	8a 07                	mov    (%edi),%al
 2fa:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 2fd:	50                   	push   %eax
 2fe:	6a 01                	push   $0x1
 300:	56                   	push   %esi
 301:	ff 75 c0             	push   -0x40(%ebp)
 304:	e8 06 ff ff ff       	call   20f <write>
  while(--i >= 0)
 309:	89 f8                	mov    %edi,%eax
 30b:	4f                   	dec    %edi
 30c:	83 c4 10             	add    $0x10,%esp
 30f:	39 c3                	cmp    %eax,%ebx
 311:	75 e5                	jne    2f8 <printint+0x60>
}
 313:	8d 65 f4             	lea    -0xc(%ebp),%esp
 316:	5b                   	pop    %ebx
 317:	5e                   	pop    %esi
 318:	5f                   	pop    %edi
 319:	5d                   	pop    %ebp
 31a:	c3                   	ret
 31b:	90                   	nop
    x = -xx;
 31c:	f7 da                	neg    %edx
 31e:	89 55 c4             	mov    %edx,-0x3c(%ebp)
 321:	eb 98                	jmp    2bb <printint+0x23>
 323:	90                   	nop

00000324 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 324:	55                   	push   %ebp
 325:	89 e5                	mov    %esp,%ebp
 327:	57                   	push   %edi
 328:	56                   	push   %esi
 329:	53                   	push   %ebx
 32a:	83 ec 2c             	sub    $0x2c,%esp
 32d:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 330:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 333:	8a 13                	mov    (%ebx),%dl
 335:	84 d2                	test   %dl,%dl
 337:	74 5c                	je     395 <printf+0x71>
 339:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 33a:	8d 45 10             	lea    0x10(%ebp),%eax
 33d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 340:	31 ff                	xor    %edi,%edi
 342:	eb 20                	jmp    364 <printf+0x40>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 344:	83 f8 25             	cmp    $0x25,%eax
 347:	74 3f                	je     388 <printf+0x64>
        state = '%';
      } else {
        putc(fd, c);
 349:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 34c:	50                   	push   %eax
 34d:	6a 01                	push   $0x1
 34f:	8d 45 e7             	lea    -0x19(%ebp),%eax
 352:	50                   	push   %eax
 353:	56                   	push   %esi
 354:	e8 b6 fe ff ff       	call   20f <write>
        putc(fd, c);
 359:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 35c:	43                   	inc    %ebx
 35d:	8a 53 ff             	mov    -0x1(%ebx),%dl
 360:	84 d2                	test   %dl,%dl
 362:	74 31                	je     395 <printf+0x71>
    c = fmt[i] & 0xff;
 364:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 367:	85 ff                	test   %edi,%edi
 369:	74 d9                	je     344 <printf+0x20>
      }
    } else if(state == '%'){
 36b:	83 ff 25             	cmp    $0x25,%edi
 36e:	75 ec                	jne    35c <printf+0x38>
      if(c == 'd'){
 370:	83 f8 25             	cmp    $0x25,%eax
 373:	0f 84 f3 00 00 00    	je     46c <printf+0x148>
 379:	83 e8 63             	sub    $0x63,%eax
 37c:	83 f8 15             	cmp    $0x15,%eax
 37f:	77 1f                	ja     3a0 <printf+0x7c>
 381:	ff 24 85 f8 05 00 00 	jmp    *0x5f8(,%eax,4)
        state = '%';
 388:	bf 25 00 00 00       	mov    $0x25,%edi
  for(i = 0; fmt[i]; i++){
 38d:	43                   	inc    %ebx
 38e:	8a 53 ff             	mov    -0x1(%ebx),%dl
 391:	84 d2                	test   %dl,%dl
 393:	75 cf                	jne    364 <printf+0x40>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 395:	8d 65 f4             	lea    -0xc(%ebp),%esp
 398:	5b                   	pop    %ebx
 399:	5e                   	pop    %esi
 39a:	5f                   	pop    %edi
 39b:	5d                   	pop    %ebp
 39c:	c3                   	ret
 39d:	8d 76 00             	lea    0x0(%esi),%esi
 3a0:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 3a3:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 3a7:	50                   	push   %eax
 3a8:	6a 01                	push   $0x1
 3aa:	8d 7d e7             	lea    -0x19(%ebp),%edi
 3ad:	57                   	push   %edi
 3ae:	56                   	push   %esi
 3af:	e8 5b fe ff ff       	call   20f <write>
        putc(fd, c);
 3b4:	8a 55 d0             	mov    -0x30(%ebp),%dl
 3b7:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 3ba:	83 c4 0c             	add    $0xc,%esp
 3bd:	6a 01                	push   $0x1
 3bf:	57                   	push   %edi
 3c0:	56                   	push   %esi
 3c1:	e8 49 fe ff ff       	call   20f <write>
        putc(fd, c);
 3c6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 3c9:	31 ff                	xor    %edi,%edi
 3cb:	eb 8f                	jmp    35c <printf+0x38>
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 3d0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 3d3:	8b 17                	mov    (%edi),%edx
 3d5:	83 ec 0c             	sub    $0xc,%esp
 3d8:	6a 00                	push   $0x0
 3da:	b9 10 00 00 00       	mov    $0x10,%ecx
 3df:	89 f0                	mov    %esi,%eax
 3e1:	e8 b2 fe ff ff       	call   298 <printint>
        ap++;
 3e6:	83 c7 04             	add    $0x4,%edi
 3e9:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 3ec:	83 c4 10             	add    $0x10,%esp
      state = 0;
 3ef:	31 ff                	xor    %edi,%edi
        ap++;
 3f1:	e9 66 ff ff ff       	jmp    35c <printf+0x38>
        s = (char*)*ap;
 3f6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 3f9:	8b 10                	mov    (%eax),%edx
        ap++;
 3fb:	83 c0 04             	add    $0x4,%eax
 3fe:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 401:	85 d2                	test   %edx,%edx
 403:	74 77                	je     47c <printf+0x158>
        while(*s != 0){
 405:	8a 02                	mov    (%edx),%al
 407:	84 c0                	test   %al,%al
 409:	74 7a                	je     485 <printf+0x161>
 40b:	8d 7d e7             	lea    -0x19(%ebp),%edi
 40e:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 411:	89 d3                	mov    %edx,%ebx
 413:	90                   	nop
          putc(fd, *s);
 414:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 417:	50                   	push   %eax
 418:	6a 01                	push   $0x1
 41a:	57                   	push   %edi
 41b:	56                   	push   %esi
 41c:	e8 ee fd ff ff       	call   20f <write>
          s++;
 421:	43                   	inc    %ebx
        while(*s != 0){
 422:	8a 03                	mov    (%ebx),%al
 424:	83 c4 10             	add    $0x10,%esp
 427:	84 c0                	test   %al,%al
 429:	75 e9                	jne    414 <printf+0xf0>
      state = 0;
 42b:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 42e:	31 ff                	xor    %edi,%edi
 430:	e9 27 ff ff ff       	jmp    35c <printf+0x38>
        printint(fd, *ap, 10, 1);
 435:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 438:	8b 17                	mov    (%edi),%edx
 43a:	83 ec 0c             	sub    $0xc,%esp
 43d:	6a 01                	push   $0x1
 43f:	b9 0a 00 00 00       	mov    $0xa,%ecx
 444:	eb 99                	jmp    3df <printf+0xbb>
        putc(fd, *ap);
 446:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 449:	8b 00                	mov    (%eax),%eax
 44b:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 44e:	51                   	push   %ecx
 44f:	6a 01                	push   $0x1
 451:	8d 7d e7             	lea    -0x19(%ebp),%edi
 454:	57                   	push   %edi
 455:	56                   	push   %esi
 456:	e8 b4 fd ff ff       	call   20f <write>
        ap++;
 45b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 45f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 462:	31 ff                	xor    %edi,%edi
 464:	e9 f3 fe ff ff       	jmp    35c <printf+0x38>
 469:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 46c:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 46f:	52                   	push   %edx
 470:	6a 01                	push   $0x1
 472:	8d 7d e7             	lea    -0x19(%ebp),%edi
 475:	e9 45 ff ff ff       	jmp    3bf <printf+0x9b>
 47a:	66 90                	xchg   %ax,%ax
 47c:	b0 28                	mov    $0x28,%al
          s = "(null)";
 47e:	ba f0 05 00 00       	mov    $0x5f0,%edx
 483:	eb 86                	jmp    40b <printf+0xe7>
      state = 0;
 485:	31 ff                	xor    %edi,%edi
 487:	e9 d0 fe ff ff       	jmp    35c <printf+0x38>

0000048c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 48c:	55                   	push   %ebp
 48d:	89 e5                	mov    %esp,%ebp
 48f:	57                   	push   %edi
 490:	56                   	push   %esi
 491:	53                   	push   %ebx
 492:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 495:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 498:	a1 64 06 00 00       	mov    0x664,%eax
 49d:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4a0:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4a2:	39 c8                	cmp    %ecx,%eax
 4a4:	73 2e                	jae    4d4 <free+0x48>
 4a6:	39 d1                	cmp    %edx,%ecx
 4a8:	72 04                	jb     4ae <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4aa:	39 d0                	cmp    %edx,%eax
 4ac:	72 2e                	jb     4dc <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4ae:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4b1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4b4:	39 fa                	cmp    %edi,%edx
 4b6:	74 28                	je     4e0 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 4b8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 4bb:	8b 50 04             	mov    0x4(%eax),%edx
 4be:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4c1:	39 f1                	cmp    %esi,%ecx
 4c3:	74 32                	je     4f7 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 4c5:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 4c7:	a3 64 06 00 00       	mov    %eax,0x664
}
 4cc:	5b                   	pop    %ebx
 4cd:	5e                   	pop    %esi
 4ce:	5f                   	pop    %edi
 4cf:	5d                   	pop    %ebp
 4d0:	c3                   	ret
 4d1:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4d4:	39 d0                	cmp    %edx,%eax
 4d6:	72 04                	jb     4dc <free+0x50>
 4d8:	39 d1                	cmp    %edx,%ecx
 4da:	72 d2                	jb     4ae <free+0x22>
{
 4dc:	89 d0                	mov    %edx,%eax
 4de:	eb c0                	jmp    4a0 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 4e0:	03 72 04             	add    0x4(%edx),%esi
 4e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 4e6:	8b 10                	mov    (%eax),%edx
 4e8:	8b 12                	mov    (%edx),%edx
 4ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 4ed:	8b 50 04             	mov    0x4(%eax),%edx
 4f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4f3:	39 f1                	cmp    %esi,%ecx
 4f5:	75 ce                	jne    4c5 <free+0x39>
    p->s.size += bp->s.size;
 4f7:	03 53 fc             	add    -0x4(%ebx),%edx
 4fa:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 4fd:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 500:	89 08                	mov    %ecx,(%eax)
  freep = p;
 502:	a3 64 06 00 00       	mov    %eax,0x664
}
 507:	5b                   	pop    %ebx
 508:	5e                   	pop    %esi
 509:	5f                   	pop    %edi
 50a:	5d                   	pop    %ebp
 50b:	c3                   	ret

0000050c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 50c:	55                   	push   %ebp
 50d:	89 e5                	mov    %esp,%ebp
 50f:	57                   	push   %edi
 510:	56                   	push   %esi
 511:	53                   	push   %ebx
 512:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 515:	8b 45 08             	mov    0x8(%ebp),%eax
 518:	8d 78 07             	lea    0x7(%eax),%edi
 51b:	c1 ef 03             	shr    $0x3,%edi
 51e:	47                   	inc    %edi
  if((prevp = freep) == 0){
 51f:	8b 15 64 06 00 00    	mov    0x664,%edx
 525:	85 d2                	test   %edx,%edx
 527:	0f 84 93 00 00 00    	je     5c0 <malloc+0xb4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 52d:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 52f:	8b 48 04             	mov    0x4(%eax),%ecx
 532:	39 f9                	cmp    %edi,%ecx
 534:	73 62                	jae    598 <malloc+0x8c>
  if(nu < 4096)
 536:	89 fb                	mov    %edi,%ebx
 538:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 53e:	72 78                	jb     5b8 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 540:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 547:	eb 0e                	jmp    557 <malloc+0x4b>
 549:	8d 76 00             	lea    0x0(%esi),%esi
 54c:	89 c2                	mov    %eax,%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 54e:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 550:	8b 48 04             	mov    0x4(%eax),%ecx
 553:	39 f9                	cmp    %edi,%ecx
 555:	73 41                	jae    598 <malloc+0x8c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 557:	3b 05 64 06 00 00    	cmp    0x664,%eax
 55d:	75 ed                	jne    54c <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 55f:	83 ec 0c             	sub    $0xc,%esp
 562:	56                   	push   %esi
 563:	e8 0f fd ff ff       	call   277 <sbrk>
  if(p == (char*)-1)
 568:	83 c4 10             	add    $0x10,%esp
 56b:	83 f8 ff             	cmp    $0xffffffff,%eax
 56e:	74 1c                	je     58c <malloc+0x80>
  hp->s.size = nu;
 570:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 573:	83 ec 0c             	sub    $0xc,%esp
 576:	83 c0 08             	add    $0x8,%eax
 579:	50                   	push   %eax
 57a:	e8 0d ff ff ff       	call   48c <free>
  return freep;
 57f:	8b 15 64 06 00 00    	mov    0x664,%edx
      if((p = morecore(nunits)) == 0)
 585:	83 c4 10             	add    $0x10,%esp
 588:	85 d2                	test   %edx,%edx
 58a:	75 c2                	jne    54e <malloc+0x42>
        return 0;
 58c:	31 c0                	xor    %eax,%eax
  }
}
 58e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 591:	5b                   	pop    %ebx
 592:	5e                   	pop    %esi
 593:	5f                   	pop    %edi
 594:	5d                   	pop    %ebp
 595:	c3                   	ret
 596:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 598:	39 cf                	cmp    %ecx,%edi
 59a:	74 4c                	je     5e8 <malloc+0xdc>
        p->s.size -= nunits;
 59c:	29 f9                	sub    %edi,%ecx
 59e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5a1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5a4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 5a7:	89 15 64 06 00 00    	mov    %edx,0x664
      return (void*)(p + 1);
 5ad:	83 c0 08             	add    $0x8,%eax
}
 5b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5b3:	5b                   	pop    %ebx
 5b4:	5e                   	pop    %esi
 5b5:	5f                   	pop    %edi
 5b6:	5d                   	pop    %ebp
 5b7:	c3                   	ret
  if(nu < 4096)
 5b8:	bb 00 10 00 00       	mov    $0x1000,%ebx
 5bd:	eb 81                	jmp    540 <malloc+0x34>
 5bf:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 5c0:	c7 05 64 06 00 00 68 	movl   $0x668,0x664
 5c7:	06 00 00 
 5ca:	c7 05 68 06 00 00 68 	movl   $0x668,0x668
 5d1:	06 00 00 
    base.s.size = 0;
 5d4:	c7 05 6c 06 00 00 00 	movl   $0x0,0x66c
 5db:	00 00 00 
 5de:	b8 68 06 00 00       	mov    $0x668,%eax
 5e3:	e9 4e ff ff ff       	jmp    536 <malloc+0x2a>
        prevp->s.ptr = p->s.ptr;
 5e8:	8b 08                	mov    (%eax),%ecx
 5ea:	89 0a                	mov    %ecx,(%edx)
 5ec:	eb b9                	jmp    5a7 <malloc+0x9b>
