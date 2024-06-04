
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

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
  11:	83 ec 18             	sub    $0x18,%esp
  14:	8b 01                	mov    (%ecx),%eax
  16:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  19:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;

  if(argc <= 1){
  1c:	48                   	dec    %eax
  1d:	7e 5a                	jle    79 <main+0x79>
  1f:	83 c3 04             	add    $0x4,%ebx
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
  22:	be 01 00 00 00       	mov    $0x1,%esi
  27:	eb 22                	jmp    4b <main+0x4b>
  29:	8d 76 00             	lea    0x0(%esi),%esi
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  2c:	83 ec 08             	sub    $0x8,%esp
  2f:	ff 33                	push   (%ebx)
  31:	50                   	push   %eax
  32:	e8 55 00 00 00       	call   8c <wc>
    close(fd);
  37:	89 3c 24             	mov    %edi,(%esp)
  3a:	e8 f8 02 00 00       	call   337 <close>
  for(i = 1; i < argc; i++){
  3f:	46                   	inc    %esi
  40:	83 c3 04             	add    $0x4,%ebx
  43:	83 c4 10             	add    $0x10,%esp
  46:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  49:	74 29                	je     74 <main+0x74>
    if((fd = open(argv[i], 0)) < 0){
  4b:	83 ec 08             	sub    $0x8,%esp
  4e:	6a 00                	push   $0x0
  50:	ff 33                	push   (%ebx)
  52:	e8 f8 02 00 00       	call   34f <open>
  57:	89 c7                	mov    %eax,%edi
  59:	83 c4 10             	add    $0x10,%esp
  5c:	85 c0                	test   %eax,%eax
  5e:	79 cc                	jns    2c <main+0x2c>
      printf(1, "wc: cannot open %s\n", argv[i]);
  60:	50                   	push   %eax
  61:	ff 33                	push   (%ebx)
  63:	68 33 07 00 00       	push   $0x733
  68:	6a 01                	push   $0x1
  6a:	e8 d5 03 00 00       	call   444 <printf>
      exit();
  6f:	e8 9b 02 00 00       	call   30f <exit>
  }
  exit();
  74:	e8 96 02 00 00       	call   30f <exit>
    wc(0, "");
  79:	52                   	push   %edx
  7a:	52                   	push   %edx
  7b:	68 25 07 00 00       	push   $0x725
  80:	6a 00                	push   $0x0
  82:	e8 05 00 00 00       	call   8c <wc>
    exit();
  87:	e8 83 02 00 00       	call   30f <exit>

0000008c <wc>:
{
  8c:	55                   	push   %ebp
  8d:	89 e5                	mov    %esp,%ebp
  8f:	57                   	push   %edi
  90:	56                   	push   %esi
  91:	53                   	push   %ebx
  92:	83 ec 1c             	sub    $0x1c,%esp
  inword = 0;
  95:	31 db                	xor    %ebx,%ebx
  l = w = c = 0;
  97:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  9e:	31 c9                	xor    %ecx,%ecx
  a0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  a7:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  aa:	66 90                	xchg   %ax,%ax
  while((n = read(fd, buf, sizeof(buf))) > 0){
  ac:	52                   	push   %edx
  ad:	68 00 02 00 00       	push   $0x200
  b2:	68 c0 07 00 00       	push   $0x7c0
  b7:	ff 75 08             	push   0x8(%ebp)
  ba:	e8 68 02 00 00       	call   327 <read>
  bf:	89 c7                	mov    %eax,%edi
  c1:	83 c4 10             	add    $0x10,%esp
  c4:	85 c0                	test   %eax,%eax
  c6:	7e 48                	jle    110 <wc+0x84>
    for(i=0; i<n; i++){
  c8:	31 f6                	xor    %esi,%esi
  ca:	eb 07                	jmp    d3 <wc+0x47>
        inword = 0;
  cc:	31 db                	xor    %ebx,%ebx
    for(i=0; i<n; i++){
  ce:	46                   	inc    %esi
  cf:	39 f7                	cmp    %esi,%edi
  d1:	74 35                	je     108 <wc+0x7c>
      if(buf[i] == '\n')
  d3:	0f be 86 c0 07 00 00 	movsbl 0x7c0(%esi),%eax
  da:	3c 0a                	cmp    $0xa,%al
  dc:	75 03                	jne    e1 <wc+0x55>
        l++;
  de:	ff 45 e4             	incl   -0x1c(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  e1:	83 ec 08             	sub    $0x8,%esp
  e4:	50                   	push   %eax
  e5:	68 10 07 00 00       	push   $0x710
  ea:	e8 01 01 00 00       	call   1f0 <strchr>
  ef:	83 c4 10             	add    $0x10,%esp
  f2:	85 c0                	test   %eax,%eax
  f4:	75 d6                	jne    cc <wc+0x40>
      else if(!inword){
  f6:	85 db                	test   %ebx,%ebx
  f8:	75 d4                	jne    ce <wc+0x42>
        w++;
  fa:	ff 45 e0             	incl   -0x20(%ebp)
        inword = 1;
  fd:	bb 01 00 00 00       	mov    $0x1,%ebx
    for(i=0; i<n; i++){
 102:	46                   	inc    %esi
 103:	39 f7                	cmp    %esi,%edi
 105:	75 cc                	jne    d3 <wc+0x47>
 107:	90                   	nop
 108:	01 7d dc             	add    %edi,-0x24(%ebp)
 10b:	eb 9f                	jmp    ac <wc+0x20>
 10d:	8d 76 00             	lea    0x0(%esi),%esi
  if(n < 0){
 110:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 113:	75 24                	jne    139 <wc+0xad>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 115:	83 ec 08             	sub    $0x8,%esp
 118:	ff 75 0c             	push   0xc(%ebp)
 11b:	ff 75 dc             	push   -0x24(%ebp)
 11e:	51                   	push   %ecx
 11f:	ff 75 e4             	push   -0x1c(%ebp)
 122:	68 26 07 00 00       	push   $0x726
 127:	6a 01                	push   $0x1
 129:	e8 16 03 00 00       	call   444 <printf>
}
 12e:	83 c4 20             	add    $0x20,%esp
 131:	8d 65 f4             	lea    -0xc(%ebp),%esp
 134:	5b                   	pop    %ebx
 135:	5e                   	pop    %esi
 136:	5f                   	pop    %edi
 137:	5d                   	pop    %ebp
 138:	c3                   	ret
    printf(1, "wc: read error\n");
 139:	50                   	push   %eax
 13a:	50                   	push   %eax
 13b:	68 16 07 00 00       	push   $0x716
 140:	6a 01                	push   $0x1
 142:	e8 fd 02 00 00       	call   444 <printf>
    exit();
 147:	e8 c3 01 00 00       	call   30f <exit>

0000014c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 14c:	55                   	push   %ebp
 14d:	89 e5                	mov    %esp,%ebp
 14f:	53                   	push   %ebx
 150:	8b 4d 08             	mov    0x8(%ebp),%ecx
 153:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 156:	31 c0                	xor    %eax,%eax
 158:	8a 14 03             	mov    (%ebx,%eax,1),%dl
 15b:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 15e:	40                   	inc    %eax
 15f:	84 d2                	test   %dl,%dl
 161:	75 f5                	jne    158 <strcpy+0xc>
    ;
  return os;
}
 163:	89 c8                	mov    %ecx,%eax
 165:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 168:	c9                   	leave
 169:	c3                   	ret
 16a:	66 90                	xchg   %ax,%ax

0000016c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 16c:	55                   	push   %ebp
 16d:	89 e5                	mov    %esp,%ebp
 16f:	53                   	push   %ebx
 170:	8b 55 08             	mov    0x8(%ebp),%edx
 173:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 176:	0f b6 02             	movzbl (%edx),%eax
 179:	84 c0                	test   %al,%al
 17b:	75 10                	jne    18d <strcmp+0x21>
 17d:	eb 2a                	jmp    1a9 <strcmp+0x3d>
 17f:	90                   	nop
    p++, q++;
 180:	42                   	inc    %edx
 181:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
 184:	0f b6 02             	movzbl (%edx),%eax
 187:	84 c0                	test   %al,%al
 189:	74 11                	je     19c <strcmp+0x30>
 18b:	89 cb                	mov    %ecx,%ebx
 18d:	0f b6 0b             	movzbl (%ebx),%ecx
 190:	38 c1                	cmp    %al,%cl
 192:	74 ec                	je     180 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 194:	29 c8                	sub    %ecx,%eax
}
 196:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 199:	c9                   	leave
 19a:	c3                   	ret
 19b:	90                   	nop
  return (uchar)*p - (uchar)*q;
 19c:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 1a0:	31 c0                	xor    %eax,%eax
 1a2:	29 c8                	sub    %ecx,%eax
}
 1a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1a7:	c9                   	leave
 1a8:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 1a9:	0f b6 0b             	movzbl (%ebx),%ecx
 1ac:	31 c0                	xor    %eax,%eax
 1ae:	eb e4                	jmp    194 <strcmp+0x28>

000001b0 <strlen>:

uint
strlen(const char *s)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1b6:	80 3a 00             	cmpb   $0x0,(%edx)
 1b9:	74 15                	je     1d0 <strlen+0x20>
 1bb:	31 c0                	xor    %eax,%eax
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
 1c0:	40                   	inc    %eax
 1c1:	89 c1                	mov    %eax,%ecx
 1c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1c7:	75 f7                	jne    1c0 <strlen+0x10>
    ;
  return n;
}
 1c9:	89 c8                	mov    %ecx,%eax
 1cb:	5d                   	pop    %ebp
 1cc:	c3                   	ret
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 1d0:	31 c9                	xor    %ecx,%ecx
}
 1d2:	89 c8                	mov    %ecx,%eax
 1d4:	5d                   	pop    %ebp
 1d5:	c3                   	ret
 1d6:	66 90                	xchg   %ax,%ax

000001d8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d8:	55                   	push   %ebp
 1d9:	89 e5                	mov    %esp,%ebp
 1db:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1dc:	8b 7d 08             	mov    0x8(%ebp),%edi
 1df:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e5:	fc                   	cld
 1e6:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e8:	8b 45 08             	mov    0x8(%ebp),%eax
 1eb:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1ee:	c9                   	leave
 1ef:	c3                   	ret

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 1f9:	8a 10                	mov    (%eax),%dl
 1fb:	84 d2                	test   %dl,%dl
 1fd:	75 0c                	jne    20b <strchr+0x1b>
 1ff:	eb 13                	jmp    214 <strchr+0x24>
 201:	8d 76 00             	lea    0x0(%esi),%esi
 204:	40                   	inc    %eax
 205:	8a 10                	mov    (%eax),%dl
 207:	84 d2                	test   %dl,%dl
 209:	74 09                	je     214 <strchr+0x24>
    if(*s == c)
 20b:	38 d1                	cmp    %dl,%cl
 20d:	75 f5                	jne    204 <strchr+0x14>
      return (char*)s;
  return 0;
}
 20f:	5d                   	pop    %ebp
 210:	c3                   	ret
 211:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 214:	31 c0                	xor    %eax,%eax
}
 216:	5d                   	pop    %ebp
 217:	c3                   	ret

00000218 <gets>:

char*
gets(char *buf, int max)
{
 218:	55                   	push   %ebp
 219:	89 e5                	mov    %esp,%ebp
 21b:	57                   	push   %edi
 21c:	56                   	push   %esi
 21d:	53                   	push   %ebx
 21e:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 221:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 223:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i=0; i+1 < max; ){
 226:	eb 24                	jmp    24c <gets+0x34>
    cc = read(0, &c, 1);
 228:	50                   	push   %eax
 229:	6a 01                	push   $0x1
 22b:	56                   	push   %esi
 22c:	6a 00                	push   $0x0
 22e:	e8 f4 00 00 00       	call   327 <read>
    if(cc < 1)
 233:	83 c4 10             	add    $0x10,%esp
 236:	85 c0                	test   %eax,%eax
 238:	7e 1a                	jle    254 <gets+0x3c>
      break;
    buf[i++] = c;
 23a:	8a 45 e7             	mov    -0x19(%ebp),%al
 23d:	8b 55 08             	mov    0x8(%ebp),%edx
 240:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 244:	3c 0a                	cmp    $0xa,%al
 246:	74 0e                	je     256 <gets+0x3e>
 248:	3c 0d                	cmp    $0xd,%al
 24a:	74 0a                	je     256 <gets+0x3e>
  for(i=0; i+1 < max; ){
 24c:	89 df                	mov    %ebx,%edi
 24e:	43                   	inc    %ebx
 24f:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 252:	7c d4                	jl     228 <gets+0x10>
 254:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 256:	8b 45 08             	mov    0x8(%ebp),%eax
 259:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 25d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 260:	5b                   	pop    %ebx
 261:	5e                   	pop    %esi
 262:	5f                   	pop    %edi
 263:	5d                   	pop    %ebp
 264:	c3                   	ret
 265:	8d 76 00             	lea    0x0(%esi),%esi

00000268 <stat>:

int
stat(const char *n, struct stat *st)
{
 268:	55                   	push   %ebp
 269:	89 e5                	mov    %esp,%ebp
 26b:	56                   	push   %esi
 26c:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 26d:	83 ec 08             	sub    $0x8,%esp
 270:	6a 00                	push   $0x0
 272:	ff 75 08             	push   0x8(%ebp)
 275:	e8 d5 00 00 00       	call   34f <open>
  if(fd < 0)
 27a:	83 c4 10             	add    $0x10,%esp
 27d:	85 c0                	test   %eax,%eax
 27f:	78 27                	js     2a8 <stat+0x40>
 281:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 283:	83 ec 08             	sub    $0x8,%esp
 286:	ff 75 0c             	push   0xc(%ebp)
 289:	50                   	push   %eax
 28a:	e8 d8 00 00 00       	call   367 <fstat>
 28f:	89 c6                	mov    %eax,%esi
  close(fd);
 291:	89 1c 24             	mov    %ebx,(%esp)
 294:	e8 9e 00 00 00       	call   337 <close>
  return r;
 299:	83 c4 10             	add    $0x10,%esp
}
 29c:	89 f0                	mov    %esi,%eax
 29e:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2a1:	5b                   	pop    %ebx
 2a2:	5e                   	pop    %esi
 2a3:	5d                   	pop    %ebp
 2a4:	c3                   	ret
 2a5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2a8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2ad:	eb ed                	jmp    29c <stat+0x34>
 2af:	90                   	nop

000002b0 <atoi>:

int
atoi(const char *s)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	53                   	push   %ebx
 2b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2b7:	0f be 01             	movsbl (%ecx),%eax
 2ba:	8d 50 d0             	lea    -0x30(%eax),%edx
 2bd:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
 2c0:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 2c5:	77 16                	ja     2dd <atoi+0x2d>
 2c7:	90                   	nop
    n = n*10 + *s++ - '0';
 2c8:	41                   	inc    %ecx
 2c9:	8d 14 92             	lea    (%edx,%edx,4),%edx
 2cc:	01 d2                	add    %edx,%edx
 2ce:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
 2d2:	0f be 01             	movsbl (%ecx),%eax
 2d5:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2d8:	80 fb 09             	cmp    $0x9,%bl
 2db:	76 eb                	jbe    2c8 <atoi+0x18>
  return n;
}
 2dd:	89 d0                	mov    %edx,%eax
 2df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2e2:	c9                   	leave
 2e3:	c3                   	ret

000002e4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2e4:	55                   	push   %ebp
 2e5:	89 e5                	mov    %esp,%ebp
 2e7:	57                   	push   %edi
 2e8:	56                   	push   %esi
 2e9:	8b 55 08             	mov    0x8(%ebp),%edx
 2ec:	8b 75 0c             	mov    0xc(%ebp),%esi
 2ef:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2f2:	85 c0                	test   %eax,%eax
 2f4:	7e 0b                	jle    301 <memmove+0x1d>
 2f6:	01 d0                	add    %edx,%eax
  dst = vdst;
 2f8:	89 d7                	mov    %edx,%edi
 2fa:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 2fc:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2fd:	39 f8                	cmp    %edi,%eax
 2ff:	75 fb                	jne    2fc <memmove+0x18>
  return vdst;
}
 301:	89 d0                	mov    %edx,%eax
 303:	5e                   	pop    %esi
 304:	5f                   	pop    %edi
 305:	5d                   	pop    %ebp
 306:	c3                   	ret

00000307 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 307:	b8 01 00 00 00       	mov    $0x1,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret

0000030f <exit>:
SYSCALL(exit)
 30f:	b8 02 00 00 00       	mov    $0x2,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret

00000317 <wait>:
SYSCALL(wait)
 317:	b8 03 00 00 00       	mov    $0x3,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret

0000031f <pipe>:
SYSCALL(pipe)
 31f:	b8 04 00 00 00       	mov    $0x4,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret

00000327 <read>:
SYSCALL(read)
 327:	b8 05 00 00 00       	mov    $0x5,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret

0000032f <write>:
SYSCALL(write)
 32f:	b8 10 00 00 00       	mov    $0x10,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret

00000337 <close>:
SYSCALL(close)
 337:	b8 15 00 00 00       	mov    $0x15,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret

0000033f <kill>:
SYSCALL(kill)
 33f:	b8 06 00 00 00       	mov    $0x6,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret

00000347 <exec>:
SYSCALL(exec)
 347:	b8 07 00 00 00       	mov    $0x7,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret

0000034f <open>:
SYSCALL(open)
 34f:	b8 0f 00 00 00       	mov    $0xf,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret

00000357 <mknod>:
SYSCALL(mknod)
 357:	b8 11 00 00 00       	mov    $0x11,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret

0000035f <unlink>:
SYSCALL(unlink)
 35f:	b8 12 00 00 00       	mov    $0x12,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret

00000367 <fstat>:
SYSCALL(fstat)
 367:	b8 08 00 00 00       	mov    $0x8,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret

0000036f <link>:
SYSCALL(link)
 36f:	b8 13 00 00 00       	mov    $0x13,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret

00000377 <mkdir>:
SYSCALL(mkdir)
 377:	b8 14 00 00 00       	mov    $0x14,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret

0000037f <chdir>:
SYSCALL(chdir)
 37f:	b8 09 00 00 00       	mov    $0x9,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret

00000387 <dup>:
SYSCALL(dup)
 387:	b8 0a 00 00 00       	mov    $0xa,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret

0000038f <getpid>:
SYSCALL(getpid)
 38f:	b8 0b 00 00 00       	mov    $0xb,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret

00000397 <sbrk>:
SYSCALL(sbrk)
 397:	b8 0c 00 00 00       	mov    $0xc,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret

0000039f <sleep>:
SYSCALL(sleep)
 39f:	b8 0d 00 00 00       	mov    $0xd,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret

000003a7 <uptime>:
SYSCALL(uptime)
 3a7:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret

000003af <countfp>:
SYSCALL(countfp)
 3af:	b8 16 00 00 00       	mov    $0x16,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret
 3b7:	90                   	nop

000003b8 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3b8:	55                   	push   %ebp
 3b9:	89 e5                	mov    %esp,%ebp
 3bb:	57                   	push   %edi
 3bc:	56                   	push   %esi
 3bd:	53                   	push   %ebx
 3be:	83 ec 3c             	sub    $0x3c,%esp
 3c1:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3c4:	89 cb                	mov    %ecx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3c9:	85 c9                	test   %ecx,%ecx
 3cb:	74 04                	je     3d1 <printint+0x19>
 3cd:	85 d2                	test   %edx,%edx
 3cf:	78 6b                	js     43c <printint+0x84>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3d1:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  neg = 0;
 3d4:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  }

  i = 0;
 3db:	31 c9                	xor    %ecx,%ecx
 3dd:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 3e0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3e3:	31 d2                	xor    %edx,%edx
 3e5:	f7 f3                	div    %ebx
 3e7:	89 cf                	mov    %ecx,%edi
 3e9:	8d 49 01             	lea    0x1(%ecx),%ecx
 3ec:	8a 92 a8 07 00 00    	mov    0x7a8(%edx),%dl
 3f2:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
  }while((x /= base) != 0);
 3f6:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 3f9:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 3fc:	39 da                	cmp    %ebx,%edx
 3fe:	73 e0                	jae    3e0 <printint+0x28>
  if(neg)
 400:	8b 55 08             	mov    0x8(%ebp),%edx
 403:	85 d2                	test   %edx,%edx
 405:	74 07                	je     40e <printint+0x56>
    buf[i++] = '-';
 407:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)

  while(--i >= 0)
 40c:	89 cf                	mov    %ecx,%edi
 40e:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 411:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 415:	8d 76 00             	lea    0x0(%esi),%esi
    putc(fd, buf[i]);
 418:	8a 07                	mov    (%edi),%al
 41a:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 41d:	50                   	push   %eax
 41e:	6a 01                	push   $0x1
 420:	56                   	push   %esi
 421:	ff 75 c0             	push   -0x40(%ebp)
 424:	e8 06 ff ff ff       	call   32f <write>
  while(--i >= 0)
 429:	89 f8                	mov    %edi,%eax
 42b:	4f                   	dec    %edi
 42c:	83 c4 10             	add    $0x10,%esp
 42f:	39 c3                	cmp    %eax,%ebx
 431:	75 e5                	jne    418 <printint+0x60>
}
 433:	8d 65 f4             	lea    -0xc(%ebp),%esp
 436:	5b                   	pop    %ebx
 437:	5e                   	pop    %esi
 438:	5f                   	pop    %edi
 439:	5d                   	pop    %ebp
 43a:	c3                   	ret
 43b:	90                   	nop
    x = -xx;
 43c:	f7 da                	neg    %edx
 43e:	89 55 c4             	mov    %edx,-0x3c(%ebp)
 441:	eb 98                	jmp    3db <printint+0x23>
 443:	90                   	nop

