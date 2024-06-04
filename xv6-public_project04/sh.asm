
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

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
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
       f:	eb 0c                	jmp    1d <main+0x1d>
      11:	8d 76 00             	lea    0x0(%esi),%esi
    if(fd >= 3){
      14:	83 f8 02             	cmp    $0x2,%eax
      17:	0f 8f 90 00 00 00    	jg     ad <main+0xad>
  while((fd = open("console", O_RDWR)) >= 0){
      1d:	83 ec 08             	sub    $0x8,%esp
      20:	6a 02                	push   $0x2
      22:	68 49 11 00 00       	push   $0x1149
      27:	e8 bb 0c 00 00       	call   ce7 <open>
      2c:	83 c4 10             	add    $0x10,%esp
      2f:	85 c0                	test   %eax,%eax
      31:	79 e1                	jns    14 <main+0x14>
      33:	eb 2a                	jmp    5f <main+0x5f>
      35:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      38:	80 3d 22 12 00 00 20 	cmpb   $0x20,0x1222
      3f:	0f 84 8b 00 00 00    	je     d0 <main+0xd0>
      45:	8d 76 00             	lea    0x0(%esi),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      48:	e8 52 0c 00 00       	call   c9f <fork>
  if(pid == -1)
      4d:	83 f8 ff             	cmp    $0xffffffff,%eax
      50:	0f 84 bf 00 00 00    	je     115 <main+0x115>
    if(fork1() == 0)
      56:	85 c0                	test   %eax,%eax
      58:	74 61                	je     bb <main+0xbb>
    wait();
      5a:	e8 50 0c 00 00       	call   caf <wait>
  printf(2, "$ ");
      5f:	83 ec 08             	sub    $0x8,%esp
      62:	68 a8 10 00 00       	push   $0x10a8
      67:	6a 02                	push   $0x2
      69:	e8 6e 0d 00 00       	call   ddc <printf>
  memset(buf, 0, nbuf);
      6e:	83 c4 0c             	add    $0xc,%esp
      71:	6a 64                	push   $0x64
      73:	6a 00                	push   $0x0
      75:	68 20 12 00 00       	push   $0x1220
      7a:	e8 f1 0a 00 00       	call   b70 <memset>
  gets(buf, nbuf);
      7f:	58                   	pop    %eax
      80:	5a                   	pop    %edx
      81:	6a 64                	push   $0x64
      83:	68 20 12 00 00       	push   $0x1220
      88:	e8 23 0b 00 00       	call   bb0 <gets>
  if(buf[0] == 0) // EOF
      8d:	a0 20 12 00 00       	mov    0x1220,%al
      92:	83 c4 10             	add    $0x10,%esp
      95:	84 c0                	test   %al,%al
      97:	74 0f                	je     a8 <main+0xa8>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      99:	3c 63                	cmp    $0x63,%al
      9b:	75 ab                	jne    48 <main+0x48>
      9d:	80 3d 21 12 00 00 64 	cmpb   $0x64,0x1221
      a4:	75 a2                	jne    48 <main+0x48>
      a6:	eb 90                	jmp    38 <main+0x38>
  exit();
      a8:	e8 fa 0b 00 00       	call   ca7 <exit>
      close(fd);
      ad:	83 ec 0c             	sub    $0xc,%esp
      b0:	50                   	push   %eax
      b1:	e8 19 0c 00 00       	call   ccf <close>
      break;
      b6:	83 c4 10             	add    $0x10,%esp
      b9:	eb a4                	jmp    5f <main+0x5f>
      runcmd(parsecmd(buf));
      bb:	83 ec 0c             	sub    $0xc,%esp
      be:	68 20 12 00 00       	push   $0x1220
      c3:	e8 b4 09 00 00       	call   a7c <parsecmd>
      c8:	89 04 24             	mov    %eax,(%esp)
      cb:	e8 d0 00 00 00       	call   1a0 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
      d0:	83 ec 0c             	sub    $0xc,%esp
      d3:	68 20 12 00 00       	push   $0x1220
      d8:	e8 6b 0a 00 00       	call   b48 <strlen>
      dd:	c6 80 1f 12 00 00 00 	movb   $0x0,0x121f(%eax)
      if(chdir(buf+3) < 0)
      e4:	c7 04 24 23 12 00 00 	movl   $0x1223,(%esp)
      eb:	e8 27 0c 00 00       	call   d17 <chdir>
      f0:	83 c4 10             	add    $0x10,%esp
      f3:	85 c0                	test   %eax,%eax
      f5:	0f 89 64 ff ff ff    	jns    5f <main+0x5f>
        printf(2, "cannot cd %s\n", buf+3);
      fb:	51                   	push   %ecx
      fc:	68 23 12 00 00       	push   $0x1223
     101:	68 51 11 00 00       	push   $0x1151
     106:	6a 02                	push   $0x2
     108:	e8 cf 0c 00 00       	call   ddc <printf>
     10d:	83 c4 10             	add    $0x10,%esp
     110:	e9 4a ff ff ff       	jmp    5f <main+0x5f>
    panic("fork");
     115:	83 ec 0c             	sub    $0xc,%esp
     118:	68 ab 10 00 00       	push   $0x10ab
     11d:	e8 42 00 00 00       	call   164 <panic>
     122:	66 90                	xchg   %ax,%ax

00000124 <getcmd>:
{
     124:	55                   	push   %ebp
     125:	89 e5                	mov    %esp,%ebp
     127:	56                   	push   %esi
     128:	53                   	push   %ebx
     129:	8b 5d 08             	mov    0x8(%ebp),%ebx
     12c:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
     12f:	83 ec 08             	sub    $0x8,%esp
     132:	68 a8 10 00 00       	push   $0x10a8
     137:	6a 02                	push   $0x2
     139:	e8 9e 0c 00 00       	call   ddc <printf>
  memset(buf, 0, nbuf);
     13e:	83 c4 0c             	add    $0xc,%esp
     141:	56                   	push   %esi
     142:	6a 00                	push   $0x0
     144:	53                   	push   %ebx
     145:	e8 26 0a 00 00       	call   b70 <memset>
  gets(buf, nbuf);
     14a:	58                   	pop    %eax
     14b:	5a                   	pop    %edx
     14c:	56                   	push   %esi
     14d:	53                   	push   %ebx
     14e:	e8 5d 0a 00 00       	call   bb0 <gets>
  if(buf[0] == 0) // EOF
     153:	83 c4 10             	add    $0x10,%esp
     156:	80 3b 01             	cmpb   $0x1,(%ebx)
     159:	19 c0                	sbb    %eax,%eax
}
     15b:	8d 65 f8             	lea    -0x8(%ebp),%esp
     15e:	5b                   	pop    %ebx
     15f:	5e                   	pop    %esi
     160:	5d                   	pop    %ebp
     161:	c3                   	ret
     162:	66 90                	xchg   %ax,%ax

00000164 <panic>:
{
     164:	55                   	push   %ebp
     165:	89 e5                	mov    %esp,%ebp
     167:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     16a:	ff 75 08             	push   0x8(%ebp)
     16d:	68 45 11 00 00       	push   $0x1145
     172:	6a 02                	push   $0x2
     174:	e8 63 0c 00 00       	call   ddc <printf>
  exit();
     179:	e8 29 0b 00 00       	call   ca7 <exit>
     17e:	66 90                	xchg   %ax,%ax

00000180 <fork1>:
{
     180:	55                   	push   %ebp
     181:	89 e5                	mov    %esp,%ebp
     183:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     186:	e8 14 0b 00 00       	call   c9f <fork>
  if(pid == -1)
     18b:	83 f8 ff             	cmp    $0xffffffff,%eax
     18e:	74 02                	je     192 <fork1+0x12>
  return pid;
}
     190:	c9                   	leave
     191:	c3                   	ret
    panic("fork");
     192:	83 ec 0c             	sub    $0xc,%esp
     195:	68 ab 10 00 00       	push   $0x10ab
     19a:	e8 c5 ff ff ff       	call   164 <panic>
     19f:	90                   	nop

000001a0 <runcmd>:
{
     1a0:	55                   	push   %ebp
     1a1:	89 e5                	mov    %esp,%ebp
     1a3:	53                   	push   %ebx
     1a4:	83 ec 14             	sub    $0x14,%esp
     1a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     1aa:	85 db                	test   %ebx,%ebx
     1ac:	74 3a                	je     1e8 <runcmd+0x48>
  switch(cmd->type){
     1ae:	83 3b 05             	cmpl   $0x5,(%ebx)
     1b1:	0f 87 db 00 00 00    	ja     292 <runcmd+0xf2>
     1b7:	8b 03                	mov    (%ebx),%eax
     1b9:	ff 24 85 68 11 00 00 	jmp    *0x1168(,%eax,4)
    if(ecmd->argv[0] == 0)
     1c0:	8b 43 04             	mov    0x4(%ebx),%eax
     1c3:	85 c0                	test   %eax,%eax
     1c5:	74 21                	je     1e8 <runcmd+0x48>
    exec(ecmd->argv[0], ecmd->argv);
     1c7:	51                   	push   %ecx
     1c8:	51                   	push   %ecx
     1c9:	8d 53 04             	lea    0x4(%ebx),%edx
     1cc:	52                   	push   %edx
     1cd:	50                   	push   %eax
     1ce:	e8 0c 0b 00 00       	call   cdf <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     1d3:	83 c4 0c             	add    $0xc,%esp
     1d6:	ff 73 04             	push   0x4(%ebx)
     1d9:	68 b7 10 00 00       	push   $0x10b7
     1de:	6a 02                	push   $0x2
     1e0:	e8 f7 0b 00 00       	call   ddc <printf>
    break;
     1e5:	83 c4 10             	add    $0x10,%esp
    exit();
     1e8:	e8 ba 0a 00 00       	call   ca7 <exit>
    if(fork1() == 0)
     1ed:	e8 8e ff ff ff       	call   180 <fork1>
     1f2:	85 c0                	test   %eax,%eax
     1f4:	75 f2                	jne    1e8 <runcmd+0x48>
     1f6:	e9 8c 00 00 00       	jmp    287 <runcmd+0xe7>
    if(pipe(p) < 0)
     1fb:	83 ec 0c             	sub    $0xc,%esp
     1fe:	8d 45 f0             	lea    -0x10(%ebp),%eax
     201:	50                   	push   %eax
     202:	e8 b0 0a 00 00       	call   cb7 <pipe>
     207:	83 c4 10             	add    $0x10,%esp
     20a:	85 c0                	test   %eax,%eax
     20c:	0f 88 a2 00 00 00    	js     2b4 <runcmd+0x114>
    if(fork1() == 0){
     212:	e8 69 ff ff ff       	call   180 <fork1>
     217:	85 c0                	test   %eax,%eax
     219:	0f 84 a2 00 00 00    	je     2c1 <runcmd+0x121>
    if(fork1() == 0){
     21f:	e8 5c ff ff ff       	call   180 <fork1>
     224:	85 c0                	test   %eax,%eax
     226:	0f 84 c3 00 00 00    	je     2ef <runcmd+0x14f>
    close(p[0]);
     22c:	83 ec 0c             	sub    $0xc,%esp
     22f:	ff 75 f0             	push   -0x10(%ebp)
     232:	e8 98 0a 00 00       	call   ccf <close>
    close(p[1]);
     237:	58                   	pop    %eax
     238:	ff 75 f4             	push   -0xc(%ebp)
     23b:	e8 8f 0a 00 00       	call   ccf <close>
    wait();
     240:	e8 6a 0a 00 00       	call   caf <wait>
    wait();
     245:	e8 65 0a 00 00       	call   caf <wait>
    break;
     24a:	83 c4 10             	add    $0x10,%esp
     24d:	eb 99                	jmp    1e8 <runcmd+0x48>
    if(fork1() == 0)
     24f:	e8 2c ff ff ff       	call   180 <fork1>
     254:	85 c0                	test   %eax,%eax
     256:	74 2f                	je     287 <runcmd+0xe7>
    wait();
     258:	e8 52 0a 00 00       	call   caf <wait>
    runcmd(lcmd->right);
     25d:	83 ec 0c             	sub    $0xc,%esp
     260:	ff 73 08             	push   0x8(%ebx)
     263:	e8 38 ff ff ff       	call   1a0 <runcmd>
    close(rcmd->fd);
     268:	83 ec 0c             	sub    $0xc,%esp
     26b:	ff 73 14             	push   0x14(%ebx)
     26e:	e8 5c 0a 00 00       	call   ccf <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     273:	58                   	pop    %eax
     274:	5a                   	pop    %edx
     275:	ff 73 10             	push   0x10(%ebx)
     278:	ff 73 08             	push   0x8(%ebx)
     27b:	e8 67 0a 00 00       	call   ce7 <open>
     280:	83 c4 10             	add    $0x10,%esp
     283:	85 c0                	test   %eax,%eax
     285:	78 18                	js     29f <runcmd+0xff>
      runcmd(bcmd->cmd);
     287:	83 ec 0c             	sub    $0xc,%esp
     28a:	ff 73 04             	push   0x4(%ebx)
     28d:	e8 0e ff ff ff       	call   1a0 <runcmd>
    panic("runcmd");
     292:	83 ec 0c             	sub    $0xc,%esp
     295:	68 b0 10 00 00       	push   $0x10b0
     29a:	e8 c5 fe ff ff       	call   164 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     29f:	51                   	push   %ecx
     2a0:	ff 73 08             	push   0x8(%ebx)
     2a3:	68 c7 10 00 00       	push   $0x10c7
     2a8:	6a 02                	push   $0x2
     2aa:	e8 2d 0b 00 00       	call   ddc <printf>
      exit();
     2af:	e8 f3 09 00 00       	call   ca7 <exit>
      panic("pipe");
     2b4:	83 ec 0c             	sub    $0xc,%esp
     2b7:	68 d7 10 00 00       	push   $0x10d7
     2bc:	e8 a3 fe ff ff       	call   164 <panic>
      close(1);
     2c1:	83 ec 0c             	sub    $0xc,%esp
     2c4:	6a 01                	push   $0x1
     2c6:	e8 04 0a 00 00       	call   ccf <close>
      dup(p[1]);
     2cb:	58                   	pop    %eax
     2cc:	ff 75 f4             	push   -0xc(%ebp)
     2cf:	e8 4b 0a 00 00       	call   d1f <dup>
      close(p[0]);
     2d4:	58                   	pop    %eax
     2d5:	ff 75 f0             	push   -0x10(%ebp)
     2d8:	e8 f2 09 00 00       	call   ccf <close>
      close(p[1]);
     2dd:	58                   	pop    %eax
     2de:	ff 75 f4             	push   -0xc(%ebp)
     2e1:	e8 e9 09 00 00       	call   ccf <close>
      runcmd(pcmd->left);
     2e6:	5a                   	pop    %edx
     2e7:	ff 73 04             	push   0x4(%ebx)
     2ea:	e8 b1 fe ff ff       	call   1a0 <runcmd>
      close(0);
     2ef:	83 ec 0c             	sub    $0xc,%esp
     2f2:	6a 00                	push   $0x0
     2f4:	e8 d6 09 00 00       	call   ccf <close>
      dup(p[0]);
     2f9:	5a                   	pop    %edx
     2fa:	ff 75 f0             	push   -0x10(%ebp)
     2fd:	e8 1d 0a 00 00       	call   d1f <dup>
      close(p[0]);
     302:	59                   	pop    %ecx
     303:	ff 75 f0             	push   -0x10(%ebp)
     306:	e8 c4 09 00 00       	call   ccf <close>
      close(p[1]);
     30b:	58                   	pop    %eax
     30c:	ff 75 f4             	push   -0xc(%ebp)
     30f:	e8 bb 09 00 00       	call   ccf <close>
      runcmd(pcmd->right);
     314:	58                   	pop    %eax
     315:	ff 73 08             	push   0x8(%ebx)
     318:	e8 83 fe ff ff       	call   1a0 <runcmd>
     31d:	8d 76 00             	lea    0x0(%esi),%esi

00000320 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     320:	55                   	push   %ebp
     321:	89 e5                	mov    %esp,%ebp
     323:	53                   	push   %ebx
     324:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     327:	6a 54                	push   $0x54
     329:	e8 96 0c 00 00       	call   fc4 <malloc>
     32e:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     330:	83 c4 0c             	add    $0xc,%esp
     333:	6a 54                	push   $0x54
     335:	6a 00                	push   $0x0
     337:	50                   	push   %eax
     338:	e8 33 08 00 00       	call   b70 <memset>
  cmd->type = EXEC;
     33d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     343:	89 d8                	mov    %ebx,%eax
     345:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     348:	c9                   	leave
     349:	c3                   	ret
     34a:	66 90                	xchg   %ax,%ax

0000034c <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     34c:	55                   	push   %ebp
     34d:	89 e5                	mov    %esp,%ebp
     34f:	53                   	push   %ebx
     350:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     353:	6a 18                	push   $0x18
     355:	e8 6a 0c 00 00       	call   fc4 <malloc>
     35a:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     35c:	83 c4 0c             	add    $0xc,%esp
     35f:	6a 18                	push   $0x18
     361:	6a 00                	push   $0x0
     363:	50                   	push   %eax
     364:	e8 07 08 00 00       	call   b70 <memset>
  cmd->type = REDIR;
     369:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     36f:	8b 45 08             	mov    0x8(%ebp),%eax
     372:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     375:	8b 45 0c             	mov    0xc(%ebp),%eax
     378:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     37b:	8b 45 10             	mov    0x10(%ebp),%eax
     37e:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     381:	8b 45 14             	mov    0x14(%ebp),%eax
     384:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     387:	8b 45 18             	mov    0x18(%ebp),%eax
     38a:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     38d:	89 d8                	mov    %ebx,%eax
     38f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     392:	c9                   	leave
     393:	c3                   	ret

00000394 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     394:	55                   	push   %ebp
     395:	89 e5                	mov    %esp,%ebp
     397:	53                   	push   %ebx
     398:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     39b:	6a 0c                	push   $0xc
     39d:	e8 22 0c 00 00       	call   fc4 <malloc>
     3a2:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3a4:	83 c4 0c             	add    $0xc,%esp
     3a7:	6a 0c                	push   $0xc
     3a9:	6a 00                	push   $0x0
     3ab:	50                   	push   %eax
     3ac:	e8 bf 07 00 00       	call   b70 <memset>
  cmd->type = PIPE;
     3b1:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     3b7:	8b 45 08             	mov    0x8(%ebp),%eax
     3ba:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3bd:	8b 45 0c             	mov    0xc(%ebp),%eax
     3c0:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3c3:	89 d8                	mov    %ebx,%eax
     3c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3c8:	c9                   	leave
     3c9:	c3                   	ret
     3ca:	66 90                	xchg   %ax,%ax

000003cc <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     3cc:	55                   	push   %ebp
     3cd:	89 e5                	mov    %esp,%ebp
     3cf:	53                   	push   %ebx
     3d0:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3d3:	6a 0c                	push   $0xc
     3d5:	e8 ea 0b 00 00       	call   fc4 <malloc>
     3da:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3dc:	83 c4 0c             	add    $0xc,%esp
     3df:	6a 0c                	push   $0xc
     3e1:	6a 00                	push   $0x0
     3e3:	50                   	push   %eax
     3e4:	e8 87 07 00 00       	call   b70 <memset>
  cmd->type = LIST;
     3e9:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     3ef:	8b 45 08             	mov    0x8(%ebp),%eax
     3f2:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3f5:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f8:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3fb:	89 d8                	mov    %ebx,%eax
     3fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     400:	c9                   	leave
     401:	c3                   	ret
     402:	66 90                	xchg   %ax,%ax

00000404 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     404:	55                   	push   %ebp
     405:	89 e5                	mov    %esp,%ebp
     407:	53                   	push   %ebx
     408:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     40b:	6a 08                	push   $0x8
     40d:	e8 b2 0b 00 00       	call   fc4 <malloc>
     412:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     414:	83 c4 0c             	add    $0xc,%esp
     417:	6a 08                	push   $0x8
     419:	6a 00                	push   $0x0
     41b:	50                   	push   %eax
     41c:	e8 4f 07 00 00       	call   b70 <memset>
  cmd->type = BACK;
     421:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     427:	8b 45 08             	mov    0x8(%ebp),%eax
     42a:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     42d:	89 d8                	mov    %ebx,%eax
     42f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     432:	c9                   	leave
     433:	c3                   	ret

00000434 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     434:	55                   	push   %ebp
     435:	89 e5                	mov    %esp,%ebp
     437:	57                   	push   %edi
     438:	56                   	push   %esi
     439:	53                   	push   %ebx
     43a:	83 ec 0c             	sub    $0xc,%esp
     43d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     440:	8b 75 10             	mov    0x10(%ebp),%esi
  char *s;
  int ret;

  s = *ps;
     443:	8b 45 08             	mov    0x8(%ebp),%eax
     446:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     448:	39 df                	cmp    %ebx,%edi
     44a:	72 09                	jb     455 <gettoken+0x21>
     44c:	eb 1f                	jmp    46d <gettoken+0x39>
     44e:	66 90                	xchg   %ax,%ax
    s++;
     450:	47                   	inc    %edi
  while(s < es && strchr(whitespace, *s))
     451:	39 fb                	cmp    %edi,%ebx
     453:	74 18                	je     46d <gettoken+0x39>
     455:	83 ec 08             	sub    $0x8,%esp
     458:	0f be 07             	movsbl (%edi),%eax
     45b:	50                   	push   %eax
     45c:	68 0c 12 00 00       	push   $0x120c
     461:	e8 22 07 00 00       	call   b88 <strchr>
     466:	83 c4 10             	add    $0x10,%esp
     469:	85 c0                	test   %eax,%eax
     46b:	75 e3                	jne    450 <gettoken+0x1c>
  if(q)
     46d:	85 f6                	test   %esi,%esi
     46f:	74 02                	je     473 <gettoken+0x3f>
    *q = s;
     471:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     473:	8a 07                	mov    (%edi),%al
  switch(*s){
     475:	3c 3c                	cmp    $0x3c,%al
     477:	0f 8f ab 00 00 00    	jg     528 <gettoken+0xf4>
     47d:	3c 3a                	cmp    $0x3a,%al
     47f:	7f 55                	jg     4d6 <gettoken+0xa2>
     481:	84 c0                	test   %al,%al
     483:	75 43                	jne    4c8 <gettoken+0x94>
     485:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     487:	8b 4d 14             	mov    0x14(%ebp),%ecx
     48a:	85 c9                	test   %ecx,%ecx
     48c:	74 05                	je     493 <gettoken+0x5f>
    *eq = s;
     48e:	8b 45 14             	mov    0x14(%ebp),%eax
     491:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     493:	39 df                	cmp    %ebx,%edi
     495:	72 0a                	jb     4a1 <gettoken+0x6d>
     497:	eb 20                	jmp    4b9 <gettoken+0x85>
     499:	8d 76 00             	lea    0x0(%esi),%esi
    s++;
     49c:	47                   	inc    %edi
  while(s < es && strchr(whitespace, *s))
     49d:	39 fb                	cmp    %edi,%ebx
     49f:	74 18                	je     4b9 <gettoken+0x85>
     4a1:	83 ec 08             	sub    $0x8,%esp
     4a4:	0f be 07             	movsbl (%edi),%eax
     4a7:	50                   	push   %eax
     4a8:	68 0c 12 00 00       	push   $0x120c
     4ad:	e8 d6 06 00 00       	call   b88 <strchr>
     4b2:	83 c4 10             	add    $0x10,%esp
     4b5:	85 c0                	test   %eax,%eax
     4b7:	75 e3                	jne    49c <gettoken+0x68>
  *ps = s;
     4b9:	8b 45 08             	mov    0x8(%ebp),%eax
     4bc:	89 38                	mov    %edi,(%eax)
  return ret;
}
     4be:	89 f0                	mov    %esi,%eax
     4c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
     4c3:	5b                   	pop    %ebx
     4c4:	5e                   	pop    %esi
     4c5:	5f                   	pop    %edi
     4c6:	5d                   	pop    %ebp
     4c7:	c3                   	ret
  switch(*s){
     4c8:	78 16                	js     4e0 <gettoken+0xac>
     4ca:	3c 26                	cmp    $0x26,%al
     4cc:	74 08                	je     4d6 <gettoken+0xa2>
     4ce:	8d 48 d8             	lea    -0x28(%eax),%ecx
     4d1:	80 f9 01             	cmp    $0x1,%cl
     4d4:	77 0a                	ja     4e0 <gettoken+0xac>
  ret = *s;
     4d6:	0f be f0             	movsbl %al,%esi
    s++;
     4d9:	47                   	inc    %edi
    break;
     4da:	eb ab                	jmp    487 <gettoken+0x53>
  switch(*s){
     4dc:	3c 7c                	cmp    $0x7c,%al
     4de:	74 f6                	je     4d6 <gettoken+0xa2>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4e0:	39 df                	cmp    %ebx,%edi
     4e2:	72 21                	jb     505 <gettoken+0xd1>
     4e4:	eb 7c                	jmp    562 <gettoken+0x12e>
     4e6:	66 90                	xchg   %ax,%ax
     4e8:	83 ec 08             	sub    $0x8,%esp
     4eb:	0f be 07             	movsbl (%edi),%eax
     4ee:	50                   	push   %eax
     4ef:	68 04 12 00 00       	push   $0x1204
     4f4:	e8 8f 06 00 00       	call   b88 <strchr>
     4f9:	83 c4 10             	add    $0x10,%esp
     4fc:	85 c0                	test   %eax,%eax
     4fe:	75 1d                	jne    51d <gettoken+0xe9>
      s++;
     500:	47                   	inc    %edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     501:	39 fb                	cmp    %edi,%ebx
     503:	74 45                	je     54a <gettoken+0x116>
     505:	83 ec 08             	sub    $0x8,%esp
     508:	0f be 07             	movsbl (%edi),%eax
     50b:	50                   	push   %eax
     50c:	68 0c 12 00 00       	push   $0x120c
     511:	e8 72 06 00 00       	call   b88 <strchr>
     516:	83 c4 10             	add    $0x10,%esp
     519:	85 c0                	test   %eax,%eax
     51b:	74 cb                	je     4e8 <gettoken+0xb4>
    ret = 'a';
     51d:	be 61 00 00 00       	mov    $0x61,%esi
     522:	e9 60 ff ff ff       	jmp    487 <gettoken+0x53>
     527:	90                   	nop
  switch(*s){
     528:	3c 3e                	cmp    $0x3e,%al
     52a:	75 b0                	jne    4dc <gettoken+0xa8>
    if(*s == '>'){
     52c:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     530:	74 0b                	je     53d <gettoken+0x109>
    s++;
     532:	47                   	inc    %edi
  ret = *s;
     533:	be 3e 00 00 00       	mov    $0x3e,%esi
     538:	e9 4a ff ff ff       	jmp    487 <gettoken+0x53>
      s++;
     53d:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     540:	be 2b 00 00 00       	mov    $0x2b,%esi
     545:	e9 3d ff ff ff       	jmp    487 <gettoken+0x53>
  if(eq)
     54a:	8b 45 14             	mov    0x14(%ebp),%eax
     54d:	85 c0                	test   %eax,%eax
     54f:	74 05                	je     556 <gettoken+0x122>
    *eq = s;
     551:	8b 45 14             	mov    0x14(%ebp),%eax
     554:	89 18                	mov    %ebx,(%eax)
  while(s < es && strchr(whitespace, *s))
     556:	89 df                	mov    %ebx,%edi
    ret = 'a';
     558:	be 61 00 00 00       	mov    $0x61,%esi
     55d:	e9 57 ff ff ff       	jmp    4b9 <gettoken+0x85>
  if(eq)
     562:	8b 55 14             	mov    0x14(%ebp),%edx
     565:	85 d2                	test   %edx,%edx
     567:	74 ef                	je     558 <gettoken+0x124>
    *eq = s;
     569:	8b 45 14             	mov    0x14(%ebp),%eax
     56c:	89 38                	mov    %edi,(%eax)
  while(s < es && strchr(whitespace, *s))
     56e:	eb e8                	jmp    558 <gettoken+0x124>

00000570 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     570:	55                   	push   %ebp
     571:	89 e5                	mov    %esp,%ebp
     573:	57                   	push   %edi
     574:	56                   	push   %esi
     575:	53                   	push   %ebx
     576:	83 ec 0c             	sub    $0xc,%esp
     579:	8b 7d 08             	mov    0x8(%ebp),%edi
     57c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     57f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     581:	39 f3                	cmp    %esi,%ebx
     583:	72 08                	jb     58d <peek+0x1d>
     585:	eb 1e                	jmp    5a5 <peek+0x35>
     587:	90                   	nop
    s++;
     588:	43                   	inc    %ebx
  while(s < es && strchr(whitespace, *s))
     589:	39 de                	cmp    %ebx,%esi
     58b:	74 18                	je     5a5 <peek+0x35>
     58d:	83 ec 08             	sub    $0x8,%esp
     590:	0f be 03             	movsbl (%ebx),%eax
     593:	50                   	push   %eax
     594:	68 0c 12 00 00       	push   $0x120c
     599:	e8 ea 05 00 00       	call   b88 <strchr>
     59e:	83 c4 10             	add    $0x10,%esp
     5a1:	85 c0                	test   %eax,%eax
     5a3:	75 e3                	jne    588 <peek+0x18>
  *ps = s;
     5a5:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     5a7:	0f be 03             	movsbl (%ebx),%eax
     5aa:	84 c0                	test   %al,%al
     5ac:	75 0a                	jne    5b8 <peek+0x48>
     5ae:	31 c0                	xor    %eax,%eax
}
     5b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5b3:	5b                   	pop    %ebx
     5b4:	5e                   	pop    %esi
     5b5:	5f                   	pop    %edi
     5b6:	5d                   	pop    %ebp
     5b7:	c3                   	ret
  return *s && strchr(toks, *s);
     5b8:	83 ec 08             	sub    $0x8,%esp
     5bb:	50                   	push   %eax
     5bc:	ff 75 10             	push   0x10(%ebp)
     5bf:	e8 c4 05 00 00       	call   b88 <strchr>
     5c4:	83 c4 10             	add    $0x10,%esp
     5c7:	85 c0                	test   %eax,%eax
     5c9:	0f 95 c0             	setne  %al
     5cc:	0f b6 c0             	movzbl %al,%eax
}
     5cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5d2:	5b                   	pop    %ebx
     5d3:	5e                   	pop    %esi
     5d4:	5f                   	pop    %edi
     5d5:	5d                   	pop    %ebp
     5d6:	c3                   	ret
     5d7:	90                   	nop

000005d8 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     5d8:	55                   	push   %ebp
     5d9:	89 e5                	mov    %esp,%ebp
     5db:	57                   	push   %edi
     5dc:	56                   	push   %esi
     5dd:	53                   	push   %ebx
     5de:	83 ec 2c             	sub    $0x2c,%esp
     5e1:	8b 75 0c             	mov    0xc(%ebp),%esi
     5e4:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     5e7:	90                   	nop
     5e8:	50                   	push   %eax
     5e9:	68 f9 10 00 00       	push   $0x10f9
     5ee:	53                   	push   %ebx
     5ef:	56                   	push   %esi
     5f0:	e8 7b ff ff ff       	call   570 <peek>
     5f5:	83 c4 10             	add    $0x10,%esp
     5f8:	85 c0                	test   %eax,%eax
     5fa:	0f 84 e8 00 00 00    	je     6e8 <parseredirs+0x110>
    tok = gettoken(ps, es, 0, 0);
     600:	6a 00                	push   $0x0
     602:	6a 00                	push   $0x0
     604:	53                   	push   %ebx
     605:	56                   	push   %esi
     606:	e8 29 fe ff ff       	call   434 <gettoken>
     60b:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     60d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     610:	50                   	push   %eax
     611:	8d 45 e0             	lea    -0x20(%ebp),%eax
     614:	50                   	push   %eax
     615:	53                   	push   %ebx
     616:	56                   	push   %esi
     617:	e8 18 fe ff ff       	call   434 <gettoken>
     61c:	83 c4 20             	add    $0x20,%esp
     61f:	83 f8 61             	cmp    $0x61,%eax
     622:	0f 85 cb 00 00 00    	jne    6f3 <parseredirs+0x11b>
      panic("missing file for redirection");
    switch(tok){
     628:	83 ff 3c             	cmp    $0x3c,%edi
     62b:	74 63                	je     690 <parseredirs+0xb8>
     62d:	83 ff 3e             	cmp    $0x3e,%edi
     630:	74 05                	je     637 <parseredirs+0x5f>
     632:	83 ff 2b             	cmp    $0x2b,%edi
     635:	75 b1                	jne    5e8 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     637:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     63a:	89 55 d0             	mov    %edx,-0x30(%ebp)
     63d:	8b 4d e0             	mov    -0x20(%ebp),%ecx
     640:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     643:	83 ec 0c             	sub    $0xc,%esp
     646:	6a 18                	push   $0x18
     648:	e8 77 09 00 00       	call   fc4 <malloc>
     64d:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     64f:	83 c4 0c             	add    $0xc,%esp
     652:	6a 18                	push   $0x18
     654:	6a 00                	push   $0x0
     656:	50                   	push   %eax
     657:	e8 14 05 00 00       	call   b70 <memset>
  cmd->type = REDIR;
     65c:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     662:	8b 45 08             	mov    0x8(%ebp),%eax
     665:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     668:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     66b:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     66e:	8b 55 d0             	mov    -0x30(%ebp),%edx
     671:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     674:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->fd = fd;
     67b:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      break;
     682:	83 c4 10             	add    $0x10,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     685:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     688:	e9 5b ff ff ff       	jmp    5e8 <parseredirs+0x10>
     68d:	8d 76 00             	lea    0x0(%esi),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     690:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     693:	89 55 d0             	mov    %edx,-0x30(%ebp)
     696:	8b 4d e0             	mov    -0x20(%ebp),%ecx
     699:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     69c:	83 ec 0c             	sub    $0xc,%esp
     69f:	6a 18                	push   $0x18
     6a1:	e8 1e 09 00 00       	call   fc4 <malloc>
     6a6:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     6a8:	83 c4 0c             	add    $0xc,%esp
     6ab:	6a 18                	push   $0x18
     6ad:	6a 00                	push   $0x0
     6af:	50                   	push   %eax
     6b0:	e8 bb 04 00 00       	call   b70 <memset>
  cmd->type = REDIR;
     6b5:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     6bb:	8b 45 08             	mov    0x8(%ebp),%eax
     6be:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     6c1:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     6c4:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     6c7:	8b 55 d0             	mov    -0x30(%ebp),%edx
     6ca:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     6cd:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     6d4:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      break;
     6db:	83 c4 10             	add    $0x10,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     6de:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     6e1:	e9 02 ff ff ff       	jmp    5e8 <parseredirs+0x10>
     6e6:	66 90                	xchg   %ax,%ax
    }
  }
  return cmd;
}
     6e8:	8b 45 08             	mov    0x8(%ebp),%eax
     6eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6ee:	5b                   	pop    %ebx
     6ef:	5e                   	pop    %esi
     6f0:	5f                   	pop    %edi
     6f1:	5d                   	pop    %ebp
     6f2:	c3                   	ret
      panic("missing file for redirection");
     6f3:	83 ec 0c             	sub    $0xc,%esp
     6f6:	68 dc 10 00 00       	push   $0x10dc
     6fb:	e8 64 fa ff ff       	call   164 <panic>

00000700 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     700:	55                   	push   %ebp
     701:	89 e5                	mov    %esp,%ebp
     703:	57                   	push   %edi
     704:	56                   	push   %esi
     705:	53                   	push   %ebx
     706:	83 ec 30             	sub    $0x30,%esp
     709:	8b 5d 08             	mov    0x8(%ebp),%ebx
     70c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     70f:	68 fc 10 00 00       	push   $0x10fc
     714:	56                   	push   %esi
     715:	53                   	push   %ebx
     716:	e8 55 fe ff ff       	call   570 <peek>
     71b:	83 c4 10             	add    $0x10,%esp
     71e:	85 c0                	test   %eax,%eax
     720:	0f 85 9e 00 00 00    	jne    7c4 <parseexec+0xc4>
     726:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     728:	83 ec 0c             	sub    $0xc,%esp
     72b:	6a 54                	push   $0x54
     72d:	e8 92 08 00 00       	call   fc4 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     732:	83 c4 0c             	add    $0xc,%esp
     735:	6a 54                	push   $0x54
     737:	6a 00                	push   $0x0
     739:	89 45 d0             	mov    %eax,-0x30(%ebp)
     73c:	50                   	push   %eax
     73d:	e8 2e 04 00 00       	call   b70 <memset>
  cmd->type = EXEC;
     742:	8b 45 d0             	mov    -0x30(%ebp),%eax
     745:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     74b:	83 c4 0c             	add    $0xc,%esp
     74e:	56                   	push   %esi
     74f:	53                   	push   %ebx
     750:	50                   	push   %eax
     751:	e8 82 fe ff ff       	call   5d8 <parseredirs>
     756:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     759:	83 c4 10             	add    $0x10,%esp
     75c:	eb 13                	jmp    771 <parseexec+0x71>
     75e:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     760:	52                   	push   %edx
     761:	56                   	push   %esi
     762:	53                   	push   %ebx
     763:	ff 75 d4             	push   -0x2c(%ebp)
     766:	e8 6d fe ff ff       	call   5d8 <parseredirs>
     76b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     76e:	83 c4 10             	add    $0x10,%esp
  while(!peek(ps, es, "|)&;")){
     771:	50                   	push   %eax
     772:	68 13 11 00 00       	push   $0x1113
     777:	56                   	push   %esi
     778:	53                   	push   %ebx
     779:	e8 f2 fd ff ff       	call   570 <peek>
     77e:	83 c4 10             	add    $0x10,%esp
     781:	85 c0                	test   %eax,%eax
     783:	75 53                	jne    7d8 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     785:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     788:	50                   	push   %eax
     789:	8d 45 e0             	lea    -0x20(%ebp),%eax
     78c:	50                   	push   %eax
     78d:	56                   	push   %esi
     78e:	53                   	push   %ebx
     78f:	e8 a0 fc ff ff       	call   434 <gettoken>
     794:	83 c4 10             	add    $0x10,%esp
     797:	85 c0                	test   %eax,%eax
     799:	74 3d                	je     7d8 <parseexec+0xd8>
    if(tok != 'a')
     79b:	83 f8 61             	cmp    $0x61,%eax
     79e:	75 56                	jne    7f6 <parseexec+0xf6>
    cmd->argv[argc] = q;
     7a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     7a3:	8b 55 d0             	mov    -0x30(%ebp),%edx
     7a6:	89 44 ba 04          	mov    %eax,0x4(%edx,%edi,4)
    cmd->eargv[argc] = eq;
     7aa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7ad:	89 44 ba 2c          	mov    %eax,0x2c(%edx,%edi,4)
    argc++;
     7b1:	47                   	inc    %edi
    if(argc >= MAXARGS)
     7b2:	83 ff 0a             	cmp    $0xa,%edi
     7b5:	75 a9                	jne    760 <parseexec+0x60>
      panic("too many args");
     7b7:	83 ec 0c             	sub    $0xc,%esp
     7ba:	68 05 11 00 00       	push   $0x1105
     7bf:	e8 a0 f9 ff ff       	call   164 <panic>
    return parseblock(ps, es);
     7c4:	89 75 0c             	mov    %esi,0xc(%ebp)
     7c7:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7cd:	5b                   	pop    %ebx
     7ce:	5e                   	pop    %esi
     7cf:	5f                   	pop    %edi
     7d0:	5d                   	pop    %ebp
    return parseblock(ps, es);
     7d1:	e9 8a 01 00 00       	jmp    960 <parseblock>
     7d6:	66 90                	xchg   %ax,%ax
  cmd->argv[argc] = 0;
     7d8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     7db:	c7 44 b8 04 00 00 00 	movl   $0x0,0x4(%eax,%edi,4)
     7e2:	00 
  cmd->eargv[argc] = 0;
     7e3:	c7 44 b8 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edi,4)
     7ea:	00 
}
     7eb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7f1:	5b                   	pop    %ebx
     7f2:	5e                   	pop    %esi
     7f3:	5f                   	pop    %edi
     7f4:	5d                   	pop    %ebp
     7f5:	c3                   	ret
      panic("syntax");
     7f6:	83 ec 0c             	sub    $0xc,%esp
     7f9:	68 fe 10 00 00       	push   $0x10fe
     7fe:	e8 61 f9 ff ff       	call   164 <panic>
     803:	90                   	nop

00000804 <parsepipe>:
{
     804:	55                   	push   %ebp
     805:	89 e5                	mov    %esp,%ebp
     807:	57                   	push   %edi
     808:	56                   	push   %esi
     809:	53                   	push   %ebx
     80a:	83 ec 14             	sub    $0x14,%esp
     80d:	8b 75 08             	mov    0x8(%ebp),%esi
     810:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
     813:	57                   	push   %edi
     814:	56                   	push   %esi
     815:	e8 e6 fe ff ff       	call   700 <parseexec>
     81a:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     81c:	83 c4 0c             	add    $0xc,%esp
     81f:	68 18 11 00 00       	push   $0x1118
     824:	57                   	push   %edi
     825:	56                   	push   %esi
     826:	e8 45 fd ff ff       	call   570 <peek>
     82b:	83 c4 10             	add    $0x10,%esp
     82e:	85 c0                	test   %eax,%eax
     830:	75 0a                	jne    83c <parsepipe+0x38>
}
     832:	89 d8                	mov    %ebx,%eax
     834:	8d 65 f4             	lea    -0xc(%ebp),%esp
     837:	5b                   	pop    %ebx
     838:	5e                   	pop    %esi
     839:	5f                   	pop    %edi
     83a:	5d                   	pop    %ebp
     83b:	c3                   	ret
    gettoken(ps, es, 0, 0);
     83c:	6a 00                	push   $0x0
     83e:	6a 00                	push   $0x0
     840:	57                   	push   %edi
     841:	56                   	push   %esi
     842:	e8 ed fb ff ff       	call   434 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     847:	58                   	pop    %eax
     848:	5a                   	pop    %edx
     849:	57                   	push   %edi
     84a:	56                   	push   %esi
     84b:	e8 b4 ff ff ff       	call   804 <parsepipe>
     850:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     852:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     859:	e8 66 07 00 00       	call   fc4 <malloc>
     85e:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     860:	83 c4 0c             	add    $0xc,%esp
     863:	6a 0c                	push   $0xc
     865:	6a 00                	push   $0x0
     867:	50                   	push   %eax
     868:	e8 03 03 00 00       	call   b70 <memset>
  cmd->type = PIPE;
     86d:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
  cmd->left = left;
     873:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     876:	89 7e 08             	mov    %edi,0x8(%esi)
     879:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     87c:	89 f3                	mov    %esi,%ebx
}
     87e:	89 d8                	mov    %ebx,%eax
     880:	8d 65 f4             	lea    -0xc(%ebp),%esp
     883:	5b                   	pop    %ebx
     884:	5e                   	pop    %esi
     885:	5f                   	pop    %edi
     886:	5d                   	pop    %ebp
     887:	c3                   	ret

00000888 <parseline>:
{
     888:	55                   	push   %ebp
     889:	89 e5                	mov    %esp,%ebp
     88b:	57                   	push   %edi
     88c:	56                   	push   %esi
     88d:	53                   	push   %ebx
     88e:	83 ec 24             	sub    $0x24,%esp
     891:	8b 75 08             	mov    0x8(%ebp),%esi
     894:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     897:	57                   	push   %edi
     898:	56                   	push   %esi
     899:	e8 66 ff ff ff       	call   804 <parsepipe>
     89e:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     8a0:	83 c4 10             	add    $0x10,%esp
     8a3:	eb 3b                	jmp    8e0 <parseline+0x58>
     8a5:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     8a8:	6a 00                	push   $0x0
     8aa:	6a 00                	push   $0x0
     8ac:	57                   	push   %edi
     8ad:	56                   	push   %esi
     8ae:	e8 81 fb ff ff       	call   434 <gettoken>
  cmd = malloc(sizeof(*cmd));
     8b3:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     8ba:	e8 05 07 00 00       	call   fc4 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     8bf:	83 c4 0c             	add    $0xc,%esp
     8c2:	6a 08                	push   $0x8
     8c4:	6a 00                	push   $0x0
     8c6:	50                   	push   %eax
     8c7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     8ca:	e8 a1 02 00 00       	call   b70 <memset>
  cmd->type = BACK;
     8cf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     8d2:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
     8d8:	89 5a 04             	mov    %ebx,0x4(%edx)
     8db:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     8de:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
     8e0:	50                   	push   %eax
     8e1:	68 1a 11 00 00       	push   $0x111a
     8e6:	57                   	push   %edi
     8e7:	56                   	push   %esi
     8e8:	e8 83 fc ff ff       	call   570 <peek>
     8ed:	83 c4 10             	add    $0x10,%esp
     8f0:	85 c0                	test   %eax,%eax
     8f2:	75 b4                	jne    8a8 <parseline+0x20>
  if(peek(ps, es, ";")){
     8f4:	51                   	push   %ecx
     8f5:	68 16 11 00 00       	push   $0x1116
     8fa:	57                   	push   %edi
     8fb:	56                   	push   %esi
     8fc:	e8 6f fc ff ff       	call   570 <peek>
     901:	83 c4 10             	add    $0x10,%esp
     904:	85 c0                	test   %eax,%eax
     906:	75 0c                	jne    914 <parseline+0x8c>
}
     908:	89 d8                	mov    %ebx,%eax
     90a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     90d:	5b                   	pop    %ebx
     90e:	5e                   	pop    %esi
     90f:	5f                   	pop    %edi
     910:	5d                   	pop    %ebp
     911:	c3                   	ret
     912:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     914:	6a 00                	push   $0x0
     916:	6a 00                	push   $0x0
     918:	57                   	push   %edi
     919:	56                   	push   %esi
     91a:	e8 15 fb ff ff       	call   434 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     91f:	58                   	pop    %eax
     920:	5a                   	pop    %edx
     921:	57                   	push   %edi
     922:	56                   	push   %esi
     923:	e8 60 ff ff ff       	call   888 <parseline>
     928:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     92a:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     931:	e8 8e 06 00 00       	call   fc4 <malloc>
     936:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     938:	83 c4 0c             	add    $0xc,%esp
     93b:	6a 0c                	push   $0xc
     93d:	6a 00                	push   $0x0
     93f:	50                   	push   %eax
     940:	e8 2b 02 00 00       	call   b70 <memset>
  cmd->type = LIST;
     945:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
  cmd->left = left;
     94b:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     94e:	89 7e 08             	mov    %edi,0x8(%esi)
     951:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     954:	89 f3                	mov    %esi,%ebx
}
     956:	89 d8                	mov    %ebx,%eax
     958:	8d 65 f4             	lea    -0xc(%ebp),%esp
     95b:	5b                   	pop    %ebx
     95c:	5e                   	pop    %esi
     95d:	5f                   	pop    %edi
     95e:	5d                   	pop    %ebp
     95f:	c3                   	ret

00000960 <parseblock>:
{
     960:	55                   	push   %ebp
     961:	89 e5                	mov    %esp,%ebp
     963:	57                   	push   %edi
     964:	56                   	push   %esi
     965:	53                   	push   %ebx
     966:	83 ec 10             	sub    $0x10,%esp
     969:	8b 5d 08             	mov    0x8(%ebp),%ebx
     96c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     96f:	68 fc 10 00 00       	push   $0x10fc
     974:	56                   	push   %esi
     975:	53                   	push   %ebx
     976:	e8 f5 fb ff ff       	call   570 <peek>
     97b:	83 c4 10             	add    $0x10,%esp
     97e:	85 c0                	test   %eax,%eax
     980:	74 4a                	je     9cc <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     982:	6a 00                	push   $0x0
     984:	6a 00                	push   $0x0
     986:	56                   	push   %esi
     987:	53                   	push   %ebx
     988:	e8 a7 fa ff ff       	call   434 <gettoken>
  cmd = parseline(ps, es);
     98d:	58                   	pop    %eax
     98e:	5a                   	pop    %edx
     98f:	56                   	push   %esi
     990:	53                   	push   %ebx
     991:	e8 f2 fe ff ff       	call   888 <parseline>
     996:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     998:	83 c4 0c             	add    $0xc,%esp
     99b:	68 38 11 00 00       	push   $0x1138
     9a0:	56                   	push   %esi
     9a1:	53                   	push   %ebx
     9a2:	e8 c9 fb ff ff       	call   570 <peek>
     9a7:	83 c4 10             	add    $0x10,%esp
     9aa:	85 c0                	test   %eax,%eax
     9ac:	74 2b                	je     9d9 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     9ae:	6a 00                	push   $0x0
     9b0:	6a 00                	push   $0x0
     9b2:	56                   	push   %esi
     9b3:	53                   	push   %ebx
     9b4:	e8 7b fa ff ff       	call   434 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     9b9:	83 c4 0c             	add    $0xc,%esp
     9bc:	56                   	push   %esi
     9bd:	53                   	push   %ebx
     9be:	57                   	push   %edi
     9bf:	e8 14 fc ff ff       	call   5d8 <parseredirs>
}
     9c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9c7:	5b                   	pop    %ebx
     9c8:	5e                   	pop    %esi
     9c9:	5f                   	pop    %edi
     9ca:	5d                   	pop    %ebp
     9cb:	c3                   	ret
    panic("parseblock");
     9cc:	83 ec 0c             	sub    $0xc,%esp
     9cf:	68 1c 11 00 00       	push   $0x111c
     9d4:	e8 8b f7 ff ff       	call   164 <panic>
    panic("syntax - missing )");
     9d9:	83 ec 0c             	sub    $0xc,%esp
     9dc:	68 27 11 00 00       	push   $0x1127
     9e1:	e8 7e f7 ff ff       	call   164 <panic>
     9e6:	66 90                	xchg   %ax,%ax

000009e8 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     9e8:	55                   	push   %ebp
     9e9:	89 e5                	mov    %esp,%ebp
     9eb:	53                   	push   %ebx
     9ec:	53                   	push   %ebx
     9ed:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     9f0:	85 db                	test   %ebx,%ebx
     9f2:	74 27                	je     a1b <nulterminate+0x33>
    return 0;

  switch(cmd->type){
     9f4:	83 3b 05             	cmpl   $0x5,(%ebx)
     9f7:	77 22                	ja     a1b <nulterminate+0x33>
     9f9:	8b 03                	mov    (%ebx),%eax
     9fb:	ff 24 85 80 11 00 00 	jmp    *0x1180(,%eax,4)
     a02:	66 90                	xchg   %ax,%ax
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     a04:	83 ec 0c             	sub    $0xc,%esp
     a07:	ff 73 04             	push   0x4(%ebx)
     a0a:	e8 d9 ff ff ff       	call   9e8 <nulterminate>
    nulterminate(lcmd->right);
     a0f:	58                   	pop    %eax
     a10:	ff 73 08             	push   0x8(%ebx)
     a13:	e8 d0 ff ff ff       	call   9e8 <nulterminate>
    break;
     a18:	83 c4 10             	add    $0x10,%esp
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a1b:	89 d8                	mov    %ebx,%eax
     a1d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a20:	c9                   	leave
     a21:	c3                   	ret
     a22:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     a24:	83 ec 0c             	sub    $0xc,%esp
     a27:	ff 73 04             	push   0x4(%ebx)
     a2a:	e8 b9 ff ff ff       	call   9e8 <nulterminate>
    break;
     a2f:	83 c4 10             	add    $0x10,%esp
}
     a32:	89 d8                	mov    %ebx,%eax
     a34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a37:	c9                   	leave
     a38:	c3                   	ret
     a39:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     a3c:	8b 4b 04             	mov    0x4(%ebx),%ecx
     a3f:	85 c9                	test   %ecx,%ecx
     a41:	74 d8                	je     a1b <nulterminate+0x33>
     a43:	8d 43 08             	lea    0x8(%ebx),%eax
     a46:	66 90                	xchg   %ax,%ax
      *ecmd->eargv[i] = 0;
     a48:	8b 50 24             	mov    0x24(%eax),%edx
     a4b:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     a4e:	83 c0 04             	add    $0x4,%eax
     a51:	8b 50 fc             	mov    -0x4(%eax),%edx
     a54:	85 d2                	test   %edx,%edx
     a56:	75 f0                	jne    a48 <nulterminate+0x60>
}
     a58:	89 d8                	mov    %ebx,%eax
     a5a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a5d:	c9                   	leave
     a5e:	c3                   	ret
     a5f:	90                   	nop
    nulterminate(rcmd->cmd);
     a60:	83 ec 0c             	sub    $0xc,%esp
     a63:	ff 73 04             	push   0x4(%ebx)
     a66:	e8 7d ff ff ff       	call   9e8 <nulterminate>
    *rcmd->efile = 0;
     a6b:	8b 43 0c             	mov    0xc(%ebx),%eax
     a6e:	c6 00 00             	movb   $0x0,(%eax)
    break;
     a71:	83 c4 10             	add    $0x10,%esp
}
     a74:	89 d8                	mov    %ebx,%eax
     a76:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a79:	c9                   	leave
     a7a:	c3                   	ret
     a7b:	90                   	nop

00000a7c <parsecmd>:
{
     a7c:	55                   	push   %ebp
     a7d:	89 e5                	mov    %esp,%ebp
     a7f:	57                   	push   %edi
     a80:	56                   	push   %esi
     a81:	53                   	push   %ebx
     a82:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
     a85:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a88:	53                   	push   %ebx
     a89:	e8 ba 00 00 00       	call   b48 <strlen>
     a8e:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     a90:	59                   	pop    %ecx
     a91:	5e                   	pop    %esi
     a92:	53                   	push   %ebx
     a93:	8d 7d 08             	lea    0x8(%ebp),%edi
     a96:	57                   	push   %edi
     a97:	e8 ec fd ff ff       	call   888 <parseline>
     a9c:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     a9e:	83 c4 0c             	add    $0xc,%esp
     aa1:	68 c6 10 00 00       	push   $0x10c6
     aa6:	53                   	push   %ebx
     aa7:	57                   	push   %edi
     aa8:	e8 c3 fa ff ff       	call   570 <peek>
  if(s != es){
     aad:	8b 45 08             	mov    0x8(%ebp),%eax
     ab0:	83 c4 10             	add    $0x10,%esp
     ab3:	39 d8                	cmp    %ebx,%eax
     ab5:	75 13                	jne    aca <parsecmd+0x4e>
  nulterminate(cmd);
     ab7:	83 ec 0c             	sub    $0xc,%esp
     aba:	56                   	push   %esi
     abb:	e8 28 ff ff ff       	call   9e8 <nulterminate>
}
     ac0:	89 f0                	mov    %esi,%eax
     ac2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ac5:	5b                   	pop    %ebx
     ac6:	5e                   	pop    %esi
     ac7:	5f                   	pop    %edi
     ac8:	5d                   	pop    %ebp
     ac9:	c3                   	ret
    printf(2, "leftovers: %s\n", s);
     aca:	52                   	push   %edx
     acb:	50                   	push   %eax
     acc:	68 3a 11 00 00       	push   $0x113a
     ad1:	6a 02                	push   $0x2
     ad3:	e8 04 03 00 00       	call   ddc <printf>
    panic("syntax");
     ad8:	c7 04 24 fe 10 00 00 	movl   $0x10fe,(%esp)
     adf:	e8 80 f6 ff ff       	call   164 <panic>

00000ae4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     ae4:	55                   	push   %ebp
     ae5:	89 e5                	mov    %esp,%ebp
     ae7:	53                   	push   %ebx
     ae8:	8b 4d 08             	mov    0x8(%ebp),%ecx
     aeb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     aee:	31 c0                	xor    %eax,%eax
     af0:	8a 14 03             	mov    (%ebx,%eax,1),%dl
     af3:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     af6:	40                   	inc    %eax
     af7:	84 d2                	test   %dl,%dl
     af9:	75 f5                	jne    af0 <strcpy+0xc>
    ;
  return os;
}
     afb:	89 c8                	mov    %ecx,%eax
     afd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b00:	c9                   	leave
     b01:	c3                   	ret
     b02:	66 90                	xchg   %ax,%ax

00000b04 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b04:	55                   	push   %ebp
     b05:	89 e5                	mov    %esp,%ebp
     b07:	53                   	push   %ebx
     b08:	8b 55 08             	mov    0x8(%ebp),%edx
     b0b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
     b0e:	0f b6 02             	movzbl (%edx),%eax
     b11:	84 c0                	test   %al,%al
     b13:	75 10                	jne    b25 <strcmp+0x21>
     b15:	eb 2a                	jmp    b41 <strcmp+0x3d>
     b17:	90                   	nop
    p++, q++;
     b18:	42                   	inc    %edx
     b19:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
     b1c:	0f b6 02             	movzbl (%edx),%eax
     b1f:	84 c0                	test   %al,%al
     b21:	74 11                	je     b34 <strcmp+0x30>
     b23:	89 cb                	mov    %ecx,%ebx
     b25:	0f b6 0b             	movzbl (%ebx),%ecx
     b28:	38 c1                	cmp    %al,%cl
     b2a:	74 ec                	je     b18 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
     b2c:	29 c8                	sub    %ecx,%eax
}
     b2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b31:	c9                   	leave
     b32:	c3                   	ret
     b33:	90                   	nop
  return (uchar)*p - (uchar)*q;
     b34:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
     b38:	31 c0                	xor    %eax,%eax
     b3a:	29 c8                	sub    %ecx,%eax
}
     b3c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b3f:	c9                   	leave
     b40:	c3                   	ret
  return (uchar)*p - (uchar)*q;
     b41:	0f b6 0b             	movzbl (%ebx),%ecx
     b44:	31 c0                	xor    %eax,%eax
     b46:	eb e4                	jmp    b2c <strcmp+0x28>

00000b48 <strlen>:

uint
strlen(const char *s)
{
     b48:	55                   	push   %ebp
     b49:	89 e5                	mov    %esp,%ebp
     b4b:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     b4e:	80 3a 00             	cmpb   $0x0,(%edx)
     b51:	74 15                	je     b68 <strlen+0x20>
     b53:	31 c0                	xor    %eax,%eax
     b55:	8d 76 00             	lea    0x0(%esi),%esi
     b58:	40                   	inc    %eax
     b59:	89 c1                	mov    %eax,%ecx
     b5b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     b5f:	75 f7                	jne    b58 <strlen+0x10>
    ;
  return n;
}
     b61:	89 c8                	mov    %ecx,%eax
     b63:	5d                   	pop    %ebp
     b64:	c3                   	ret
     b65:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     b68:	31 c9                	xor    %ecx,%ecx
}
     b6a:	89 c8                	mov    %ecx,%eax
     b6c:	5d                   	pop    %ebp
     b6d:	c3                   	ret
     b6e:	66 90                	xchg   %ax,%ax

