
_mkdir:     file format elf32-i386


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
  16:	8b 59 04             	mov    0x4(%ecx),%ebx
  int i;

  if(argc < 2){
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 3a                	jle    58 <main+0x58>
  1e:	83 c3 04             	add    $0x4,%ebx
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  21:	bf 01 00 00 00       	mov    $0x1,%edi
  26:	eb 08                	jmp    30 <main+0x30>
  28:	47                   	inc    %edi
  29:	83 c3 04             	add    $0x4,%ebx
  2c:	39 fe                	cmp    %edi,%esi
  2e:	74 23                	je     53 <main+0x53>
    if(mkdir(argv[i]) < 0){
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 33                	push   (%ebx)
  35:	e8 5d 02 00 00       	call   297 <mkdir>
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
  3f:	79 e7                	jns    28 <main+0x28>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  41:	50                   	push   %eax
  42:	ff 33                	push   (%ebx)
  44:	68 47 06 00 00       	push   $0x647
  49:	6a 02                	push   $0x2
  4b:	e8 14 03 00 00       	call   364 <printf>
      break;
  50:	83 c4 10             	add    $0x10,%esp
    }
  }

  exit();
  53:	e8 d7 01 00 00       	call   22f <exit>
    printf(2, "Usage: mkdir files...\n");
  58:	52                   	push   %edx
  59:	52                   	push   %edx
  5a:	68 30 06 00 00       	push   $0x630
  5f:	6a 02                	push   $0x2
  61:	e8 fe 02 00 00       	call   364 <printf>
    exit();
  66:	e8 c4 01 00 00       	call   22f <exit>
  6b:	90                   	nop

0000006c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  6c:	55                   	push   %ebp
  6d:	89 e5                	mov    %esp,%ebp
  6f:	53                   	push   %ebx
  70:	8b 4d 08             	mov    0x8(%ebp),%ecx
  73:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  76:	31 c0                	xor    %eax,%eax
  78:	8a 14 03             	mov    (%ebx,%eax,1),%dl
  7b:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  7e:	40                   	inc    %eax
  7f:	84 d2                	test   %dl,%dl
  81:	75 f5                	jne    78 <strcpy+0xc>
    ;
  return os;
}
  83:	89 c8                	mov    %ecx,%eax
  85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  88:	c9                   	leave
  89:	c3                   	ret
  8a:	66 90                	xchg   %ax,%ax

0000008c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8c:	55                   	push   %ebp
  8d:	89 e5                	mov    %esp,%ebp
  8f:	53                   	push   %ebx
  90:	8b 55 08             	mov    0x8(%ebp),%edx
  93:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
  96:	0f b6 02             	movzbl (%edx),%eax
  99:	84 c0                	test   %al,%al
  9b:	75 10                	jne    ad <strcmp+0x21>
  9d:	eb 2a                	jmp    c9 <strcmp+0x3d>
  9f:	90                   	nop
    p++, q++;
  a0:	42                   	inc    %edx
  a1:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
  a4:	0f b6 02             	movzbl (%edx),%eax
  a7:	84 c0                	test   %al,%al
  a9:	74 11                	je     bc <strcmp+0x30>
  ab:	89 cb                	mov    %ecx,%ebx
  ad:	0f b6 0b             	movzbl (%ebx),%ecx
  b0:	38 c1                	cmp    %al,%cl
  b2:	74 ec                	je     a0 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  b4:	29 c8                	sub    %ecx,%eax
}
  b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  b9:	c9                   	leave
  ba:	c3                   	ret
  bb:	90                   	nop
  return (uchar)*p - (uchar)*q;
  bc:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
  c0:	31 c0                	xor    %eax,%eax
  c2:	29 c8                	sub    %ecx,%eax
}
  c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  c7:	c9                   	leave
  c8:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  c9:	0f b6 0b             	movzbl (%ebx),%ecx
  cc:	31 c0                	xor    %eax,%eax
  ce:	eb e4                	jmp    b4 <strcmp+0x28>

000000d0 <strlen>:

uint
strlen(const char *s)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  d6:	80 3a 00             	cmpb   $0x0,(%edx)
  d9:	74 15                	je     f0 <strlen+0x20>
  db:	31 c0                	xor    %eax,%eax
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	40                   	inc    %eax
  e1:	89 c1                	mov    %eax,%ecx
  e3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  e7:	75 f7                	jne    e0 <strlen+0x10>
    ;
  return n;
}
  e9:	89 c8                	mov    %ecx,%eax
  eb:	5d                   	pop    %ebp
  ec:	c3                   	ret
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  f0:	31 c9                	xor    %ecx,%ecx
}
  f2:	89 c8                	mov    %ecx,%eax
  f4:	5d                   	pop    %ebp
  f5:	c3                   	ret
  f6:	66 90                	xchg   %ax,%ax

000000f8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  fc:	8b 7d 08             	mov    0x8(%ebp),%edi
  ff:	8b 4d 10             	mov    0x10(%ebp),%ecx
 102:	8b 45 0c             	mov    0xc(%ebp),%eax
 105:	fc                   	cld
 106:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 108:	8b 45 08             	mov    0x8(%ebp),%eax
 10b:	8b 7d fc             	mov    -0x4(%ebp),%edi
 10e:	c9                   	leave
 10f:	c3                   	ret

00000110 <strchr>:

char*
strchr(const char *s, char c)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 45 08             	mov    0x8(%ebp),%eax
 116:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 119:	8a 10                	mov    (%eax),%dl
 11b:	84 d2                	test   %dl,%dl
 11d:	75 0c                	jne    12b <strchr+0x1b>
 11f:	eb 13                	jmp    134 <strchr+0x24>
 121:	8d 76 00             	lea    0x0(%esi),%esi
 124:	40                   	inc    %eax
 125:	8a 10                	mov    (%eax),%dl
 127:	84 d2                	test   %dl,%dl
 129:	74 09                	je     134 <strchr+0x24>
    if(*s == c)
 12b:	38 d1                	cmp    %dl,%cl
 12d:	75 f5                	jne    124 <strchr+0x14>
      return (char*)s;
  return 0;
}
 12f:	5d                   	pop    %ebp
 130:	c3                   	ret
 131:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 134:	31 c0                	xor    %eax,%eax
}
 136:	5d                   	pop    %ebp
 137:	c3                   	ret

00000138 <gets>:

char*
gets(char *buf, int max)
{
 138:	55                   	push   %ebp
 139:	89 e5                	mov    %esp,%ebp
 13b:	57                   	push   %edi
 13c:	56                   	push   %esi
 13d:	53                   	push   %ebx
 13e:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 141:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 143:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i=0; i+1 < max; ){
 146:	eb 24                	jmp    16c <gets+0x34>
    cc = read(0, &c, 1);
 148:	50                   	push   %eax
 149:	6a 01                	push   $0x1
 14b:	56                   	push   %esi
 14c:	6a 00                	push   $0x0
 14e:	e8 f4 00 00 00       	call   247 <read>
    if(cc < 1)
 153:	83 c4 10             	add    $0x10,%esp
 156:	85 c0                	test   %eax,%eax
 158:	7e 1a                	jle    174 <gets+0x3c>
      break;
    buf[i++] = c;
 15a:	8a 45 e7             	mov    -0x19(%ebp),%al
 15d:	8b 55 08             	mov    0x8(%ebp),%edx
 160:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 164:	3c 0a                	cmp    $0xa,%al
 166:	74 0e                	je     176 <gets+0x3e>
 168:	3c 0d                	cmp    $0xd,%al
 16a:	74 0a                	je     176 <gets+0x3e>
  for(i=0; i+1 < max; ){
 16c:	89 df                	mov    %ebx,%edi
 16e:	43                   	inc    %ebx
 16f:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 172:	7c d4                	jl     148 <gets+0x10>
 174:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 176:	8b 45 08             	mov    0x8(%ebp),%eax
 179:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 17d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 180:	5b                   	pop    %ebx
 181:	5e                   	pop    %esi
 182:	5f                   	pop    %edi
 183:	5d                   	pop    %ebp
 184:	c3                   	ret
 185:	8d 76 00             	lea    0x0(%esi),%esi

00000188 <stat>:

int
stat(const char *n, struct stat *st)
{
 188:	55                   	push   %ebp
 189:	89 e5                	mov    %esp,%ebp
 18b:	56                   	push   %esi
 18c:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 18d:	83 ec 08             	sub    $0x8,%esp
 190:	6a 00                	push   $0x0
 192:	ff 75 08             	push   0x8(%ebp)
 195:	e8 d5 00 00 00       	call   26f <open>
  if(fd < 0)
 19a:	83 c4 10             	add    $0x10,%esp
 19d:	85 c0                	test   %eax,%eax
 19f:	78 27                	js     1c8 <stat+0x40>
 1a1:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1a3:	83 ec 08             	sub    $0x8,%esp
 1a6:	ff 75 0c             	push   0xc(%ebp)
 1a9:	50                   	push   %eax
 1aa:	e8 d8 00 00 00       	call   287 <fstat>
 1af:	89 c6                	mov    %eax,%esi
  close(fd);
 1b1:	89 1c 24             	mov    %ebx,(%esp)
 1b4:	e8 9e 00 00 00       	call   257 <close>
  return r;
 1b9:	83 c4 10             	add    $0x10,%esp
}
 1bc:	89 f0                	mov    %esi,%eax
 1be:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1c1:	5b                   	pop    %ebx
 1c2:	5e                   	pop    %esi
 1c3:	5d                   	pop    %ebp
 1c4:	c3                   	ret
 1c5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 1c8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1cd:	eb ed                	jmp    1bc <stat+0x34>
 1cf:	90                   	nop

000001d0 <atoi>:

int
atoi(const char *s)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	53                   	push   %ebx
 1d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d7:	0f be 01             	movsbl (%ecx),%eax
 1da:	8d 50 d0             	lea    -0x30(%eax),%edx
 1dd:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
 1e0:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 1e5:	77 16                	ja     1fd <atoi+0x2d>
 1e7:	90                   	nop
    n = n*10 + *s++ - '0';
 1e8:	41                   	inc    %ecx
 1e9:	8d 14 92             	lea    (%edx,%edx,4),%edx
 1ec:	01 d2                	add    %edx,%edx
 1ee:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
 1f2:	0f be 01             	movsbl (%ecx),%eax
 1f5:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1f8:	80 fb 09             	cmp    $0x9,%bl
 1fb:	76 eb                	jbe    1e8 <atoi+0x18>
  return n;
}
 1fd:	89 d0                	mov    %edx,%eax
 1ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 202:	c9                   	leave
 203:	c3                   	ret

00000204 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 204:	55                   	push   %ebp
 205:	89 e5                	mov    %esp,%ebp
 207:	57                   	push   %edi
 208:	56                   	push   %esi
 209:	8b 55 08             	mov    0x8(%ebp),%edx
 20c:	8b 75 0c             	mov    0xc(%ebp),%esi
 20f:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 212:	85 c0                	test   %eax,%eax
 214:	7e 0b                	jle    221 <memmove+0x1d>
 216:	01 d0                	add    %edx,%eax
  dst = vdst;
 218:	89 d7                	mov    %edx,%edi
 21a:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 21c:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 21d:	39 f8                	cmp    %edi,%eax
 21f:	75 fb                	jne    21c <memmove+0x18>
  return vdst;
}
 221:	89 d0                	mov    %edx,%eax
 223:	5e                   	pop    %esi
 224:	5f                   	pop    %edi
 225:	5d                   	pop    %ebp
 226:	c3                   	ret

00000227 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 227:	b8 01 00 00 00       	mov    $0x1,%eax
 22c:	cd 40                	int    $0x40
 22e:	c3                   	ret

0000022f <exit>:
SYSCALL(exit)
 22f:	b8 02 00 00 00       	mov    $0x2,%eax
 234:	cd 40                	int    $0x40
 236:	c3                   	ret

00000237 <wait>:
SYSCALL(wait)
 237:	b8 03 00 00 00       	mov    $0x3,%eax
 23c:	cd 40                	int    $0x40
 23e:	c3                   	ret

