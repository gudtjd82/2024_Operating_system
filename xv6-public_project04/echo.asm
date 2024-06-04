
_echo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 08             	sub    $0x8,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  for(i = 1; i < argc; i++)
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 41                	jle    5f <main+0x5f>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  1e:	8b 47 04             	mov    0x4(%edi),%eax
  21:	83 fe 02             	cmp    $0x2,%esi
  24:	74 24                	je     4a <main+0x4a>
  26:	bb 02 00 00 00       	mov    $0x2,%ebx
  2b:	90                   	nop
  2c:	68 28 06 00 00       	push   $0x628
  31:	50                   	push   %eax
  32:	68 2a 06 00 00       	push   $0x62a
  37:	6a 01                	push   $0x1
  39:	e8 1e 03 00 00       	call   35c <printf>
  3e:	43                   	inc    %ebx
  3f:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
  43:	83 c4 10             	add    $0x10,%esp
  46:	39 de                	cmp    %ebx,%esi
  48:	75 e2                	jne    2c <main+0x2c>
  4a:	68 2f 06 00 00       	push   $0x62f
  4f:	50                   	push   %eax
  50:	68 2a 06 00 00       	push   $0x62a
  55:	6a 01                	push   $0x1
  57:	e8 00 03 00 00       	call   35c <printf>
  5c:	83 c4 10             	add    $0x10,%esp
  exit();
  5f:	e8 c3 01 00 00       	call   227 <exit>

00000064 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  64:	55                   	push   %ebp
  65:	89 e5                	mov    %esp,%ebp
  67:	53                   	push   %ebx
  68:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6e:	31 c0                	xor    %eax,%eax
  70:	8a 14 03             	mov    (%ebx,%eax,1),%dl
  73:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  76:	40                   	inc    %eax
  77:	84 d2                	test   %dl,%dl
  79:	75 f5                	jne    70 <strcpy+0xc>
    ;
  return os;
}
  7b:	89 c8                	mov    %ecx,%eax
  7d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80:	c9                   	leave
  81:	c3                   	ret
  82:	66 90                	xchg   %ax,%ax

00000084 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	53                   	push   %ebx
  88:	8b 55 08             	mov    0x8(%ebp),%edx
  8b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  8e:	0f b6 02             	movzbl (%edx),%eax
  91:	84 c0                	test   %al,%al
  93:	75 10                	jne    a5 <strcmp+0x21>
  95:	eb 2a                	jmp    c1 <strcmp+0x3d>
  97:	90                   	nop
    p++, q++;
  98:	42                   	inc    %edx
  99:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
  9c:	0f b6 02             	movzbl (%edx),%eax
  9f:	84 c0                	test   %al,%al
  a1:	74 11                	je     b4 <strcmp+0x30>
  a3:	89 cb                	mov    %ecx,%ebx
  a5:	0f b6 0b             	movzbl (%ebx),%ecx
  a8:	38 c1                	cmp    %al,%cl
  aa:	74 ec                	je     98 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  ac:	29 c8                	sub    %ecx,%eax
}
  ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  b1:	c9                   	leave
  b2:	c3                   	ret
  b3:	90                   	nop
  return (uchar)*p - (uchar)*q;
  b4:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  b8:	31 c0                	xor    %eax,%eax
  ba:	29 c8                	sub    %ecx,%eax
}
  bc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  bf:	c9                   	leave
  c0:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  c1:	0f b6 0b             	movzbl (%ebx),%ecx
  c4:	31 c0                	xor    %eax,%eax
  c6:	eb e4                	jmp    ac <strcmp+0x28>

000000c8 <strlen>:

uint
strlen(const char *s)
{
  c8:	55                   	push   %ebp
  c9:	89 e5                	mov    %esp,%ebp
  cb:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  ce:	80 3a 00             	cmpb   $0x0,(%edx)
  d1:	74 15                	je     e8 <strlen+0x20>
  d3:	31 c0                	xor    %eax,%eax
  d5:	8d 76 00             	lea    0x0(%esi),%esi
  d8:	40                   	inc    %eax
  d9:	89 c1                	mov    %eax,%ecx
  db:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  df:	75 f7                	jne    d8 <strlen+0x10>
    ;
  return n;
}
  e1:	89 c8                	mov    %ecx,%eax
  e3:	5d                   	pop    %ebp
  e4:	c3                   	ret
  e5:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  e8:	31 c9                	xor    %ecx,%ecx
}
  ea:	89 c8                	mov    %ecx,%eax
  ec:	5d                   	pop    %ebp
  ed:	c3                   	ret
  ee:	66 90                	xchg   %ax,%ax

000000f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  f4:	8b 7d 08             	mov    0x8(%ebp),%edi
  f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	fc                   	cld
  fe:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 100:	8b 45 08             	mov    0x8(%ebp),%eax
 103:	8b 7d fc             	mov    -0x4(%ebp),%edi
 106:	c9                   	leave
 107:	c3                   	ret

00000108 <strchr>:

char*
strchr(const char *s, char c)
{
 108:	55                   	push   %ebp
 109:	89 e5                	mov    %esp,%ebp
 10b:	8b 45 08             	mov    0x8(%ebp),%eax
 10e:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 111:	8a 10                	mov    (%eax),%dl
 113:	84 d2                	test   %dl,%dl
 115:	75 0c                	jne    123 <strchr+0x1b>
 117:	eb 13                	jmp    12c <strchr+0x24>
 119:	8d 76 00             	lea    0x0(%esi),%esi
 11c:	40                   	inc    %eax
 11d:	8a 10                	mov    (%eax),%dl
 11f:	84 d2                	test   %dl,%dl
 121:	74 09                	je     12c <strchr+0x24>
    if(*s == c)
 123:	38 d1                	cmp    %dl,%cl
 125:	75 f5                	jne    11c <strchr+0x14>
      return (char*)s;
  return 0;
}
 127:	5d                   	pop    %ebp
 128:	c3                   	ret
 129:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 12c:	31 c0                	xor    %eax,%eax
}
 12e:	5d                   	pop    %ebp
 12f:	c3                   	ret

00000130 <gets>:

char*
gets(char *buf, int max)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	56                   	push   %esi
 135:	53                   	push   %ebx
 136:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 139:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 13b:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i=0; i+1 < max; ){
 13e:	eb 24                	jmp    164 <gets+0x34>
    cc = read(0, &c, 1);
 140:	50                   	push   %eax
 141:	6a 01                	push   $0x1
 143:	56                   	push   %esi
 144:	6a 00                	push   $0x0
 146:	e8 f4 00 00 00       	call   23f <read>
    if(cc < 1)
 14b:	83 c4 10             	add    $0x10,%esp
 14e:	85 c0                	test   %eax,%eax
 150:	7e 1a                	jle    16c <gets+0x3c>
      break;
    buf[i++] = c;
 152:	8a 45 e7             	mov    -0x19(%ebp),%al
 155:	8b 55 08             	mov    0x8(%ebp),%edx
 158:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 15c:	3c 0a                	cmp    $0xa,%al
 15e:	74 0e                	je     16e <gets+0x3e>
 160:	3c 0d                	cmp    $0xd,%al
 162:	74 0a                	je     16e <gets+0x3e>
  for(i=0; i+1 < max; ){
 164:	89 df                	mov    %ebx,%edi
 166:	43                   	inc    %ebx
 167:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 16a:	7c d4                	jl     140 <gets+0x10>
 16c:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 16e:	8b 45 08             	mov    0x8(%ebp),%eax
 171:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 175:	8d 65 f4             	lea    -0xc(%ebp),%esp
 178:	5b                   	pop    %ebx
 179:	5e                   	pop    %esi
 17a:	5f                   	pop    %edi
 17b:	5d                   	pop    %ebp
 17c:	c3                   	ret
 17d:	8d 76 00             	lea    0x0(%esi),%esi

00000180 <stat>:

int
stat(const char *n, struct stat *st)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	56                   	push   %esi
 184:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 185:	83 ec 08             	sub    $0x8,%esp
 188:	6a 00                	push   $0x0
 18a:	ff 75 08             	push   0x8(%ebp)
 18d:	e8 d5 00 00 00       	call   267 <open>
  if(fd < 0)
 192:	83 c4 10             	add    $0x10,%esp
 195:	85 c0                	test   %eax,%eax
 197:	78 27                	js     1c0 <stat+0x40>
 199:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 19b:	83 ec 08             	sub    $0x8,%esp
 19e:	ff 75 0c             	push   0xc(%ebp)
 1a1:	50                   	push   %eax
 1a2:	e8 d8 00 00 00       	call   27f <fstat>
 1a7:	89 c6                	mov    %eax,%esi
  close(fd);
 1a9:	89 1c 24             	mov    %ebx,(%esp)
 1ac:	e8 9e 00 00 00       	call   24f <close>
  return r;
 1b1:	83 c4 10             	add    $0x10,%esp
}
 1b4:	89 f0                	mov    %esi,%eax
 1b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1b9:	5b                   	pop    %ebx
 1ba:	5e                   	pop    %esi
 1bb:	5d                   	pop    %ebp
 1bc:	c3                   	ret
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 1c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1c5:	eb ed                	jmp    1b4 <stat+0x34>
 1c7:	90                   	nop

000001c8 <atoi>:

int
atoi(const char *s)
{
 1c8:	55                   	push   %ebp
 1c9:	89 e5                	mov    %esp,%ebp
 1cb:	53                   	push   %ebx
 1cc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1cf:	0f be 01             	movsbl (%ecx),%eax
 1d2:	8d 50 d0             	lea    -0x30(%eax),%edx
 1d5:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
 1d8:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 1dd:	77 16                	ja     1f5 <atoi+0x2d>
 1df:	90                   	nop
    n = n*10 + *s++ - '0';
 1e0:	41                   	inc    %ecx
 1e1:	8d 14 92             	lea    (%edx,%edx,4),%edx
 1e4:	01 d2                	add    %edx,%edx
 1e6:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
 1ea:	0f be 01             	movsbl (%ecx),%eax
 1ed:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1f0:	80 fb 09             	cmp    $0x9,%bl
 1f3:	76 eb                	jbe    1e0 <atoi+0x18>
  return n;
}
 1f5:	89 d0                	mov    %edx,%eax
 1f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1fa:	c9                   	leave
 1fb:	c3                   	ret

000001fc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1fc:	55                   	push   %ebp
 1fd:	89 e5                	mov    %esp,%ebp
 1ff:	57                   	push   %edi
 200:	56                   	push   %esi
 201:	8b 55 08             	mov    0x8(%ebp),%edx
 204:	8b 75 0c             	mov    0xc(%ebp),%esi
 207:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 20a:	85 c0                	test   %eax,%eax
 20c:	7e 0b                	jle    219 <memmove+0x1d>
 20e:	01 d0                	add    %edx,%eax
  dst = vdst;
 210:	89 d7                	mov    %edx,%edi
 212:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 214:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 215:	39 f8                	cmp    %edi,%eax
 217:	75 fb                	jne    214 <memmove+0x18>
  return vdst;
}
 219:	89 d0                	mov    %edx,%eax
 21b:	5e                   	pop    %esi
 21c:	5f                   	pop    %edi
 21d:	5d                   	pop    %ebp
 21e:	c3                   	ret

0000021f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 21f:	b8 01 00 00 00       	mov    $0x1,%eax
 224:	cd 40                	int    $0x40
 226:	c3                   	ret

00000227 <exit>:
SYSCALL(exit)
 227:	b8 02 00 00 00       	mov    $0x2,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret

0000022f <wait>:
SYSCALL(wait)
 22f:	b8 03 00 00 00       	mov    $0x3,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret

00000237 <pipe>:
SYSCALL(pipe)
 237:	b8 04 00 00 00       	mov    $0x4,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret

0000023f <read>:
SYSCALL(read)
 23f:	b8 05 00 00 00       	mov    $0x5,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret

00000247 <write>:
SYSCALL(write)
 247:	b8 10 00 00 00       	mov    $0x10,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret

0000024f <close>:
SYSCALL(close)
 24f:	b8 15 00 00 00       	mov    $0x15,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret

00000257 <kill>:
SYSCALL(kill)
 257:	b8 06 00 00 00       	mov    $0x6,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret

0000025f <exec>:
SYSCALL(exec)
 25f:	b8 07 00 00 00       	mov    $0x7,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret

00000267 <open>:
SYSCALL(open)
 267:	b8 0f 00 00 00       	mov    $0xf,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret

0000026f <mknod>:
SYSCALL(mknod)
 26f:	b8 11 00 00 00       	mov    $0x11,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret

00000277 <unlink>:
SYSCALL(unlink)
 277:	b8 12 00 00 00       	mov    $0x12,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret

0000027f <fstat>:
SYSCALL(fstat)
 27f:	b8 08 00 00 00       	mov    $0x8,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret

00000287 <link>:
SYSCALL(link)
 287:	b8 13 00 00 00       	mov    $0x13,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret

0000028f <mkdir>:
SYSCALL(mkdir)
 28f:	b8 14 00 00 00       	mov    $0x14,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret

00000297 <chdir>:
SYSCALL(chdir)
 297:	b8 09 00 00 00       	mov    $0x9,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret

0000029f <dup>:
SYSCALL(dup)
 29f:	b8 0a 00 00 00       	mov    $0xa,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret

000002a7 <getpid>:
SYSCALL(getpid)
 2a7:	b8 0b 00 00 00       	mov    $0xb,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret

000002af <sbrk>:
SYSCALL(sbrk)
 2af:	b8 0c 00 00 00       	mov    $0xc,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret

000002b7 <sleep>:
SYSCALL(sleep)
 2b7:	b8 0d 00 00 00       	mov    $0xd,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret

000002bf <uptime>:
SYSCALL(uptime)
 2bf:	b8 0e 00 00 00       	mov    $0xe,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret

000002c7 <countfp>:
SYSCALL(countfp)
 2c7:	b8 16 00 00 00       	mov    $0x16,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret
 2cf:	90                   	nop

000002d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	57                   	push   %edi
 2d4:	56                   	push   %esi
 2d5:	53                   	push   %ebx
 2d6:	83 ec 3c             	sub    $0x3c,%esp
 2d9:	89 45 c0             	mov    %eax,-0x40(%ebp)
 2dc:	89 cb                	mov    %ecx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2de:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2e1:	85 c9                	test   %ecx,%ecx
 2e3:	74 04                	je     2e9 <printint+0x19>
 2e5:	85 d2                	test   %edx,%edx
 2e7:	78 6b                	js     354 <printint+0x84>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 2e9:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  neg = 0;
 2ec:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  }

  i = 0;
 2f3:	31 c9                	xor    %ecx,%ecx
 2f5:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 2f8:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 2fb:	31 d2                	xor    %edx,%edx
 2fd:	f7 f3                	div    %ebx
 2ff:	89 cf                	mov    %ecx,%edi
 301:	8d 49 01             	lea    0x1(%ecx),%ecx
 304:	8a 92 90 06 00 00    	mov    0x690(%edx),%dl
 30a:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
  }while((x /= base) != 0);
 30e:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 311:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 314:	39 da                	cmp    %ebx,%edx
 316:	73 e0                	jae    2f8 <printint+0x28>
  if(neg)
 318:	8b 55 08             	mov    0x8(%ebp),%edx
 31b:	85 d2                	test   %edx,%edx
 31d:	74 07                	je     326 <printint+0x56>
    buf[i++] = '-';
 31f:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)

  while(--i >= 0)
 324:	89 cf                	mov    %ecx,%edi
 326:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 329:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 32d:	8d 76 00             	lea    0x0(%esi),%esi
    putc(fd, buf[i]);
 330:	8a 07                	mov    (%edi),%al
 332:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 335:	50                   	push   %eax
 336:	6a 01                	push   $0x1
 338:	56                   	push   %esi
 339:	ff 75 c0             	push   -0x40(%ebp)
 33c:	e8 06 ff ff ff       	call   247 <write>
  while(--i >= 0)
 341:	89 f8                	mov    %edi,%eax
 343:	4f                   	dec    %edi
 344:	83 c4 10             	add    $0x10,%esp
 347:	39 c3                	cmp    %eax,%ebx
 349:	75 e5                	jne    330 <printint+0x60>
}
 34b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 34e:	5b                   	pop    %ebx
 34f:	5e                   	pop    %esi
 350:	5f                   	pop    %edi
 351:	5d                   	pop    %ebp
 352:	c3                   	ret
 353:	90                   	nop
    x = -xx;
 354:	f7 da                	neg    %edx
 356:	89 55 c4             	mov    %edx,-0x3c(%ebp)
 359:	eb 98                	jmp    2f3 <printint+0x23>
 35b:	90                   	nop

