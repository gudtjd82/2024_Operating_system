
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

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
  11:	81 ec 20 02 00 00    	sub    $0x220,%esp
  int fd, i;
  char path[] = "stressfs0";
  17:	be e3 06 00 00       	mov    $0x6e3,%esi
  1c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  21:	8d bd de fd ff ff    	lea    -0x222(%ebp),%edi
  27:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  char data[512];

  printf(1, "stressfs starting\n");
  29:	68 c0 06 00 00       	push   $0x6c0
  2e:	6a 01                	push   $0x1
  30:	e8 bf 03 00 00       	call   3f4 <printf>
  memset(data, 'a', sizeof(data));
  35:	83 c4 0c             	add    $0xc,%esp
  38:	68 00 02 00 00       	push   $0x200
  3d:	6a 61                	push   $0x61
  3f:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
  45:	56                   	push   %esi
  46:	e8 3d 01 00 00       	call   188 <memset>
  4b:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
  4e:	31 db                	xor    %ebx,%ebx
    if(fork() > 0)
  50:	e8 62 02 00 00       	call   2b7 <fork>
  55:	85 c0                	test   %eax,%eax
  57:	7f 06                	jg     5f <main+0x5f>
  for(i = 0; i < 4; i++)
  59:	43                   	inc    %ebx
  5a:	83 fb 04             	cmp    $0x4,%ebx
  5d:	75 f1                	jne    50 <main+0x50>
      break;

  printf(1, "write %d\n", i);
  5f:	50                   	push   %eax
  60:	53                   	push   %ebx
  61:	68 d3 06 00 00       	push   $0x6d3
  66:	6a 01                	push   $0x1
  68:	e8 87 03 00 00       	call   3f4 <printf>

  path[8] += i;
  6d:	00 9d e6 fd ff ff    	add    %bl,-0x21a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  73:	58                   	pop    %eax
  74:	5a                   	pop    %edx
  75:	68 02 02 00 00       	push   $0x202
  7a:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  80:	50                   	push   %eax
  81:	e8 79 02 00 00       	call   2ff <open>
  86:	89 c7                	mov    %eax,%edi
  88:	83 c4 10             	add    $0x10,%esp
  8b:	bb 14 00 00 00       	mov    $0x14,%ebx
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  90:	50                   	push   %eax
  91:	68 00 02 00 00       	push   $0x200
  96:	56                   	push   %esi
  97:	57                   	push   %edi
  98:	e8 42 02 00 00       	call   2df <write>
  for(i = 0; i < 20; i++)
  9d:	83 c4 10             	add    $0x10,%esp
  a0:	4b                   	dec    %ebx
  a1:	75 ed                	jne    90 <main+0x90>
  close(fd);
  a3:	83 ec 0c             	sub    $0xc,%esp
  a6:	57                   	push   %edi
  a7:	e8 3b 02 00 00       	call   2e7 <close>

  printf(1, "read\n");
  ac:	5a                   	pop    %edx
  ad:	59                   	pop    %ecx
  ae:	68 dd 06 00 00       	push   $0x6dd
  b3:	6a 01                	push   $0x1
  b5:	e8 3a 03 00 00       	call   3f4 <printf>

  fd = open(path, O_RDONLY);
  ba:	5b                   	pop    %ebx
  bb:	5f                   	pop    %edi
  bc:	6a 00                	push   $0x0
  be:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  c4:	50                   	push   %eax
  c5:	e8 35 02 00 00       	call   2ff <open>
  ca:	89 c7                	mov    %eax,%edi
  cc:	83 c4 10             	add    $0x10,%esp
  cf:	bb 14 00 00 00       	mov    $0x14,%ebx
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  d4:	50                   	push   %eax
  d5:	68 00 02 00 00       	push   $0x200
  da:	56                   	push   %esi
  db:	57                   	push   %edi
  dc:	e8 f6 01 00 00       	call   2d7 <read>
  for (i = 0; i < 20; i++)
  e1:	83 c4 10             	add    $0x10,%esp
  e4:	4b                   	dec    %ebx
  e5:	75 ed                	jne    d4 <main+0xd4>
  close(fd);
  e7:	83 ec 0c             	sub    $0xc,%esp
  ea:	57                   	push   %edi
  eb:	e8 f7 01 00 00       	call   2e7 <close>

  wait();
  f0:	e8 d2 01 00 00       	call   2c7 <wait>

  exit();
  f5:	e8 c5 01 00 00       	call   2bf <exit>
  fa:	66 90                	xchg   %ax,%ax

