
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
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
  16:	89 45 e0             	mov    %eax,-0x20(%ebp)
  19:	8b 59 04             	mov    0x4(%ecx),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
  1c:	48                   	dec    %eax
  1d:	7e 65                	jle    84 <main+0x84>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  1f:	8b 7b 04             	mov    0x4(%ebx),%edi

  if(argc <= 2){
  22:	83 7d e0 02          	cmpl   $0x2,-0x20(%ebp)
  26:	74 6f                	je     97 <main+0x97>
  28:	83 c3 08             	add    $0x8,%ebx
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  2b:	be 02 00 00 00       	mov    $0x2,%esi
  30:	eb 26                	jmp    58 <main+0x58>
  32:	66 90                	xchg   %ax,%ax
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  34:	83 ec 08             	sub    $0x8,%esp
  37:	50                   	push   %eax
  38:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  3b:	57                   	push   %edi
  3c:	e8 53 01 00 00       	call   194 <grep>
    close(fd);
  41:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  44:	89 04 24             	mov    %eax,(%esp)
  47:	e8 ab 04 00 00       	call   4f7 <close>
  for(i = 2; i < argc; i++){
  4c:	46                   	inc    %esi
  4d:	83 c3 04             	add    $0x4,%ebx
  50:	83 c4 10             	add    $0x10,%esp
  53:	39 75 e0             	cmp    %esi,-0x20(%ebp)
  56:	7e 27                	jle    7f <main+0x7f>
    if((fd = open(argv[i], 0)) < 0){
  58:	83 ec 08             	sub    $0x8,%esp
  5b:	6a 00                	push   $0x0
  5d:	ff 33                	push   (%ebx)
  5f:	e8 ab 04 00 00       	call   50f <open>
  64:	83 c4 10             	add    $0x10,%esp
  67:	85 c0                	test   %eax,%eax
  69:	79 c9                	jns    34 <main+0x34>
      printf(1, "grep: cannot open %s\n", argv[i]);
  6b:	50                   	push   %eax
  6c:	ff 33                	push   (%ebx)
  6e:	68 f0 08 00 00       	push   $0x8f0
  73:	6a 01                	push   $0x1
  75:	e8 8a 05 00 00       	call   604 <printf>
      exit();
  7a:	e8 50 04 00 00       	call   4cf <exit>
  }
  exit();
  7f:	e8 4b 04 00 00       	call   4cf <exit>
    printf(2, "usage: grep pattern [file ...]\n");
  84:	51                   	push   %ecx
  85:	51                   	push   %ecx
  86:	68 d0 08 00 00       	push   $0x8d0
  8b:	6a 02                	push   $0x2
  8d:	e8 72 05 00 00       	call   604 <printf>
    exit();
  92:	e8 38 04 00 00       	call   4cf <exit>
    grep(pattern, 0);
  97:	52                   	push   %edx
  98:	52                   	push   %edx
  99:	6a 00                	push   $0x0
  9b:	57                   	push   %edi
  9c:	e8 f3 00 00 00       	call   194 <grep>
    exit();
  a1:	e8 29 04 00 00       	call   4cf <exit>
  a6:	66 90                	xchg   %ax,%ax

000000a8 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  a8:	55                   	push   %ebp
  a9:	89 e5                	mov    %esp,%ebp
  ab:	57                   	push   %edi
  ac:	56                   	push   %esi
  ad:	53                   	push   %ebx
  ae:	83 ec 0c             	sub    $0xc,%esp
  b1:	8b 75 08             	mov    0x8(%ebp),%esi
  b4:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '\0')
  b7:	8a 16                	mov    (%esi),%dl
  b9:	84 d2                	test   %dl,%dl
  bb:	74 53                	je     110 <matchhere+0x68>
    return 1;
  if(re[1] == '*')
  bd:	8a 46 01             	mov    0x1(%esi),%al
  c0:	3c 2a                	cmp    $0x2a,%al
  c2:	74 1f                	je     e3 <matchhere+0x3b>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  c4:	8a 0b                	mov    (%ebx),%cl
  if(re[0] == '$' && re[1] == '\0')
  c6:	80 fa 24             	cmp    $0x24,%dl
  c9:	74 55                	je     120 <matchhere+0x78>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  cb:	84 c9                	test   %cl,%cl
  cd:	74 69                	je     138 <matchhere+0x90>
  cf:	80 fa 2e             	cmp    $0x2e,%dl
  d2:	75 60                	jne    134 <matchhere+0x8c>
    return matchhere(re+1, text+1);
  d4:	43                   	inc    %ebx
  d5:	46                   	inc    %esi
  if(re[0] == '\0')
  d6:	84 c0                	test   %al,%al
  d8:	74 36                	je     110 <matchhere+0x68>
{
  da:	88 c2                	mov    %al,%dl
  if(re[1] == '*')
  dc:	8a 46 01             	mov    0x1(%esi),%al
  df:	3c 2a                	cmp    $0x2a,%al
  e1:	75 e1                	jne    c4 <matchhere+0x1c>
    return matchstar(re[0], re+2, text);
  e3:	83 c6 02             	add    $0x2,%esi
  e6:	0f be fa             	movsbl %dl,%edi
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
  e9:	eb 12                	jmp    fd <matchhere+0x55>
  eb:	90                   	nop
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  ec:	0f be 0b             	movsbl (%ebx),%ecx
  ef:	84 c9                	test   %cl,%cl
  f1:	74 22                	je     115 <matchhere+0x6d>
  f3:	43                   	inc    %ebx
  f4:	39 cf                	cmp    %ecx,%edi
  f6:	74 05                	je     fd <matchhere+0x55>
  f8:	83 ff 2e             	cmp    $0x2e,%edi
  fb:	75 18                	jne    115 <matchhere+0x6d>
    if(matchhere(re, text))
  fd:	83 ec 08             	sub    $0x8,%esp
 100:	53                   	push   %ebx
 101:	56                   	push   %esi
 102:	e8 a1 ff ff ff       	call   a8 <matchhere>
 107:	83 c4 10             	add    $0x10,%esp
 10a:	85 c0                	test   %eax,%eax
 10c:	74 de                	je     ec <matchhere+0x44>
 10e:	66 90                	xchg   %ax,%ax
    return 1;
 110:	b8 01 00 00 00       	mov    $0x1,%eax
}
 115:	8d 65 f4             	lea    -0xc(%ebp),%esp
 118:	5b                   	pop    %ebx
 119:	5e                   	pop    %esi
 11a:	5f                   	pop    %edi
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret
 11d:	8d 76 00             	lea    0x0(%esi),%esi
  if(re[0] == '$' && re[1] == '\0')
 120:	84 c0                	test   %al,%al
 122:	74 1e                	je     142 <matchhere+0x9a>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 124:	84 c9                	test   %cl,%cl
 126:	74 10                	je     138 <matchhere+0x90>
 128:	80 f9 24             	cmp    $0x24,%cl
 12b:	75 0b                	jne    138 <matchhere+0x90>
    return matchhere(re+1, text+1);
 12d:	43                   	inc    %ebx
 12e:	46                   	inc    %esi
{
 12f:	88 c2                	mov    %al,%dl
 131:	eb a9                	jmp    dc <matchhere+0x34>
 133:	90                   	nop
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 134:	38 d1                	cmp    %dl,%cl
 136:	74 9c                	je     d4 <matchhere+0x2c>
  return 0;
 138:	31 c0                	xor    %eax,%eax
}
 13a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 13d:	5b                   	pop    %ebx
 13e:	5e                   	pop    %esi
 13f:	5f                   	pop    %edi
 140:	5d                   	pop    %ebp
 141:	c3                   	ret
    return *text == '\0';
 142:	31 c0                	xor    %eax,%eax
 144:	84 c9                	test   %cl,%cl
 146:	0f 94 c0             	sete   %al
 149:	eb ca                	jmp    115 <matchhere+0x6d>
 14b:	90                   	nop

0000014c <match>:
{
 14c:	55                   	push   %ebp
 14d:	89 e5                	mov    %esp,%ebp
 14f:	56                   	push   %esi
 150:	53                   	push   %ebx
 151:	8b 5d 08             	mov    0x8(%ebp),%ebx
 154:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(re[0] == '^')
 157:	80 3b 5e             	cmpb   $0x5e,(%ebx)
 15a:	75 0b                	jne    167 <match+0x1b>
 15c:	eb 26                	jmp    184 <match+0x38>
 15e:	66 90                	xchg   %ax,%ax
  }while(*text++ != '\0');
 160:	46                   	inc    %esi
 161:	80 7e ff 00          	cmpb   $0x0,-0x1(%esi)
 165:	74 16                	je     17d <match+0x31>
    if(matchhere(re, text))
 167:	83 ec 08             	sub    $0x8,%esp
 16a:	56                   	push   %esi
 16b:	53                   	push   %ebx
 16c:	e8 37 ff ff ff       	call   a8 <matchhere>
 171:	83 c4 10             	add    $0x10,%esp
 174:	85 c0                	test   %eax,%eax
 176:	74 e8                	je     160 <match+0x14>
      return 1;
 178:	b8 01 00 00 00       	mov    $0x1,%eax
}
 17d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 180:	5b                   	pop    %ebx
 181:	5e                   	pop    %esi
 182:	5d                   	pop    %ebp
 183:	c3                   	ret
    return matchhere(re+1, text);
 184:	43                   	inc    %ebx
 185:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
 188:	8d 65 f8             	lea    -0x8(%ebp),%esp
 18b:	5b                   	pop    %ebx
 18c:	5e                   	pop    %esi
 18d:	5d                   	pop    %ebp
    return matchhere(re+1, text);
 18e:	e9 15 ff ff ff       	jmp    a8 <matchhere>
 193:	90                   	nop