0000035c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 35c:	55                   	push   %ebp
 35d:	89 e5                	mov    %esp,%ebp
 35f:	57                   	push   %edi
 360:	56                   	push   %esi
 361:	53                   	push   %ebx
 362:	83 ec 2c             	sub    $0x2c,%esp
 365:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 368:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 36b:	8a 13                	mov    (%ebx),%dl
 36d:	84 d2                	test   %dl,%dl
 36f:	74 5c                	je     3cd <printf+0x71>
 371:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 372:	8d 45 10             	lea    0x10(%ebp),%eax
 375:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 378:	31 ff                	xor    %edi,%edi
 37a:	eb 20                	jmp    39c <printf+0x40>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 37c:	83 f8 25             	cmp    $0x25,%eax
 37f:	74 3f                	je     3c0 <printf+0x64>
        state = '%';
      } else {
        putc(fd, c);
 381:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 384:	50                   	push   %eax
 385:	6a 01                	push   $0x1
 387:	8d 45 e7             	lea    -0x19(%ebp),%eax
 38a:	50                   	push   %eax
 38b:	56                   	push   %esi
 38c:	e8 b6 fe ff ff       	call   247 <write>
        putc(fd, c);
 391:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 394:	43                   	inc    %ebx
 395:	8a 53 ff             	mov    -0x1(%ebx),%dl
 398:	84 d2                	test   %dl,%dl
 39a:	74 31                	je     3cd <printf+0x71>
    c = fmt[i] & 0xff;
 39c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 39f:	85 ff                	test   %edi,%edi
 3a1:	74 d9                	je     37c <printf+0x20>
      }
    } else if(state == '%'){
 3a3:	83 ff 25             	cmp    $0x25,%edi
 3a6:	75 ec                	jne    394 <printf+0x38>
      if(c == 'd'){
 3a8:	83 f8 25             	cmp    $0x25,%eax
 3ab:	0f 84 f3 00 00 00    	je     4a4 <printf+0x148>
 3b1:	83 e8 63             	sub    $0x63,%eax
 3b4:	83 f8 15             	cmp    $0x15,%eax
 3b7:	77 1f                	ja     3d8 <printf+0x7c>
 3b9:	ff 24 85 38 06 00 00 	jmp    *0x638(,%eax,4)
        state = '%';
 3c0:	bf 25 00 00 00       	mov    $0x25,%edi
  for(i = 0; fmt[i]; i++){
 3c5:	43                   	inc    %ebx
 3c6:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3c9:	84 d2                	test   %dl,%dl
 3cb:	75 cf                	jne    39c <printf+0x40>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3d0:	5b                   	pop    %ebx
 3d1:	5e                   	pop    %esi
 3d2:	5f                   	pop    %edi
 3d3:	5d                   	pop    %ebp
 3d4:	c3                   	ret
 3d5:	8d 76 00             	lea    0x0(%esi),%esi
 3d8:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 3db:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 3df:	50                   	push   %eax
 3e0:	6a 01                	push   $0x1
 3e2:	8d 7d e7             	lea    -0x19(%ebp),%edi
 3e5:	57                   	push   %edi
 3e6:	56                   	push   %esi
 3e7:	e8 5b fe ff ff       	call   247 <write>
        putc(fd, c);
 3ec:	8a 55 d0             	mov    -0x30(%ebp),%dl
 3ef:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 3f2:	83 c4 0c             	add    $0xc,%esp
 3f5:	6a 01                	push   $0x1
 3f7:	57                   	push   %edi
 3f8:	56                   	push   %esi
 3f9:	e8 49 fe ff ff       	call   247 <write>
        putc(fd, c);
 3fe:	83 c4 10             	add    $0x10,%esp
      state = 0;
 401:	31 ff                	xor    %edi,%edi
 403:	eb 8f                	jmp    394 <printf+0x38>
 405:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 408:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 40b:	8b 17                	mov    (%edi),%edx
 40d:	83 ec 0c             	sub    $0xc,%esp
 410:	6a 00                	push   $0x0
 412:	b9 10 00 00 00       	mov    $0x10,%ecx
 417:	89 f0                	mov    %esi,%eax
 419:	e8 b2 fe ff ff       	call   2d0 <printint>
        ap++;
 41e:	83 c7 04             	add    $0x4,%edi
 421:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 424:	83 c4 10             	add    $0x10,%esp
      state = 0;
 427:	31 ff                	xor    %edi,%edi
        ap++;
 429:	e9 66 ff ff ff       	jmp    394 <printf+0x38>
        s = (char*)*ap;
 42e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 431:	8b 10                	mov    (%eax),%edx
        ap++;
 433:	83 c0 04             	add    $0x4,%eax
 436:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 439:	85 d2                	test   %edx,%edx
 43b:	74 77                	je     4b4 <printf+0x158>
        while(*s != 0){
 43d:	8a 02                	mov    (%edx),%al
 43f:	84 c0                	test   %al,%al
 441:	74 7a                	je     4bd <printf+0x161>
 443:	8d 7d e7             	lea    -0x19(%ebp),%edi
 446:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 449:	89 d3                	mov    %edx,%ebx
 44b:	90                   	nop
          putc(fd, *s);
 44c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 44f:	50                   	push   %eax
 450:	6a 01                	push   $0x1
 452:	57                   	push   %edi
 453:	56                   	push   %esi
 454:	e8 ee fd ff ff       	call   247 <write>
          s++;
 459:	43                   	inc    %ebx
        while(*s != 0){
 45a:	8a 03                	mov    (%ebx),%al
 45c:	83 c4 10             	add    $0x10,%esp
 45f:	84 c0                	test   %al,%al
 461:	75 e9                	jne    44c <printf+0xf0>
      state = 0;
 463:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 466:	31 ff                	xor    %edi,%edi
 468:	e9 27 ff ff ff       	jmp    394 <printf+0x38>
        printint(fd, *ap, 10, 1);
 46d:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 470:	8b 17                	mov    (%edi),%edx
 472:	83 ec 0c             	sub    $0xc,%esp
 475:	6a 01                	push   $0x1
 477:	b9 0a 00 00 00       	mov    $0xa,%ecx
 47c:	eb 99                	jmp    417 <printf+0xbb>
        putc(fd, *ap);
 47e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 481:	8b 00                	mov    (%eax),%eax
 483:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 486:	51                   	push   %ecx
 487:	6a 01                	push   $0x1
 489:	8d 7d e7             	lea    -0x19(%ebp),%edi
 48c:	57                   	push   %edi
 48d:	56                   	push   %esi
 48e:	e8 b4 fd ff ff       	call   247 <write>
        ap++;
 493:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 497:	83 c4 10             	add    $0x10,%esp
      state = 0;
 49a:	31 ff                	xor    %edi,%edi
 49c:	e9 f3 fe ff ff       	jmp    394 <printf+0x38>
 4a1:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 4a4:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4a7:	52                   	push   %edx
 4a8:	6a 01                	push   $0x1
 4aa:	8d 7d e7             	lea    -0x19(%ebp),%edi
 4ad:	e9 45 ff ff ff       	jmp    3f7 <printf+0x9b>
 4b2:	66 90                	xchg   %ax,%ax
 4b4:	b0 28                	mov    $0x28,%al
          s = "(null)";
 4b6:	ba 31 06 00 00       	mov    $0x631,%edx
 4bb:	eb 86                	jmp    443 <printf+0xe7>
      state = 0;
 4bd:	31 ff                	xor    %edi,%edi
 4bf:	e9 d0 fe ff ff       	jmp    394 <printf+0x38>

000004c4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4c4:	55                   	push   %ebp
 4c5:	89 e5                	mov    %esp,%ebp
 4c7:	57                   	push   %edi
 4c8:	56                   	push   %esi
 4c9:	53                   	push   %ebx
 4ca:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4cd:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4d0:	a1 a4 06 00 00       	mov    0x6a4,%eax
 4d5:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4d8:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4da:	39 c8                	cmp    %ecx,%eax
 4dc:	73 2e                	jae    50c <free+0x48>
 4de:	39 d1                	cmp    %edx,%ecx
 4e0:	72 04                	jb     4e6 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4e2:	39 d0                	cmp    %edx,%eax
 4e4:	72 2e                	jb     514 <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4e6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4e9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4ec:	39 fa                	cmp    %edi,%edx
 4ee:	74 28                	je     518 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 4f0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 4f3:	8b 50 04             	mov    0x4(%eax),%edx
 4f6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4f9:	39 f1                	cmp    %esi,%ecx
 4fb:	74 32                	je     52f <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 4fd:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 4ff:	a3 a4 06 00 00       	mov    %eax,0x6a4
}
 504:	5b                   	pop    %ebx
 505:	5e                   	pop    %esi
 506:	5f                   	pop    %edi
 507:	5d                   	pop    %ebp
 508:	c3                   	ret
 509:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 50c:	39 d0                	cmp    %edx,%eax
 50e:	72 04                	jb     514 <free+0x50>
 510:	39 d1                	cmp    %edx,%ecx
 512:	72 d2                	jb     4e6 <free+0x22>
{
 514:	89 d0                	mov    %edx,%eax
 516:	eb c0                	jmp    4d8 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 518:	03 72 04             	add    0x4(%edx),%esi
 51b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 51e:	8b 10                	mov    (%eax),%edx
 520:	8b 12                	mov    (%edx),%edx
 522:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 525:	8b 50 04             	mov    0x4(%eax),%edx
 528:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 52b:	39 f1                	cmp    %esi,%ecx
 52d:	75 ce                	jne    4fd <free+0x39>
    p->s.size += bp->s.size;
 52f:	03 53 fc             	add    -0x4(%ebx),%edx
 532:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 535:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 538:	89 08                	mov    %ecx,(%eax)
  freep = p;
 53a:	a3 a4 06 00 00       	mov    %eax,0x6a4
}
 53f:	5b                   	pop    %ebx
 540:	5e                   	pop    %esi
 541:	5f                   	pop    %edi
 542:	5d                   	pop    %ebp
 543:	c3                   	ret

00000544 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 544:	55                   	push   %ebp
 545:	89 e5                	mov    %esp,%ebp
 547:	57                   	push   %edi
 548:	56                   	push   %esi
 549:	53                   	push   %ebx
 54a:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 54d:	8b 45 08             	mov    0x8(%ebp),%eax
 550:	8d 78 07             	lea    0x7(%eax),%edi
 553:	c1 ef 03             	shr    $0x3,%edi
 556:	47                   	inc    %edi
  if((prevp = freep) == 0){
 557:	8b 15 a4 06 00 00    	mov    0x6a4,%edx
 55d:	85 d2                	test   %edx,%edx
 55f:	0f 84 93 00 00 00    	je     5f8 <malloc+0xb4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 565:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 567:	8b 48 04             	mov    0x4(%eax),%ecx
 56a:	39 f9                	cmp    %edi,%ecx
 56c:	73 62                	jae    5d0 <malloc+0x8c>
  if(nu < 4096)
 56e:	89 fb                	mov    %edi,%ebx
 570:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 576:	72 78                	jb     5f0 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 578:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 57f:	eb 0e                	jmp    58f <malloc+0x4b>
 581:	8d 76 00             	lea    0x0(%esi),%esi
 584:	89 c2                	mov    %eax,%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 586:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 588:	8b 48 04             	mov    0x4(%eax),%ecx
 58b:	39 f9                	cmp    %edi,%ecx
 58d:	73 41                	jae    5d0 <malloc+0x8c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 58f:	3b 05 a4 06 00 00    	cmp    0x6a4,%eax
 595:	75 ed                	jne    584 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 597:	83 ec 0c             	sub    $0xc,%esp
 59a:	56                   	push   %esi
 59b:	e8 0f fd ff ff       	call   2af <sbrk>
  if(p == (char*)-1)
 5a0:	83 c4 10             	add    $0x10,%esp
 5a3:	83 f8 ff             	cmp    $0xffffffff,%eax
 5a6:	74 1c                	je     5c4 <malloc+0x80>
  hp->s.size = nu;
 5a8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 5ab:	83 ec 0c             	sub    $0xc,%esp
 5ae:	83 c0 08             	add    $0x8,%eax
 5b1:	50                   	push   %eax
 5b2:	e8 0d ff ff ff       	call   4c4 <free>
  return freep;
 5b7:	8b 15 a4 06 00 00    	mov    0x6a4,%edx
      if((p = morecore(nunits)) == 0)
 5bd:	83 c4 10             	add    $0x10,%esp
 5c0:	85 d2                	test   %edx,%edx
 5c2:	75 c2                	jne    586 <malloc+0x42>
        return 0;
 5c4:	31 c0                	xor    %eax,%eax
  }
}
 5c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c9:	5b                   	pop    %ebx
 5ca:	5e                   	pop    %esi
 5cb:	5f                   	pop    %edi
 5cc:	5d                   	pop    %ebp
 5cd:	c3                   	ret
 5ce:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 5d0:	39 cf                	cmp    %ecx,%edi
 5d2:	74 4c                	je     620 <malloc+0xdc>
        p->s.size -= nunits;
 5d4:	29 f9                	sub    %edi,%ecx
 5d6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5d9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5dc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 5df:	89 15 a4 06 00 00    	mov    %edx,0x6a4
      return (void*)(p + 1);
 5e5:	83 c0 08             	add    $0x8,%eax
}
 5e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5eb:	5b                   	pop    %ebx
 5ec:	5e                   	pop    %esi
 5ed:	5f                   	pop    %edi
 5ee:	5d                   	pop    %ebp
 5ef:	c3                   	ret
  if(nu < 4096)
 5f0:	bb 00 10 00 00       	mov    $0x1000,%ebx
 5f5:	eb 81                	jmp    578 <malloc+0x34>
 5f7:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 5f8:	c7 05 a4 06 00 00 a8 	movl   $0x6a8,0x6a4
 5ff:	06 00 00 
 602:	c7 05 a8 06 00 00 a8 	movl   $0x6a8,0x6a8
 609:	06 00 00 
    base.s.size = 0;
 60c:	c7 05 ac 06 00 00 00 	movl   $0x0,0x6ac
 613:	00 00 00 
 616:	b8 a8 06 00 00       	mov    $0x6a8,%eax
 61b:	e9 4e ff ff ff       	jmp    56e <malloc+0x2a>
        prevp->s.ptr = p->s.ptr;
 620:	8b 08                	mov    (%eax),%ecx
 622:	89 0a                	mov    %ecx,(%edx)
 624:	eb b9                	jmp    5df <malloc+0x9b>