000000fc <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  fc:	55                   	push   %ebp
  fd:	89 e5                	mov    %esp,%ebp
  ff:	53                   	push   %ebx
 100:	8b 4d 08             	mov    0x8(%ebp),%ecx
 103:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 106:	31 c0                	xor    %eax,%eax
 108:	8a 14 03             	mov    (%ebx,%eax,1),%dl
 10b:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 10e:	40                   	inc    %eax
 10f:	84 d2                	test   %dl,%dl
 111:	75 f5                	jne    108 <strcpy+0xc>
    ;
  return os;
}
 113:	89 c8                	mov    %ecx,%eax
 115:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 118:	c9                   	leave
 119:	c3                   	ret
 11a:	66 90                	xchg   %ax,%ax

0000011c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 11c:	55                   	push   %ebp
 11d:	89 e5                	mov    %esp,%ebp
 11f:	53                   	push   %ebx
 120:	8b 55 08             	mov    0x8(%ebp),%edx
 123:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 126:	0f b6 02             	movzbl (%edx),%eax
 129:	84 c0                	test   %al,%al
 12b:	75 10                	jne    13d <strcmp+0x21>
 12d:	eb 2a                	jmp    159 <strcmp+0x3d>
 12f:	90                   	nop
    p++, q++;
 130:	42                   	inc    %edx
 131:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
 134:	0f b6 02             	movzbl (%edx),%eax
 137:	84 c0                	test   %al,%al
 139:	74 11                	je     14c <strcmp+0x30>
 13b:	89 cb                	mov    %ecx,%ebx
 13d:	0f b6 0b             	movzbl (%ebx),%ecx
 140:	38 c1                	cmp    %al,%cl
 142:	74 ec                	je     130 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 144:	29 c8                	sub    %ecx,%eax
}
 146:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 149:	c9                   	leave
 14a:	c3                   	ret
 14b:	90                   	nop
  return (uchar)*p - (uchar)*q;
 14c:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 150:	31 c0                	xor    %eax,%eax
 152:	29 c8                	sub    %ecx,%eax
}
 154:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 157:	c9                   	leave
 158:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 159:	0f b6 0b             	movzbl (%ebx),%ecx
 15c:	31 c0                	xor    %eax,%eax
 15e:	eb e4                	jmp    144 <strcmp+0x28>

00000160 <strlen>:

uint
strlen(const char *s)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 166:	80 3a 00             	cmpb   $0x0,(%edx)
 169:	74 15                	je     180 <strlen+0x20>
 16b:	31 c0                	xor    %eax,%eax
 16d:	8d 76 00             	lea    0x0(%esi),%esi
 170:	40                   	inc    %eax
 171:	89 c1                	mov    %eax,%ecx
 173:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 177:	75 f7                	jne    170 <strlen+0x10>
    ;
  return n;
}
 179:	89 c8                	mov    %ecx,%eax
 17b:	5d                   	pop    %ebp
 17c:	c3                   	ret
 17d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 180:	31 c9                	xor    %ecx,%ecx
}
 182:	89 c8                	mov    %ecx,%eax
 184:	5d                   	pop    %ebp
 185:	c3                   	ret
 186:	66 90                	xchg   %ax,%ax

00000188 <memset>:

void*
memset(void *dst, int c, uint n)
{
 188:	55                   	push   %ebp
 189:	89 e5                	mov    %esp,%ebp
 18b:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 18c:	8b 7d 08             	mov    0x8(%ebp),%edi
 18f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 192:	8b 45 0c             	mov    0xc(%ebp),%eax
 195:	fc                   	cld
 196:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 198:	8b 45 08             	mov    0x8(%ebp),%eax
 19b:	8b 7d fc             	mov    -0x4(%ebp),%edi
 19e:	c9                   	leave
 19f:	c3                   	ret

000001a0 <strchr>:

char*
strchr(const char *s, char c)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 1a9:	8a 10                	mov    (%eax),%dl
 1ab:	84 d2                	test   %dl,%dl
 1ad:	75 0c                	jne    1bb <strchr+0x1b>
 1af:	eb 13                	jmp    1c4 <strchr+0x24>
 1b1:	8d 76 00             	lea    0x0(%esi),%esi
 1b4:	40                   	inc    %eax
 1b5:	8a 10                	mov    (%eax),%dl
 1b7:	84 d2                	test   %dl,%dl
 1b9:	74 09                	je     1c4 <strchr+0x24>
    if(*s == c)
 1bb:	38 d1                	cmp    %dl,%cl
 1bd:	75 f5                	jne    1b4 <strchr+0x14>
      return (char*)s;
  return 0;
}
 1bf:	5d                   	pop    %ebp
 1c0:	c3                   	ret
 1c1:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 1c4:	31 c0                	xor    %eax,%eax
}
 1c6:	5d                   	pop    %ebp
 1c7:	c3                   	ret