00000b70 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b70:	55                   	push   %ebp
     b71:	89 e5                	mov    %esp,%ebp
     b73:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b74:	8b 7d 08             	mov    0x8(%ebp),%edi
     b77:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b7a:	8b 45 0c             	mov    0xc(%ebp),%eax
     b7d:	fc                   	cld
     b7e:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     b80:	8b 45 08             	mov    0x8(%ebp),%eax
     b83:	8b 7d fc             	mov    -0x4(%ebp),%edi
     b86:	c9                   	leave
     b87:	c3                   	ret

00000b88 <strchr>:

char*
strchr(const char *s, char c)
{
     b88:	55                   	push   %ebp
     b89:	89 e5                	mov    %esp,%ebp
     b8b:	8b 45 08             	mov    0x8(%ebp),%eax
     b8e:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
     b91:	8a 10                	mov    (%eax),%dl
     b93:	84 d2                	test   %dl,%dl
     b95:	75 0c                	jne    ba3 <strchr+0x1b>
     b97:	eb 13                	jmp    bac <strchr+0x24>
     b99:	8d 76 00             	lea    0x0(%esi),%esi
     b9c:	40                   	inc    %eax
     b9d:	8a 10                	mov    (%eax),%dl
     b9f:	84 d2                	test   %dl,%dl
     ba1:	74 09                	je     bac <strchr+0x24>
    if(*s == c)
     ba3:	38 d1                	cmp    %dl,%cl
     ba5:	75 f5                	jne    b9c <strchr+0x14>
      return (char*)s;
  return 0;
}
     ba7:	5d                   	pop    %ebp
     ba8:	c3                   	ret
     ba9:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
     bac:	31 c0                	xor    %eax,%eax
}
     bae:	5d                   	pop    %ebp
     baf:	c3                   	ret