00000194 <grep>:
{
 194:	55                   	push   %ebp
 195:	89 e5                	mov    %esp,%ebp
 197:	57                   	push   %edi
 198:	56                   	push   %esi
 199:	53                   	push   %ebx
 19a:	83 ec 1c             	sub    $0x1c,%esp
 19d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  m = 0;
 1a0:	31 ff                	xor    %edi,%edi
    return matchhere(re+1, text);
 1a2:	8d 43 01             	lea    0x1(%ebx),%eax
 1a5:	89 45 dc             	mov    %eax,-0x24(%ebp)
 1a8:	89 7d e0             	mov    %edi,-0x20(%ebp)
 1ab:	90                   	nop
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 1ac:	50                   	push   %eax
 1ad:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 1b2:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 1b5:	29 c8                	sub    %ecx,%eax
 1b7:	50                   	push   %eax
 1b8:	8d 81 80 09 00 00    	lea    0x980(%ecx),%eax
 1be:	50                   	push   %eax
 1bf:	ff 75 0c             	push   0xc(%ebp)
 1c2:	e8 20 03 00 00       	call   4e7 <read>
 1c7:	83 c4 10             	add    $0x10,%esp
 1ca:	85 c0                	test   %eax,%eax
 1cc:	0f 8e e1 00 00 00    	jle    2b3 <grep+0x11f>
    m += n;
 1d2:	01 45 e0             	add    %eax,-0x20(%ebp)
 1d5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    buf[m] = '\0';
 1d8:	c6 81 80 09 00 00 00 	movb   $0x0,0x980(%ecx)
    while((q = strchr(p, '\n')) != 0){
 1df:	bf 80 09 00 00       	mov    $0x980,%edi
 1e4:	89 de                	mov    %ebx,%esi
 1e6:	66 90                	xchg   %ax,%ax
 1e8:	83 ec 08             	sub    $0x8,%esp
 1eb:	6a 0a                	push   $0xa
 1ed:	57                   	push   %edi
 1ee:	e8 bd 01 00 00       	call   3b0 <strchr>
 1f3:	89 c2                	mov    %eax,%edx
 1f5:	83 c4 10             	add    $0x10,%esp
 1f8:	85 c0                	test   %eax,%eax
 1fa:	74 74                	je     270 <grep+0xdc>
      *q = 0;
 1fc:	c6 02 00             	movb   $0x0,(%edx)
  if(re[0] == '^')
 1ff:	80 3e 5e             	cmpb   $0x5e,(%esi)
 202:	74 48                	je     24c <grep+0xb8>
 204:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 207:	89 d3                	mov    %edx,%ebx
 209:	eb 08                	jmp    213 <grep+0x7f>
 20b:	90                   	nop
  }while(*text++ != '\0');
 20c:	47                   	inc    %edi
 20d:	80 7f ff 00          	cmpb   $0x0,-0x1(%edi)
 211:	74 31                	je     244 <grep+0xb0>
    if(matchhere(re, text))
 213:	83 ec 08             	sub    $0x8,%esp
 216:	57                   	push   %edi
 217:	56                   	push   %esi
 218:	e8 8b fe ff ff       	call   a8 <matchhere>
 21d:	83 c4 10             	add    $0x10,%esp
 220:	85 c0                	test   %eax,%eax
 222:	74 e8                	je     20c <grep+0x78>
        write(1, p, q+1 - p);
 224:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 227:	89 da                	mov    %ebx,%edx
 229:	8d 5b 01             	lea    0x1(%ebx),%ebx
        *q = '\n';
 22c:	c6 02 0a             	movb   $0xa,(%edx)
        write(1, p, q+1 - p);
 22f:	50                   	push   %eax
 230:	89 d8                	mov    %ebx,%eax
 232:	29 f8                	sub    %edi,%eax
 234:	50                   	push   %eax
 235:	57                   	push   %edi
 236:	6a 01                	push   $0x1
 238:	e8 b2 02 00 00       	call   4ef <write>
 23d:	83 c4 10             	add    $0x10,%esp
 240:	89 df                	mov    %ebx,%edi
 242:	eb a4                	jmp    1e8 <grep+0x54>
 244:	8d 7b 01             	lea    0x1(%ebx),%edi
      p = q+1;
 247:	eb 9f                	jmp    1e8 <grep+0x54>
 249:	8d 76 00             	lea    0x0(%esi),%esi
 24c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return matchhere(re+1, text);
 24f:	83 ec 08             	sub    $0x8,%esp
 252:	57                   	push   %edi
 253:	ff 75 dc             	push   -0x24(%ebp)
 256:	e8 4d fe ff ff       	call   a8 <matchhere>
 25b:	83 c4 10             	add    $0x10,%esp
        write(1, p, q+1 - p);
 25e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 261:	8d 5a 01             	lea    0x1(%edx),%ebx
      if(match(pattern, p)){
 264:	85 c0                	test   %eax,%eax
 266:	75 c4                	jne    22c <grep+0x98>
        write(1, p, q+1 - p);
 268:	89 df                	mov    %ebx,%edi
 26a:	e9 79 ff ff ff       	jmp    1e8 <grep+0x54>
 26f:	90                   	nop
    if(p == buf)
 270:	89 f3                	mov    %esi,%ebx
 272:	81 ff 80 09 00 00    	cmp    $0x980,%edi
 278:	74 2d                	je     2a7 <grep+0x113>
    if(m > 0){
 27a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 27d:	85 c9                	test   %ecx,%ecx
 27f:	0f 8e 27 ff ff ff    	jle    1ac <grep+0x18>
      m -= p - buf;
 285:	89 f8                	mov    %edi,%eax
 287:	2d 80 09 00 00       	sub    $0x980,%eax
 28c:	29 45 e0             	sub    %eax,-0x20(%ebp)
 28f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      memmove(buf, p, m);
 292:	52                   	push   %edx
 293:	51                   	push   %ecx
 294:	57                   	push   %edi
 295:	68 80 09 00 00       	push   $0x980
 29a:	e8 05 02 00 00       	call   4a4 <memmove>
 29f:	83 c4 10             	add    $0x10,%esp
 2a2:	e9 05 ff ff ff       	jmp    1ac <grep+0x18>
      m = 0;
 2a7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 2ae:	e9 f9 fe ff ff       	jmp    1ac <grep+0x18>
}
 2b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2b6:	5b                   	pop    %ebx
 2b7:	5e                   	pop    %esi
 2b8:	5f                   	pop    %edi
 2b9:	5d                   	pop    %ebp
 2ba:	c3                   	ret
 2bb:	90                   	nop

000002bc <matchstar>:
{
 2bc:	55                   	push   %ebp
 2bd:	89 e5                	mov    %esp,%ebp
 2bf:	57                   	push   %edi
 2c0:	56                   	push   %esi
 2c1:	53                   	push   %ebx
 2c2:	83 ec 0c             	sub    $0xc,%esp
 2c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2c8:	8b 75 0c             	mov    0xc(%ebp),%esi
 2cb:	8b 7d 10             	mov    0x10(%ebp),%edi
 2ce:	66 90                	xchg   %ax,%ax
    if(matchhere(re, text))
 2d0:	83 ec 08             	sub    $0x8,%esp
 2d3:	57                   	push   %edi
 2d4:	56                   	push   %esi
 2d5:	e8 ce fd ff ff       	call   a8 <matchhere>
 2da:	83 c4 10             	add    $0x10,%esp
 2dd:	85 c0                	test   %eax,%eax
 2df:	75 1b                	jne    2fc <matchstar+0x40>
  }while(*text!='\0' && (*text++==c || c=='.'));
 2e1:	0f be 17             	movsbl (%edi),%edx
 2e4:	84 d2                	test   %dl,%dl
 2e6:	74 0a                	je     2f2 <matchstar+0x36>
 2e8:	47                   	inc    %edi
 2e9:	39 da                	cmp    %ebx,%edx
 2eb:	74 e3                	je     2d0 <matchstar+0x14>
 2ed:	83 fb 2e             	cmp    $0x2e,%ebx
 2f0:	74 de                	je     2d0 <matchstar+0x14>
}
 2f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2f5:	5b                   	pop    %ebx
 2f6:	5e                   	pop    %esi
 2f7:	5f                   	pop    %edi
 2f8:	5d                   	pop    %ebp
 2f9:	c3                   	ret
 2fa:	66 90                	xchg   %ax,%ax
      return 1;
 2fc:	b8 01 00 00 00       	mov    $0x1,%eax
}
 301:	8d 65 f4             	lea    -0xc(%ebp),%esp
 304:	5b                   	pop    %ebx
 305:	5e                   	pop    %esi
 306:	5f                   	pop    %edi
 307:	5d                   	pop    %ebp
 308:	c3                   	ret
 309:	66 90                	xchg   %ax,%ax
 30b:	90                   	nop