000001c8 <gets>:

char*
gets(char *buf, int max)
{
 1c8:	55                   	push   %ebp
 1c9:	89 e5                	mov    %esp,%ebp
 1cb:	57                   	push   %edi
 1cc:	56                   	push   %esi
 1cd:	53                   	push   %ebx
 1ce:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d1:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 1d3:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i=0; i+1 < max; ){
 1d6:	eb 24                	jmp    1fc <gets+0x34>
    cc = read(0, &c, 1);
 1d8:	50                   	push   %eax
 1d9:	6a 01                	push   $0x1
 1db:	56                   	push   %esi
 1dc:	6a 00                	push   $0x0
 1de:	e8 f4 00 00 00       	call   2d7 <read>
    if(cc < 1)
 1e3:	83 c4 10             	add    $0x10,%esp
 1e6:	85 c0                	test   %eax,%eax
 1e8:	7e 1a                	jle    204 <gets+0x3c>
      break;
    buf[i++] = c;
 1ea:	8a 45 e7             	mov    -0x19(%ebp),%al
 1ed:	8b 55 08             	mov    0x8(%ebp),%edx
 1f0:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1f4:	3c 0a                	cmp    $0xa,%al
 1f6:	74 0e                	je     206 <gets+0x3e>
 1f8:	3c 0d                	cmp    $0xd,%al
 1fa:	74 0a                	je     206 <gets+0x3e>
  for(i=0; i+1 < max; ){
 1fc:	89 df                	mov    %ebx,%edi
 1fe:	43                   	inc    %ebx
 1ff:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 202:	7c d4                	jl     1d8 <gets+0x10>
 204:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 206:	8b 45 08             	mov    0x8(%ebp),%eax
 209:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 20d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 210:	5b                   	pop    %ebx
 211:	5e                   	pop    %esi
 212:	5f                   	pop    %edi
 213:	5d                   	pop    %ebp
 214:	c3                   	ret
 215:	8d 76 00             	lea    0x0(%esi),%esi

00000218 <stat>:

int
stat(const char *n, struct stat *st)
{
 218:	55                   	push   %ebp
 219:	89 e5                	mov    %esp,%ebp
 21b:	56                   	push   %esi
 21c:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 21d:	83 ec 08             	sub    $0x8,%esp
 220:	6a 00                	push   $0x0
 222:	ff 75 08             	push   0x8(%ebp)
 225:	e8 d5 00 00 00       	call   2ff <open>
  if(fd < 0)
 22a:	83 c4 10             	add    $0x10,%esp
 22d:	85 c0                	test   %eax,%eax
 22f:	78 27                	js     258 <stat+0x40>
 231:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 233:	83 ec 08             	sub    $0x8,%esp
 236:	ff 75 0c             	push   0xc(%ebp)
 239:	50                   	push   %eax
 23a:	e8 d8 00 00 00       	call   317 <fstat>
 23f:	89 c6                	mov    %eax,%esi
  close(fd);
 241:	89 1c 24             	mov    %ebx,(%esp)
 244:	e8 9e 00 00 00       	call   2e7 <close>
  return r;
 249:	83 c4 10             	add    $0x10,%esp
}
 24c:	89 f0                	mov    %esi,%eax
 24e:	8d 65 f8             	lea    -0x8(%ebp),%esp
 251:	5b                   	pop    %ebx
 252:	5e                   	pop    %esi
 253:	5d                   	pop    %ebp
 254:	c3                   	ret
 255:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 258:	be ff ff ff ff       	mov    $0xffffffff,%esi
 25d:	eb ed                	jmp    24c <stat+0x34>
 25f:	90                   	nop

00000260 <atoi>:

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 01             	movsbl (%ecx),%eax
 26a:	8d 50 d0             	lea    -0x30(%eax),%edx
 26d:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
 270:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 275:	77 16                	ja     28d <atoi+0x2d>
 277:	90                   	nop
    n = n*10 + *s++ - '0';
 278:	41                   	inc    %ecx
 279:	8d 14 92             	lea    (%edx,%edx,4),%edx
 27c:	01 d2                	add    %edx,%edx
 27e:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
 282:	0f be 01             	movsbl (%ecx),%eax
 285:	8d 58 d0             	lea    -0x30(%eax),%ebx
 288:	80 fb 09             	cmp    $0x9,%bl
 28b:	76 eb                	jbe    278 <atoi+0x18>
  return n;
}
 28d:	89 d0                	mov    %edx,%eax
 28f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 292:	c9                   	leave
 293:	c3                   	ret

00000294 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 294:	55                   	push   %ebp
 295:	89 e5                	mov    %esp,%ebp
 297:	57                   	push   %edi
 298:	56                   	push   %esi
 299:	8b 55 08             	mov    0x8(%ebp),%edx
 29c:	8b 75 0c             	mov    0xc(%ebp),%esi
 29f:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2a2:	85 c0                	test   %eax,%eax
 2a4:	7e 0b                	jle    2b1 <memmove+0x1d>
 2a6:	01 d0                	add    %edx,%eax
  dst = vdst;
 2a8:	89 d7                	mov    %edx,%edi
 2aa:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 2ac:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2ad:	39 f8                	cmp    %edi,%eax
 2af:	75 fb                	jne    2ac <memmove+0x18>
  return vdst;
}
 2b1:	89 d0                	mov    %edx,%eax
 2b3:	5e                   	pop    %esi
 2b4:	5f                   	pop    %edi
 2b5:	5d                   	pop    %ebp
 2b6:	c3                   	ret