00000bb0 <gets>:

char*
gets(char *buf, int max)
{
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	57                   	push   %edi
     bb4:	56                   	push   %esi
     bb5:	53                   	push   %ebx
     bb6:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bb9:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
     bbb:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i=0; i+1 < max; ){
     bbe:	eb 24                	jmp    be4 <gets+0x34>
    cc = read(0, &c, 1);
     bc0:	50                   	push   %eax
     bc1:	6a 01                	push   $0x1
     bc3:	56                   	push   %esi
     bc4:	6a 00                	push   $0x0
     bc6:	e8 f4 00 00 00       	call   cbf <read>
    if(cc < 1)
     bcb:	83 c4 10             	add    $0x10,%esp
     bce:	85 c0                	test   %eax,%eax
     bd0:	7e 1a                	jle    bec <gets+0x3c>
      break;
    buf[i++] = c;
     bd2:	8a 45 e7             	mov    -0x19(%ebp),%al
     bd5:	8b 55 08             	mov    0x8(%ebp),%edx
     bd8:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     bdc:	3c 0a                	cmp    $0xa,%al
     bde:	74 0e                	je     bee <gets+0x3e>
     be0:	3c 0d                	cmp    $0xd,%al
     be2:	74 0a                	je     bee <gets+0x3e>
  for(i=0; i+1 < max; ){
     be4:	89 df                	mov    %ebx,%edi
     be6:	43                   	inc    %ebx
     be7:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     bea:	7c d4                	jl     bc0 <gets+0x10>
     bec:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
     bee:	8b 45 08             	mov    0x8(%ebp),%eax
     bf1:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
     bf5:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bf8:	5b                   	pop    %ebx
     bf9:	5e                   	pop    %esi
     bfa:	5f                   	pop    %edi
     bfb:	5d                   	pop    %ebp
     bfc:	c3                   	ret
     bfd:	8d 76 00             	lea    0x0(%esi),%esi

00000c00 <stat>:

int
stat(const char *n, struct stat *st)
{
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	56                   	push   %esi
     c04:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c05:	83 ec 08             	sub    $0x8,%esp
     c08:	6a 00                	push   $0x0
     c0a:	ff 75 08             	push   0x8(%ebp)
     c0d:	e8 d5 00 00 00       	call   ce7 <open>
  if(fd < 0)
     c12:	83 c4 10             	add    $0x10,%esp
     c15:	85 c0                	test   %eax,%eax
     c17:	78 27                	js     c40 <stat+0x40>
     c19:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
     c1b:	83 ec 08             	sub    $0x8,%esp
     c1e:	ff 75 0c             	push   0xc(%ebp)
     c21:	50                   	push   %eax
     c22:	e8 d8 00 00 00       	call   cff <fstat>
     c27:	89 c6                	mov    %eax,%esi
  close(fd);
     c29:	89 1c 24             	mov    %ebx,(%esp)
     c2c:	e8 9e 00 00 00       	call   ccf <close>
  return r;
     c31:	83 c4 10             	add    $0x10,%esp
}
     c34:	89 f0                	mov    %esi,%eax
     c36:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c39:	5b                   	pop    %ebx
     c3a:	5e                   	pop    %esi
     c3b:	5d                   	pop    %ebp
     c3c:	c3                   	ret
     c3d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     c40:	be ff ff ff ff       	mov    $0xffffffff,%esi
     c45:	eb ed                	jmp    c34 <stat+0x34>
     c47:	90                   	nop

00000c48 <atoi>:

int
atoi(const char *s)
{
     c48:	55                   	push   %ebp
     c49:	89 e5                	mov    %esp,%ebp
     c4b:	53                   	push   %ebx
     c4c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     c4f:	0f be 01             	movsbl (%ecx),%eax
     c52:	8d 50 d0             	lea    -0x30(%eax),%edx
     c55:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
     c58:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
     c5d:	77 16                	ja     c75 <atoi+0x2d>
     c5f:	90                   	nop
    n = n*10 + *s++ - '0';
     c60:	41                   	inc    %ecx
     c61:	8d 14 92             	lea    (%edx,%edx,4),%edx
     c64:	01 d2                	add    %edx,%edx
     c66:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
     c6a:	0f be 01             	movsbl (%ecx),%eax
     c6d:	8d 58 d0             	lea    -0x30(%eax),%ebx
     c70:	80 fb 09             	cmp    $0x9,%bl
     c73:	76 eb                	jbe    c60 <atoi+0x18>
  return n;
}
     c75:	89 d0                	mov    %edx,%eax
     c77:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c7a:	c9                   	leave
     c7b:	c3                   	ret

00000c7c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     c7c:	55                   	push   %ebp
     c7d:	89 e5                	mov    %esp,%ebp
     c7f:	57                   	push   %edi
     c80:	56                   	push   %esi
     c81:	8b 55 08             	mov    0x8(%ebp),%edx
     c84:	8b 75 0c             	mov    0xc(%ebp),%esi
     c87:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     c8a:	85 c0                	test   %eax,%eax
     c8c:	7e 0b                	jle    c99 <memmove+0x1d>
     c8e:	01 d0                	add    %edx,%eax
  dst = vdst;
     c90:	89 d7                	mov    %edx,%edi
     c92:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
     c94:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     c95:	39 f8                	cmp    %edi,%eax
     c97:	75 fb                	jne    c94 <memmove+0x18>
  return vdst;
}
     c99:	89 d0                	mov    %edx,%eax
     c9b:	5e                   	pop    %esi
     c9c:	5f                   	pop    %edi
     c9d:	5d                   	pop    %ebp
     c9e:	c3                   	ret

00000c9f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     c9f:	b8 01 00 00 00       	mov    $0x1,%eax
     ca4:	cd 40                	int    $0x40
     ca6:	c3                   	ret

00000ca7 <exit>:
SYSCALL(exit)
     ca7:	b8 02 00 00 00       	mov    $0x2,%eax
     cac:	cd 40                	int    $0x40
     cae:	c3                   	ret

00000caf <wait>:
SYSCALL(wait)
     caf:	b8 03 00 00 00       	mov    $0x3,%eax
     cb4:	cd 40                	int    $0x40
     cb6:	c3                   	ret

00000cb7 <pipe>:
SYSCALL(pipe)
     cb7:	b8 04 00 00 00       	mov    $0x4,%eax
     cbc:	cd 40                	int    $0x40
     cbe:	c3                   	ret

00000cbf <read>:
SYSCALL(read)
     cbf:	b8 05 00 00 00       	mov    $0x5,%eax
     cc4:	cd 40                	int    $0x40
     cc6:	c3                   	ret

00000cc7 <write>:
SYSCALL(write)
     cc7:	b8 10 00 00 00       	mov    $0x10,%eax
     ccc:	cd 40                	int    $0x40
     cce:	c3                   	ret

00000ccf <close>:
SYSCALL(close)
     ccf:	b8 15 00 00 00       	mov    $0x15,%eax
     cd4:	cd 40                	int    $0x40
     cd6:	c3                   	ret

00000cd7 <kill>:
SYSCALL(kill)
     cd7:	b8 06 00 00 00       	mov    $0x6,%eax
     cdc:	cd 40                	int    $0x40
     cde:	c3                   	ret

00000cdf <exec>:
SYSCALL(exec)
     cdf:	b8 07 00 00 00       	mov    $0x7,%eax
     ce4:	cd 40                	int    $0x40
     ce6:	c3                   	ret

00000ce7 <open>:
SYSCALL(open)
     ce7:	b8 0f 00 00 00       	mov    $0xf,%eax
     cec:	cd 40                	int    $0x40
     cee:	c3                   	ret

00000cef <mknod>:
SYSCALL(mknod)
     cef:	b8 11 00 00 00       	mov    $0x11,%eax
     cf4:	cd 40                	int    $0x40
     cf6:	c3                   	ret

00000cf7 <unlink>:
SYSCALL(unlink)
     cf7:	b8 12 00 00 00       	mov    $0x12,%eax
     cfc:	cd 40                	int    $0x40
     cfe:	c3                   	ret

00000cff <fstat>:
SYSCALL(fstat)
     cff:	b8 08 00 00 00       	mov    $0x8,%eax
     d04:	cd 40                	int    $0x40
     d06:	c3                   	ret

00000d07 <link>:
SYSCALL(link)
     d07:	b8 13 00 00 00       	mov    $0x13,%eax
     d0c:	cd 40                	int    $0x40
     d0e:	c3                   	ret

00000d0f <mkdir>:
SYSCALL(mkdir)
     d0f:	b8 14 00 00 00       	mov    $0x14,%eax
     d14:	cd 40                	int    $0x40
     d16:	c3                   	ret

00000d17 <chdir>:
SYSCALL(chdir)
     d17:	b8 09 00 00 00       	mov    $0x9,%eax
     d1c:	cd 40                	int    $0x40
     d1e:	c3                   	ret

00000d1f <dup>:
SYSCALL(dup)
     d1f:	b8 0a 00 00 00       	mov    $0xa,%eax
     d24:	cd 40                	int    $0x40
     d26:	c3                   	ret

00000d27 <getpid>:
SYSCALL(getpid)
     d27:	b8 0b 00 00 00       	mov    $0xb,%eax
     d2c:	cd 40                	int    $0x40
     d2e:	c3                   	ret

00000d2f <sbrk>:
SYSCALL(sbrk)
     d2f:	b8 0c 00 00 00       	mov    $0xc,%eax
     d34:	cd 40                	int    $0x40
     d36:	c3                   	ret

00000d37 <sleep>:
SYSCALL(sleep)
     d37:	b8 0d 00 00 00       	mov    $0xd,%eax
     d3c:	cd 40                	int    $0x40
     d3e:	c3                   	ret

00000d3f <uptime>:
SYSCALL(uptime)
     d3f:	b8 0e 00 00 00       	mov    $0xe,%eax
     d44:	cd 40                	int    $0x40
     d46:	c3                   	ret

00000d47 <countfp>:
SYSCALL(countfp)
     d47:	b8 16 00 00 00       	mov    $0x16,%eax
     d4c:	cd 40                	int    $0x40
     d4e:	c3                   	ret
     d4f:	90                   	nop

00000d50 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	57                   	push   %edi
     d54:	56                   	push   %esi
     d55:	53                   	push   %ebx
     d56:	83 ec 3c             	sub    $0x3c,%esp
     d59:	89 45 c0             	mov    %eax,-0x40(%ebp)
     d5c:	89 cb                	mov    %ecx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     d5e:	8b 4d 08             	mov    0x8(%ebp),%ecx
     d61:	85 c9                	test   %ecx,%ecx
     d63:	74 04                	je     d69 <printint+0x19>
     d65:	85 d2                	test   %edx,%edx
     d67:	78 6b                	js     dd4 <printint+0x84>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     d69:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  neg = 0;
     d6c:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  }

  i = 0;
     d73:	31 c9                	xor    %ecx,%ecx
     d75:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
     d78:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     d7b:	31 d2                	xor    %edx,%edx
     d7d:	f7 f3                	div    %ebx
     d7f:	89 cf                	mov    %ecx,%edi
     d81:	8d 49 01             	lea    0x1(%ecx),%ecx
     d84:	8a 92 f0 11 00 00    	mov    0x11f0(%edx),%dl
     d8a:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
  }while((x /= base) != 0);
     d8e:	8b 55 c4             	mov    -0x3c(%ebp),%edx
     d91:	89 45 c4             	mov    %eax,-0x3c(%ebp)
     d94:	39 da                	cmp    %ebx,%edx
     d96:	73 e0                	jae    d78 <printint+0x28>
  if(neg)
     d98:	8b 55 08             	mov    0x8(%ebp),%edx
     d9b:	85 d2                	test   %edx,%edx
     d9d:	74 07                	je     da6 <printint+0x56>
    buf[i++] = '-';
     d9f:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)

  while(--i >= 0)
     da4:	89 cf                	mov    %ecx,%edi
     da6:	8d 5d d8             	lea    -0x28(%ebp),%ebx
     da9:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
     dad:	8d 76 00             	lea    0x0(%esi),%esi
    putc(fd, buf[i]);
     db0:	8a 07                	mov    (%edi),%al
     db2:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
     db5:	50                   	push   %eax
     db6:	6a 01                	push   $0x1
     db8:	56                   	push   %esi
     db9:	ff 75 c0             	push   -0x40(%ebp)
     dbc:	e8 06 ff ff ff       	call   cc7 <write>
  while(--i >= 0)
     dc1:	89 f8                	mov    %edi,%eax
     dc3:	4f                   	dec    %edi
     dc4:	83 c4 10             	add    $0x10,%esp
     dc7:	39 c3                	cmp    %eax,%ebx
     dc9:	75 e5                	jne    db0 <printint+0x60>
}
     dcb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     dce:	5b                   	pop    %ebx
     dcf:	5e                   	pop    %esi
     dd0:	5f                   	pop    %edi
     dd1:	5d                   	pop    %ebp
     dd2:	c3                   	ret
     dd3:	90                   	nop
    x = -xx;
     dd4:	f7 da                	neg    %edx
     dd6:	89 55 c4             	mov    %edx,-0x3c(%ebp)
     dd9:	eb 98                	jmp    d73 <printint+0x23>
     ddb:	90                   	nop