0000030c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 30c:	55                   	push   %ebp
 30d:	89 e5                	mov    %esp,%ebp
 30f:	53                   	push   %ebx
 310:	8b 4d 08             	mov    0x8(%ebp),%ecx
 313:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 316:	31 c0                	xor    %eax,%eax
 318:	8a 14 03             	mov    (%ebx,%eax,1),%dl
 31b:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 31e:	40                   	inc    %eax
 31f:	84 d2                	test   %dl,%dl
 321:	75 f5                	jne    318 <strcpy+0xc>
    ;
  return os;
}
 323:	89 c8                	mov    %ecx,%eax
 325:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 328:	c9                   	leave
 329:	c3                   	ret
 32a:	66 90                	xchg   %ax,%ax

0000032c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 32c:	55                   	push   %ebp
 32d:	89 e5                	mov    %esp,%ebp
 32f:	53                   	push   %ebx
 330:	8b 55 08             	mov    0x8(%ebp),%edx
 333:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
 336:	0f b6 02             	movzbl (%edx),%eax
 339:	84 c0                	test   %al,%al
 33b:	75 10                	jne    34d <strcmp+0x21>
 33d:	eb 2a                	jmp    369 <strcmp+0x3d>
 33f:	90                   	nop
    p++, q++;
 340:	42                   	inc    %edx
 341:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
 344:	0f b6 02             	movzbl (%edx),%eax
 347:	84 c0                	test   %al,%al
 349:	74 11                	je     35c <strcmp+0x30>
 34b:	89 cb                	mov    %ecx,%ebx
 34d:	0f b6 0b             	movzbl (%ebx),%ecx
 350:	38 c1                	cmp    %al,%cl
 352:	74 ec                	je     340 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 354:	29 c8                	sub    %ecx,%eax
}
 356:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 359:	c9                   	leave
 35a:	c3                   	ret
 35b:	90                   	nop
  return (uchar)*p - (uchar)*q;
 35c:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
 360:	31 c0                	xor    %eax,%eax
 362:	29 c8                	sub    %ecx,%eax
}
 364:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 367:	c9                   	leave
 368:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 369:	0f b6 0b             	movzbl (%ebx),%ecx
 36c:	31 c0                	xor    %eax,%eax
 36e:	eb e4                	jmp    354 <strcmp+0x28>