000002b7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2b7:	b8 01 00 00 00       	mov    $0x1,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret

000002bf <exit>:
SYSCALL(exit)
 2bf:	b8 02 00 00 00       	mov    $0x2,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret

000002c7 <wait>:
SYSCALL(wait)
 2c7:	b8 03 00 00 00       	mov    $0x3,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret

000002cf <pipe>:
SYSCALL(pipe)
 2cf:	b8 04 00 00 00       	mov    $0x4,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret

000002d7 <read>:
SYSCALL(read)
 2d7:	b8 05 00 00 00       	mov    $0x5,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret

000002df <write>:
SYSCALL(write)
 2df:	b8 10 00 00 00       	mov    $0x10,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret

000002e7 <close>:
SYSCALL(close)
 2e7:	b8 15 00 00 00       	mov    $0x15,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret

000002ef <kill>:
SYSCALL(kill)
 2ef:	b8 06 00 00 00       	mov    $0x6,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret

000002f7 <exec>:
SYSCALL(exec)
 2f7:	b8 07 00 00 00       	mov    $0x7,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret

000002ff <open>:
SYSCALL(open)
 2ff:	b8 0f 00 00 00       	mov    $0xf,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret

00000307 <mknod>:
SYSCALL(mknod)
 307:	b8 11 00 00 00       	mov    $0x11,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret

0000030f <unlink>:
SYSCALL(unlink)
 30f:	b8 12 00 00 00       	mov    $0x12,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret

00000317 <fstat>:
SYSCALL(fstat)
 317:	b8 08 00 00 00       	mov    $0x8,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret

0000031f <link>:
SYSCALL(link)
 31f:	b8 13 00 00 00       	mov    $0x13,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret

00000327 <mkdir>:
SYSCALL(mkdir)
 327:	b8 14 00 00 00       	mov    $0x14,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret

0000032f <chdir>:
SYSCALL(chdir)
 32f:	b8 09 00 00 00       	mov    $0x9,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret

00000337 <dup>:
SYSCALL(dup)
 337:	b8 0a 00 00 00       	mov    $0xa,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret

0000033f <getpid>:
SYSCALL(getpid)
 33f:	b8 0b 00 00 00       	mov    $0xb,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret

00000347 <sbrk>:
SYSCALL(sbrk)
 347:	b8 0c 00 00 00       	mov    $0xc,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret

0000034f <sleep>:
SYSCALL(sleep)
 34f:	b8 0d 00 00 00       	mov    $0xd,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret

00000357 <uptime>:
SYSCALL(uptime)
 357:	b8 0e 00 00 00       	mov    $0xe,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret

0000035f <countfp>:
SYSCALL(countfp)
 35f:	b8 16 00 00 00       	mov    $0x16,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret
 367:	90                   	nop