00000ddc <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     ddc:	55                   	push   %ebp
     ddd:	89 e5                	mov    %esp,%ebp
     ddf:	57                   	push   %edi
     de0:	56                   	push   %esi
     de1:	53                   	push   %ebx
     de2:	83 ec 2c             	sub    $0x2c,%esp
     de5:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     de8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     deb:	8a 13                	mov    (%ebx),%dl
     ded:	84 d2                	test   %dl,%dl
     def:	74 5c                	je     e4d <printf+0x71>
     df1:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
     df2:	8d 45 10             	lea    0x10(%ebp),%eax
     df5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
     df8:	31 ff                	xor    %edi,%edi
     dfa:	eb 20                	jmp    e1c <printf+0x40>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     dfc:	83 f8 25             	cmp    $0x25,%eax
     dff:	74 3f                	je     e40 <printf+0x64>
        state = '%';
      } else {
        putc(fd, c);
     e01:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
     e04:	50                   	push   %eax
     e05:	6a 01                	push   $0x1
     e07:	8d 45 e7             	lea    -0x19(%ebp),%eax
     e0a:	50                   	push   %eax
     e0b:	56                   	push   %esi
     e0c:	e8 b6 fe ff ff       	call   cc7 <write>
        putc(fd, c);
     e11:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     e14:	43                   	inc    %ebx
     e15:	8a 53 ff             	mov    -0x1(%ebx),%dl
     e18:	84 d2                	test   %dl,%dl
     e1a:	74 31                	je     e4d <printf+0x71>
    c = fmt[i] & 0xff;
     e1c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
     e1f:	85 ff                	test   %edi,%edi
     e21:	74 d9                	je     dfc <printf+0x20>
      }
    } else if(state == '%'){
     e23:	83 ff 25             	cmp    $0x25,%edi
     e26:	75 ec                	jne    e14 <printf+0x38>
      if(c == 'd'){
     e28:	83 f8 25             	cmp    $0x25,%eax
     e2b:	0f 84 f3 00 00 00    	je     f24 <printf+0x148>
     e31:	83 e8 63             	sub    $0x63,%eax
     e34:	83 f8 15             	cmp    $0x15,%eax
     e37:	77 1f                	ja     e58 <printf+0x7c>
     e39:	ff 24 85 98 11 00 00 	jmp    *0x1198(,%eax,4)
        state = '%';
     e40:	bf 25 00 00 00       	mov    $0x25,%edi
  for(i = 0; fmt[i]; i++){
     e45:	43                   	inc    %ebx
     e46:	8a 53 ff             	mov    -0x1(%ebx),%dl
     e49:	84 d2                	test   %dl,%dl
     e4b:	75 cf                	jne    e1c <printf+0x40>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     e4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e50:	5b                   	pop    %ebx
     e51:	5e                   	pop    %esi
     e52:	5f                   	pop    %edi
     e53:	5d                   	pop    %ebp
     e54:	c3                   	ret
     e55:	8d 76 00             	lea    0x0(%esi),%esi
     e58:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
     e5b:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
     e5f:	50                   	push   %eax
     e60:	6a 01                	push   $0x1
     e62:	8d 7d e7             	lea    -0x19(%ebp),%edi
     e65:	57                   	push   %edi
     e66:	56                   	push   %esi
     e67:	e8 5b fe ff ff       	call   cc7 <write>
        putc(fd, c);
     e6c:	8a 55 d0             	mov    -0x30(%ebp),%dl
     e6f:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
     e72:	83 c4 0c             	add    $0xc,%esp
     e75:	6a 01                	push   $0x1
     e77:	57                   	push   %edi
     e78:	56                   	push   %esi
     e79:	e8 49 fe ff ff       	call   cc7 <write>
        putc(fd, c);
     e7e:	83 c4 10             	add    $0x10,%esp
      state = 0;
     e81:	31 ff                	xor    %edi,%edi
     e83:	eb 8f                	jmp    e14 <printf+0x38>
     e85:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
     e88:	8b 7d d4             	mov    -0x2c(%ebp),%edi
     e8b:	8b 17                	mov    (%edi),%edx
     e8d:	83 ec 0c             	sub    $0xc,%esp
     e90:	6a 00                	push   $0x0
     e92:	b9 10 00 00 00       	mov    $0x10,%ecx
     e97:	89 f0                	mov    %esi,%eax
     e99:	e8 b2 fe ff ff       	call   d50 <printint>
        ap++;
     e9e:	83 c7 04             	add    $0x4,%edi
     ea1:	89 7d d4             	mov    %edi,-0x2c(%ebp)
     ea4:	83 c4 10             	add    $0x10,%esp
      state = 0;
     ea7:	31 ff                	xor    %edi,%edi
        ap++;
     ea9:	e9 66 ff ff ff       	jmp    e14 <printf+0x38>
        s = (char*)*ap;
     eae:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     eb1:	8b 10                	mov    (%eax),%edx
        ap++;
     eb3:	83 c0 04             	add    $0x4,%eax
     eb6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
     eb9:	85 d2                	test   %edx,%edx
     ebb:	74 77                	je     f34 <printf+0x158>
        while(*s != 0){
     ebd:	8a 02                	mov    (%edx),%al
     ebf:	84 c0                	test   %al,%al
     ec1:	74 7a                	je     f3d <printf+0x161>
     ec3:	8d 7d e7             	lea    -0x19(%ebp),%edi
     ec6:	89 5d d0             	mov    %ebx,-0x30(%ebp)
     ec9:	89 d3                	mov    %edx,%ebx
     ecb:	90                   	nop
          putc(fd, *s);
     ecc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
     ecf:	50                   	push   %eax
     ed0:	6a 01                	push   $0x1
     ed2:	57                   	push   %edi
     ed3:	56                   	push   %esi
     ed4:	e8 ee fd ff ff       	call   cc7 <write>
          s++;
     ed9:	43                   	inc    %ebx
        while(*s != 0){
     eda:	8a 03                	mov    (%ebx),%al
     edc:	83 c4 10             	add    $0x10,%esp
     edf:	84 c0                	test   %al,%al
     ee1:	75 e9                	jne    ecc <printf+0xf0>
      state = 0;
     ee3:	8b 5d d0             	mov    -0x30(%ebp),%ebx
     ee6:	31 ff                	xor    %edi,%edi
     ee8:	e9 27 ff ff ff       	jmp    e14 <printf+0x38>
        printint(fd, *ap, 10, 1);
     eed:	8b 7d d4             	mov    -0x2c(%ebp),%edi
     ef0:	8b 17                	mov    (%edi),%edx
     ef2:	83 ec 0c             	sub    $0xc,%esp
     ef5:	6a 01                	push   $0x1
     ef7:	b9 0a 00 00 00       	mov    $0xa,%ecx
     efc:	eb 99                	jmp    e97 <printf+0xbb>
        putc(fd, *ap);
     efe:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     f01:	8b 00                	mov    (%eax),%eax
     f03:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
     f06:	51                   	push   %ecx
     f07:	6a 01                	push   $0x1
     f09:	8d 7d e7             	lea    -0x19(%ebp),%edi
     f0c:	57                   	push   %edi
     f0d:	56                   	push   %esi
     f0e:	e8 b4 fd ff ff       	call   cc7 <write>
        ap++;
     f13:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
     f17:	83 c4 10             	add    $0x10,%esp
      state = 0;
     f1a:	31 ff                	xor    %edi,%edi
     f1c:	e9 f3 fe ff ff       	jmp    e14 <printf+0x38>
     f21:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
     f24:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
     f27:	52                   	push   %edx
     f28:	6a 01                	push   $0x1
     f2a:	8d 7d e7             	lea    -0x19(%ebp),%edi
     f2d:	e9 45 ff ff ff       	jmp    e77 <printf+0x9b>
     f32:	66 90                	xchg   %ax,%ax
     f34:	b0 28                	mov    $0x28,%al
          s = "(null)";
     f36:	ba 5f 11 00 00       	mov    $0x115f,%edx
     f3b:	eb 86                	jmp    ec3 <printf+0xe7>
      state = 0;
     f3d:	31 ff                	xor    %edi,%edi
     f3f:	e9 d0 fe ff ff       	jmp    e14 <printf+0x38>

00000f44 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     f44:	55                   	push   %ebp
     f45:	89 e5                	mov    %esp,%ebp
     f47:	57                   	push   %edi
     f48:	56                   	push   %esi
     f49:	53                   	push   %ebx
     f4a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
     f4d:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f50:	a1 84 12 00 00       	mov    0x1284,%eax
     f55:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f58:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f5a:	39 c8                	cmp    %ecx,%eax
     f5c:	73 2e                	jae    f8c <free+0x48>
     f5e:	39 d1                	cmp    %edx,%ecx
     f60:	72 04                	jb     f66 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f62:	39 d0                	cmp    %edx,%eax
     f64:	72 2e                	jb     f94 <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
     f66:	8b 73 fc             	mov    -0x4(%ebx),%esi
     f69:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
     f6c:	39 fa                	cmp    %edi,%edx
     f6e:	74 28                	je     f98 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
     f70:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
     f73:	8b 50 04             	mov    0x4(%eax),%edx
     f76:	8d 34 d0             	lea    (%eax,%edx,8),%esi
     f79:	39 f1                	cmp    %esi,%ecx
     f7b:	74 32                	je     faf <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
     f7d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
     f7f:	a3 84 12 00 00       	mov    %eax,0x1284
}
     f84:	5b                   	pop    %ebx
     f85:	5e                   	pop    %esi
     f86:	5f                   	pop    %edi
     f87:	5d                   	pop    %ebp
     f88:	c3                   	ret
     f89:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f8c:	39 d0                	cmp    %edx,%eax
     f8e:	72 04                	jb     f94 <free+0x50>
     f90:	39 d1                	cmp    %edx,%ecx
     f92:	72 d2                	jb     f66 <free+0x22>
{
     f94:	89 d0                	mov    %edx,%eax
     f96:	eb c0                	jmp    f58 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
     f98:	03 72 04             	add    0x4(%edx),%esi
     f9b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
     f9e:	8b 10                	mov    (%eax),%edx
     fa0:	8b 12                	mov    (%edx),%edx
     fa2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
     fa5:	8b 50 04             	mov    0x4(%eax),%edx
     fa8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
     fab:	39 f1                	cmp    %esi,%ecx
     fad:	75 ce                	jne    f7d <free+0x39>
    p->s.size += bp->s.size;
     faf:	03 53 fc             	add    -0x4(%ebx),%edx
     fb2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     fb5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
     fb8:	89 08                	mov    %ecx,(%eax)
  freep = p;
     fba:	a3 84 12 00 00       	mov    %eax,0x1284
}
     fbf:	5b                   	pop    %ebx
     fc0:	5e                   	pop    %esi
     fc1:	5f                   	pop    %edi
     fc2:	5d                   	pop    %ebp
     fc3:	c3                   	ret

00000fc4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
     fc4:	55                   	push   %ebp
     fc5:	89 e5                	mov    %esp,%ebp
     fc7:	57                   	push   %edi
     fc8:	56                   	push   %esi
     fc9:	53                   	push   %ebx
     fca:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     fcd:	8b 45 08             	mov    0x8(%ebp),%eax
     fd0:	8d 78 07             	lea    0x7(%eax),%edi
     fd3:	c1 ef 03             	shr    $0x3,%edi
     fd6:	47                   	inc    %edi
  if((prevp = freep) == 0){
     fd7:	8b 15 84 12 00 00    	mov    0x1284,%edx
     fdd:	85 d2                	test   %edx,%edx
     fdf:	0f 84 93 00 00 00    	je     1078 <malloc+0xb4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fe5:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
     fe7:	8b 48 04             	mov    0x4(%eax),%ecx
     fea:	39 f9                	cmp    %edi,%ecx
     fec:	73 62                	jae    1050 <malloc+0x8c>
  if(nu < 4096)
     fee:	89 fb                	mov    %edi,%ebx
     ff0:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
     ff6:	72 78                	jb     1070 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
     ff8:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
     fff:	eb 0e                	jmp    100f <malloc+0x4b>
    1001:	8d 76 00             	lea    0x0(%esi),%esi
    1004:	89 c2                	mov    %eax,%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1006:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1008:	8b 48 04             	mov    0x4(%eax),%ecx
    100b:	39 f9                	cmp    %edi,%ecx
    100d:	73 41                	jae    1050 <malloc+0x8c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    100f:	3b 05 84 12 00 00    	cmp    0x1284,%eax
    1015:	75 ed                	jne    1004 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    1017:	83 ec 0c             	sub    $0xc,%esp
    101a:	56                   	push   %esi
    101b:	e8 0f fd ff ff       	call   d2f <sbrk>
  if(p == (char*)-1)
    1020:	83 c4 10             	add    $0x10,%esp
    1023:	83 f8 ff             	cmp    $0xffffffff,%eax
    1026:	74 1c                	je     1044 <malloc+0x80>
  hp->s.size = nu;
    1028:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    102b:	83 ec 0c             	sub    $0xc,%esp
    102e:	83 c0 08             	add    $0x8,%eax
    1031:	50                   	push   %eax
    1032:	e8 0d ff ff ff       	call   f44 <free>
  return freep;
    1037:	8b 15 84 12 00 00    	mov    0x1284,%edx
      if((p = morecore(nunits)) == 0)
    103d:	83 c4 10             	add    $0x10,%esp
    1040:	85 d2                	test   %edx,%edx
    1042:	75 c2                	jne    1006 <malloc+0x42>
        return 0;
    1044:	31 c0                	xor    %eax,%eax
  }
}
    1046:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1049:	5b                   	pop    %ebx
    104a:	5e                   	pop    %esi
    104b:	5f                   	pop    %edi
    104c:	5d                   	pop    %ebp
    104d:	c3                   	ret
    104e:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
    1050:	39 cf                	cmp    %ecx,%edi
    1052:	74 4c                	je     10a0 <malloc+0xdc>
        p->s.size -= nunits;
    1054:	29 f9                	sub    %edi,%ecx
    1056:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1059:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    105c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    105f:	89 15 84 12 00 00    	mov    %edx,0x1284
      return (void*)(p + 1);
    1065:	83 c0 08             	add    $0x8,%eax
}
    1068:	8d 65 f4             	lea    -0xc(%ebp),%esp
    106b:	5b                   	pop    %ebx
    106c:	5e                   	pop    %esi
    106d:	5f                   	pop    %edi
    106e:	5d                   	pop    %ebp
    106f:	c3                   	ret
  if(nu < 4096)
    1070:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1075:	eb 81                	jmp    ff8 <malloc+0x34>
    1077:	90                   	nop
    base.s.ptr = freep = prevp = &base;
    1078:	c7 05 84 12 00 00 88 	movl   $0x1288,0x1284
    107f:	12 00 00 
    1082:	c7 05 88 12 00 00 88 	movl   $0x1288,0x1288
    1089:	12 00 00 
    base.s.size = 0;
    108c:	c7 05 8c 12 00 00 00 	movl   $0x0,0x128c
    1093:	00 00 00 
    1096:	b8 88 12 00 00       	mov    $0x1288,%eax
    109b:	e9 4e ff ff ff       	jmp    fee <malloc+0x2a>
        prevp->s.ptr = p->s.ptr;
    10a0:	8b 08                	mov    (%eax),%ecx
    10a2:	89 0a                	mov    %ecx,(%edx)
    10a4:	eb b9                	jmp    105f <malloc+0x9b>