00000370 <strlen>:

uint
strlen(const char *s)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 376:	80 3a 00             	cmpb   $0x0,(%edx)
 379:	74 15                	je     390 <strlen+0x20>
 37b:	31 c0                	xor    %eax,%eax
 37d:	8d 76 00             	lea    0x0(%esi),%esi
 380:	40                   	inc    %eax
 381:	89 c1                	mov    %eax,%ecx
 383:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 387:	75 f7                	jne    380 <strlen+0x10>
    ;
  return n;
}
 389:	89 c8                	mov    %ecx,%eax
 38b:	5d                   	pop    %ebp
 38c:	c3                   	ret
 38d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 390:	31 c9                	xor    %ecx,%ecx
}
 392:	89 c8                	mov    %ecx,%eax
 394:	5d                   	pop    %ebp
 395:	c3                   	ret
 396:	66 90                	xchg   %ax,%ax

00000398 <memset>:

void*
memset(void *dst, int c, uint n)
{
 398:	55                   	push   %ebp
 399:	89 e5                	mov    %esp,%ebp
 39b:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 39c:	8b 7d 08             	mov    0x8(%ebp),%edi
 39f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3a2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a5:	fc                   	cld
 3a6:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3a8:	8b 45 08             	mov    0x8(%ebp),%eax
 3ab:	8b 7d fc             	mov    -0x4(%ebp),%edi
 3ae:	c9                   	leave
 3af:	c3                   	ret

000003b0 <strchr>:

char*
strchr(const char *s, char c)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 45 08             	mov    0x8(%ebp),%eax
 3b6:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
 3b9:	8a 10                	mov    (%eax),%dl
 3bb:	84 d2                	test   %dl,%dl
 3bd:	75 0c                	jne    3cb <strchr+0x1b>
 3bf:	eb 13                	jmp    3d4 <strchr+0x24>
 3c1:	8d 76 00             	lea    0x0(%esi),%esi
 3c4:	40                   	inc    %eax
 3c5:	8a 10                	mov    (%eax),%dl
 3c7:	84 d2                	test   %dl,%dl
 3c9:	74 09                	je     3d4 <strchr+0x24>
    if(*s == c)
 3cb:	38 d1                	cmp    %dl,%cl
 3cd:	75 f5                	jne    3c4 <strchr+0x14>
      return (char*)s;
  return 0;
}
 3cf:	5d                   	pop    %ebp
 3d0:	c3                   	ret
 3d1:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
 3d4:	31 c0                	xor    %eax,%eax
}
 3d6:	5d                   	pop    %ebp
 3d7:	c3                   	ret

000003d8 <gets>:

char*
gets(char *buf, int max)
{
 3d8:	55                   	push   %ebp
 3d9:	89 e5                	mov    %esp,%ebp
 3db:	57                   	push   %edi
 3dc:	56                   	push   %esi
 3dd:	53                   	push   %ebx
 3de:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3e1:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
 3e3:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i=0; i+1 < max; ){
 3e6:	eb 24                	jmp    40c <gets+0x34>
    cc = read(0, &c, 1);
 3e8:	50                   	push   %eax
 3e9:	6a 01                	push   $0x1
 3eb:	56                   	push   %esi
 3ec:	6a 00                	push   $0x0
 3ee:	e8 f4 00 00 00       	call   4e7 <read>
    if(cc < 1)
 3f3:	83 c4 10             	add    $0x10,%esp
 3f6:	85 c0                	test   %eax,%eax
 3f8:	7e 1a                	jle    414 <gets+0x3c>
      break;
    buf[i++] = c;
 3fa:	8a 45 e7             	mov    -0x19(%ebp),%al
 3fd:	8b 55 08             	mov    0x8(%ebp),%edx
 400:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 404:	3c 0a                	cmp    $0xa,%al
 406:	74 0e                	je     416 <gets+0x3e>
 408:	3c 0d                	cmp    $0xd,%al
 40a:	74 0a                	je     416 <gets+0x3e>
  for(i=0; i+1 < max; ){
 40c:	89 df                	mov    %ebx,%edi
 40e:	43                   	inc    %ebx
 40f:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 412:	7c d4                	jl     3e8 <gets+0x10>
 414:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 416:	8b 45 08             	mov    0x8(%ebp),%eax
 419:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 41d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 420:	5b                   	pop    %ebx
 421:	5e                   	pop    %esi
 422:	5f                   	pop    %edi
 423:	5d                   	pop    %ebp
 424:	c3                   	ret
 425:	8d 76 00             	lea    0x0(%esi),%esi

00000428 <stat>:

int
stat(const char *n, struct stat *st)
{
 428:	55                   	push   %ebp
 429:	89 e5                	mov    %esp,%ebp
 42b:	56                   	push   %esi
 42c:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 42d:	83 ec 08             	sub    $0x8,%esp
 430:	6a 00                	push   $0x0
 432:	ff 75 08             	push   0x8(%ebp)
 435:	e8 d5 00 00 00       	call   50f <open>
  if(fd < 0)
 43a:	83 c4 10             	add    $0x10,%esp
 43d:	85 c0                	test   %eax,%eax
 43f:	78 27                	js     468 <stat+0x40>
 441:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 443:	83 ec 08             	sub    $0x8,%esp
 446:	ff 75 0c             	push   0xc(%ebp)
 449:	50                   	push   %eax
 44a:	e8 d8 00 00 00       	call   527 <fstat>
 44f:	89 c6                	mov    %eax,%esi
  close(fd);
 451:	89 1c 24             	mov    %ebx,(%esp)
 454:	e8 9e 00 00 00       	call   4f7 <close>
  return r;
 459:	83 c4 10             	add    $0x10,%esp
}
 45c:	89 f0                	mov    %esi,%eax
 45e:	8d 65 f8             	lea    -0x8(%ebp),%esp
 461:	5b                   	pop    %ebx
 462:	5e                   	pop    %esi
 463:	5d                   	pop    %ebp
 464:	c3                   	ret
 465:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 468:	be ff ff ff ff       	mov    $0xffffffff,%esi
 46d:	eb ed                	jmp    45c <stat+0x34>
 46f:	90                   	nop

00000470 <atoi>:

int
atoi(const char *s)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	53                   	push   %ebx
 474:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 477:	0f be 01             	movsbl (%ecx),%eax
 47a:	8d 50 d0             	lea    -0x30(%eax),%edx
 47d:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
 480:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
 485:	77 16                	ja     49d <atoi+0x2d>
 487:	90                   	nop
    n = n*10 + *s++ - '0';
 488:	41                   	inc    %ecx
 489:	8d 14 92             	lea    (%edx,%edx,4),%edx
 48c:	01 d2                	add    %edx,%edx
 48e:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
 492:	0f be 01             	movsbl (%ecx),%eax
 495:	8d 58 d0             	lea    -0x30(%eax),%ebx
 498:	80 fb 09             	cmp    $0x9,%bl
 49b:	76 eb                	jbe    488 <atoi+0x18>
  return n;
}
 49d:	89 d0                	mov    %edx,%eax
 49f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4a2:	c9                   	leave
 4a3:	c3                   	ret

000004a4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4a4:	55                   	push   %ebp
 4a5:	89 e5                	mov    %esp,%ebp
 4a7:	57                   	push   %edi
 4a8:	56                   	push   %esi
 4a9:	8b 55 08             	mov    0x8(%ebp),%edx
 4ac:	8b 75 0c             	mov    0xc(%ebp),%esi
 4af:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4b2:	85 c0                	test   %eax,%eax
 4b4:	7e 0b                	jle    4c1 <memmove+0x1d>
 4b6:	01 d0                	add    %edx,%eax
  dst = vdst;
 4b8:	89 d7                	mov    %edx,%edi
 4ba:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 4bc:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 4bd:	39 f8                	cmp    %edi,%eax
 4bf:	75 fb                	jne    4bc <memmove+0x18>
  return vdst;
}
 4c1:	89 d0                	mov    %edx,%eax
 4c3:	5e                   	pop    %esi
 4c4:	5f                   	pop    %edi
 4c5:	5d                   	pop    %ebp
 4c6:	c3                   	ret

000004c7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4c7:	b8 01 00 00 00       	mov    $0x1,%eax
 4cc:	cd 40                	int    $0x40
 4ce:	c3                   	ret

000004cf <exit>:
SYSCALL(exit)
 4cf:	b8 02 00 00 00       	mov    $0x2,%eax
 4d4:	cd 40                	int    $0x40
 4d6:	c3                   	ret

000004d7 <wait>:
SYSCALL(wait)
 4d7:	b8 03 00 00 00       	mov    $0x3,%eax
 4dc:	cd 40                	int    $0x40
 4de:	c3                   	ret

000004df <pipe>:
SYSCALL(pipe)
 4df:	b8 04 00 00 00       	mov    $0x4,%eax
 4e4:	cd 40                	int    $0x40
 4e6:	c3                   	ret

000004e7 <read>:
SYSCALL(read)
 4e7:	b8 05 00 00 00       	mov    $0x5,%eax
 4ec:	cd 40                	int    $0x40
 4ee:	c3                   	ret

000004ef <write>:
SYSCALL(write)
 4ef:	b8 10 00 00 00       	mov    $0x10,%eax
 4f4:	cd 40                	int    $0x40
 4f6:	c3                   	ret

000004f7 <close>:
SYSCALL(close)
 4f7:	b8 15 00 00 00       	mov    $0x15,%eax
 4fc:	cd 40                	int    $0x40
 4fe:	c3                   	ret

000004ff <kill>:
SYSCALL(kill)
 4ff:	b8 06 00 00 00       	mov    $0x6,%eax
 504:	cd 40                	int    $0x40
 506:	c3                   	ret

00000507 <exec>:
SYSCALL(exec)
 507:	b8 07 00 00 00       	mov    $0x7,%eax
 50c:	cd 40                	int    $0x40
 50e:	c3                   	ret

0000050f <open>:
SYSCALL(open)
 50f:	b8 0f 00 00 00       	mov    $0xf,%eax
 514:	cd 40                	int    $0x40
 516:	c3                   	ret

00000517 <mknod>:
SYSCALL(mknod)
 517:	b8 11 00 00 00       	mov    $0x11,%eax
 51c:	cd 40                	int    $0x40
 51e:	c3                   	ret

0000051f <unlink>:
SYSCALL(unlink)
 51f:	b8 12 00 00 00       	mov    $0x12,%eax
 524:	cd 40                	int    $0x40
 526:	c3                   	ret

00000527 <fstat>:
SYSCALL(fstat)
 527:	b8 08 00 00 00       	mov    $0x8,%eax
 52c:	cd 40                	int    $0x40
 52e:	c3                   	ret

0000052f <link>:
SYSCALL(link)
 52f:	b8 13 00 00 00       	mov    $0x13,%eax
 534:	cd 40                	int    $0x40
 536:	c3                   	ret

00000537 <mkdir>:
SYSCALL(mkdir)
 537:	b8 14 00 00 00       	mov    $0x14,%eax
 53c:	cd 40                	int    $0x40
 53e:	c3                   	ret