00000368 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 368:	55                   	push   %ebp
 369:	89 e5                	mov    %esp,%ebp
 36b:	57                   	push   %edi
 36c:	56                   	push   %esi
 36d:	53                   	push   %ebx
 36e:	83 ec 3c             	sub    $0x3c,%esp
 371:	89 45 c0             	mov    %eax,-0x40(%ebp)
 374:	89 cb                	mov    %ecx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 376:	8b 4d 08             	mov    0x8(%ebp),%ecx
 379:	85 c9                	test   %ecx,%ecx
 37b:	74 04                	je     381 <printint+0x19>
 37d:	85 d2                	test   %edx,%edx
 37f:	78 6b                	js     3ec <printint+0x84>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 381:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  neg = 0;
 384:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  }

  i = 0;
 38b:	31 c9                	xor    %ecx,%ecx
 38d:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 390:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 393:	31 d2                	xor    %edx,%edx
 395:	f7 f3                	div    %ebx
 397:	89 cf                	mov    %ecx,%edi
 399:	8d 49 01             	lea    0x1(%ecx),%ecx
 39c:	8a 92 4c 07 00 00    	mov    0x74c(%edx),%dl
 3a2:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
  }while((x /= base) != 0);
 3a6:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 3a9:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 3ac:	39 da                	cmp    %ebx,%edx
 3ae:	73 e0                	jae    390 <printint+0x28>
  if(neg)
 3b0:	8b 55 08             	mov    0x8(%ebp),%edx
 3b3:	85 d2                	test   %edx,%edx
 3b5:	74 07                	je     3be <printint+0x56>
    buf[i++] = '-';
 3b7:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)

  while(--i >= 0)
 3bc:	89 cf                	mov    %ecx,%edi
 3be:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 3c1:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 3c5:	8d 76 00             	lea    0x0(%esi),%esi
    putc(fd, buf[i]);
 3c8:	8a 07                	mov    (%edi),%al
 3ca:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 3cd:	50                   	push   %eax
 3ce:	6a 01                	push   $0x1
 3d0:	56                   	push   %esi
 3d1:	ff 75 c0             	push   -0x40(%ebp)
 3d4:	e8 06 ff ff ff       	call   2df <write>
  while(--i >= 0)
 3d9:	89 f8                	mov    %edi,%eax
 3db:	4f                   	dec    %edi
 3dc:	83 c4 10             	add    $0x10,%esp
 3df:	39 c3                	cmp    %eax,%ebx
 3e1:	75 e5                	jne    3c8 <printint+0x60>
}
 3e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3e6:	5b                   	pop    %ebx
 3e7:	5e                   	pop    %esi
 3e8:	5f                   	pop    %edi
 3e9:	5d                   	pop    %ebp
 3ea:	c3                   	ret
 3eb:	90                   	nop
    x = -xx;
 3ec:	f7 da                	neg    %edx
 3ee:	89 55 c4             	mov    %edx,-0x3c(%ebp)
 3f1:	eb 98                	jmp    38b <printint+0x23>
 3f3:	90                   	nop