0000023f <pipe>:
SYSCALL(pipe)
 23f:	b8 04 00 00 00       	mov    $0x4,%eax
 244:	cd 40                	int    $0x40
 246:	c3                   	ret

00000247 <read>:
SYSCALL(read)
 247:	b8 05 00 00 00       	mov    $0x5,%eax
 24c:	cd 40                	int    $0x40
 24e:	c3                   	ret

0000024f <write>:
SYSCALL(write)
 24f:	b8 10 00 00 00       	mov    $0x10,%eax
 254:	cd 40                	int    $0x40
 256:	c3                   	ret

00000257 <close>:
SYSCALL(close)
 257:	b8 15 00 00 00       	mov    $0x15,%eax
 25c:	cd 40                	int    $0x40
 25e:	c3                   	ret

0000025f <kill>:
SYSCALL(kill)
 25f:	b8 06 00 00 00       	mov    $0x6,%eax
 264:	cd 40                	int    $0x40
 266:	c3                   	ret

00000267 <exec>:
SYSCALL(exec)
 267:	b8 07 00 00 00       	mov    $0x7,%eax
 26c:	cd 40                	int    $0x40
 26e:	c3                   	ret

0000026f <open>:
SYSCALL(open)
 26f:	b8 0f 00 00 00       	mov    $0xf,%eax
 274:	cd 40                	int    $0x40
 276:	c3                   	ret

00000277 <mknod>:
SYSCALL(mknod)
 277:	b8 11 00 00 00       	mov    $0x11,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret

0000027f <unlink>:
SYSCALL(unlink)
 27f:	b8 12 00 00 00       	mov    $0x12,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret

00000287 <fstat>:
SYSCALL(fstat)
 287:	b8 08 00 00 00       	mov    $0x8,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret

0000028f <link>:
SYSCALL(link)
 28f:	b8 13 00 00 00       	mov    $0x13,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret

00000297 <mkdir>:
SYSCALL(mkdir)
 297:	b8 14 00 00 00       	mov    $0x14,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret

0000029f <chdir>:
SYSCALL(chdir)
 29f:	b8 09 00 00 00       	mov    $0x9,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret

000002a7 <dup>:
SYSCALL(dup)
 2a7:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret

000002af <getpid>:
SYSCALL(getpid)
 2af:	b8 0b 00 00 00       	mov    $0xb,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret

000002b7 <sbrk>:
SYSCALL(sbrk)
 2b7:	b8 0c 00 00 00       	mov    $0xc,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret

000002bf <sleep>:
SYSCALL(sleep)
 2bf:	b8 0d 00 00 00       	mov    $0xd,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret

000002c7 <uptime>:
SYSCALL(uptime)
 2c7:	b8 0e 00 00 00       	mov    $0xe,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret

000002cf <countfp>:
SYSCALL(countfp)
 2cf:	b8 16 00 00 00       	mov    $0x16,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret
 2d7:	90                   	nop