0000053f <chdir>:
SYSCALL(chdir)
 53f:	b8 09 00 00 00       	mov    $0x9,%eax
 544:	cd 40                	int    $0x40
 546:	c3                   	ret

00000547 <dup>:
SYSCALL(dup)
 547:	b8 0a 00 00 00       	mov    $0xa,%eax
 54c:	cd 40                	int    $0x40
 54e:	c3                   	ret

0000054f <getpid>:
SYSCALL(getpid)
 54f:	b8 0b 00 00 00       	mov    $0xb,%eax
 554:	cd 40                	int    $0x40
 556:	c3                   	ret

00000557 <sbrk>:
SYSCALL(sbrk)
 557:	b8 0c 00 00 00       	mov    $0xc,%eax
 55c:	cd 40                	int    $0x40
 55e:	c3                   	ret

0000055f <sleep>:
SYSCALL(sleep)
 55f:	b8 0d 00 00 00       	mov    $0xd,%eax
 564:	cd 40                	int    $0x40
 566:	c3                   	ret

00000567 <uptime>:
SYSCALL(uptime)
 567:	b8 0e 00 00 00       	mov    $0xe,%eax
 56c:	cd 40                	int    $0x40
 56e:	c3                   	ret

0000056f <countfp>:
SYSCALL(countfp)
 56f:	b8 16 00 00 00       	mov    $0x16,%eax
 574:	cd 40                	int    $0x40
 576:	c3                   	ret
 577:	90                   	nop

00000578 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 578:	55                   	push   %ebp
 579:	89 e5                	mov    %esp,%ebp
 57b:	57                   	push   %edi
 57c:	56                   	push   %esi
 57d:	53                   	push   %ebx
 57e:	83 ec 3c             	sub    $0x3c,%esp
 581:	89 45 c0             	mov    %eax,-0x40(%ebp)
 584:	89 cb                	mov    %ecx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 586:	8b 4d 08             	mov    0x8(%ebp),%ecx
 589:	85 c9                	test   %ecx,%ecx
 58b:	74 04                	je     591 <printint+0x19>
 58d:	85 d2                	test   %edx,%edx
 58f:	78 6b                	js     5fc <printint+0x84>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 591:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  neg = 0;
 594:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  }

  i = 0;
 59b:	31 c9                	xor    %ecx,%ecx
 59d:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
 5a0:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 5a3:	31 d2                	xor    %edx,%edx
 5a5:	f7 f3                	div    %ebx
 5a7:	89 cf                	mov    %ecx,%edi
 5a9:	8d 49 01             	lea    0x1(%ecx),%ecx
 5ac:	8a 92 68 09 00 00    	mov    0x968(%edx),%dl
 5b2:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
  }while((x /= base) != 0);
 5b6:	8b 55 c4             	mov    -0x3c(%ebp),%edx
 5b9:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 5bc:	39 da                	cmp    %ebx,%edx
 5be:	73 e0                	jae    5a0 <printint+0x28>
  if(neg)
 5c0:	8b 55 08             	mov    0x8(%ebp),%edx
 5c3:	85 d2                	test   %edx,%edx
 5c5:	74 07                	je     5ce <printint+0x56>
    buf[i++] = '-';
 5c7:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)

  while(--i >= 0)
 5cc:	89 cf                	mov    %ecx,%edi
 5ce:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 5d1:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
 5d5:	8d 76 00             	lea    0x0(%esi),%esi
    putc(fd, buf[i]);
 5d8:	8a 07                	mov    (%edi),%al
 5da:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 5dd:	50                   	push   %eax
 5de:	6a 01                	push   $0x1
 5e0:	56                   	push   %esi
 5e1:	ff 75 c0             	push   -0x40(%ebp)
 5e4:	e8 06 ff ff ff       	call   4ef <write>
  while(--i >= 0)
 5e9:	89 f8                	mov    %edi,%eax
 5eb:	4f                   	dec    %edi
 5ec:	83 c4 10             	add    $0x10,%esp
 5ef:	39 c3                	cmp    %eax,%ebx
 5f1:	75 e5                	jne    5d8 <printint+0x60>
}
 5f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f6:	5b                   	pop    %ebx
 5f7:	5e                   	pop    %esi
 5f8:	5f                   	pop    %edi
 5f9:	5d                   	pop    %ebp
 5fa:	c3                   	ret
 5fb:	90                   	nop
    x = -xx;
 5fc:	f7 da                	neg    %edx
 5fe:	89 55 c4             	mov    %edx,-0x3c(%ebp)
 601:	eb 98                	jmp    59b <printint+0x23>
 603:	90                   	nop