000003f4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3f4:	55                   	push   %ebp
 3f5:	89 e5                	mov    %esp,%ebp
 3f7:	57                   	push   %edi
 3f8:	56                   	push   %esi
 3f9:	53                   	push   %ebx
 3fa:	83 ec 2c             	sub    $0x2c,%esp
 3fd:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 400:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 403:	8a 13                	mov    (%ebx),%dl
 405:	84 d2                	test   %dl,%dl
 407:	74 5c                	je     465 <printf+0x71>
 409:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 40a:	8d 45 10             	lea    0x10(%ebp),%eax
 40d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 410:	31 ff                	xor    %edi,%edi
 412:	eb 20                	jmp    434 <printf+0x40>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 414:	83 f8 25             	cmp    $0x25,%eax
 417:	74 3f                	je     458 <printf+0x64>
        state = '%';
      } else {
        putc(fd, c);
 419:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 41c:	50                   	push   %eax
 41d:	6a 01                	push   $0x1
 41f:	8d 45 e7             	lea    -0x19(%ebp),%eax
 422:	50                   	push   %eax
 423:	56                   	push   %esi
 424:	e8 b6 fe ff ff       	call   2df <write>
        putc(fd, c);
 429:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 42c:	43                   	inc    %ebx
 42d:	8a 53 ff             	mov    -0x1(%ebx),%dl
 430:	84 d2                	test   %dl,%dl
 432:	74 31                	je     465 <printf+0x71>
    c = fmt[i] & 0xff;
 434:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 437:	85 ff                	test   %edi,%edi
 439:	74 d9                	je     414 <printf+0x20>
      }
    } else if(state == '%'){
 43b:	83 ff 25             	cmp    $0x25,%edi
 43e:	75 ec                	jne    42c <printf+0x38>
      if(c == 'd'){
 440:	83 f8 25             	cmp    $0x25,%eax
 443:	0f 84 f3 00 00 00    	je     53c <printf+0x148>
 449:	83 e8 63             	sub    $0x63,%eax
 44c:	83 f8 15             	cmp    $0x15,%eax
 44f:	77 1f                	ja     470 <printf+0x7c>
 451:	ff 24 85 f4 06 00 00 	jmp    *0x6f4(,%eax,4)
        state = '%';
 458:	bf 25 00 00 00       	mov    $0x25,%edi
  for(i = 0; fmt[i]; i++){
 45d:	43                   	inc    %ebx
 45e:	8a 53 ff             	mov    -0x1(%ebx),%dl
 461:	84 d2                	test   %dl,%dl
 463:	75 cf                	jne    434 <printf+0x40>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 465:	8d 65 f4             	lea    -0xc(%ebp),%esp
 468:	5b                   	pop    %ebx
 469:	5e                   	pop    %esi
 46a:	5f                   	pop    %edi
 46b:	5d                   	pop    %ebp
 46c:	c3                   	ret
 46d:	8d 76 00             	lea    0x0(%esi),%esi
 470:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 473:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 477:	50                   	push   %eax
 478:	6a 01                	push   $0x1
 47a:	8d 7d e7             	lea    -0x19(%ebp),%edi
 47d:	57                   	push   %edi
 47e:	56                   	push   %esi
 47f:	e8 5b fe ff ff       	call   2df <write>
        putc(fd, c);
 484:	8a 55 d0             	mov    -0x30(%ebp),%dl
 487:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 48a:	83 c4 0c             	add    $0xc,%esp
 48d:	6a 01                	push   $0x1
 48f:	57                   	push   %edi
 490:	56                   	push   %esi
 491:	e8 49 fe ff ff       	call   2df <write>
        putc(fd, c);
 496:	83 c4 10             	add    $0x10,%esp
      state = 0;
 499:	31 ff                	xor    %edi,%edi
 49b:	eb 8f                	jmp    42c <printf+0x38>
 49d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 4a0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4a3:	8b 17                	mov    (%edi),%edx
 4a5:	83 ec 0c             	sub    $0xc,%esp
 4a8:	6a 00                	push   $0x0
 4aa:	b9 10 00 00 00       	mov    $0x10,%ecx
 4af:	89 f0                	mov    %esi,%eax
 4b1:	e8 b2 fe ff ff       	call   368 <printint>
        ap++;
 4b6:	83 c7 04             	add    $0x4,%edi
 4b9:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 4bc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4bf:	31 ff                	xor    %edi,%edi
        ap++;
 4c1:	e9 66 ff ff ff       	jmp    42c <printf+0x38>
        s = (char*)*ap;
 4c6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4c9:	8b 10                	mov    (%eax),%edx
        ap++;
 4cb:	83 c0 04             	add    $0x4,%eax
 4ce:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 4d1:	85 d2                	test   %edx,%edx
 4d3:	74 77                	je     54c <printf+0x158>
        while(*s != 0){
 4d5:	8a 02                	mov    (%edx),%al
 4d7:	84 c0                	test   %al,%al
 4d9:	74 7a                	je     555 <printf+0x161>
 4db:	8d 7d e7             	lea    -0x19(%ebp),%edi
 4de:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 4e1:	89 d3                	mov    %edx,%ebx
 4e3:	90                   	nop
          putc(fd, *s);
 4e4:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 4e7:	50                   	push   %eax
 4e8:	6a 01                	push   $0x1
 4ea:	57                   	push   %edi
 4eb:	56                   	push   %esi
 4ec:	e8 ee fd ff ff       	call   2df <write>
          s++;
 4f1:	43                   	inc    %ebx
        while(*s != 0){
 4f2:	8a 03                	mov    (%ebx),%al
 4f4:	83 c4 10             	add    $0x10,%esp
 4f7:	84 c0                	test   %al,%al
 4f9:	75 e9                	jne    4e4 <printf+0xf0>
      state = 0;
 4fb:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4fe:	31 ff                	xor    %edi,%edi
 500:	e9 27 ff ff ff       	jmp    42c <printf+0x38>
        printint(fd, *ap, 10, 1);
 505:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 508:	8b 17                	mov    (%edi),%edx
 50a:	83 ec 0c             	sub    $0xc,%esp
 50d:	6a 01                	push   $0x1
 50f:	b9 0a 00 00 00       	mov    $0xa,%ecx
 514:	eb 99                	jmp    4af <printf+0xbb>
        putc(fd, *ap);
 516:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 519:	8b 00                	mov    (%eax),%eax
 51b:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 51e:	51                   	push   %ecx
 51f:	6a 01                	push   $0x1
 521:	8d 7d e7             	lea    -0x19(%ebp),%edi
 524:	57                   	push   %edi
 525:	56                   	push   %esi
 526:	e8 b4 fd ff ff       	call   2df <write>
        ap++;
 52b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 52f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 532:	31 ff                	xor    %edi,%edi
 534:	e9 f3 fe ff ff       	jmp    42c <printf+0x38>
 539:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 53c:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 53f:	52                   	push   %edx
 540:	6a 01                	push   $0x1
 542:	8d 7d e7             	lea    -0x19(%ebp),%edi
 545:	e9 45 ff ff ff       	jmp    48f <printf+0x9b>
 54a:	66 90                	xchg   %ax,%ax
 54c:	b0 28                	mov    $0x28,%al
          s = "(null)";
 54e:	ba ed 06 00 00       	mov    $0x6ed,%edx
 553:	eb 86                	jmp    4db <printf+0xe7>
      state = 0;
 555:	31 ff                	xor    %edi,%edi
 557:	e9 d0 fe ff ff       	jmp    42c <printf+0x38>

0000055c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 55c:	55                   	push   %ebp
 55d:	89 e5                	mov    %esp,%ebp
 55f:	57                   	push   %edi
 560:	56                   	push   %esi
 561:	53                   	push   %ebx
 562:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 565:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 568:	a1 60 07 00 00       	mov    0x760,%eax
 56d:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 570:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 572:	39 c8                	cmp    %ecx,%eax
 574:	73 2e                	jae    5a4 <free+0x48>
 576:	39 d1                	cmp    %edx,%ecx
 578:	72 04                	jb     57e <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 57a:	39 d0                	cmp    %edx,%eax
 57c:	72 2e                	jb     5ac <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 57e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 581:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 584:	39 fa                	cmp    %edi,%edx
 586:	74 28                	je     5b0 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 588:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 58b:	8b 50 04             	mov    0x4(%eax),%edx
 58e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 591:	39 f1                	cmp    %esi,%ecx
 593:	74 32                	je     5c7 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 595:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 597:	a3 60 07 00 00       	mov    %eax,0x760
}
 59c:	5b                   	pop    %ebx
 59d:	5e                   	pop    %esi
 59e:	5f                   	pop    %edi
 59f:	5d                   	pop    %ebp
 5a0:	c3                   	ret
 5a1:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5a4:	39 d0                	cmp    %edx,%eax
 5a6:	72 04                	jb     5ac <free+0x50>
 5a8:	39 d1                	cmp    %edx,%ecx
 5aa:	72 d2                	jb     57e <free+0x22>
{
 5ac:	89 d0                	mov    %edx,%eax
 5ae:	eb c0                	jmp    570 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 5b0:	03 72 04             	add    0x4(%edx),%esi
 5b3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5b6:	8b 10                	mov    (%eax),%edx
 5b8:	8b 12                	mov    (%edx),%edx
 5ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5bd:	8b 50 04             	mov    0x4(%eax),%edx
 5c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5c3:	39 f1                	cmp    %esi,%ecx
 5c5:	75 ce                	jne    595 <free+0x39>
    p->s.size += bp->s.size;
 5c7:	03 53 fc             	add    -0x4(%ebx),%edx
 5ca:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5cd:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 5d0:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5d2:	a3 60 07 00 00       	mov    %eax,0x760
}
 5d7:	5b                   	pop    %ebx
 5d8:	5e                   	pop    %esi
 5d9:	5f                   	pop    %edi
 5da:	5d                   	pop    %ebp
 5db:	c3                   	ret

000005dc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5dc:	55                   	push   %ebp
 5dd:	89 e5                	mov    %esp,%ebp
 5df:	57                   	push   %edi
 5e0:	56                   	push   %esi
 5e1:	53                   	push   %ebx
 5e2:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5e5:	8b 45 08             	mov    0x8(%ebp),%eax
 5e8:	8d 78 07             	lea    0x7(%eax),%edi
 5eb:	c1 ef 03             	shr    $0x3,%edi
 5ee:	47                   	inc    %edi
  if((prevp = freep) == 0){
 5ef:	8b 15 60 07 00 00    	mov    0x760,%edx
 5f5:	85 d2                	test   %edx,%edx
 5f7:	0f 84 93 00 00 00    	je     690 <malloc+0xb4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5fd:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5ff:	8b 48 04             	mov    0x4(%eax),%ecx
 602:	39 f9                	cmp    %edi,%ecx
 604:	73 62                	jae    668 <malloc+0x8c>
  if(nu < 4096)
 606:	89 fb                	mov    %edi,%ebx
 608:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 60e:	72 78                	jb     688 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 610:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 617:	eb 0e                	jmp    627 <malloc+0x4b>
 619:	8d 76 00             	lea    0x0(%esi),%esi
 61c:	89 c2                	mov    %eax,%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 61e:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 620:	8b 48 04             	mov    0x4(%eax),%ecx
 623:	39 f9                	cmp    %edi,%ecx
 625:	73 41                	jae    668 <malloc+0x8c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 627:	3b 05 60 07 00 00    	cmp    0x760,%eax
 62d:	75 ed                	jne    61c <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 62f:	83 ec 0c             	sub    $0xc,%esp
 632:	56                   	push   %esi
 633:	e8 0f fd ff ff       	call   347 <sbrk>
  if(p == (char*)-1)
 638:	83 c4 10             	add    $0x10,%esp
 63b:	83 f8 ff             	cmp    $0xffffffff,%eax
 63e:	74 1c                	je     65c <malloc+0x80>
  hp->s.size = nu;
 640:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 643:	83 ec 0c             	sub    $0xc,%esp
 646:	83 c0 08             	add    $0x8,%eax
 649:	50                   	push   %eax
 64a:	e8 0d ff ff ff       	call   55c <free>
  return freep;
 64f:	8b 15 60 07 00 00    	mov    0x760,%edx
      if((p = morecore(nunits)) == 0)
 655:	83 c4 10             	add    $0x10,%esp
 658:	85 d2                	test   %edx,%edx
 65a:	75 c2                	jne    61e <malloc+0x42>
        return 0;
 65c:	31 c0                	xor    %eax,%eax
  }
}
 65e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 661:	5b                   	pop    %ebx
 662:	5e                   	pop    %esi
 663:	5f                   	pop    %edi
 664:	5d                   	pop    %ebp
 665:	c3                   	ret
 666:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 668:	39 cf                	cmp    %ecx,%edi
 66a:	74 4c                	je     6b8 <malloc+0xdc>
        p->s.size -= nunits;
 66c:	29 f9                	sub    %edi,%ecx
 66e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 671:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 674:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 677:	89 15 60 07 00 00    	mov    %edx,0x760
      return (void*)(p + 1);
 67d:	83 c0 08             	add    $0x8,%eax
}
 680:	8d 65 f4             	lea    -0xc(%ebp),%esp
 683:	5b                   	pop    %ebx
 684:	5e                   	pop    %esi
 685:	5f                   	pop    %edi
 686:	5d                   	pop    %ebp
 687:	c3                   	ret
  if(nu < 4096)
 688:	bb 00 10 00 00       	mov    $0x1000,%ebx
 68d:	eb 81                	jmp    610 <malloc+0x34>
 68f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 690:	c7 05 60 07 00 00 64 	movl   $0x764,0x760
 697:	07 00 00 
 69a:	c7 05 64 07 00 00 64 	movl   $0x764,0x764
 6a1:	07 00 00 
    base.s.size = 0;
 6a4:	c7 05 68 07 00 00 00 	movl   $0x0,0x768
 6ab:	00 00 00 
 6ae:	b8 64 07 00 00       	mov    $0x764,%eax
 6b3:	e9 4e ff ff ff       	jmp    606 <malloc+0x2a>
        prevp->s.ptr = p->s.ptr;
 6b8:	8b 08                	mov    (%eax),%ecx
 6ba:	89 0a                	mov    %ecx,(%edx)
 6bc:	eb b9                	jmp    677 <malloc+0x9b>