000002d8 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2d8:	55                   	push   %ebp
 2d9:	89 e5                	mov    %esp,%ebp
 2db:	57                   	push   %edi
 2dc:	56                   	push   %esi
 2dd:	53                   	push   %ebx
 2de:	83 ec 3c             	sub    $0x3c,%esp
 2e1:	89 45 c0             	mov    %eax,-0x40(%ebp)
 2e4:	89 cb                	mov    %ecx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2e9:	85 c9                	test   %ecx,%ecx
 2eb:	74 04                	je     2f1 <printint+0x19>
 2ed:	85 d2                	test   %edx,%edx
 2ef:	78 6b                	js     35c <printint+0x84>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 2f1:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  neg = 0;
 2f4:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  }

  i = 0;
 2fb:	31 c9                	xor    %ecx,%ecx
 2fd:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 300:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 303:	31 d2                	xor    %edx,%edx
 305:	f7 f3                	div    %ebx
 307:	89 cf                	mov    %ecx,%edi
 309:	8d 49 01             	lea    0x1(%ecx),%ecx
 30c:	8a 92 c4 06 00 00    	mov    0x6c4(%edx),%dl
 312:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
  }while((x /= base) != 0);
 316:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 319:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 31c:	39 da                	cmp    %ebx,%edx
 31e:	73 e0                	jae    300 <printint+0x28>
  if(neg)
 320:	8b 55 08             	mov    0x8(%ebp),%edx
 323:	85 d2                	test   %edx,%edx
 325:	74 07                	je     32e <printint+0x56>
    buf[i++] = '-';
 327:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)

  while(--i >= 0)
 32c:	89 cf                	mov    %ecx,%edi
 32e:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 331:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 335:	8d 76 00             	lea    0x0(%esi),%esi
    putc(fd, buf[i]);
 338:	8a 07                	mov    (%edi),%al
 33a:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 33d:	50                   	push   %eax
 33e:	6a 01                	push   $0x1
 340:	56                   	push   %esi
 341:	ff 75 c0             	push   -0x40(%ebp)
 344:	e8 06 ff ff ff       	call   24f <write>
  while(--i >= 0)
 349:	89 f8                	mov    %edi,%eax
 34b:	4f                   	dec    %edi
 34c:	83 c4 10             	add    $0x10,%esp
 34f:	39 c3                	cmp    %eax,%ebx
 351:	75 e5                	jne    338 <printint+0x60>
}
 353:	8d 65 f4             	lea    -0xc(%ebp),%esp
 356:	5b                   	pop    %ebx
 357:	5e                   	pop    %esi
 358:	5f                   	pop    %edi
 359:	5d                   	pop    %ebp
 35a:	c3                   	ret
 35b:	90                   	nop
    x = -xx;
 35c:	f7 da                	neg    %edx
 35e:	89 55 c4             	mov    %edx,-0x3c(%ebp)
 361:	eb 98                	jmp    2fb <printint+0x23>
 363:	90                   	nop