00000444 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 444:	55                   	push   %ebp
 445:	89 e5                	mov    %esp,%ebp
 447:	57                   	push   %edi
 448:	56                   	push   %esi
 449:	53                   	push   %ebx
 44a:	83 ec 2c             	sub    $0x2c,%esp
 44d:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 450:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 453:	8a 13                	mov    (%ebx),%dl
 455:	84 d2                	test   %dl,%dl
 457:	74 5c                	je     4b5 <printf+0x71>
 459:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 45a:	8d 45 10             	lea    0x10(%ebp),%eax
 45d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 460:	31 ff                	xor    %edi,%edi
 462:	eb 20                	jmp    484 <printf+0x40>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 464:	83 f8 25             	cmp    $0x25,%eax
 467:	74 3f                	je     4a8 <printf+0x64>
        state = '%';
      } else {
        putc(fd, c);
 469:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 46c:	50                   	push   %eax
 46d:	6a 01                	push   $0x1
 46f:	8d 45 e7             	lea    -0x19(%ebp),%eax
 472:	50                   	push   %eax
 473:	56                   	push   %esi
 474:	e8 b6 fe ff ff       	call   32f <write>
        putc(fd, c);
 479:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 47c:	43                   	inc    %ebx
 47d:	8a 53 ff             	mov    -0x1(%ebx),%dl
 480:	84 d2                	test   %dl,%dl
 482:	74 31                	je     4b5 <printf+0x71>
    c = fmt[i] & 0xff;
 484:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 487:	85 ff                	test   %edi,%edi
 489:	74 d9                	je     464 <printf+0x20>
      }
    } else if(state == '%'){
 48b:	83 ff 25             	cmp    $0x25,%edi
 48e:	75 ec                	jne    47c <printf+0x38>
      if(c == 'd'){
 490:	83 f8 25             	cmp    $0x25,%eax
 493:	0f 84 f3 00 00 00    	je     58c <printf+0x148>
 499:	83 e8 63             	sub    $0x63,%eax
 49c:	83 f8 15             	cmp    $0x15,%eax
 49f:	77 1f                	ja     4c0 <printf+0x7c>
 4a1:	ff 24 85 50 07 00 00 	jmp    *0x750(,%eax,4)
        state = '%';
 4a8:	bf 25 00 00 00       	mov    $0x25,%edi
  for(i = 0; fmt[i]; i++){
 4ad:	43                   	inc    %ebx
 4ae:	8a 53 ff             	mov    -0x1(%ebx),%dl
 4b1:	84 d2                	test   %dl,%dl
 4b3:	75 cf                	jne    484 <printf+0x40>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4b8:	5b                   	pop    %ebx
 4b9:	5e                   	pop    %esi
 4ba:	5f                   	pop    %edi
 4bb:	5d                   	pop    %ebp
 4bc:	c3                   	ret
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
 4c0:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 4c3:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 4c7:	50                   	push   %eax
 4c8:	6a 01                	push   $0x1
 4ca:	8d 7d e7             	lea    -0x19(%ebp),%edi
 4cd:	57                   	push   %edi
 4ce:	56                   	push   %esi
 4cf:	e8 5b fe ff ff       	call   32f <write>
        putc(fd, c);
 4d4:	8a 55 d0             	mov    -0x30(%ebp),%dl
 4d7:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4da:	83 c4 0c             	add    $0xc,%esp
 4dd:	6a 01                	push   $0x1
 4df:	57                   	push   %edi
 4e0:	56                   	push   %esi
 4e1:	e8 49 fe ff ff       	call   32f <write>
        putc(fd, c);
 4e6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4e9:	31 ff                	xor    %edi,%edi
 4eb:	eb 8f                	jmp    47c <printf+0x38>
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 4f0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4f3:	8b 17                	mov    (%edi),%edx
 4f5:	83 ec 0c             	sub    $0xc,%esp
 4f8:	6a 00                	push   $0x0
 4fa:	b9 10 00 00 00       	mov    $0x10,%ecx
 4ff:	89 f0                	mov    %esi,%eax
 501:	e8 b2 fe ff ff       	call   3b8 <printint>
        ap++;
 506:	83 c7 04             	add    $0x4,%edi
 509:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 50c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 50f:	31 ff                	xor    %edi,%edi
        ap++;
 511:	e9 66 ff ff ff       	jmp    47c <printf+0x38>
        s = (char*)*ap;
 516:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 519:	8b 10                	mov    (%eax),%edx
        ap++;
 51b:	83 c0 04             	add    $0x4,%eax
 51e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 521:	85 d2                	test   %edx,%edx
 523:	74 77                	je     59c <printf+0x158>
        while(*s != 0){
 525:	8a 02                	mov    (%edx),%al
 527:	84 c0                	test   %al,%al
 529:	74 7a                	je     5a5 <printf+0x161>
 52b:	8d 7d e7             	lea    -0x19(%ebp),%edi
 52e:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 531:	89 d3                	mov    %edx,%ebx
 533:	90                   	nop
          putc(fd, *s);
 534:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 537:	50                   	push   %eax
 538:	6a 01                	push   $0x1
 53a:	57                   	push   %edi
 53b:	56                   	push   %esi
 53c:	e8 ee fd ff ff       	call   32f <write>
          s++;
 541:	43                   	inc    %ebx
        while(*s != 0){
 542:	8a 03                	mov    (%ebx),%al
 544:	83 c4 10             	add    $0x10,%esp
 547:	84 c0                	test   %al,%al
 549:	75 e9                	jne    534 <printf+0xf0>
      state = 0;
 54b:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 54e:	31 ff                	xor    %edi,%edi
 550:	e9 27 ff ff ff       	jmp    47c <printf+0x38>
        printint(fd, *ap, 10, 1);
 555:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 558:	8b 17                	mov    (%edi),%edx
 55a:	83 ec 0c             	sub    $0xc,%esp
 55d:	6a 01                	push   $0x1
 55f:	b9 0a 00 00 00       	mov    $0xa,%ecx
 564:	eb 99                	jmp    4ff <printf+0xbb>
        putc(fd, *ap);
 566:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 569:	8b 00                	mov    (%eax),%eax
 56b:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 56e:	51                   	push   %ecx
 56f:	6a 01                	push   $0x1
 571:	8d 7d e7             	lea    -0x19(%ebp),%edi
 574:	57                   	push   %edi
 575:	56                   	push   %esi
 576:	e8 b4 fd ff ff       	call   32f <write>
        ap++;
 57b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 57f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 582:	31 ff                	xor    %edi,%edi
 584:	e9 f3 fe ff ff       	jmp    47c <printf+0x38>
 589:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 58c:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 58f:	52                   	push   %edx
 590:	6a 01                	push   $0x1
 592:	8d 7d e7             	lea    -0x19(%ebp),%edi
 595:	e9 45 ff ff ff       	jmp    4df <printf+0x9b>
 59a:	66 90                	xchg   %ax,%ax
 59c:	b0 28                	mov    $0x28,%al
          s = "(null)";
 59e:	ba 47 07 00 00       	mov    $0x747,%edx
 5a3:	eb 86                	jmp    52b <printf+0xe7>
      state = 0;
 5a5:	31 ff                	xor    %edi,%edi
 5a7:	e9 d0 fe ff ff       	jmp    47c <printf+0x38>

000005ac <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5ac:	55                   	push   %ebp
 5ad:	89 e5                	mov    %esp,%ebp
 5af:	57                   	push   %edi
 5b0:	56                   	push   %esi
 5b1:	53                   	push   %ebx
 5b2:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5b5:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b8:	a1 c0 09 00 00       	mov    0x9c0,%eax
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c0:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c2:	39 c8                	cmp    %ecx,%eax
 5c4:	73 2e                	jae    5f4 <free+0x48>
 5c6:	39 d1                	cmp    %edx,%ecx
 5c8:	72 04                	jb     5ce <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ca:	39 d0                	cmp    %edx,%eax
 5cc:	72 2e                	jb     5fc <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5ce:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5d1:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5d4:	39 fa                	cmp    %edi,%edx
 5d6:	74 28                	je     600 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 5d8:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5db:	8b 50 04             	mov    0x4(%eax),%edx
 5de:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5e1:	39 f1                	cmp    %esi,%ecx
 5e3:	74 32                	je     617 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 5e5:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 5e7:	a3 c0 09 00 00       	mov    %eax,0x9c0
}
 5ec:	5b                   	pop    %ebx
 5ed:	5e                   	pop    %esi
 5ee:	5f                   	pop    %edi
 5ef:	5d                   	pop    %ebp
 5f0:	c3                   	ret
 5f1:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f4:	39 d0                	cmp    %edx,%eax
 5f6:	72 04                	jb     5fc <free+0x50>
 5f8:	39 d1                	cmp    %edx,%ecx
 5fa:	72 d2                	jb     5ce <free+0x22>
{
 5fc:	89 d0                	mov    %edx,%eax
 5fe:	eb c0                	jmp    5c0 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 600:	03 72 04             	add    0x4(%edx),%esi
 603:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 606:	8b 10                	mov    (%eax),%edx
 608:	8b 12                	mov    (%edx),%edx
 60a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 60d:	8b 50 04             	mov    0x4(%eax),%edx
 610:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 613:	39 f1                	cmp    %esi,%ecx
 615:	75 ce                	jne    5e5 <free+0x39>
    p->s.size += bp->s.size;
 617:	03 53 fc             	add    -0x4(%ebx),%edx
 61a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 61d:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 620:	89 08                	mov    %ecx,(%eax)
  freep = p;
 622:	a3 c0 09 00 00       	mov    %eax,0x9c0
}
 627:	5b                   	pop    %ebx
 628:	5e                   	pop    %esi
 629:	5f                   	pop    %edi
 62a:	5d                   	pop    %ebp
 62b:	c3                   	ret

0000062c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 62c:	55                   	push   %ebp
 62d:	89 e5                	mov    %esp,%ebp
 62f:	57                   	push   %edi
 630:	56                   	push   %esi
 631:	53                   	push   %ebx
 632:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 635:	8b 45 08             	mov    0x8(%ebp),%eax
 638:	8d 78 07             	lea    0x7(%eax),%edi
 63b:	c1 ef 03             	shr    $0x3,%edi
 63e:	47                   	inc    %edi
  if((prevp = freep) == 0){
 63f:	8b 15 c0 09 00 00    	mov    0x9c0,%edx
 645:	85 d2                	test   %edx,%edx
 647:	0f 84 93 00 00 00    	je     6e0 <malloc+0xb4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 64d:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 64f:	8b 48 04             	mov    0x4(%eax),%ecx
 652:	39 f9                	cmp    %edi,%ecx
 654:	73 62                	jae    6b8 <malloc+0x8c>
  if(nu < 4096)
 656:	89 fb                	mov    %edi,%ebx
 658:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 65e:	72 78                	jb     6d8 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 660:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 667:	eb 0e                	jmp    677 <malloc+0x4b>
 669:	8d 76 00             	lea    0x0(%esi),%esi
 66c:	89 c2                	mov    %eax,%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 66e:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 670:	8b 48 04             	mov    0x4(%eax),%ecx
 673:	39 f9                	cmp    %edi,%ecx
 675:	73 41                	jae    6b8 <malloc+0x8c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 677:	3b 05 c0 09 00 00    	cmp    0x9c0,%eax
 67d:	75 ed                	jne    66c <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 67f:	83 ec 0c             	sub    $0xc,%esp
 682:	56                   	push   %esi
 683:	e8 0f fd ff ff       	call   397 <sbrk>
  if(p == (char*)-1)
 688:	83 c4 10             	add    $0x10,%esp
 68b:	83 f8 ff             	cmp    $0xffffffff,%eax
 68e:	74 1c                	je     6ac <malloc+0x80>
  hp->s.size = nu;
 690:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 693:	83 ec 0c             	sub    $0xc,%esp
 696:	83 c0 08             	add    $0x8,%eax
 699:	50                   	push   %eax
 69a:	e8 0d ff ff ff       	call   5ac <free>
  return freep;
 69f:	8b 15 c0 09 00 00    	mov    0x9c0,%edx
      if((p = morecore(nunits)) == 0)
 6a5:	83 c4 10             	add    $0x10,%esp
 6a8:	85 d2                	test   %edx,%edx
 6aa:	75 c2                	jne    66e <malloc+0x42>
        return 0;
 6ac:	31 c0                	xor    %eax,%eax
  }
}
 6ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6b1:	5b                   	pop    %ebx
 6b2:	5e                   	pop    %esi
 6b3:	5f                   	pop    %edi
 6b4:	5d                   	pop    %ebp
 6b5:	c3                   	ret
 6b6:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 6b8:	39 cf                	cmp    %ecx,%edi
 6ba:	74 4c                	je     708 <malloc+0xdc>
        p->s.size -= nunits;
 6bc:	29 f9                	sub    %edi,%ecx
 6be:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6c1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6c4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 6c7:	89 15 c0 09 00 00    	mov    %edx,0x9c0
      return (void*)(p + 1);
 6cd:	83 c0 08             	add    $0x8,%eax
}
 6d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6d3:	5b                   	pop    %ebx
 6d4:	5e                   	pop    %esi
 6d5:	5f                   	pop    %edi
 6d6:	5d                   	pop    %ebp
 6d7:	c3                   	ret
  if(nu < 4096)
 6d8:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6dd:	eb 81                	jmp    660 <malloc+0x34>
 6df:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 6e0:	c7 05 c0 09 00 00 c4 	movl   $0x9c4,0x9c0
 6e7:	09 00 00 
 6ea:	c7 05 c4 09 00 00 c4 	movl   $0x9c4,0x9c4
 6f1:	09 00 00 
    base.s.size = 0;
 6f4:	c7 05 c8 09 00 00 00 	movl   $0x0,0x9c8
 6fb:	00 00 00 
 6fe:	b8 c4 09 00 00       	mov    $0x9c4,%eax
 703:	e9 4e ff ff ff       	jmp    656 <malloc+0x2a>
        prevp->s.ptr = p->s.ptr;
 708:	8b 08                	mov    (%eax),%ecx
 70a:	89 0a                	mov    %ecx,(%edx)
 70c:	eb b9                	jmp    6c7 <malloc+0x9b>