00000604 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 604:	55                   	push   %ebp
 605:	89 e5                	mov    %esp,%ebp
 607:	57                   	push   %edi
 608:	56                   	push   %esi
 609:	53                   	push   %ebx
 60a:	83 ec 2c             	sub    $0x2c,%esp
 60d:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 610:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 613:	8a 13                	mov    (%ebx),%dl
 615:	84 d2                	test   %dl,%dl
 617:	74 5c                	je     675 <printf+0x71>
 619:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
 61a:	8d 45 10             	lea    0x10(%ebp),%eax
 61d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 620:	31 ff                	xor    %edi,%edi
 622:	eb 20                	jmp    644 <printf+0x40>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 624:	83 f8 25             	cmp    $0x25,%eax
 627:	74 3f                	je     668 <printf+0x64>
        state = '%';
      } else {
        putc(fd, c);
 629:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 62c:	50                   	push   %eax
 62d:	6a 01                	push   $0x1
 62f:	8d 45 e7             	lea    -0x19(%ebp),%eax
 632:	50                   	push   %eax
 633:	56                   	push   %esi
 634:	e8 b6 fe ff ff       	call   4ef <write>
        putc(fd, c);
 639:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 63c:	43                   	inc    %ebx
 63d:	8a 53 ff             	mov    -0x1(%ebx),%dl
 640:	84 d2                	test   %dl,%dl
 642:	74 31                	je     675 <printf+0x71>
    c = fmt[i] & 0xff;
 644:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 647:	85 ff                	test   %edi,%edi
 649:	74 d9                	je     624 <printf+0x20>
      }
    } else if(state == '%'){
 64b:	83 ff 25             	cmp    $0x25,%edi
 64e:	75 ec                	jne    63c <printf+0x38>
      if(c == 'd'){
 650:	83 f8 25             	cmp    $0x25,%eax
 653:	0f 84 f3 00 00 00    	je     74c <printf+0x148>
 659:	83 e8 63             	sub    $0x63,%eax
 65c:	83 f8 15             	cmp    $0x15,%eax
 65f:	77 1f                	ja     680 <printf+0x7c>
 661:	ff 24 85 10 09 00 00 	jmp    *0x910(,%eax,4)
        state = '%';
 668:	bf 25 00 00 00       	mov    $0x25,%edi
  for(i = 0; fmt[i]; i++){
 66d:	43                   	inc    %ebx
 66e:	8a 53 ff             	mov    -0x1(%ebx),%dl
 671:	84 d2                	test   %dl,%dl
 673:	75 cf                	jne    644 <printf+0x40>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 675:	8d 65 f4             	lea    -0xc(%ebp),%esp
 678:	5b                   	pop    %ebx
 679:	5e                   	pop    %esi
 67a:	5f                   	pop    %edi
 67b:	5d                   	pop    %ebp
 67c:	c3                   	ret
 67d:	8d 76 00             	lea    0x0(%esi),%esi
 680:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
 683:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 687:	50                   	push   %eax
 688:	6a 01                	push   $0x1
 68a:	8d 7d e7             	lea    -0x19(%ebp),%edi
 68d:	57                   	push   %edi
 68e:	56                   	push   %esi
 68f:	e8 5b fe ff ff       	call   4ef <write>
        putc(fd, c);
 694:	8a 55 d0             	mov    -0x30(%ebp),%dl
 697:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 69a:	83 c4 0c             	add    $0xc,%esp
 69d:	6a 01                	push   $0x1
 69f:	57                   	push   %edi
 6a0:	56                   	push   %esi
 6a1:	e8 49 fe ff ff       	call   4ef <write>
        putc(fd, c);
 6a6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6a9:	31 ff                	xor    %edi,%edi
 6ab:	eb 8f                	jmp    63c <printf+0x38>
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 6b0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6b3:	8b 17                	mov    (%edi),%edx
 6b5:	83 ec 0c             	sub    $0xc,%esp
 6b8:	6a 00                	push   $0x0
 6ba:	b9 10 00 00 00       	mov    $0x10,%ecx
 6bf:	89 f0                	mov    %esi,%eax
 6c1:	e8 b2 fe ff ff       	call   578 <printint>
        ap++;
 6c6:	83 c7 04             	add    $0x4,%edi
 6c9:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 6cc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6cf:	31 ff                	xor    %edi,%edi
        ap++;
 6d1:	e9 66 ff ff ff       	jmp    63c <printf+0x38>
        s = (char*)*ap;
 6d6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 6d9:	8b 10                	mov    (%eax),%edx
        ap++;
 6db:	83 c0 04             	add    $0x4,%eax
 6de:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 6e1:	85 d2                	test   %edx,%edx
 6e3:	74 77                	je     75c <printf+0x158>
        while(*s != 0){
 6e5:	8a 02                	mov    (%edx),%al
 6e7:	84 c0                	test   %al,%al
 6e9:	74 7a                	je     765 <printf+0x161>
 6eb:	8d 7d e7             	lea    -0x19(%ebp),%edi
 6ee:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6f1:	89 d3                	mov    %edx,%ebx
 6f3:	90                   	nop
          putc(fd, *s);
 6f4:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6f7:	50                   	push   %eax
 6f8:	6a 01                	push   $0x1
 6fa:	57                   	push   %edi
 6fb:	56                   	push   %esi
 6fc:	e8 ee fd ff ff       	call   4ef <write>
          s++;
 701:	43                   	inc    %ebx
        while(*s != 0){
 702:	8a 03                	mov    (%ebx),%al
 704:	83 c4 10             	add    $0x10,%esp
 707:	84 c0                	test   %al,%al
 709:	75 e9                	jne    6f4 <printf+0xf0>
      state = 0;
 70b:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 70e:	31 ff                	xor    %edi,%edi
 710:	e9 27 ff ff ff       	jmp    63c <printf+0x38>
        printint(fd, *ap, 10, 1);
 715:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 718:	8b 17                	mov    (%edi),%edx
 71a:	83 ec 0c             	sub    $0xc,%esp
 71d:	6a 01                	push   $0x1
 71f:	b9 0a 00 00 00       	mov    $0xa,%ecx
 724:	eb 99                	jmp    6bf <printf+0xbb>
        putc(fd, *ap);
 726:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 729:	8b 00                	mov    (%eax),%eax
 72b:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 72e:	51                   	push   %ecx
 72f:	6a 01                	push   $0x1
 731:	8d 7d e7             	lea    -0x19(%ebp),%edi
 734:	57                   	push   %edi
 735:	56                   	push   %esi
 736:	e8 b4 fd ff ff       	call   4ef <write>
        ap++;
 73b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 73f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 742:	31 ff                	xor    %edi,%edi
 744:	e9 f3 fe ff ff       	jmp    63c <printf+0x38>
 749:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 74c:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 74f:	52                   	push   %edx
 750:	6a 01                	push   $0x1
 752:	8d 7d e7             	lea    -0x19(%ebp),%edi
 755:	e9 45 ff ff ff       	jmp    69f <printf+0x9b>
 75a:	66 90                	xchg   %ax,%ax
 75c:	b0 28                	mov    $0x28,%al
          s = "(null)";
 75e:	ba 06 09 00 00       	mov    $0x906,%edx
 763:	eb 86                	jmp    6eb <printf+0xe7>
      state = 0;
 765:	31 ff                	xor    %edi,%edi
 767:	e9 d0 fe ff ff       	jmp    63c <printf+0x38>

0000076c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 76c:	55                   	push   %ebp
 76d:	89 e5                	mov    %esp,%ebp
 76f:	57                   	push   %edi
 770:	56                   	push   %esi
 771:	53                   	push   %ebx
 772:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 775:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 778:	a1 80 0d 00 00       	mov    0xd80,%eax
 77d:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 780:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 782:	39 c8                	cmp    %ecx,%eax
 784:	73 2e                	jae    7b4 <free+0x48>
 786:	39 d1                	cmp    %edx,%ecx
 788:	72 04                	jb     78e <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 78a:	39 d0                	cmp    %edx,%eax
 78c:	72 2e                	jb     7bc <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
 78e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 791:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 794:	39 fa                	cmp    %edi,%edx
 796:	74 28                	je     7c0 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 798:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 79b:	8b 50 04             	mov    0x4(%eax),%edx
 79e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7a1:	39 f1                	cmp    %esi,%ecx
 7a3:	74 32                	je     7d7 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7a5:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 7a7:	a3 80 0d 00 00       	mov    %eax,0xd80
}
 7ac:	5b                   	pop    %ebx
 7ad:	5e                   	pop    %esi
 7ae:	5f                   	pop    %edi
 7af:	5d                   	pop    %ebp
 7b0:	c3                   	ret
 7b1:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b4:	39 d0                	cmp    %edx,%eax
 7b6:	72 04                	jb     7bc <free+0x50>
 7b8:	39 d1                	cmp    %edx,%ecx
 7ba:	72 d2                	jb     78e <free+0x22>
{
 7bc:	89 d0                	mov    %edx,%eax
 7be:	eb c0                	jmp    780 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
 7c0:	03 72 04             	add    0x4(%edx),%esi
 7c3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c6:	8b 10                	mov    (%eax),%edx
 7c8:	8b 12                	mov    (%edx),%edx
 7ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7cd:	8b 50 04             	mov    0x4(%eax),%edx
 7d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7d3:	39 f1                	cmp    %esi,%ecx
 7d5:	75 ce                	jne    7a5 <free+0x39>
    p->s.size += bp->s.size;
 7d7:	03 53 fc             	add    -0x4(%ebx),%edx
 7da:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7dd:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7e0:	89 08                	mov    %ecx,(%eax)
  freep = p;
 7e2:	a3 80 0d 00 00       	mov    %eax,0xd80
}
 7e7:	5b                   	pop    %ebx
 7e8:	5e                   	pop    %esi
 7e9:	5f                   	pop    %edi
 7ea:	5d                   	pop    %ebp
 7eb:	c3                   	ret

000007ec <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7ec:	55                   	push   %ebp
 7ed:	89 e5                	mov    %esp,%ebp
 7ef:	57                   	push   %edi
 7f0:	56                   	push   %esi
 7f1:	53                   	push   %ebx
 7f2:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f5:	8b 45 08             	mov    0x8(%ebp),%eax
 7f8:	8d 78 07             	lea    0x7(%eax),%edi
 7fb:	c1 ef 03             	shr    $0x3,%edi
 7fe:	47                   	inc    %edi
  if((prevp = freep) == 0){
 7ff:	8b 15 80 0d 00 00    	mov    0xd80,%edx
 805:	85 d2                	test   %edx,%edx
 807:	0f 84 93 00 00 00    	je     8a0 <malloc+0xb4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80d:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 80f:	8b 48 04             	mov    0x4(%eax),%ecx
 812:	39 f9                	cmp    %edi,%ecx
 814:	73 62                	jae    878 <malloc+0x8c>
  if(nu < 4096)
 816:	89 fb                	mov    %edi,%ebx
 818:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 81e:	72 78                	jb     898 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 820:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 827:	eb 0e                	jmp    837 <malloc+0x4b>
 829:	8d 76 00             	lea    0x0(%esi),%esi
 82c:	89 c2                	mov    %eax,%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 82e:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 830:	8b 48 04             	mov    0x4(%eax),%ecx
 833:	39 f9                	cmp    %edi,%ecx
 835:	73 41                	jae    878 <malloc+0x8c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 837:	3b 05 80 0d 00 00    	cmp    0xd80,%eax
 83d:	75 ed                	jne    82c <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 83f:	83 ec 0c             	sub    $0xc,%esp
 842:	56                   	push   %esi
 843:	e8 0f fd ff ff       	call   557 <sbrk>
  if(p == (char*)-1)
 848:	83 c4 10             	add    $0x10,%esp
 84b:	83 f8 ff             	cmp    $0xffffffff,%eax
 84e:	74 1c                	je     86c <malloc+0x80>
  hp->s.size = nu;
 850:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 853:	83 ec 0c             	sub    $0xc,%esp
 856:	83 c0 08             	add    $0x8,%eax
 859:	50                   	push   %eax
 85a:	e8 0d ff ff ff       	call   76c <free>
  return freep;
 85f:	8b 15 80 0d 00 00    	mov    0xd80,%edx
      if((p = morecore(nunits)) == 0)
 865:	83 c4 10             	add    $0x10,%esp
 868:	85 d2                	test   %edx,%edx
 86a:	75 c2                	jne    82e <malloc+0x42>
        return 0;
 86c:	31 c0                	xor    %eax,%eax
  }
}
 86e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 871:	5b                   	pop    %ebx
 872:	5e                   	pop    %esi
 873:	5f                   	pop    %edi
 874:	5d                   	pop    %ebp
 875:	c3                   	ret
 876:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
 878:	39 cf                	cmp    %ecx,%edi
 87a:	74 4c                	je     8c8 <malloc+0xdc>
        p->s.size -= nunits;
 87c:	29 f9                	sub    %edi,%ecx
 87e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 881:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 884:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 887:	89 15 80 0d 00 00    	mov    %edx,0xd80
      return (void*)(p + 1);
 88d:	83 c0 08             	add    $0x8,%eax
}
 890:	8d 65 f4             	lea    -0xc(%ebp),%esp
 893:	5b                   	pop    %ebx
 894:	5e                   	pop    %esi
 895:	5f                   	pop    %edi
 896:	5d                   	pop    %ebp
 897:	c3                   	ret
  if(nu < 4096)
 898:	bb 00 10 00 00       	mov    $0x1000,%ebx
 89d:	eb 81                	jmp    820 <malloc+0x34>
 89f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
 8a0:	c7 05 80 0d 00 00 84 	movl   $0xd84,0xd80
 8a7:	0d 00 00 
 8aa:	c7 05 84 0d 00 00 84 	movl   $0xd84,0xd84
 8b1:	0d 00 00 
    base.s.size = 0;
 8b4:	c7 05 88 0d 00 00 00 	movl   $0x0,0xd88
 8bb:	00 00 00 
 8be:	b8 84 0d 00 00       	mov    $0xd84,%eax
 8c3:	e9 4e ff ff ff       	jmp    816 <malloc+0x2a>
        prevp->s.ptr = p->s.ptr;
 8c8:	8b 08                	mov    (%eax),%ecx
 8ca:	89 0a                	mov    %ecx,(%edx)
 8cc:	eb b9                	jmp    887 <malloc+0x9b>