00000364 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	57                   	push   %edi
 368:	56                   	push   %esi
 369:	53                   	push   %ebx
 36a:	83 ec 2c             	sub    $0x2c,%esp
 36d:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 370:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 373:	8a 13                	mov    (%ebx),%dl
 375:	84 d2                	test   %dl,%dl
 377:	74 5c                	je     3d5 <printf+0x71>
 379:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 37a:	8d 45 10             	lea    0x10(%ebp),%eax
 37d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 380:	31 ff                	xor    %edi,%edi
 382:	eb 20                	jmp    3a4 <printf+0x40>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 384:	83 f8 25             	cmp    $0x25,%eax
 387:	74 3f                	je     3c8 <printf+0x64>
        state = '%';
      } else {
        putc(fd, c);
 389:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 38c:	50                   	push   %eax
 38d:	6a 01                	push   $0x1
 38f:	8d 45 e7             	lea    -0x19(%ebp),%eax
 392:	50                   	push   %eax
 393:	56                   	push   %esi
 394:	e8 b6 fe ff ff       	call   24f <write>
        putc(fd, c);
 399:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 39c:	43                   	inc    %ebx
 39d:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3a0:	84 d2                	test   %dl,%dl
 3a2:	74 31                	je     3d5 <printf+0x71>
    c = fmt[i] & 0xff;
 3a4:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 3a7:	85 ff                	test   %edi,%edi
 3a9:	74 d9                	je     384 <printf+0x20>
      }
    } else if(state == '%'){
 3ab:	83 ff 25             	cmp    $0x25,%edi
 3ae:	75 ec                	jne    39c <printf+0x38>
      if(c == 'd'){
 3b0:	83 f8 25             	cmp    $0x25,%eax
 3b3:	0f 84 f3 00 00 00    	je     4ac <printf+0x148>
 3b9:	83 e8 63             	sub    $0x63,%eax
 3bc:	83 f8 15             	cmp    $0x15,%eax
 3bf:	77 1f                	ja     3e0 <printf+0x7c>
 3c1:	ff 24 85 6c 06 00 00 	jmp    *0x66c(,%eax,4)
        state = '%';
 3c8:	bf 25 00 00 00       	mov    $0x25,%edi
  for(i = 0; fmt[i]; i++){
 3cd:	43                   	inc    %ebx
 3ce:	8a 53 ff             	mov    -0x1(%ebx),%dl
 3d1:	84 d2                	test   %dl,%dl
 3d3:	75 cf                	jne    3a4 <printf+0x40>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3d8:	5b                   	pop    %ebx
 3d9:	5e                   	pop    %esi
 3da:	5f                   	pop    %edi
 3db:	5d                   	pop    %ebp
 3dc:	c3                   	ret
 3dd:	8d 76 00             	lea    0x0(%esi),%esi
 3e0:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 3e3:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 3e7:	50                   	push   %eax
 3e8:	6a 01                	push   $0x1
 3ea:	8d 7d e7             	lea    -0x19(%ebp),%edi
 3ed:	57                   	push   %edi
 3ee:	56                   	push   %esi
 3ef:	e8 5b fe ff ff       	call   24f <write>
        putc(fd, c);
 3f4:	8a 55 d0             	mov    -0x30(%ebp),%dl
 3f7:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 3fa:	83 c4 0c             	add    $0xc,%esp
 3fd:	6a 01                	push   $0x1
 3ff:	57                   	push   %edi
 400:	56                   	push   %esi
 401:	e8 49 fe ff ff       	call   24f <write>
        putc(fd, c);
 406:	83 c4 10             	add    $0x10,%esp
      state = 0;
 409:	31 ff                	xor    %edi,%edi
 40b:	eb 8f                	jmp    39c <printf+0x38>
 40d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 410:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 413:	8b 17                	mov    (%edi),%edx
 415:	83 ec 0c             	sub    $0xc,%esp
 418:	6a 00                	push   $0x0
 41a:	b9 10 00 00 00       	mov    $0x10,%ecx
 41f:	89 f0                	mov    %esi,%eax
 421:	e8 b2 fe ff ff       	call   2d8 <printint>
        ap++;
 426:	83 c7 04             	add    $0x4,%edi
 429:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 42c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 42f:	31 ff                	xor    %edi,%edi
        ap++;
 431:	e9 66 ff ff ff       	jmp    39c <printf+0x38>
        s = (char*)*ap;
 436:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 439:	8b 10                	mov    (%eax),%edx
        ap++;
 43b:	83 c0 04             	add    $0x4,%eax
 43e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 441:	85 d2                	test   %edx,%edx
 443:	74 77                	je     4bc <printf+0x158>
        while(*s != 0){
 445:	8a 02                	mov    (%edx),%al
 447:	84 c0                	test   %al,%al
 449:	74 7a                	je     4c5 <printf+0x161>
 44b:	8d 7d e7             	lea    -0x19(%ebp),%edi
 44e:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 451:	89 d3                	mov    %edx,%ebx
 453:	90                   	nop
          putc(fd, *s);
 454:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 457:	50                   	push   %eax
 458:	6a 01                	push   $0x1
 45a:	57                   	push   %edi
 45b:	56                   	push   %esi
 45c:	e8 ee fd ff ff       	call   24f <write>
          s++;
 461:	43                   	inc    %ebx
        while(*s != 0){
 462:	8a 03                	mov    (%ebx),%al
 464:	83 c4 10             	add    $0x10,%esp
 467:	84 c0                	test   %al,%al
 469:	75 e9                	jne    454 <printf+0xf0>
      state = 0;
 46b:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 46e:	31 ff                	xor    %edi,%edi
 470:	e9 27 ff ff ff       	jmp    39c <printf+0x38>
        printint(fd, *ap, 10, 1);
 475:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 478:	8b 17                	mov    (%edi),%edx
 47a:	83 ec 0c             	sub    $0xc,%esp
 47d:	6a 01                	push   $0x1
 47f:	b9 0a 00 00 00       	mov    $0xa,%ecx
 484:	eb 99                	jmp    41f <printf+0xbb>
        putc(fd, *ap);
 486:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 489:	8b 00                	mov    (%eax),%eax
 48b:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 48e:	51                   	push   %ecx
 48f:	6a 01                	push   $0x1
 491:	8d 7d e7             	lea    -0x19(%ebp),%edi
 494:	57                   	push   %edi
 495:	56                   	push   %esi
 496:	e8 b4 fd ff ff       	call   24f <write>
        ap++;
 49b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 49f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4a2:	31 ff                	xor    %edi,%edi
 4a4:	e9 f3 fe ff ff       	jmp    39c <printf+0x38>
 4a9:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 4ac:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4af:	52                   	push   %edx
 4b0:	6a 01                	push   $0x1
 4b2:	8d 7d e7             	lea    -0x19(%ebp),%edi
 4b5:	e9 45 ff ff ff       	jmp    3ff <printf+0x9b>
 4ba:	66 90                	xchg   %ax,%ax
 4bc:	b0 28                	mov    $0x28,%al
          s = "(null)";
 4be:	ba 63 06 00 00       	mov    $0x663,%edx
 4c3:	eb 86                	jmp    44b <printf+0xe7>
      state = 0;
 4c5:	31 ff                	xor    %edi,%edi
 4c7:	e9 d0 fe ff ff       	jmp    39c <printf+0x38>

000004cc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4cc:	55                   	push   %ebp
 4cd:	89 e5                	mov    %esp,%ebp
 4cf:	57                   	push   %edi
 4d0:	56                   	push   %esi
 4d1:	53                   	push   %ebx
 4d2:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4d5:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4d8:	a1 d8 06 00 00       	mov    0x6d8,%eax
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4e0:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4e2:	39 c8                	cmp    %ecx,%eax
 4e4:	73 2e                	jae    514 <free+0x48>
 4e6:	39 d1                	cmp    %edx,%ecx
 4e8:	72 04                	jb     4ee <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4ea:	39 d0                	cmp    %edx,%eax
 4ec:	72 2e                	jb     51c <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4ee:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4f1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4f4:	39 fa                	cmp    %edi,%edx
 4f6:	74 28                	je     520 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 4f8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 4fb:	8b 50 04             	mov    0x4(%eax),%edx
 4fe:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 501:	39 f1                	cmp    %esi,%ecx
 503:	74 32                	je     537 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 505:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 507:	a3 d8 06 00 00       	mov    %eax,0x6d8
}
 50c:	5b                   	pop    %ebx
 50d:	5e                   	pop    %esi
 50e:	5f                   	pop    %edi
 50f:	5d                   	pop    %ebp
 510:	c3                   	ret
 511:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 514:	39 d0                	cmp    %edx,%eax
 516:	72 04                	jb     51c <free+0x50>
 518:	39 d1                	cmp    %edx,%ecx
 51a:	72 d2                	jb     4ee <free+0x22>
{
 51c:	89 d0                	mov    %edx,%eax
 51e:	eb c0                	jmp    4e0 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 520:	03 72 04             	add    0x4(%edx),%esi
 523:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 526:	8b 10                	mov    (%eax),%edx
 528:	8b 12                	mov    (%edx),%edx
 52a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 52d:	8b 50 04             	mov    0x4(%eax),%edx
 530:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 533:	39 f1                	cmp    %esi,%ecx
 535:	75 ce                	jne    505 <free+0x39>
    p->s.size += bp->s.size;
 537:	03 53 fc             	add    -0x4(%ebx),%edx
 53a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 53d:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 540:	89 08                	mov    %ecx,(%eax)
  freep = p;
 542:	a3 d8 06 00 00       	mov    %eax,0x6d8
}
 547:	5b                   	pop    %ebx
 548:	5e                   	pop    %esi
 549:	5f                   	pop    %edi
 54a:	5d                   	pop    %ebp
 54b:	c3                   	ret

0000054c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 54c:	55                   	push   %ebp
 54d:	89 e5                	mov    %esp,%ebp
 54f:	57                   	push   %edi
 550:	56                   	push   %esi
 551:	53                   	push   %ebx
 552:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 555:	8b 45 08             	mov    0x8(%ebp),%eax
 558:	8d 78 07             	lea    0x7(%eax),%edi
 55b:	c1 ef 03             	shr    $0x3,%edi
 55e:	47                   	inc    %edi
  if((prevp = freep) == 0){
 55f:	8b 15 d8 06 00 00    	mov    0x6d8,%edx
 565:	85 d2                	test   %edx,%edx
 567:	0f 84 93 00 00 00    	je     600 <malloc+0xb4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 56d:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 56f:	8b 48 04             	mov    0x4(%eax),%ecx
 572:	39 f9                	cmp    %edi,%ecx
 574:	73 62                	jae    5d8 <malloc+0x8c>
  if(nu < 4096)
 576:	89 fb                	mov    %edi,%ebx
 578:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 57e:	72 78                	jb     5f8 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 580:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 587:	eb 0e                	jmp    597 <malloc+0x4b>
 589:	8d 76 00             	lea    0x0(%esi),%esi
 58c:	89 c2                	mov    %eax,%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 58e:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 590:	8b 48 04             	mov    0x4(%eax),%ecx
 593:	39 f9                	cmp    %edi,%ecx
 595:	73 41                	jae    5d8 <malloc+0x8c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 597:	3b 05 d8 06 00 00    	cmp    0x6d8,%eax
 59d:	75 ed                	jne    58c <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 59f:	83 ec 0c             	sub    $0xc,%esp
 5a2:	56                   	push   %esi
 5a3:	e8 0f fd ff ff       	call   2b7 <sbrk>
  if(p == (char*)-1)
 5a8:	83 c4 10             	add    $0x10,%esp
 5ab:	83 f8 ff             	cmp    $0xffffffff,%eax
 5ae:	74 1c                	je     5cc <malloc+0x80>
  hp->s.size = nu;
 5b0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 5b3:	83 ec 0c             	sub    $0xc,%esp
 5b6:	83 c0 08             	add    $0x8,%eax
 5b9:	50                   	push   %eax
 5ba:	e8 0d ff ff ff       	call   4cc <free>
  return freep;
 5bf:	8b 15 d8 06 00 00    	mov    0x6d8,%edx
      if((p = morecore(nunits)) == 0)
 5c5:	83 c4 10             	add    $0x10,%esp
 5c8:	85 d2                	test   %edx,%edx
 5ca:	75 c2                	jne    58e <malloc+0x42>
        return 0;
 5cc:	31 c0                	xor    %eax,%eax
  }
}
 5ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5d1:	5b                   	pop    %ebx
 5d2:	5e                   	pop    %esi
 5d3:	5f                   	pop    %edi
 5d4:	5d                   	pop    %ebp
 5d5:	c3                   	ret
 5d6:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 5d8:	39 cf                	cmp    %ecx,%edi
 5da:	74 4c                	je     628 <malloc+0xdc>
        p->s.size -= nunits;
 5dc:	29 f9                	sub    %edi,%ecx
 5de:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5e1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5e4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 5e7:	89 15 d8 06 00 00    	mov    %edx,0x6d8
      return (void*)(p + 1);
 5ed:	83 c0 08             	add    $0x8,%eax
}
 5f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f3:	5b                   	pop    %ebx
 5f4:	5e                   	pop    %esi
 5f5:	5f                   	pop    %edi
 5f6:	5d                   	pop    %ebp
 5f7:	c3                   	ret
  if(nu < 4096)
 5f8:	bb 00 10 00 00       	mov    $0x1000,%ebx
 5fd:	eb 81                	jmp    580 <malloc+0x34>
 5ff:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 600:	c7 05 d8 06 00 00 dc 	movl   $0x6dc,0x6d8
 607:	06 00 00 
 60a:	c7 05 dc 06 00 00 dc 	movl   $0x6dc,0x6dc
 611:	06 00 00 
    base.s.size = 0;
 614:	c7 05 e0 06 00 00 00 	movl   $0x0,0x6e0
 61b:	00 00 00 
 61e:	b8 dc 06 00 00       	mov    $0x6dc,%eax
 623:	e9 4e ff ff ff       	jmp    576 <malloc+0x2a>
        prevp->s.ptr = p->s.ptr;
 628:	8b 08                	mov    (%eax),%ecx
 62a:	89 0a                	mov    %ecx,(%edx)
 62c:	eb b9                	jmp    5e7 <malloc+0x9b>
