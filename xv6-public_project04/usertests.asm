
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
      11:	68 7e 49 00 00       	push   $0x497e
      16:	6a 01                	push   $0x1
      18:	e8 a7 36 00 00       	call   36c4 <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	59                   	pop    %ecx
      1e:	58                   	pop    %eax
      1f:	6a 00                	push   $0x0
      21:	68 92 49 00 00       	push   $0x4992
      26:	e8 a4 35 00 00       	call   35cf <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 13                	js     45 <main+0x45>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      32:	52                   	push   %edx
      33:	52                   	push   %edx
      34:	68 04 51 00 00       	push   $0x5104
      39:	6a 01                	push   $0x1
      3b:	e8 84 36 00 00       	call   36c4 <printf>
    exit();
      40:	e8 4a 35 00 00       	call   358f <exit>
  }
  close(open("usertests.ran", O_CREATE));
      45:	50                   	push   %eax
      46:	50                   	push   %eax
      47:	68 00 02 00 00       	push   $0x200
      4c:	68 92 49 00 00       	push   $0x4992
      51:	e8 79 35 00 00       	call   35cf <open>
      56:	89 04 24             	mov    %eax,(%esp)
      59:	e8 59 35 00 00       	call   35b7 <close>

  argptest();
      5e:	e8 dd 32 00 00       	call   3340 <argptest>
  createdelete();
      63:	e8 ac 10 00 00       	call   1114 <createdelete>
  linkunlink();
      68:	e8 a7 18 00 00       	call   1914 <linkunlink>
  concreate();
      6d:	e8 ea 15 00 00       	call   165c <concreate>
  fourfiles();
      72:	e8 c5 0e 00 00       	call   f3c <fourfiles>
  sharedfd();
      77:	e8 28 0d 00 00       	call   da4 <sharedfd>

  bigargtest();
      7c:	e8 af 2f 00 00       	call   3030 <bigargtest>
  bigwrite();
      81:	e8 a2 21 00 00       	call   2228 <bigwrite>
  bigargtest();
      86:	e8 a5 2f 00 00       	call   3030 <bigargtest>
  bsstest();
      8b:	e8 40 2f 00 00       	call   2fd0 <bsstest>
  sbrktest();
      90:	e8 73 2a 00 00       	call   2b08 <sbrktest>
  validatetest();
      95:	e8 8a 2e 00 00       	call   2f24 <validatetest>

  opentest();
      9a:	e8 39 03 00 00       	call   3d8 <opentest>
  writetest();
      9f:	e8 c4 03 00 00       	call   468 <writetest>
  writetest1();
      a4:	e8 8b 05 00 00       	call   634 <writetest1>
  createtest();
      a9:	e8 32 07 00 00       	call   7e0 <createtest>

  openiputtest();
      ae:	e8 35 02 00 00       	call   2e8 <openiputtest>
  exitiputtest();
      b3:	e8 3c 01 00 00       	call   1f4 <exitiputtest>
  iputtest();
      b8:	e8 57 00 00 00       	call   114 <iputtest>

  mem();
      bd:	e8 2a 0c 00 00       	call   cec <mem>
  pipe1();
      c2:	e8 e1 08 00 00       	call   9a8 <pipe1>
  preempt();
      c7:	e8 68 0a 00 00       	call   b34 <preempt>
  exitwait();
      cc:	e8 a3 0b 00 00       	call   c74 <exitwait>

  rmdot();
      d1:	e8 12 25 00 00       	call   25e8 <rmdot>
  fourteen();
      d6:	e8 d9 23 00 00       	call   24b4 <fourteen>
  bigfile();
      db:	e8 1c 22 00 00       	call   22fc <bigfile>
  subdir();
      e0:	e8 6b 1a 00 00       	call   1b50 <subdir>
  linktest();
      e5:	e8 66 13 00 00       	call   1450 <linktest>
  unlinkread();
      ea:	e8 dd 11 00 00       	call   12cc <unlinkread>
  dirfile();
      ef:	e8 68 26 00 00       	call   275c <dirfile>
  iref();
      f4:	e8 5b 28 00 00       	call   2954 <iref>
  forktest();
      f9:	e8 6e 29 00 00       	call   2a6c <forktest>
  bigdir(); // slow
      fe:	e8 21 19 00 00       	call   1a24 <bigdir>

  uio();
     103:	e8 c8 31 00 00       	call   32d0 <uio>

  exectest();
     108:	e8 53 08 00 00       	call   960 <exectest>

  exit();
     10d:	e8 7d 34 00 00       	call   358f <exit>
     112:	66 90                	xchg   %ax,%ax

00000114 <iputtest>:
{
     114:	55                   	push   %ebp
     115:	89 e5                	mov    %esp,%ebp
     117:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
     11a:	68 24 3a 00 00       	push   $0x3a24
     11f:	ff 35 b0 51 00 00    	push   0x51b0
     125:	e8 9a 35 00 00       	call   36c4 <printf>
  if(mkdir("iputdir") < 0){
     12a:	c7 04 24 b7 39 00 00 	movl   $0x39b7,(%esp)
     131:	e8 c1 34 00 00       	call   35f7 <mkdir>
     136:	83 c4 10             	add    $0x10,%esp
     139:	85 c0                	test   %eax,%eax
     13b:	78 58                	js     195 <iputtest+0x81>
  if(chdir("iputdir") < 0){
     13d:	83 ec 0c             	sub    $0xc,%esp
     140:	68 b7 39 00 00       	push   $0x39b7
     145:	e8 b5 34 00 00       	call   35ff <chdir>
     14a:	83 c4 10             	add    $0x10,%esp
     14d:	85 c0                	test   %eax,%eax
     14f:	0f 88 85 00 00 00    	js     1da <iputtest+0xc6>
  if(unlink("../iputdir") < 0){
     155:	83 ec 0c             	sub    $0xc,%esp
     158:	68 b4 39 00 00       	push   $0x39b4
     15d:	e8 7d 34 00 00       	call   35df <unlink>
     162:	83 c4 10             	add    $0x10,%esp
     165:	85 c0                	test   %eax,%eax
     167:	78 5a                	js     1c3 <iputtest+0xaf>
  if(chdir("/") < 0){
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	68 d9 39 00 00       	push   $0x39d9
     171:	e8 89 34 00 00       	call   35ff <chdir>
     176:	83 c4 10             	add    $0x10,%esp
     179:	85 c0                	test   %eax,%eax
     17b:	78 2f                	js     1ac <iputtest+0x98>
  printf(stdout, "iput test ok\n");
     17d:	83 ec 08             	sub    $0x8,%esp
     180:	68 5c 3a 00 00       	push   $0x3a5c
     185:	ff 35 b0 51 00 00    	push   0x51b0
     18b:	e8 34 35 00 00       	call   36c4 <printf>
}
     190:	83 c4 10             	add    $0x10,%esp
     193:	c9                   	leave
     194:	c3                   	ret
    printf(stdout, "mkdir failed\n");
     195:	50                   	push   %eax
     196:	50                   	push   %eax
     197:	68 90 39 00 00       	push   $0x3990
     19c:	ff 35 b0 51 00 00    	push   0x51b0
     1a2:	e8 1d 35 00 00       	call   36c4 <printf>
    exit();
     1a7:	e8 e3 33 00 00       	call   358f <exit>
    printf(stdout, "chdir / failed\n");
     1ac:	50                   	push   %eax
     1ad:	50                   	push   %eax
     1ae:	68 db 39 00 00       	push   $0x39db
     1b3:	ff 35 b0 51 00 00    	push   0x51b0
     1b9:	e8 06 35 00 00       	call   36c4 <printf>
    exit();
     1be:	e8 cc 33 00 00       	call   358f <exit>
    printf(stdout, "unlink ../iputdir failed\n");
     1c3:	52                   	push   %edx
     1c4:	52                   	push   %edx
     1c5:	68 bf 39 00 00       	push   $0x39bf
     1ca:	ff 35 b0 51 00 00    	push   0x51b0
     1d0:	e8 ef 34 00 00       	call   36c4 <printf>
    exit();
     1d5:	e8 b5 33 00 00       	call   358f <exit>
    printf(stdout, "chdir iputdir failed\n");
     1da:	51                   	push   %ecx
     1db:	51                   	push   %ecx
     1dc:	68 9e 39 00 00       	push   $0x399e
     1e1:	ff 35 b0 51 00 00    	push   0x51b0
     1e7:	e8 d8 34 00 00       	call   36c4 <printf>
    exit();
     1ec:	e8 9e 33 00 00       	call   358f <exit>
     1f1:	8d 76 00             	lea    0x0(%esi),%esi

000001f4 <exitiputtest>:
{
     1f4:	55                   	push   %ebp
     1f5:	89 e5                	mov    %esp,%ebp
     1f7:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exitiput test\n");
     1fa:	68 eb 39 00 00       	push   $0x39eb
     1ff:	ff 35 b0 51 00 00    	push   0x51b0
     205:	e8 ba 34 00 00       	call   36c4 <printf>
  pid = fork();
     20a:	e8 78 33 00 00       	call   3587 <fork>
  if(pid < 0){
     20f:	83 c4 10             	add    $0x10,%esp
     212:	85 c0                	test   %eax,%eax
     214:	0f 88 86 00 00 00    	js     2a0 <exitiputtest+0xac>
  if(pid == 0){
     21a:	75 4c                	jne    268 <exitiputtest+0x74>
    if(mkdir("iputdir") < 0){
     21c:	83 ec 0c             	sub    $0xc,%esp
     21f:	68 b7 39 00 00       	push   $0x39b7
     224:	e8 ce 33 00 00       	call   35f7 <mkdir>
     229:	83 c4 10             	add    $0x10,%esp
     22c:	85 c0                	test   %eax,%eax
     22e:	0f 88 83 00 00 00    	js     2b7 <exitiputtest+0xc3>
    if(chdir("iputdir") < 0){
     234:	83 ec 0c             	sub    $0xc,%esp
     237:	68 b7 39 00 00       	push   $0x39b7
     23c:	e8 be 33 00 00       	call   35ff <chdir>
     241:	83 c4 10             	add    $0x10,%esp
     244:	85 c0                	test   %eax,%eax
     246:	0f 88 82 00 00 00    	js     2ce <exitiputtest+0xda>
    if(unlink("../iputdir") < 0){
     24c:	83 ec 0c             	sub    $0xc,%esp
     24f:	68 b4 39 00 00       	push   $0x39b4
     254:	e8 86 33 00 00       	call   35df <unlink>
     259:	83 c4 10             	add    $0x10,%esp
     25c:	85 c0                	test   %eax,%eax
     25e:	78 28                	js     288 <exitiputtest+0x94>
    exit();
     260:	e8 2a 33 00 00       	call   358f <exit>
     265:	8d 76 00             	lea    0x0(%esi),%esi
  wait();
     268:	e8 2a 33 00 00       	call   3597 <wait>
  printf(stdout, "exitiput test ok\n");
     26d:	83 ec 08             	sub    $0x8,%esp
     270:	68 0e 3a 00 00       	push   $0x3a0e
     275:	ff 35 b0 51 00 00    	push   0x51b0
     27b:	e8 44 34 00 00       	call   36c4 <printf>
}
     280:	83 c4 10             	add    $0x10,%esp
     283:	c9                   	leave
     284:	c3                   	ret
     285:	8d 76 00             	lea    0x0(%esi),%esi
      printf(stdout, "unlink ../iputdir failed\n");
     288:	83 ec 08             	sub    $0x8,%esp
     28b:	68 bf 39 00 00       	push   $0x39bf
     290:	ff 35 b0 51 00 00    	push   0x51b0
     296:	e8 29 34 00 00       	call   36c4 <printf>
      exit();
     29b:	e8 ef 32 00 00       	call   358f <exit>
    printf(stdout, "fork failed\n");
     2a0:	51                   	push   %ecx
     2a1:	51                   	push   %ecx
     2a2:	68 d1 48 00 00       	push   $0x48d1
     2a7:	ff 35 b0 51 00 00    	push   0x51b0
     2ad:	e8 12 34 00 00       	call   36c4 <printf>
    exit();
     2b2:	e8 d8 32 00 00       	call   358f <exit>
      printf(stdout, "mkdir failed\n");
     2b7:	52                   	push   %edx
     2b8:	52                   	push   %edx
     2b9:	68 90 39 00 00       	push   $0x3990
     2be:	ff 35 b0 51 00 00    	push   0x51b0
     2c4:	e8 fb 33 00 00       	call   36c4 <printf>
      exit();
     2c9:	e8 c1 32 00 00       	call   358f <exit>
      printf(stdout, "child chdir failed\n");
     2ce:	50                   	push   %eax
     2cf:	50                   	push   %eax
     2d0:	68 fa 39 00 00       	push   $0x39fa
     2d5:	ff 35 b0 51 00 00    	push   0x51b0
     2db:	e8 e4 33 00 00       	call   36c4 <printf>
      exit();
     2e0:	e8 aa 32 00 00       	call   358f <exit>
     2e5:	8d 76 00             	lea    0x0(%esi),%esi

000002e8 <openiputtest>:
{
     2e8:	55                   	push   %ebp
     2e9:	89 e5                	mov    %esp,%ebp
     2eb:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "openiput test\n");
     2ee:	68 20 3a 00 00       	push   $0x3a20
     2f3:	ff 35 b0 51 00 00    	push   0x51b0
     2f9:	e8 c6 33 00 00       	call   36c4 <printf>
  if(mkdir("oidir") < 0){
     2fe:	c7 04 24 2f 3a 00 00 	movl   $0x3a2f,(%esp)
     305:	e8 ed 32 00 00       	call   35f7 <mkdir>
     30a:	83 c4 10             	add    $0x10,%esp
     30d:	85 c0                	test   %eax,%eax
     30f:	0f 88 93 00 00 00    	js     3a8 <openiputtest+0xc0>
  pid = fork();
     315:	e8 6d 32 00 00       	call   3587 <fork>
  if(pid < 0){
     31a:	85 c0                	test   %eax,%eax
     31c:	78 73                	js     391 <openiputtest+0xa9>
  if(pid == 0){
     31e:	75 30                	jne    350 <openiputtest+0x68>
    int fd = open("oidir", O_RDWR);
     320:	83 ec 08             	sub    $0x8,%esp
     323:	6a 02                	push   $0x2
     325:	68 2f 3a 00 00       	push   $0x3a2f
     32a:	e8 a0 32 00 00       	call   35cf <open>
    if(fd >= 0){
     32f:	83 c4 10             	add    $0x10,%esp
     332:	85 c0                	test   %eax,%eax
     334:	78 56                	js     38c <openiputtest+0xa4>
      printf(stdout, "open directory for write succeeded\n");
     336:	83 ec 08             	sub    $0x8,%esp
     339:	68 b8 49 00 00       	push   $0x49b8
     33e:	ff 35 b0 51 00 00    	push   0x51b0
     344:	e8 7b 33 00 00       	call   36c4 <printf>
      exit();
     349:	e8 41 32 00 00       	call   358f <exit>
     34e:	66 90                	xchg   %ax,%ax
  sleep(1);
     350:	83 ec 0c             	sub    $0xc,%esp
     353:	6a 01                	push   $0x1
     355:	e8 c5 32 00 00       	call   361f <sleep>
  if(unlink("oidir") != 0){
     35a:	c7 04 24 2f 3a 00 00 	movl   $0x3a2f,(%esp)
     361:	e8 79 32 00 00       	call   35df <unlink>
     366:	83 c4 10             	add    $0x10,%esp
     369:	85 c0                	test   %eax,%eax
     36b:	75 52                	jne    3bf <openiputtest+0xd7>
  wait();
     36d:	e8 25 32 00 00       	call   3597 <wait>
  printf(stdout, "openiput test ok\n");
     372:	83 ec 08             	sub    $0x8,%esp
     375:	68 58 3a 00 00       	push   $0x3a58
     37a:	ff 35 b0 51 00 00    	push   0x51b0
     380:	e8 3f 33 00 00       	call   36c4 <printf>
}
     385:	83 c4 10             	add    $0x10,%esp
     388:	c9                   	leave
     389:	c3                   	ret
     38a:	66 90                	xchg   %ax,%ax
    exit();
     38c:	e8 fe 31 00 00       	call   358f <exit>
    printf(stdout, "fork failed\n");
     391:	52                   	push   %edx
     392:	52                   	push   %edx
     393:	68 d1 48 00 00       	push   $0x48d1
     398:	ff 35 b0 51 00 00    	push   0x51b0
     39e:	e8 21 33 00 00       	call   36c4 <printf>
    exit();
     3a3:	e8 e7 31 00 00       	call   358f <exit>
    printf(stdout, "mkdir oidir failed\n");
     3a8:	51                   	push   %ecx
     3a9:	51                   	push   %ecx
     3aa:	68 35 3a 00 00       	push   $0x3a35
     3af:	ff 35 b0 51 00 00    	push   0x51b0
     3b5:	e8 0a 33 00 00       	call   36c4 <printf>
    exit();
     3ba:	e8 d0 31 00 00       	call   358f <exit>
    printf(stdout, "unlink failed\n");
     3bf:	50                   	push   %eax
     3c0:	50                   	push   %eax
     3c1:	68 49 3a 00 00       	push   $0x3a49
     3c6:	ff 35 b0 51 00 00    	push   0x51b0
     3cc:	e8 f3 32 00 00       	call   36c4 <printf>
    exit();
     3d1:	e8 b9 31 00 00       	call   358f <exit>
     3d6:	66 90                	xchg   %ax,%ax

000003d8 <opentest>:
{
     3d8:	55                   	push   %ebp
     3d9:	89 e5                	mov    %esp,%ebp
     3db:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "open test\n");
     3de:	68 6a 3a 00 00       	push   $0x3a6a
     3e3:	ff 35 b0 51 00 00    	push   0x51b0
     3e9:	e8 d6 32 00 00       	call   36c4 <printf>
  fd = open("echo", 0);
     3ee:	58                   	pop    %eax
     3ef:	5a                   	pop    %edx
     3f0:	6a 00                	push   $0x0
     3f2:	68 75 3a 00 00       	push   $0x3a75
     3f7:	e8 d3 31 00 00       	call   35cf <open>
  if(fd < 0){
     3fc:	83 c4 10             	add    $0x10,%esp
     3ff:	85 c0                	test   %eax,%eax
     401:	78 36                	js     439 <opentest+0x61>
  close(fd);
     403:	83 ec 0c             	sub    $0xc,%esp
     406:	50                   	push   %eax
     407:	e8 ab 31 00 00       	call   35b7 <close>
  fd = open("doesnotexist", 0);
     40c:	5a                   	pop    %edx
     40d:	59                   	pop    %ecx
     40e:	6a 00                	push   $0x0
     410:	68 8d 3a 00 00       	push   $0x3a8d
     415:	e8 b5 31 00 00       	call   35cf <open>
  if(fd >= 0){
     41a:	83 c4 10             	add    $0x10,%esp
     41d:	85 c0                	test   %eax,%eax
     41f:	79 2f                	jns    450 <opentest+0x78>
  printf(stdout, "open test ok\n");
     421:	83 ec 08             	sub    $0x8,%esp
     424:	68 b8 3a 00 00       	push   $0x3ab8
     429:	ff 35 b0 51 00 00    	push   0x51b0
     42f:	e8 90 32 00 00       	call   36c4 <printf>
}
     434:	83 c4 10             	add    $0x10,%esp
     437:	c9                   	leave
     438:	c3                   	ret
    printf(stdout, "open echo failed!\n");
     439:	50                   	push   %eax
     43a:	50                   	push   %eax
     43b:	68 7a 3a 00 00       	push   $0x3a7a
     440:	ff 35 b0 51 00 00    	push   0x51b0
     446:	e8 79 32 00 00       	call   36c4 <printf>
    exit();
     44b:	e8 3f 31 00 00       	call   358f <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     450:	50                   	push   %eax
     451:	50                   	push   %eax
     452:	68 9a 3a 00 00       	push   $0x3a9a
     457:	ff 35 b0 51 00 00    	push   0x51b0
     45d:	e8 62 32 00 00       	call   36c4 <printf>
    exit();
     462:	e8 28 31 00 00       	call   358f <exit>
     467:	90                   	nop

00000468 <writetest>:
{
     468:	55                   	push   %ebp
     469:	89 e5                	mov    %esp,%ebp
     46b:	56                   	push   %esi
     46c:	53                   	push   %ebx
  printf(stdout, "small file test\n");
     46d:	83 ec 08             	sub    $0x8,%esp
     470:	68 c6 3a 00 00       	push   $0x3ac6
     475:	ff 35 b0 51 00 00    	push   0x51b0
     47b:	e8 44 32 00 00       	call   36c4 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     480:	5a                   	pop    %edx
     481:	59                   	pop    %ecx
     482:	68 02 02 00 00       	push   $0x202
     487:	68 d7 3a 00 00       	push   $0x3ad7
     48c:	e8 3e 31 00 00       	call   35cf <open>
  if(fd >= 0){
     491:	83 c4 10             	add    $0x10,%esp
     494:	85 c0                	test   %eax,%eax
     496:	0f 88 7e 01 00 00    	js     61a <writetest+0x1b2>
     49c:	89 c6                	mov    %eax,%esi
    printf(stdout, "creat small succeeded; ok\n");
     49e:	83 ec 08             	sub    $0x8,%esp
     4a1:	68 dd 3a 00 00       	push   $0x3add
     4a6:	ff 35 b0 51 00 00    	push   0x51b0
     4ac:	e8 13 32 00 00       	call   36c4 <printf>
     4b1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
     4b4:	31 db                	xor    %ebx,%ebx
     4b6:	66 90                	xchg   %ax,%ax
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4b8:	50                   	push   %eax
     4b9:	6a 0a                	push   $0xa
     4bb:	68 14 3b 00 00       	push   $0x3b14
     4c0:	56                   	push   %esi
     4c1:	e8 e9 30 00 00       	call   35af <write>
     4c6:	83 c4 10             	add    $0x10,%esp
     4c9:	83 f8 0a             	cmp    $0xa,%eax
     4cc:	0f 85 d5 00 00 00    	jne    5a7 <writetest+0x13f>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4d2:	50                   	push   %eax
     4d3:	6a 0a                	push   $0xa
     4d5:	68 1f 3b 00 00       	push   $0x3b1f
     4da:	56                   	push   %esi
     4db:	e8 cf 30 00 00       	call   35af <write>
     4e0:	83 c4 10             	add    $0x10,%esp
     4e3:	83 f8 0a             	cmp    $0xa,%eax
     4e6:	0f 85 d2 00 00 00    	jne    5be <writetest+0x156>
  for(i = 0; i < 100; i++){
     4ec:	43                   	inc    %ebx
     4ed:	83 fb 64             	cmp    $0x64,%ebx
     4f0:	75 c6                	jne    4b8 <writetest+0x50>
  printf(stdout, "writes ok\n");
     4f2:	83 ec 08             	sub    $0x8,%esp
     4f5:	68 2a 3b 00 00       	push   $0x3b2a
     4fa:	ff 35 b0 51 00 00    	push   0x51b0
     500:	e8 bf 31 00 00       	call   36c4 <printf>
  close(fd);
     505:	89 34 24             	mov    %esi,(%esp)
     508:	e8 aa 30 00 00       	call   35b7 <close>
  fd = open("small", O_RDONLY);
     50d:	5b                   	pop    %ebx
     50e:	5e                   	pop    %esi
     50f:	6a 00                	push   $0x0
     511:	68 d7 3a 00 00       	push   $0x3ad7
     516:	e8 b4 30 00 00       	call   35cf <open>
     51b:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     51d:	83 c4 10             	add    $0x10,%esp
     520:	85 c0                	test   %eax,%eax
     522:	0f 88 ad 00 00 00    	js     5d5 <writetest+0x16d>
    printf(stdout, "open small succeeded ok\n");
     528:	83 ec 08             	sub    $0x8,%esp
     52b:	68 35 3b 00 00       	push   $0x3b35
     530:	ff 35 b0 51 00 00    	push   0x51b0
     536:	e8 89 31 00 00       	call   36c4 <printf>
  i = read(fd, buf, 2000);
     53b:	83 c4 0c             	add    $0xc,%esp
     53e:	68 d0 07 00 00       	push   $0x7d0
     543:	68 00 79 00 00       	push   $0x7900
     548:	53                   	push   %ebx
     549:	e8 59 30 00 00       	call   35a7 <read>
  if(i == 2000){
     54e:	83 c4 10             	add    $0x10,%esp
     551:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     556:	0f 85 90 00 00 00    	jne    5ec <writetest+0x184>
    printf(stdout, "read succeeded ok\n");
     55c:	83 ec 08             	sub    $0x8,%esp
     55f:	68 69 3b 00 00       	push   $0x3b69
     564:	ff 35 b0 51 00 00    	push   0x51b0
     56a:	e8 55 31 00 00       	call   36c4 <printf>
  close(fd);
     56f:	89 1c 24             	mov    %ebx,(%esp)
     572:	e8 40 30 00 00       	call   35b7 <close>
  if(unlink("small") < 0){
     577:	c7 04 24 d7 3a 00 00 	movl   $0x3ad7,(%esp)
     57e:	e8 5c 30 00 00       	call   35df <unlink>
     583:	83 c4 10             	add    $0x10,%esp
     586:	85 c0                	test   %eax,%eax
     588:	78 79                	js     603 <writetest+0x19b>
  printf(stdout, "small file test ok\n");
     58a:	83 ec 08             	sub    $0x8,%esp
     58d:	68 91 3b 00 00       	push   $0x3b91
     592:	ff 35 b0 51 00 00    	push   0x51b0
     598:	e8 27 31 00 00       	call   36c4 <printf>
}
     59d:	83 c4 10             	add    $0x10,%esp
     5a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5a3:	5b                   	pop    %ebx
     5a4:	5e                   	pop    %esi
     5a5:	5d                   	pop    %ebp
     5a6:	c3                   	ret
      printf(stdout, "error: write aa %d new file failed\n", i);
     5a7:	50                   	push   %eax
     5a8:	53                   	push   %ebx
     5a9:	68 dc 49 00 00       	push   $0x49dc
     5ae:	ff 35 b0 51 00 00    	push   0x51b0
     5b4:	e8 0b 31 00 00       	call   36c4 <printf>
      exit();
     5b9:	e8 d1 2f 00 00       	call   358f <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     5be:	50                   	push   %eax
     5bf:	53                   	push   %ebx
     5c0:	68 00 4a 00 00       	push   $0x4a00
     5c5:	ff 35 b0 51 00 00    	push   0x51b0
     5cb:	e8 f4 30 00 00       	call   36c4 <printf>
      exit();
     5d0:	e8 ba 2f 00 00       	call   358f <exit>
    printf(stdout, "error: open small failed!\n");
     5d5:	51                   	push   %ecx
     5d6:	51                   	push   %ecx
     5d7:	68 4e 3b 00 00       	push   $0x3b4e
     5dc:	ff 35 b0 51 00 00    	push   0x51b0
     5e2:	e8 dd 30 00 00       	call   36c4 <printf>
    exit();
     5e7:	e8 a3 2f 00 00       	call   358f <exit>
    printf(stdout, "read failed\n");
     5ec:	52                   	push   %edx
     5ed:	52                   	push   %edx
     5ee:	68 95 3e 00 00       	push   $0x3e95
     5f3:	ff 35 b0 51 00 00    	push   0x51b0
     5f9:	e8 c6 30 00 00       	call   36c4 <printf>
    exit();
     5fe:	e8 8c 2f 00 00       	call   358f <exit>
    printf(stdout, "unlink small failed\n");
     603:	50                   	push   %eax
     604:	50                   	push   %eax
     605:	68 7c 3b 00 00       	push   $0x3b7c
     60a:	ff 35 b0 51 00 00    	push   0x51b0
     610:	e8 af 30 00 00       	call   36c4 <printf>
    exit();
     615:	e8 75 2f 00 00       	call   358f <exit>
    printf(stdout, "error: creat small failed!\n");
     61a:	50                   	push   %eax
     61b:	50                   	push   %eax
     61c:	68 f8 3a 00 00       	push   $0x3af8
     621:	ff 35 b0 51 00 00    	push   0x51b0
     627:	e8 98 30 00 00       	call   36c4 <printf>
    exit();
     62c:	e8 5e 2f 00 00       	call   358f <exit>
     631:	8d 76 00             	lea    0x0(%esi),%esi

00000634 <writetest1>:
{
     634:	55                   	push   %ebp
     635:	89 e5                	mov    %esp,%ebp
     637:	56                   	push   %esi
     638:	53                   	push   %ebx
  printf(stdout, "big files test\n");
     639:	83 ec 08             	sub    $0x8,%esp
     63c:	68 a5 3b 00 00       	push   $0x3ba5
     641:	ff 35 b0 51 00 00    	push   0x51b0
     647:	e8 78 30 00 00       	call   36c4 <printf>
  fd = open("big", O_CREATE|O_RDWR);
     64c:	58                   	pop    %eax
     64d:	5a                   	pop    %edx
     64e:	68 02 02 00 00       	push   $0x202
     653:	68 1f 3c 00 00       	push   $0x3c1f
     658:	e8 72 2f 00 00       	call   35cf <open>
  if(fd < 0){
     65d:	83 c4 10             	add    $0x10,%esp
     660:	85 c0                	test   %eax,%eax
     662:	0f 88 49 01 00 00    	js     7b1 <writetest1+0x17d>
     668:	89 c6                	mov    %eax,%esi
  for(i = 0; i < MAXFILE; i++){
     66a:	31 db                	xor    %ebx,%ebx
    ((int*)buf)[0] = i;
     66c:	89 1d 00 79 00 00    	mov    %ebx,0x7900
    if(write(fd, buf, 512) != 512){
     672:	50                   	push   %eax
     673:	68 00 02 00 00       	push   $0x200
     678:	68 00 79 00 00       	push   $0x7900
     67d:	56                   	push   %esi
     67e:	e8 2c 2f 00 00       	call   35af <write>
     683:	83 c4 10             	add    $0x10,%esp
     686:	3d 00 02 00 00       	cmp    $0x200,%eax
     68b:	0f 85 a9 00 00 00    	jne    73a <writetest1+0x106>
  for(i = 0; i < MAXFILE; i++){
     691:	43                   	inc    %ebx
     692:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     698:	75 d2                	jne    66c <writetest1+0x38>
  close(fd);
     69a:	83 ec 0c             	sub    $0xc,%esp
     69d:	56                   	push   %esi
     69e:	e8 14 2f 00 00       	call   35b7 <close>
  fd = open("big", O_RDONLY);
     6a3:	58                   	pop    %eax
     6a4:	5a                   	pop    %edx
     6a5:	6a 00                	push   $0x0
     6a7:	68 1f 3c 00 00       	push   $0x3c1f
     6ac:	e8 1e 2f 00 00       	call   35cf <open>
     6b1:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     6b3:	83 c4 10             	add    $0x10,%esp
     6b6:	85 c0                	test   %eax,%eax
     6b8:	0f 88 dc 00 00 00    	js     79a <writetest1+0x166>
  n = 0;
     6be:	31 db                	xor    %ebx,%ebx
     6c0:	eb 17                	jmp    6d9 <writetest1+0xa5>
     6c2:	66 90                	xchg   %ax,%ax
    } else if(i != 512){
     6c4:	3d 00 02 00 00       	cmp    $0x200,%eax
     6c9:	0f 85 99 00 00 00    	jne    768 <writetest1+0x134>
    if(((int*)buf)[0] != n){
     6cf:	a1 00 79 00 00       	mov    0x7900,%eax
     6d4:	39 d8                	cmp    %ebx,%eax
     6d6:	75 79                	jne    751 <writetest1+0x11d>
    n++;
     6d8:	43                   	inc    %ebx
    i = read(fd, buf, 512);
     6d9:	50                   	push   %eax
     6da:	68 00 02 00 00       	push   $0x200
     6df:	68 00 79 00 00       	push   $0x7900
     6e4:	56                   	push   %esi
     6e5:	e8 bd 2e 00 00       	call   35a7 <read>
    if(i == 0){
     6ea:	83 c4 10             	add    $0x10,%esp
     6ed:	85 c0                	test   %eax,%eax
     6ef:	75 d3                	jne    6c4 <writetest1+0x90>
      if(n == MAXFILE - 1){
     6f1:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     6f7:	0f 84 82 00 00 00    	je     77f <writetest1+0x14b>
  close(fd);
     6fd:	83 ec 0c             	sub    $0xc,%esp
     700:	56                   	push   %esi
     701:	e8 b1 2e 00 00       	call   35b7 <close>
  if(unlink("big") < 0){
     706:	c7 04 24 1f 3c 00 00 	movl   $0x3c1f,(%esp)
     70d:	e8 cd 2e 00 00       	call   35df <unlink>
     712:	83 c4 10             	add    $0x10,%esp
     715:	85 c0                	test   %eax,%eax
     717:	0f 88 ab 00 00 00    	js     7c8 <writetest1+0x194>
  printf(stdout, "big files ok\n");
     71d:	83 ec 08             	sub    $0x8,%esp
     720:	68 46 3c 00 00       	push   $0x3c46
     725:	ff 35 b0 51 00 00    	push   0x51b0
     72b:	e8 94 2f 00 00       	call   36c4 <printf>
}
     730:	83 c4 10             	add    $0x10,%esp
     733:	8d 65 f8             	lea    -0x8(%ebp),%esp
     736:	5b                   	pop    %ebx
     737:	5e                   	pop    %esi
     738:	5d                   	pop    %ebp
     739:	c3                   	ret
      printf(stdout, "error: write big file failed\n", i);
     73a:	51                   	push   %ecx
     73b:	53                   	push   %ebx
     73c:	68 cf 3b 00 00       	push   $0x3bcf
     741:	ff 35 b0 51 00 00    	push   0x51b0
     747:	e8 78 2f 00 00       	call   36c4 <printf>
      exit();
     74c:	e8 3e 2e 00 00       	call   358f <exit>
      printf(stdout, "read content of block %d is %d\n",
     751:	50                   	push   %eax
     752:	53                   	push   %ebx
     753:	68 24 4a 00 00       	push   $0x4a24
     758:	ff 35 b0 51 00 00    	push   0x51b0
     75e:	e8 61 2f 00 00       	call   36c4 <printf>
      exit();
     763:	e8 27 2e 00 00       	call   358f <exit>
      printf(stdout, "read failed %d\n", i);
     768:	52                   	push   %edx
     769:	50                   	push   %eax
     76a:	68 23 3c 00 00       	push   $0x3c23
     76f:	ff 35 b0 51 00 00    	push   0x51b0
     775:	e8 4a 2f 00 00       	call   36c4 <printf>
      exit();
     77a:	e8 10 2e 00 00       	call   358f <exit>
        printf(stdout, "read only %d blocks from big", n);
     77f:	51                   	push   %ecx
     780:	68 8b 00 00 00       	push   $0x8b
     785:	68 06 3c 00 00       	push   $0x3c06
     78a:	ff 35 b0 51 00 00    	push   0x51b0
     790:	e8 2f 2f 00 00       	call   36c4 <printf>
        exit();
     795:	e8 f5 2d 00 00       	call   358f <exit>
    printf(stdout, "error: open big failed!\n");
     79a:	50                   	push   %eax
     79b:	50                   	push   %eax
     79c:	68 ed 3b 00 00       	push   $0x3bed
     7a1:	ff 35 b0 51 00 00    	push   0x51b0
     7a7:	e8 18 2f 00 00       	call   36c4 <printf>
    exit();
     7ac:	e8 de 2d 00 00       	call   358f <exit>
    printf(stdout, "error: creat big failed!\n");
     7b1:	50                   	push   %eax
     7b2:	50                   	push   %eax
     7b3:	68 b5 3b 00 00       	push   $0x3bb5
     7b8:	ff 35 b0 51 00 00    	push   0x51b0
     7be:	e8 01 2f 00 00       	call   36c4 <printf>
    exit();
     7c3:	e8 c7 2d 00 00       	call   358f <exit>
    printf(stdout, "unlink big failed\n");
     7c8:	50                   	push   %eax
     7c9:	50                   	push   %eax
     7ca:	68 33 3c 00 00       	push   $0x3c33
     7cf:	ff 35 b0 51 00 00    	push   0x51b0
     7d5:	e8 ea 2e 00 00       	call   36c4 <printf>
    exit();
     7da:	e8 b0 2d 00 00       	call   358f <exit>
     7df:	90                   	nop

000007e0 <createtest>:
{
     7e0:	55                   	push   %ebp
     7e1:	89 e5                	mov    %esp,%ebp
     7e3:	53                   	push   %ebx
     7e4:	83 ec 0c             	sub    $0xc,%esp
  printf(stdout, "many creates, followed by unlink test\n");
     7e7:	68 44 4a 00 00       	push   $0x4a44
     7ec:	ff 35 b0 51 00 00    	push   0x51b0
     7f2:	e8 cd 2e 00 00       	call   36c4 <printf>
  name[0] = 'a';
     7f7:	c6 05 f0 78 00 00 61 	movb   $0x61,0x78f0
  name[2] = '\0';
     7fe:	c6 05 f2 78 00 00 00 	movb   $0x0,0x78f2
     805:	83 c4 10             	add    $0x10,%esp
     808:	b3 30                	mov    $0x30,%bl
     80a:	66 90                	xchg   %ax,%ax
    name[1] = '0' + i;
     80c:	88 1d f1 78 00 00    	mov    %bl,0x78f1
    fd = open(name, O_CREATE|O_RDWR);
     812:	83 ec 08             	sub    $0x8,%esp
     815:	68 02 02 00 00       	push   $0x202
     81a:	68 f0 78 00 00       	push   $0x78f0
     81f:	e8 ab 2d 00 00       	call   35cf <open>
    close(fd);
     824:	89 04 24             	mov    %eax,(%esp)
     827:	e8 8b 2d 00 00       	call   35b7 <close>
  for(i = 0; i < 52; i++){
     82c:	43                   	inc    %ebx
     82d:	83 c4 10             	add    $0x10,%esp
     830:	80 fb 64             	cmp    $0x64,%bl
     833:	75 d7                	jne    80c <createtest+0x2c>
  name[0] = 'a';
     835:	c6 05 f0 78 00 00 61 	movb   $0x61,0x78f0
  name[2] = '\0';
     83c:	c6 05 f2 78 00 00 00 	movb   $0x0,0x78f2
     843:	b3 30                	mov    $0x30,%bl
     845:	8d 76 00             	lea    0x0(%esi),%esi
    name[1] = '0' + i;
     848:	88 1d f1 78 00 00    	mov    %bl,0x78f1
    unlink(name);
     84e:	83 ec 0c             	sub    $0xc,%esp
     851:	68 f0 78 00 00       	push   $0x78f0
     856:	e8 84 2d 00 00       	call   35df <unlink>
  for(i = 0; i < 52; i++){
     85b:	43                   	inc    %ebx
     85c:	83 c4 10             	add    $0x10,%esp
     85f:	80 fb 64             	cmp    $0x64,%bl
     862:	75 e4                	jne    848 <createtest+0x68>
  printf(stdout, "many creates, followed by unlink; ok\n");
     864:	83 ec 08             	sub    $0x8,%esp
     867:	68 70 4a 00 00       	push   $0x4a70
     86c:	ff 35 b0 51 00 00    	push   0x51b0
     872:	e8 4d 2e 00 00       	call   36c4 <printf>
}
     877:	83 c4 10             	add    $0x10,%esp
     87a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     87d:	c9                   	leave
     87e:	c3                   	ret
     87f:	90                   	nop

00000880 <dirtest>:
{
     880:	55                   	push   %ebp
     881:	89 e5                	mov    %esp,%ebp
     883:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     886:	68 54 3c 00 00       	push   $0x3c54
     88b:	ff 35 b0 51 00 00    	push   0x51b0
     891:	e8 2e 2e 00 00       	call   36c4 <printf>
  if(mkdir("dir0") < 0){
     896:	c7 04 24 60 3c 00 00 	movl   $0x3c60,(%esp)
     89d:	e8 55 2d 00 00       	call   35f7 <mkdir>
     8a2:	83 c4 10             	add    $0x10,%esp
     8a5:	85 c0                	test   %eax,%eax
     8a7:	78 58                	js     901 <dirtest+0x81>
  if(chdir("dir0") < 0){
     8a9:	83 ec 0c             	sub    $0xc,%esp
     8ac:	68 60 3c 00 00       	push   $0x3c60
     8b1:	e8 49 2d 00 00       	call   35ff <chdir>
     8b6:	83 c4 10             	add    $0x10,%esp
     8b9:	85 c0                	test   %eax,%eax
     8bb:	0f 88 85 00 00 00    	js     946 <dirtest+0xc6>
  if(chdir("..") < 0){
     8c1:	83 ec 0c             	sub    $0xc,%esp
     8c4:	68 05 42 00 00       	push   $0x4205
     8c9:	e8 31 2d 00 00       	call   35ff <chdir>
     8ce:	83 c4 10             	add    $0x10,%esp
     8d1:	85 c0                	test   %eax,%eax
     8d3:	78 5a                	js     92f <dirtest+0xaf>
  if(unlink("dir0") < 0){
     8d5:	83 ec 0c             	sub    $0xc,%esp
     8d8:	68 60 3c 00 00       	push   $0x3c60
     8dd:	e8 fd 2c 00 00       	call   35df <unlink>
     8e2:	83 c4 10             	add    $0x10,%esp
     8e5:	85 c0                	test   %eax,%eax
     8e7:	78 2f                	js     918 <dirtest+0x98>
  printf(stdout, "mkdir test ok\n");
     8e9:	83 ec 08             	sub    $0x8,%esp
     8ec:	68 9d 3c 00 00       	push   $0x3c9d
     8f1:	ff 35 b0 51 00 00    	push   0x51b0
     8f7:	e8 c8 2d 00 00       	call   36c4 <printf>
}
     8fc:	83 c4 10             	add    $0x10,%esp
     8ff:	c9                   	leave
     900:	c3                   	ret
    printf(stdout, "mkdir failed\n");
     901:	50                   	push   %eax
     902:	50                   	push   %eax
     903:	68 90 39 00 00       	push   $0x3990
     908:	ff 35 b0 51 00 00    	push   0x51b0
     90e:	e8 b1 2d 00 00       	call   36c4 <printf>
    exit();
     913:	e8 77 2c 00 00       	call   358f <exit>
    printf(stdout, "unlink dir0 failed\n");
     918:	50                   	push   %eax
     919:	50                   	push   %eax
     91a:	68 89 3c 00 00       	push   $0x3c89
     91f:	ff 35 b0 51 00 00    	push   0x51b0
     925:	e8 9a 2d 00 00       	call   36c4 <printf>
    exit();
     92a:	e8 60 2c 00 00       	call   358f <exit>
    printf(stdout, "chdir .. failed\n");
     92f:	52                   	push   %edx
     930:	52                   	push   %edx
     931:	68 78 3c 00 00       	push   $0x3c78
     936:	ff 35 b0 51 00 00    	push   0x51b0
     93c:	e8 83 2d 00 00       	call   36c4 <printf>
    exit();
     941:	e8 49 2c 00 00       	call   358f <exit>
    printf(stdout, "chdir dir0 failed\n");
     946:	51                   	push   %ecx
     947:	51                   	push   %ecx
     948:	68 65 3c 00 00       	push   $0x3c65
     94d:	ff 35 b0 51 00 00    	push   0x51b0
     953:	e8 6c 2d 00 00       	call   36c4 <printf>
    exit();
     958:	e8 32 2c 00 00       	call   358f <exit>
     95d:	8d 76 00             	lea    0x0(%esi),%esi

00000960 <exectest>:
{
     960:	55                   	push   %ebp
     961:	89 e5                	mov    %esp,%ebp
     963:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     966:	68 ac 3c 00 00       	push   $0x3cac
     96b:	ff 35 b0 51 00 00    	push   0x51b0
     971:	e8 4e 2d 00 00       	call   36c4 <printf>
  if(exec("echo", echoargv) < 0){
     976:	5a                   	pop    %edx
     977:	59                   	pop    %ecx
     978:	68 b4 51 00 00       	push   $0x51b4
     97d:	68 75 3a 00 00       	push   $0x3a75
     982:	e8 40 2c 00 00       	call   35c7 <exec>
     987:	83 c4 10             	add    $0x10,%esp
     98a:	85 c0                	test   %eax,%eax
     98c:	78 02                	js     990 <exectest+0x30>
}
     98e:	c9                   	leave
     98f:	c3                   	ret
    printf(stdout, "exec echo failed\n");
     990:	50                   	push   %eax
     991:	50                   	push   %eax
     992:	68 b7 3c 00 00       	push   $0x3cb7
     997:	ff 35 b0 51 00 00    	push   0x51b0
     99d:	e8 22 2d 00 00       	call   36c4 <printf>
    exit();
     9a2:	e8 e8 2b 00 00       	call   358f <exit>
     9a7:	90                   	nop

000009a8 <pipe1>:
{
     9a8:	55                   	push   %ebp
     9a9:	89 e5                	mov    %esp,%ebp
     9ab:	57                   	push   %edi
     9ac:	56                   	push   %esi
     9ad:	53                   	push   %ebx
     9ae:	83 ec 28             	sub    $0x28,%esp
  if(pipe(fds) != 0){
     9b1:	8d 45 e0             	lea    -0x20(%ebp),%eax
     9b4:	50                   	push   %eax
     9b5:	e8 e5 2b 00 00       	call   359f <pipe>
     9ba:	83 c4 10             	add    $0x10,%esp
     9bd:	85 c0                	test   %eax,%eax
     9bf:	0f 85 35 01 00 00    	jne    afa <pipe1+0x152>
     9c5:	89 c6                	mov    %eax,%esi
  pid = fork();
     9c7:	e8 bb 2b 00 00       	call   3587 <fork>
  if(pid == 0){
     9cc:	85 c0                	test   %eax,%eax
     9ce:	0f 84 8f 00 00 00    	je     a63 <pipe1+0xbb>
  } else if(pid > 0){
     9d4:	0f 8e 33 01 00 00    	jle    b0d <pipe1+0x165>
    close(fds[1]);
     9da:	83 ec 0c             	sub    $0xc,%esp
     9dd:	ff 75 e4             	push   -0x1c(%ebp)
     9e0:	e8 d2 2b 00 00       	call   35b7 <close>
    while((n = read(fds[0], buf, cc)) > 0){
     9e5:	83 c4 10             	add    $0x10,%esp
    total = 0;
     9e8:	31 db                	xor    %ebx,%ebx
    cc = 1;
     9ea:	bf 01 00 00 00       	mov    $0x1,%edi
    while((n = read(fds[0], buf, cc)) > 0){
     9ef:	50                   	push   %eax
     9f0:	57                   	push   %edi
     9f1:	68 00 79 00 00       	push   $0x7900
     9f6:	ff 75 e0             	push   -0x20(%ebp)
     9f9:	e8 a9 2b 00 00       	call   35a7 <read>
     9fe:	89 c1                	mov    %eax,%ecx
     a00:	83 c4 10             	add    $0x10,%esp
     a03:	85 c0                	test   %eax,%eax
     a05:	0f 8e ae 00 00 00    	jle    ab9 <pipe1+0x111>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a0b:	89 f0                	mov    %esi,%eax
     a0d:	33 05 00 79 00 00    	xor    0x7900,%eax
     a13:	0f b6 c0             	movzbl %al,%eax
     a16:	85 c0                	test   %eax,%eax
     a18:	75 26                	jne    a40 <pipe1+0x98>
     a1a:	46                   	inc    %esi
     a1b:	eb 0b                	jmp    a28 <pipe1+0x80>
     a1d:	8d 76 00             	lea    0x0(%esi),%esi
     a20:	38 90 00 79 00 00    	cmp    %dl,0x7900(%eax)
     a26:	75 18                	jne    a40 <pipe1+0x98>
     a28:	8d 14 06             	lea    (%esi,%eax,1),%edx
      for(i = 0; i < n; i++){
     a2b:	40                   	inc    %eax
     a2c:	39 c1                	cmp    %eax,%ecx
     a2e:	75 f0                	jne    a20 <pipe1+0x78>
      total += n;
     a30:	01 cb                	add    %ecx,%ebx
      if(cc > sizeof(buf))
     a32:	01 ff                	add    %edi,%edi
     a34:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     a3a:	7f 1e                	jg     a5a <pipe1+0xb2>
     a3c:	89 d6                	mov    %edx,%esi
     a3e:	eb af                	jmp    9ef <pipe1+0x47>
          printf(1, "pipe1 oops 2\n");
     a40:	83 ec 08             	sub    $0x8,%esp
     a43:	68 e6 3c 00 00       	push   $0x3ce6
     a48:	6a 01                	push   $0x1
     a4a:	e8 75 2c 00 00       	call   36c4 <printf>
     a4f:	83 c4 10             	add    $0x10,%esp
}
     a52:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a55:	5b                   	pop    %ebx
     a56:	5e                   	pop    %esi
     a57:	5f                   	pop    %edi
     a58:	5d                   	pop    %ebp
     a59:	c3                   	ret
      if(cc > sizeof(buf))
     a5a:	bf 00 20 00 00       	mov    $0x2000,%edi
     a5f:	89 d6                	mov    %edx,%esi
     a61:	eb 8c                	jmp    9ef <pipe1+0x47>
    close(fds[0]);
     a63:	83 ec 0c             	sub    $0xc,%esp
     a66:	ff 75 e0             	push   -0x20(%ebp)
     a69:	e8 49 2b 00 00       	call   35b7 <close>
     a6e:	83 c4 10             	add    $0x10,%esp
  seq = 0;
     a71:	31 db                	xor    %ebx,%ebx
     a73:	90                   	nop
      for(i = 0; i < 1033; i++)
     a74:	31 c0                	xor    %eax,%eax
     a76:	66 90                	xchg   %ax,%ax
        buf[i] = seq++;
     a78:	8d 14 03             	lea    (%ebx,%eax,1),%edx
     a7b:	88 90 00 79 00 00    	mov    %dl,0x7900(%eax)
      for(i = 0; i < 1033; i++)
     a81:	40                   	inc    %eax
     a82:	3d 09 04 00 00       	cmp    $0x409,%eax
     a87:	75 ef                	jne    a78 <pipe1+0xd0>
     a89:	81 c3 09 04 00 00    	add    $0x409,%ebx
      if(write(fds[1], buf, 1033) != 1033){
     a8f:	50                   	push   %eax
     a90:	68 09 04 00 00       	push   $0x409
     a95:	68 00 79 00 00       	push   $0x7900
     a9a:	ff 75 e4             	push   -0x1c(%ebp)
     a9d:	e8 0d 2b 00 00       	call   35af <write>
     aa2:	83 c4 10             	add    $0x10,%esp
     aa5:	3d 09 04 00 00       	cmp    $0x409,%eax
     aaa:	75 74                	jne    b20 <pipe1+0x178>
    for(n = 0; n < 5; n++){
     aac:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     ab2:	75 c0                	jne    a74 <pipe1+0xcc>
    exit();
     ab4:	e8 d6 2a 00 00       	call   358f <exit>
    if(total != 5 * 1033){
     ab9:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     abf:	75 26                	jne    ae7 <pipe1+0x13f>
    close(fds[0]);
     ac1:	83 ec 0c             	sub    $0xc,%esp
     ac4:	ff 75 e0             	push   -0x20(%ebp)
     ac7:	e8 eb 2a 00 00       	call   35b7 <close>
    wait();
     acc:	e8 c6 2a 00 00       	call   3597 <wait>
  printf(1, "pipe1 ok\n");
     ad1:	5a                   	pop    %edx
     ad2:	59                   	pop    %ecx
     ad3:	68 0b 3d 00 00       	push   $0x3d0b
     ad8:	6a 01                	push   $0x1
     ada:	e8 e5 2b 00 00       	call   36c4 <printf>
     adf:	83 c4 10             	add    $0x10,%esp
     ae2:	e9 6b ff ff ff       	jmp    a52 <pipe1+0xaa>
      printf(1, "pipe1 oops 3 total %d\n", total);
     ae7:	56                   	push   %esi
     ae8:	53                   	push   %ebx
     ae9:	68 f4 3c 00 00       	push   $0x3cf4
     aee:	6a 01                	push   $0x1
     af0:	e8 cf 2b 00 00       	call   36c4 <printf>
      exit();
     af5:	e8 95 2a 00 00       	call   358f <exit>
    printf(1, "pipe() failed\n");
     afa:	50                   	push   %eax
     afb:	50                   	push   %eax
     afc:	68 c9 3c 00 00       	push   $0x3cc9
     b01:	6a 01                	push   $0x1
     b03:	e8 bc 2b 00 00       	call   36c4 <printf>
    exit();
     b08:	e8 82 2a 00 00       	call   358f <exit>
    printf(1, "fork() failed\n");
     b0d:	50                   	push   %eax
     b0e:	50                   	push   %eax
     b0f:	68 15 3d 00 00       	push   $0x3d15
     b14:	6a 01                	push   $0x1
     b16:	e8 a9 2b 00 00       	call   36c4 <printf>
    exit();
     b1b:	e8 6f 2a 00 00       	call   358f <exit>
        printf(1, "pipe1 oops 1\n");
     b20:	50                   	push   %eax
     b21:	50                   	push   %eax
     b22:	68 d8 3c 00 00       	push   $0x3cd8
     b27:	6a 01                	push   $0x1
     b29:	e8 96 2b 00 00       	call   36c4 <printf>
        exit();
     b2e:	e8 5c 2a 00 00       	call   358f <exit>
     b33:	90                   	nop

00000b34 <preempt>:
{
     b34:	55                   	push   %ebp
     b35:	89 e5                	mov    %esp,%ebp
     b37:	57                   	push   %edi
     b38:	56                   	push   %esi
     b39:	53                   	push   %ebx
     b3a:	83 ec 24             	sub    $0x24,%esp
  printf(1, "preempt: ");
     b3d:	68 24 3d 00 00       	push   $0x3d24
     b42:	6a 01                	push   $0x1
     b44:	e8 7b 2b 00 00       	call   36c4 <printf>
  pid1 = fork();
     b49:	e8 39 2a 00 00       	call   3587 <fork>
  if(pid1 == 0)
     b4e:	83 c4 10             	add    $0x10,%esp
     b51:	85 c0                	test   %eax,%eax
     b53:	75 03                	jne    b58 <preempt+0x24>
    for(;;)
     b55:	eb fe                	jmp    b55 <preempt+0x21>
     b57:	90                   	nop
     b58:	89 c3                	mov    %eax,%ebx
  pid2 = fork();
     b5a:	e8 28 2a 00 00       	call   3587 <fork>
     b5f:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     b61:	85 c0                	test   %eax,%eax
     b63:	75 03                	jne    b68 <preempt+0x34>
    for(;;)
     b65:	eb fe                	jmp    b65 <preempt+0x31>
     b67:	90                   	nop
  pipe(pfds);
     b68:	83 ec 0c             	sub    $0xc,%esp
     b6b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     b6e:	50                   	push   %eax
     b6f:	e8 2b 2a 00 00       	call   359f <pipe>
  pid3 = fork();
     b74:	e8 0e 2a 00 00       	call   3587 <fork>
     b79:	89 c7                	mov    %eax,%edi
  if(pid3 == 0){
     b7b:	83 c4 10             	add    $0x10,%esp
     b7e:	85 c0                	test   %eax,%eax
     b80:	75 3a                	jne    bbc <preempt+0x88>
    close(pfds[0]);
     b82:	83 ec 0c             	sub    $0xc,%esp
     b85:	ff 75 e0             	push   -0x20(%ebp)
     b88:	e8 2a 2a 00 00       	call   35b7 <close>
    if(write(pfds[1], "x", 1) != 1)
     b8d:	83 c4 0c             	add    $0xc,%esp
     b90:	6a 01                	push   $0x1
     b92:	68 e9 42 00 00       	push   $0x42e9
     b97:	ff 75 e4             	push   -0x1c(%ebp)
     b9a:	e8 10 2a 00 00       	call   35af <write>
     b9f:	83 c4 10             	add    $0x10,%esp
     ba2:	48                   	dec    %eax
     ba3:	0f 85 b4 00 00 00    	jne    c5d <preempt+0x129>
    close(pfds[1]);
     ba9:	83 ec 0c             	sub    $0xc,%esp
     bac:	ff 75 e4             	push   -0x1c(%ebp)
     baf:	e8 03 2a 00 00       	call   35b7 <close>
     bb4:	83 c4 10             	add    $0x10,%esp
    for(;;)
     bb7:	eb fe                	jmp    bb7 <preempt+0x83>
     bb9:	8d 76 00             	lea    0x0(%esi),%esi
  close(pfds[1]);
     bbc:	83 ec 0c             	sub    $0xc,%esp
     bbf:	ff 75 e4             	push   -0x1c(%ebp)
     bc2:	e8 f0 29 00 00       	call   35b7 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     bc7:	83 c4 0c             	add    $0xc,%esp
     bca:	68 00 20 00 00       	push   $0x2000
     bcf:	68 00 79 00 00       	push   $0x7900
     bd4:	ff 75 e0             	push   -0x20(%ebp)
     bd7:	e8 cb 29 00 00       	call   35a7 <read>
     bdc:	83 c4 10             	add    $0x10,%esp
     bdf:	48                   	dec    %eax
     be0:	75 67                	jne    c49 <preempt+0x115>
  close(pfds[0]);
     be2:	83 ec 0c             	sub    $0xc,%esp
     be5:	ff 75 e0             	push   -0x20(%ebp)
     be8:	e8 ca 29 00 00       	call   35b7 <close>
  printf(1, "kill... ");
     bed:	58                   	pop    %eax
     bee:	5a                   	pop    %edx
     bef:	68 55 3d 00 00       	push   $0x3d55
     bf4:	6a 01                	push   $0x1
     bf6:	e8 c9 2a 00 00       	call   36c4 <printf>
  kill(pid1);
     bfb:	89 1c 24             	mov    %ebx,(%esp)
     bfe:	e8 bc 29 00 00       	call   35bf <kill>
  kill(pid2);
     c03:	89 34 24             	mov    %esi,(%esp)
     c06:	e8 b4 29 00 00       	call   35bf <kill>
  kill(pid3);
     c0b:	89 3c 24             	mov    %edi,(%esp)
     c0e:	e8 ac 29 00 00       	call   35bf <kill>
  printf(1, "wait... ");
     c13:	59                   	pop    %ecx
     c14:	5b                   	pop    %ebx
     c15:	68 5e 3d 00 00       	push   $0x3d5e
     c1a:	6a 01                	push   $0x1
     c1c:	e8 a3 2a 00 00       	call   36c4 <printf>
  wait();
     c21:	e8 71 29 00 00       	call   3597 <wait>
  wait();
     c26:	e8 6c 29 00 00       	call   3597 <wait>
  wait();
     c2b:	e8 67 29 00 00       	call   3597 <wait>
  printf(1, "preempt ok\n");
     c30:	5e                   	pop    %esi
     c31:	5f                   	pop    %edi
     c32:	68 67 3d 00 00       	push   $0x3d67
     c37:	6a 01                	push   $0x1
     c39:	e8 86 2a 00 00       	call   36c4 <printf>
     c3e:	83 c4 10             	add    $0x10,%esp
}
     c41:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c44:	5b                   	pop    %ebx
     c45:	5e                   	pop    %esi
     c46:	5f                   	pop    %edi
     c47:	5d                   	pop    %ebp
     c48:	c3                   	ret
    printf(1, "preempt read error");
     c49:	83 ec 08             	sub    $0x8,%esp
     c4c:	68 42 3d 00 00       	push   $0x3d42
     c51:	6a 01                	push   $0x1
     c53:	e8 6c 2a 00 00       	call   36c4 <printf>
     c58:	83 c4 10             	add    $0x10,%esp
     c5b:	eb e4                	jmp    c41 <preempt+0x10d>
      printf(1, "preempt write error");
     c5d:	83 ec 08             	sub    $0x8,%esp
     c60:	68 2e 3d 00 00       	push   $0x3d2e
     c65:	6a 01                	push   $0x1
     c67:	e8 58 2a 00 00       	call   36c4 <printf>
     c6c:	83 c4 10             	add    $0x10,%esp
     c6f:	e9 35 ff ff ff       	jmp    ba9 <preempt+0x75>

00000c74 <exitwait>:
{
     c74:	55                   	push   %ebp
     c75:	89 e5                	mov    %esp,%ebp
     c77:	56                   	push   %esi
     c78:	53                   	push   %ebx
     c79:	be 64 00 00 00       	mov    $0x64,%esi
     c7e:	eb 0e                	jmp    c8e <exitwait+0x1a>
    if(pid){
     c80:	74 64                	je     ce6 <exitwait+0x72>
      if(wait() != pid){
     c82:	e8 10 29 00 00       	call   3597 <wait>
     c87:	39 d8                	cmp    %ebx,%eax
     c89:	75 29                	jne    cb4 <exitwait+0x40>
  for(i = 0; i < 100; i++){
     c8b:	4e                   	dec    %esi
     c8c:	74 3f                	je     ccd <exitwait+0x59>
    pid = fork();
     c8e:	e8 f4 28 00 00       	call   3587 <fork>
     c93:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     c95:	85 c0                	test   %eax,%eax
     c97:	79 e7                	jns    c80 <exitwait+0xc>
      printf(1, "fork failed\n");
     c99:	83 ec 08             	sub    $0x8,%esp
     c9c:	68 d1 48 00 00       	push   $0x48d1
     ca1:	6a 01                	push   $0x1
     ca3:	e8 1c 2a 00 00       	call   36c4 <printf>
      return;
     ca8:	83 c4 10             	add    $0x10,%esp
}
     cab:	8d 65 f8             	lea    -0x8(%ebp),%esp
     cae:	5b                   	pop    %ebx
     caf:	5e                   	pop    %esi
     cb0:	5d                   	pop    %ebp
     cb1:	c3                   	ret
     cb2:	66 90                	xchg   %ax,%ax
        printf(1, "wait wrong pid\n");
     cb4:	83 ec 08             	sub    $0x8,%esp
     cb7:	68 73 3d 00 00       	push   $0x3d73
     cbc:	6a 01                	push   $0x1
     cbe:	e8 01 2a 00 00       	call   36c4 <printf>
        return;
     cc3:	83 c4 10             	add    $0x10,%esp
}
     cc6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     cc9:	5b                   	pop    %ebx
     cca:	5e                   	pop    %esi
     ccb:	5d                   	pop    %ebp
     ccc:	c3                   	ret
  printf(1, "exitwait ok\n");
     ccd:	83 ec 08             	sub    $0x8,%esp
     cd0:	68 83 3d 00 00       	push   $0x3d83
     cd5:	6a 01                	push   $0x1
     cd7:	e8 e8 29 00 00       	call   36c4 <printf>
     cdc:	83 c4 10             	add    $0x10,%esp
}
     cdf:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ce2:	5b                   	pop    %ebx
     ce3:	5e                   	pop    %esi
     ce4:	5d                   	pop    %ebp
     ce5:	c3                   	ret
      exit();
     ce6:	e8 a4 28 00 00       	call   358f <exit>
     ceb:	90                   	nop

00000cec <mem>:
{
     cec:	55                   	push   %ebp
     ced:	89 e5                	mov    %esp,%ebp
     cef:	56                   	push   %esi
     cf0:	53                   	push   %ebx
  printf(1, "mem test\n");
     cf1:	83 ec 08             	sub    $0x8,%esp
     cf4:	68 90 3d 00 00       	push   $0x3d90
     cf9:	6a 01                	push   $0x1
     cfb:	e8 c4 29 00 00       	call   36c4 <printf>
  ppid = getpid();
     d00:	e8 0a 29 00 00       	call   360f <getpid>
     d05:	89 c3                	mov    %eax,%ebx
  if((pid = fork()) == 0){
     d07:	e8 7b 28 00 00       	call   3587 <fork>
     d0c:	83 c4 10             	add    $0x10,%esp
     d0f:	85 c0                	test   %eax,%eax
     d11:	0f 85 81 00 00 00    	jne    d98 <mem+0xac>
    m1 = 0;
     d17:	31 f6                	xor    %esi,%esi
     d19:	eb 05                	jmp    d20 <mem+0x34>
     d1b:	90                   	nop
      *(char**)m2 = m1;
     d1c:	89 30                	mov    %esi,(%eax)
      m1 = m2;
     d1e:	89 c6                	mov    %eax,%esi
    while((m2 = malloc(10001)) != 0){
     d20:	83 ec 0c             	sub    $0xc,%esp
     d23:	68 11 27 00 00       	push   $0x2711
     d28:	e8 7f 2b 00 00       	call   38ac <malloc>
     d2d:	83 c4 10             	add    $0x10,%esp
     d30:	85 c0                	test   %eax,%eax
     d32:	75 e8                	jne    d1c <mem+0x30>
    while(m1){
     d34:	85 f6                	test   %esi,%esi
     d36:	74 14                	je     d4c <mem+0x60>
      m2 = *(char**)m1;
     d38:	89 f0                	mov    %esi,%eax
     d3a:	8b 36                	mov    (%esi),%esi
      free(m1);
     d3c:	83 ec 0c             	sub    $0xc,%esp
     d3f:	50                   	push   %eax
     d40:	e8 e7 2a 00 00       	call   382c <free>
    while(m1){
     d45:	83 c4 10             	add    $0x10,%esp
     d48:	85 f6                	test   %esi,%esi
     d4a:	75 ec                	jne    d38 <mem+0x4c>
    m1 = malloc(1024*20);
     d4c:	83 ec 0c             	sub    $0xc,%esp
     d4f:	68 00 50 00 00       	push   $0x5000
     d54:	e8 53 2b 00 00       	call   38ac <malloc>
    if(m1 == 0){
     d59:	83 c4 10             	add    $0x10,%esp
     d5c:	85 c0                	test   %eax,%eax
     d5e:	74 1c                	je     d7c <mem+0x90>
    free(m1);
     d60:	83 ec 0c             	sub    $0xc,%esp
     d63:	50                   	push   %eax
     d64:	e8 c3 2a 00 00       	call   382c <free>
    printf(1, "mem ok\n");
     d69:	58                   	pop    %eax
     d6a:	5a                   	pop    %edx
     d6b:	68 b4 3d 00 00       	push   $0x3db4
     d70:	6a 01                	push   $0x1
     d72:	e8 4d 29 00 00       	call   36c4 <printf>
    exit();
     d77:	e8 13 28 00 00       	call   358f <exit>
      printf(1, "couldn't allocate mem?!!\n");
     d7c:	83 ec 08             	sub    $0x8,%esp
     d7f:	68 9a 3d 00 00       	push   $0x3d9a
     d84:	6a 01                	push   $0x1
     d86:	e8 39 29 00 00       	call   36c4 <printf>
      kill(ppid);
     d8b:	89 1c 24             	mov    %ebx,(%esp)
     d8e:	e8 2c 28 00 00       	call   35bf <kill>
      exit();
     d93:	e8 f7 27 00 00       	call   358f <exit>
}
     d98:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d9b:	5b                   	pop    %ebx
     d9c:	5e                   	pop    %esi
     d9d:	5d                   	pop    %ebp
    wait();
     d9e:	e9 f4 27 00 00       	jmp    3597 <wait>
     da3:	90                   	nop

00000da4 <sharedfd>:
{
     da4:	55                   	push   %ebp
     da5:	89 e5                	mov    %esp,%ebp
     da7:	57                   	push   %edi
     da8:	56                   	push   %esi
     da9:	53                   	push   %ebx
     daa:	83 ec 34             	sub    $0x34,%esp
  printf(1, "sharedfd test\n");
     dad:	68 bc 3d 00 00       	push   $0x3dbc
     db2:	6a 01                	push   $0x1
     db4:	e8 0b 29 00 00       	call   36c4 <printf>
  unlink("sharedfd");
     db9:	c7 04 24 cb 3d 00 00 	movl   $0x3dcb,(%esp)
     dc0:	e8 1a 28 00 00       	call   35df <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     dc5:	59                   	pop    %ecx
     dc6:	5b                   	pop    %ebx
     dc7:	68 02 02 00 00       	push   $0x202
     dcc:	68 cb 3d 00 00       	push   $0x3dcb
     dd1:	e8 f9 27 00 00       	call   35cf <open>
  if(fd < 0){
     dd6:	83 c4 10             	add    $0x10,%esp
     dd9:	85 c0                	test   %eax,%eax
     ddb:	0f 88 0e 01 00 00    	js     eef <sharedfd+0x14b>
     de1:	89 c7                	mov    %eax,%edi
  pid = fork();
     de3:	e8 9f 27 00 00       	call   3587 <fork>
     de8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     deb:	83 f8 01             	cmp    $0x1,%eax
     dee:	19 c0                	sbb    %eax,%eax
     df0:	83 e0 f3             	and    $0xfffffff3,%eax
     df3:	83 c0 70             	add    $0x70,%eax
     df6:	52                   	push   %edx
     df7:	6a 0a                	push   $0xa
     df9:	50                   	push   %eax
     dfa:	8d 75 de             	lea    -0x22(%ebp),%esi
     dfd:	56                   	push   %esi
     dfe:	e8 55 26 00 00       	call   3458 <memset>
     e03:	83 c4 10             	add    $0x10,%esp
     e06:	bb e8 03 00 00       	mov    $0x3e8,%ebx
     e0b:	eb 06                	jmp    e13 <sharedfd+0x6f>
     e0d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 1000; i++){
     e10:	4b                   	dec    %ebx
     e11:	74 24                	je     e37 <sharedfd+0x93>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     e13:	50                   	push   %eax
     e14:	6a 0a                	push   $0xa
     e16:	56                   	push   %esi
     e17:	57                   	push   %edi
     e18:	e8 92 27 00 00       	call   35af <write>
     e1d:	83 c4 10             	add    $0x10,%esp
     e20:	83 f8 0a             	cmp    $0xa,%eax
     e23:	74 eb                	je     e10 <sharedfd+0x6c>
      printf(1, "fstests: write sharedfd failed\n");
     e25:	83 ec 08             	sub    $0x8,%esp
     e28:	68 c4 4a 00 00       	push   $0x4ac4
     e2d:	6a 01                	push   $0x1
     e2f:	e8 90 28 00 00       	call   36c4 <printf>
      break;
     e34:	83 c4 10             	add    $0x10,%esp
  if(pid == 0)
     e37:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
     e3a:	85 db                	test   %ebx,%ebx
     e3c:	0f 84 e1 00 00 00    	je     f23 <sharedfd+0x17f>
    wait();
     e42:	e8 50 27 00 00       	call   3597 <wait>
  close(fd);
     e47:	83 ec 0c             	sub    $0xc,%esp
     e4a:	57                   	push   %edi
     e4b:	e8 67 27 00 00       	call   35b7 <close>
  fd = open("sharedfd", 0);
     e50:	5a                   	pop    %edx
     e51:	59                   	pop    %ecx
     e52:	6a 00                	push   $0x0
     e54:	68 cb 3d 00 00       	push   $0x3dcb
     e59:	e8 71 27 00 00       	call   35cf <open>
     e5e:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
     e61:	83 c4 10             	add    $0x10,%esp
     e64:	85 c0                	test   %eax,%eax
     e66:	0f 88 9d 00 00 00    	js     f09 <sharedfd+0x165>
  nc = np = 0;
     e6c:	31 d2                	xor    %edx,%edx
     e6e:	31 ff                	xor    %edi,%edi
     e70:	8d 5d e8             	lea    -0x18(%ebp),%ebx
     e73:	90                   	nop
     e74:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
     e77:	50                   	push   %eax
     e78:	6a 0a                	push   $0xa
     e7a:	56                   	push   %esi
     e7b:	ff 75 d0             	push   -0x30(%ebp)
     e7e:	e8 24 27 00 00       	call   35a7 <read>
     e83:	83 c4 10             	add    $0x10,%esp
     e86:	85 c0                	test   %eax,%eax
     e88:	7e 1e                	jle    ea8 <sharedfd+0x104>
     e8a:	89 f1                	mov    %esi,%ecx
     e8c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     e8f:	eb 0d                	jmp    e9e <sharedfd+0xfa>
     e91:	8d 76 00             	lea    0x0(%esi),%esi
      if(buf[i] == 'p')
     e94:	3c 70                	cmp    $0x70,%al
     e96:	75 01                	jne    e99 <sharedfd+0xf5>
        np++;
     e98:	42                   	inc    %edx
    for(i = 0; i < sizeof(buf); i++){
     e99:	41                   	inc    %ecx
     e9a:	39 cb                	cmp    %ecx,%ebx
     e9c:	74 d6                	je     e74 <sharedfd+0xd0>
      if(buf[i] == 'c')
     e9e:	8a 01                	mov    (%ecx),%al
     ea0:	3c 63                	cmp    $0x63,%al
     ea2:	75 f0                	jne    e94 <sharedfd+0xf0>
        nc++;
     ea4:	47                   	inc    %edi
      if(buf[i] == 'p')
     ea5:	eb f2                	jmp    e99 <sharedfd+0xf5>
     ea7:	90                   	nop
  close(fd);
     ea8:	83 ec 0c             	sub    $0xc,%esp
     eab:	ff 75 d0             	push   -0x30(%ebp)
     eae:	e8 04 27 00 00       	call   35b7 <close>
  unlink("sharedfd");
     eb3:	c7 04 24 cb 3d 00 00 	movl   $0x3dcb,(%esp)
     eba:	e8 20 27 00 00       	call   35df <unlink>
  if(nc == 10000 && np == 10000){
     ebf:	83 c4 10             	add    $0x10,%esp
     ec2:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
     ec8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     ecb:	75 5b                	jne    f28 <sharedfd+0x184>
     ecd:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     ed3:	75 53                	jne    f28 <sharedfd+0x184>
    printf(1, "sharedfd ok\n");
     ed5:	83 ec 08             	sub    $0x8,%esp
     ed8:	68 d4 3d 00 00       	push   $0x3dd4
     edd:	6a 01                	push   $0x1
     edf:	e8 e0 27 00 00       	call   36c4 <printf>
     ee4:	83 c4 10             	add    $0x10,%esp
}
     ee7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     eea:	5b                   	pop    %ebx
     eeb:	5e                   	pop    %esi
     eec:	5f                   	pop    %edi
     eed:	5d                   	pop    %ebp
     eee:	c3                   	ret
    printf(1, "fstests: cannot open sharedfd for writing");
     eef:	83 ec 08             	sub    $0x8,%esp
     ef2:	68 98 4a 00 00       	push   $0x4a98
     ef7:	6a 01                	push   $0x1
     ef9:	e8 c6 27 00 00       	call   36c4 <printf>
    return;
     efe:	83 c4 10             	add    $0x10,%esp
}
     f01:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f04:	5b                   	pop    %ebx
     f05:	5e                   	pop    %esi
     f06:	5f                   	pop    %edi
     f07:	5d                   	pop    %ebp
     f08:	c3                   	ret
    printf(1, "fstests: cannot open sharedfd for reading\n");
     f09:	83 ec 08             	sub    $0x8,%esp
     f0c:	68 e4 4a 00 00       	push   $0x4ae4
     f11:	6a 01                	push   $0x1
     f13:	e8 ac 27 00 00       	call   36c4 <printf>
    return;
     f18:	83 c4 10             	add    $0x10,%esp
}
     f1b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f1e:	5b                   	pop    %ebx
     f1f:	5e                   	pop    %esi
     f20:	5f                   	pop    %edi
     f21:	5d                   	pop    %ebp
     f22:	c3                   	ret
    exit();
     f23:	e8 67 26 00 00       	call   358f <exit>
    printf(1, "sharedfd oops %d %d\n", nc, np);
     f28:	52                   	push   %edx
     f29:	57                   	push   %edi
     f2a:	68 e1 3d 00 00       	push   $0x3de1
     f2f:	6a 01                	push   $0x1
     f31:	e8 8e 27 00 00       	call   36c4 <printf>
    exit();
     f36:	e8 54 26 00 00       	call   358f <exit>
     f3b:	90                   	nop

00000f3c <fourfiles>:
{
     f3c:	55                   	push   %ebp
     f3d:	89 e5                	mov    %esp,%ebp
     f3f:	57                   	push   %edi
     f40:	56                   	push   %esi
     f41:	53                   	push   %ebx
     f42:	83 ec 34             	sub    $0x34,%esp
  char *names[] = { "f0", "f1", "f2", "f3" };
     f45:	be 30 51 00 00       	mov    $0x5130,%esi
     f4a:	b9 04 00 00 00       	mov    $0x4,%ecx
     f4f:	8d 7d d8             	lea    -0x28(%ebp),%edi
     f52:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  printf(1, "fourfiles test\n");
     f54:	68 f6 3d 00 00       	push   $0x3df6
     f59:	6a 01                	push   $0x1
     f5b:	e8 64 27 00 00       	call   36c4 <printf>
     f60:	83 c4 10             	add    $0x10,%esp
  for(pi = 0; pi < 4; pi++){
     f63:	31 db                	xor    %ebx,%ebx
    fname = names[pi];
     f65:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    unlink(fname);
     f69:	83 ec 0c             	sub    $0xc,%esp
     f6c:	56                   	push   %esi
     f6d:	e8 6d 26 00 00       	call   35df <unlink>
    pid = fork();
     f72:	e8 10 26 00 00       	call   3587 <fork>
    if(pid < 0){
     f77:	83 c4 10             	add    $0x10,%esp
     f7a:	85 c0                	test   %eax,%eax
     f7c:	0f 88 56 01 00 00    	js     10d8 <fourfiles+0x19c>
    if(pid == 0){
     f82:	0f 84 e6 00 00 00    	je     106e <fourfiles+0x132>
  for(pi = 0; pi < 4; pi++){
     f88:	43                   	inc    %ebx
     f89:	83 fb 04             	cmp    $0x4,%ebx
     f8c:	75 d7                	jne    f65 <fourfiles+0x29>
    wait();
     f8e:	e8 04 26 00 00       	call   3597 <wait>
     f93:	e8 ff 25 00 00       	call   3597 <wait>
     f98:	e8 fa 25 00 00       	call   3597 <wait>
     f9d:	e8 f5 25 00 00       	call   3597 <wait>
  for(i = 0; i < 2; i++){
     fa2:	31 db                	xor    %ebx,%ebx
    fname = names[i];
     fa4:	8b 44 9d d8          	mov    -0x28(%ebp,%ebx,4),%eax
     fa8:	89 45 d0             	mov    %eax,-0x30(%ebp)
    fd = open(fname, 0);
     fab:	83 ec 08             	sub    $0x8,%esp
     fae:	6a 00                	push   $0x0
     fb0:	50                   	push   %eax
     fb1:	e8 19 26 00 00       	call   35cf <open>
     fb6:	89 c7                	mov    %eax,%edi
    while((n = read(fd, buf, sizeof(buf))) > 0){
     fb8:	83 c4 10             	add    $0x10,%esp
    total = 0;
     fbb:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     fc2:	89 de                	mov    %ebx,%esi
     fc4:	83 f6 01             	xor    $0x1,%esi
     fc7:	89 5d cc             	mov    %ebx,-0x34(%ebp)
     fca:	66 90                	xchg   %ax,%ax
    while((n = read(fd, buf, sizeof(buf))) > 0){
     fcc:	52                   	push   %edx
     fcd:	68 00 20 00 00       	push   $0x2000
     fd2:	68 00 79 00 00       	push   $0x7900
     fd7:	57                   	push   %edi
     fd8:	e8 ca 25 00 00       	call   35a7 <read>
     fdd:	89 c3                	mov    %eax,%ebx
     fdf:	83 c4 10             	add    $0x10,%esp
     fe2:	85 c0                	test   %eax,%eax
     fe4:	7e 22                	jle    1008 <fourfiles+0xcc>
      for(j = 0; j < n; j++){
     fe6:	31 d2                	xor    %edx,%edx
        if(buf[j] != '0'+i){
     fe8:	0f be 8a 00 79 00 00 	movsbl 0x7900(%edx),%ecx
     fef:	89 f0                	mov    %esi,%eax
     ff1:	c1 e0 1f             	shl    $0x1f,%eax
     ff4:	c1 f8 1f             	sar    $0x1f,%eax
     ff7:	83 c0 31             	add    $0x31,%eax
     ffa:	39 c1                	cmp    %eax,%ecx
     ffc:	75 5c                	jne    105a <fourfiles+0x11e>
      for(j = 0; j < n; j++){
     ffe:	42                   	inc    %edx
     fff:	39 d3                	cmp    %edx,%ebx
    1001:	75 e5                	jne    fe8 <fourfiles+0xac>
      total += n;
    1003:	01 5d d4             	add    %ebx,-0x2c(%ebp)
    1006:	eb c4                	jmp    fcc <fourfiles+0x90>
    close(fd);
    1008:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    100b:	83 ec 0c             	sub    $0xc,%esp
    100e:	57                   	push   %edi
    100f:	e8 a3 25 00 00       	call   35b7 <close>
    if(total != 12*500){
    1014:	83 c4 10             	add    $0x10,%esp
    1017:	81 7d d4 70 17 00 00 	cmpl   $0x1770,-0x2c(%ebp)
    101e:	0f 85 c8 00 00 00    	jne    10ec <fourfiles+0x1b0>
    unlink(fname);
    1024:	83 ec 0c             	sub    $0xc,%esp
    1027:	ff 75 d0             	push   -0x30(%ebp)
    102a:	e8 b0 25 00 00       	call   35df <unlink>
  for(i = 0; i < 2; i++){
    102f:	83 c4 10             	add    $0x10,%esp
    1032:	85 db                	test   %ebx,%ebx
    1034:	75 0a                	jne    1040 <fourfiles+0x104>
    1036:	bb 01 00 00 00       	mov    $0x1,%ebx
    103b:	e9 64 ff ff ff       	jmp    fa4 <fourfiles+0x68>
  printf(1, "fourfiles ok\n");
    1040:	83 ec 08             	sub    $0x8,%esp
    1043:	68 34 3e 00 00       	push   $0x3e34
    1048:	6a 01                	push   $0x1
    104a:	e8 75 26 00 00       	call   36c4 <printf>
}
    104f:	83 c4 10             	add    $0x10,%esp
    1052:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1055:	5b                   	pop    %ebx
    1056:	5e                   	pop    %esi
    1057:	5f                   	pop    %edi
    1058:	5d                   	pop    %ebp
    1059:	c3                   	ret
          printf(1, "wrong char\n");
    105a:	83 ec 08             	sub    $0x8,%esp
    105d:	68 17 3e 00 00       	push   $0x3e17
    1062:	6a 01                	push   $0x1
    1064:	e8 5b 26 00 00       	call   36c4 <printf>
          exit();
    1069:	e8 21 25 00 00       	call   358f <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    106e:	83 ec 08             	sub    $0x8,%esp
    1071:	68 02 02 00 00       	push   $0x202
    1076:	56                   	push   %esi
    1077:	e8 53 25 00 00       	call   35cf <open>
    107c:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    107e:	83 c4 10             	add    $0x10,%esp
    1081:	85 c0                	test   %eax,%eax
    1083:	78 3f                	js     10c4 <fourfiles+0x188>
      memset(buf, '0'+pi, 512);
    1085:	50                   	push   %eax
    1086:	68 00 02 00 00       	push   $0x200
    108b:	83 c3 30             	add    $0x30,%ebx
    108e:	53                   	push   %ebx
    108f:	68 00 79 00 00       	push   $0x7900
    1094:	e8 bf 23 00 00       	call   3458 <memset>
    1099:	83 c4 10             	add    $0x10,%esp
    109c:	bb 0c 00 00 00       	mov    $0xc,%ebx
        if((n = write(fd, buf, 500)) != 500){
    10a1:	57                   	push   %edi
    10a2:	68 f4 01 00 00       	push   $0x1f4
    10a7:	68 00 79 00 00       	push   $0x7900
    10ac:	56                   	push   %esi
    10ad:	e8 fd 24 00 00       	call   35af <write>
    10b2:	83 c4 10             	add    $0x10,%esp
    10b5:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    10ba:	75 45                	jne    1101 <fourfiles+0x1c5>
      for(i = 0; i < 12; i++){
    10bc:	4b                   	dec    %ebx
    10bd:	75 e2                	jne    10a1 <fourfiles+0x165>
      exit();
    10bf:	e8 cb 24 00 00       	call   358f <exit>
        printf(1, "create failed\n");
    10c4:	50                   	push   %eax
    10c5:	50                   	push   %eax
    10c6:	68 97 40 00 00       	push   $0x4097
    10cb:	6a 01                	push   $0x1
    10cd:	e8 f2 25 00 00       	call   36c4 <printf>
        exit();
    10d2:	e8 b8 24 00 00       	call   358f <exit>
    10d7:	90                   	nop
      printf(1, "fork failed\n");
    10d8:	83 ec 08             	sub    $0x8,%esp
    10db:	68 d1 48 00 00       	push   $0x48d1
    10e0:	6a 01                	push   $0x1
    10e2:	e8 dd 25 00 00       	call   36c4 <printf>
      exit();
    10e7:	e8 a3 24 00 00       	call   358f <exit>
      printf(1, "wrong length %d\n", total);
    10ec:	50                   	push   %eax
    10ed:	ff 75 d4             	push   -0x2c(%ebp)
    10f0:	68 23 3e 00 00       	push   $0x3e23
    10f5:	6a 01                	push   $0x1
    10f7:	e8 c8 25 00 00       	call   36c4 <printf>
      exit();
    10fc:	e8 8e 24 00 00       	call   358f <exit>
          printf(1, "write failed %d\n", n);
    1101:	51                   	push   %ecx
    1102:	50                   	push   %eax
    1103:	68 06 3e 00 00       	push   $0x3e06
    1108:	6a 01                	push   $0x1
    110a:	e8 b5 25 00 00       	call   36c4 <printf>
          exit();
    110f:	e8 7b 24 00 00       	call   358f <exit>

00001114 <createdelete>:
{
    1114:	55                   	push   %ebp
    1115:	89 e5                	mov    %esp,%ebp
    1117:	57                   	push   %edi
    1118:	56                   	push   %esi
    1119:	53                   	push   %ebx
    111a:	83 ec 44             	sub    $0x44,%esp
  printf(1, "createdelete test\n");
    111d:	68 48 3e 00 00       	push   $0x3e48
    1122:	6a 01                	push   $0x1
    1124:	e8 9b 25 00 00       	call   36c4 <printf>
    1129:	83 c4 10             	add    $0x10,%esp
  for(pi = 0; pi < 4; pi++){
    112c:	31 f6                	xor    %esi,%esi
    pid = fork();
    112e:	e8 54 24 00 00       	call   3587 <fork>
    1133:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
    1135:	85 c0                	test   %eax,%eax
    1137:	0f 88 66 01 00 00    	js     12a3 <createdelete+0x18f>
    if(pid == 0){
    113d:	0f 84 cd 00 00 00    	je     1210 <createdelete+0xfc>
  for(pi = 0; pi < 4; pi++){
    1143:	46                   	inc    %esi
    1144:	83 fe 04             	cmp    $0x4,%esi
    1147:	75 e5                	jne    112e <createdelete+0x1a>
    wait();
    1149:	e8 49 24 00 00       	call   3597 <wait>
    114e:	e8 44 24 00 00       	call   3597 <wait>
    1153:	e8 3f 24 00 00       	call   3597 <wait>
    1158:	e8 3a 24 00 00       	call   3597 <wait>
  name[0] = name[1] = name[2] = 0;
    115d:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
  for(i = 0; i < N; i++){
    1161:	31 f6                	xor    %esi,%esi
    1163:	8d 7d c8             	lea    -0x38(%ebp),%edi
    1166:	66 90                	xchg   %ax,%ax
      name[1] = '0' + i;
    1168:	8d 46 30             	lea    0x30(%esi),%eax
    116b:	88 45 c7             	mov    %al,-0x39(%ebp)
    116e:	b3 70                	mov    $0x70,%bl
      name[0] = 'p' + pi;
    1170:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    1173:	8a 45 c7             	mov    -0x39(%ebp),%al
    1176:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1179:	83 ec 08             	sub    $0x8,%esp
    117c:	6a 00                	push   $0x0
    117e:	57                   	push   %edi
    117f:	e8 4b 24 00 00       	call   35cf <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1184:	83 c4 10             	add    $0x10,%esp
    1187:	85 f6                	test   %esi,%esi
    1189:	74 05                	je     1190 <createdelete+0x7c>
    118b:	83 fe 09             	cmp    $0x9,%esi
    118e:	7e 68                	jle    11f8 <createdelete+0xe4>
    1190:	85 c0                	test   %eax,%eax
    1192:	0f 88 f8 00 00 00    	js     1290 <createdelete+0x17c>
        close(fd);
    1198:	83 ec 0c             	sub    $0xc,%esp
    119b:	50                   	push   %eax
    119c:	e8 16 24 00 00       	call   35b7 <close>
    11a1:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    11a4:	43                   	inc    %ebx
    11a5:	80 fb 74             	cmp    $0x74,%bl
    11a8:	75 c6                	jne    1170 <createdelete+0x5c>
  for(i = 0; i < N; i++){
    11aa:	46                   	inc    %esi
    11ab:	83 fe 14             	cmp    $0x14,%esi
    11ae:	75 b8                	jne    1168 <createdelete+0x54>
    11b0:	b3 70                	mov    $0x70,%bl
    11b2:	66 90                	xchg   %ax,%ax
      name[1] = '0' + i;
    11b4:	8d 43 c0             	lea    -0x40(%ebx),%eax
    11b7:	88 45 c7             	mov    %al,-0x39(%ebp)
    11ba:	be 04 00 00 00       	mov    $0x4,%esi
      name[0] = 'p' + i;
    11bf:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    11c2:	8a 45 c7             	mov    -0x39(%ebp),%al
    11c5:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    11c8:	83 ec 0c             	sub    $0xc,%esp
    11cb:	57                   	push   %edi
    11cc:	e8 0e 24 00 00       	call   35df <unlink>
    for(pi = 0; pi < 4; pi++){
    11d1:	83 c4 10             	add    $0x10,%esp
    11d4:	4e                   	dec    %esi
    11d5:	75 e8                	jne    11bf <createdelete+0xab>
  for(i = 0; i < N; i++){
    11d7:	43                   	inc    %ebx
    11d8:	80 fb 84             	cmp    $0x84,%bl
    11db:	75 d7                	jne    11b4 <createdelete+0xa0>
  printf(1, "createdelete ok\n");
    11dd:	83 ec 08             	sub    $0x8,%esp
    11e0:	68 5b 3e 00 00       	push   $0x3e5b
    11e5:	6a 01                	push   $0x1
    11e7:	e8 d8 24 00 00       	call   36c4 <printf>
}
    11ec:	83 c4 10             	add    $0x10,%esp
    11ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11f2:	5b                   	pop    %ebx
    11f3:	5e                   	pop    %esi
    11f4:	5f                   	pop    %edi
    11f5:	5d                   	pop    %ebp
    11f6:	c3                   	ret
    11f7:	90                   	nop
      } else if((i >= 1 && i < N/2) && fd >= 0){
    11f8:	85 c0                	test   %eax,%eax
    11fa:	78 a8                	js     11a4 <createdelete+0x90>
        printf(1, "oops createdelete %s did exist\n", name);
    11fc:	50                   	push   %eax
    11fd:	57                   	push   %edi
    11fe:	68 34 4b 00 00       	push   $0x4b34
    1203:	6a 01                	push   $0x1
    1205:	e8 ba 24 00 00       	call   36c4 <printf>
        exit();
    120a:	e8 80 23 00 00       	call   358f <exit>
    120f:	90                   	nop
      name[0] = 'p' + pi;
    1210:	8d 46 70             	lea    0x70(%esi),%eax
    1213:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[2] = '\0';
    1216:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
      for(i = 0; i < N; i++){
    121a:	8d 7d c8             	lea    -0x38(%ebp),%edi
    121d:	8d 76 00             	lea    0x0(%esi),%esi
        name[1] = '0' + i;
    1220:	8d 43 30             	lea    0x30(%ebx),%eax
    1223:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1226:	83 ec 08             	sub    $0x8,%esp
    1229:	68 02 02 00 00       	push   $0x202
    122e:	57                   	push   %edi
    122f:	e8 9b 23 00 00       	call   35cf <open>
        if(fd < 0){
    1234:	83 c4 10             	add    $0x10,%esp
    1237:	85 c0                	test   %eax,%eax
    1239:	78 7c                	js     12b7 <createdelete+0x1a3>
        close(fd);
    123b:	83 ec 0c             	sub    $0xc,%esp
    123e:	50                   	push   %eax
    123f:	e8 73 23 00 00       	call   35b7 <close>
        if(i > 0 && (i % 2 ) == 0){
    1244:	83 c4 10             	add    $0x10,%esp
    1247:	85 db                	test   %ebx,%ebx
    1249:	74 11                	je     125c <createdelete+0x148>
    124b:	f6 c3 01             	test   $0x1,%bl
    124e:	74 13                	je     1263 <createdelete+0x14f>
      for(i = 0; i < N; i++){
    1250:	43                   	inc    %ebx
    1251:	83 fb 14             	cmp    $0x14,%ebx
    1254:	75 ca                	jne    1220 <createdelete+0x10c>
      exit();
    1256:	e8 34 23 00 00       	call   358f <exit>
    125b:	90                   	nop
      for(i = 0; i < N; i++){
    125c:	bb 01 00 00 00       	mov    $0x1,%ebx
    1261:	eb bd                	jmp    1220 <createdelete+0x10c>
          name[1] = '0' + (i / 2);
    1263:	89 d8                	mov    %ebx,%eax
    1265:	d1 f8                	sar    %eax
    1267:	83 c0 30             	add    $0x30,%eax
    126a:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    126d:	83 ec 0c             	sub    $0xc,%esp
    1270:	57                   	push   %edi
    1271:	e8 69 23 00 00       	call   35df <unlink>
    1276:	83 c4 10             	add    $0x10,%esp
    1279:	85 c0                	test   %eax,%eax
    127b:	79 d3                	jns    1250 <createdelete+0x13c>
            printf(1, "unlink failed\n");
    127d:	51                   	push   %ecx
    127e:	51                   	push   %ecx
    127f:	68 49 3a 00 00       	push   $0x3a49
    1284:	6a 01                	push   $0x1
    1286:	e8 39 24 00 00       	call   36c4 <printf>
            exit();
    128b:	e8 ff 22 00 00       	call   358f <exit>
        printf(1, "oops createdelete %s didn't exist\n", name);
    1290:	52                   	push   %edx
    1291:	57                   	push   %edi
    1292:	68 10 4b 00 00       	push   $0x4b10
    1297:	6a 01                	push   $0x1
    1299:	e8 26 24 00 00       	call   36c4 <printf>
        exit();
    129e:	e8 ec 22 00 00       	call   358f <exit>
      printf(1, "fork failed\n");
    12a3:	83 ec 08             	sub    $0x8,%esp
    12a6:	68 d1 48 00 00       	push   $0x48d1
    12ab:	6a 01                	push   $0x1
    12ad:	e8 12 24 00 00       	call   36c4 <printf>
      exit();
    12b2:	e8 d8 22 00 00       	call   358f <exit>
          printf(1, "create failed\n");
    12b7:	83 ec 08             	sub    $0x8,%esp
    12ba:	68 97 40 00 00       	push   $0x4097
    12bf:	6a 01                	push   $0x1
    12c1:	e8 fe 23 00 00       	call   36c4 <printf>
          exit();
    12c6:	e8 c4 22 00 00       	call   358f <exit>
    12cb:	90                   	nop

000012cc <unlinkread>:
{
    12cc:	55                   	push   %ebp
    12cd:	89 e5                	mov    %esp,%ebp
    12cf:	56                   	push   %esi
    12d0:	53                   	push   %ebx
  printf(1, "unlinkread test\n");
    12d1:	83 ec 08             	sub    $0x8,%esp
    12d4:	68 6c 3e 00 00       	push   $0x3e6c
    12d9:	6a 01                	push   $0x1
    12db:	e8 e4 23 00 00       	call   36c4 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    12e0:	5e                   	pop    %esi
    12e1:	58                   	pop    %eax
    12e2:	68 02 02 00 00       	push   $0x202
    12e7:	68 7d 3e 00 00       	push   $0x3e7d
    12ec:	e8 de 22 00 00       	call   35cf <open>
  if(fd < 0){
    12f1:	83 c4 10             	add    $0x10,%esp
    12f4:	85 c0                	test   %eax,%eax
    12f6:	0f 88 e2 00 00 00    	js     13de <unlinkread+0x112>
    12fc:	89 c3                	mov    %eax,%ebx
  write(fd, "hello", 5);
    12fe:	50                   	push   %eax
    12ff:	6a 05                	push   $0x5
    1301:	68 a2 3e 00 00       	push   $0x3ea2
    1306:	53                   	push   %ebx
    1307:	e8 a3 22 00 00       	call   35af <write>
  close(fd);
    130c:	89 1c 24             	mov    %ebx,(%esp)
    130f:	e8 a3 22 00 00       	call   35b7 <close>
  fd = open("unlinkread", O_RDWR);
    1314:	5a                   	pop    %edx
    1315:	59                   	pop    %ecx
    1316:	6a 02                	push   $0x2
    1318:	68 7d 3e 00 00       	push   $0x3e7d
    131d:	e8 ad 22 00 00       	call   35cf <open>
    1322:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1324:	83 c4 10             	add    $0x10,%esp
    1327:	85 c0                	test   %eax,%eax
    1329:	0f 88 0e 01 00 00    	js     143d <unlinkread+0x171>
  if(unlink("unlinkread") != 0){
    132f:	83 ec 0c             	sub    $0xc,%esp
    1332:	68 7d 3e 00 00       	push   $0x3e7d
    1337:	e8 a3 22 00 00       	call   35df <unlink>
    133c:	83 c4 10             	add    $0x10,%esp
    133f:	85 c0                	test   %eax,%eax
    1341:	0f 85 e3 00 00 00    	jne    142a <unlinkread+0x15e>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1347:	83 ec 08             	sub    $0x8,%esp
    134a:	68 02 02 00 00       	push   $0x202
    134f:	68 7d 3e 00 00       	push   $0x3e7d
    1354:	e8 76 22 00 00       	call   35cf <open>
    1359:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    135b:	83 c4 0c             	add    $0xc,%esp
    135e:	6a 03                	push   $0x3
    1360:	68 da 3e 00 00       	push   $0x3eda
    1365:	50                   	push   %eax
    1366:	e8 44 22 00 00       	call   35af <write>
  close(fd1);
    136b:	89 34 24             	mov    %esi,(%esp)
    136e:	e8 44 22 00 00       	call   35b7 <close>
  if(read(fd, buf, sizeof(buf)) != 5){
    1373:	83 c4 0c             	add    $0xc,%esp
    1376:	68 00 20 00 00       	push   $0x2000
    137b:	68 00 79 00 00       	push   $0x7900
    1380:	53                   	push   %ebx
    1381:	e8 21 22 00 00       	call   35a7 <read>
    1386:	83 c4 10             	add    $0x10,%esp
    1389:	83 f8 05             	cmp    $0x5,%eax
    138c:	0f 85 85 00 00 00    	jne    1417 <unlinkread+0x14b>
  if(buf[0] != 'h'){
    1392:	80 3d 00 79 00 00 68 	cmpb   $0x68,0x7900
    1399:	75 69                	jne    1404 <unlinkread+0x138>
  if(write(fd, buf, 10) != 10){
    139b:	56                   	push   %esi
    139c:	6a 0a                	push   $0xa
    139e:	68 00 79 00 00       	push   $0x7900
    13a3:	53                   	push   %ebx
    13a4:	e8 06 22 00 00       	call   35af <write>
    13a9:	83 c4 10             	add    $0x10,%esp
    13ac:	83 f8 0a             	cmp    $0xa,%eax
    13af:	75 40                	jne    13f1 <unlinkread+0x125>
  close(fd);
    13b1:	83 ec 0c             	sub    $0xc,%esp
    13b4:	53                   	push   %ebx
    13b5:	e8 fd 21 00 00       	call   35b7 <close>
  unlink("unlinkread");
    13ba:	c7 04 24 7d 3e 00 00 	movl   $0x3e7d,(%esp)
    13c1:	e8 19 22 00 00       	call   35df <unlink>
  printf(1, "unlinkread ok\n");
    13c6:	58                   	pop    %eax
    13c7:	5a                   	pop    %edx
    13c8:	68 25 3f 00 00       	push   $0x3f25
    13cd:	6a 01                	push   $0x1
    13cf:	e8 f0 22 00 00       	call   36c4 <printf>
}
    13d4:	83 c4 10             	add    $0x10,%esp
    13d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    13da:	5b                   	pop    %ebx
    13db:	5e                   	pop    %esi
    13dc:	5d                   	pop    %ebp
    13dd:	c3                   	ret
    printf(1, "create unlinkread failed\n");
    13de:	53                   	push   %ebx
    13df:	53                   	push   %ebx
    13e0:	68 88 3e 00 00       	push   $0x3e88
    13e5:	6a 01                	push   $0x1
    13e7:	e8 d8 22 00 00       	call   36c4 <printf>
    exit();
    13ec:	e8 9e 21 00 00       	call   358f <exit>
    printf(1, "unlinkread write failed\n");
    13f1:	51                   	push   %ecx
    13f2:	51                   	push   %ecx
    13f3:	68 0c 3f 00 00       	push   $0x3f0c
    13f8:	6a 01                	push   $0x1
    13fa:	e8 c5 22 00 00       	call   36c4 <printf>
    exit();
    13ff:	e8 8b 21 00 00       	call   358f <exit>
    printf(1, "unlinkread wrong data\n");
    1404:	50                   	push   %eax
    1405:	50                   	push   %eax
    1406:	68 f5 3e 00 00       	push   $0x3ef5
    140b:	6a 01                	push   $0x1
    140d:	e8 b2 22 00 00       	call   36c4 <printf>
    exit();
    1412:	e8 78 21 00 00       	call   358f <exit>
    printf(1, "unlinkread read failed");
    1417:	50                   	push   %eax
    1418:	50                   	push   %eax
    1419:	68 de 3e 00 00       	push   $0x3ede
    141e:	6a 01                	push   $0x1
    1420:	e8 9f 22 00 00       	call   36c4 <printf>
    exit();
    1425:	e8 65 21 00 00       	call   358f <exit>
    printf(1, "unlink unlinkread failed\n");
    142a:	50                   	push   %eax
    142b:	50                   	push   %eax
    142c:	68 c0 3e 00 00       	push   $0x3ec0
    1431:	6a 01                	push   $0x1
    1433:	e8 8c 22 00 00       	call   36c4 <printf>
    exit();
    1438:	e8 52 21 00 00       	call   358f <exit>
    printf(1, "open unlinkread failed\n");
    143d:	50                   	push   %eax
    143e:	50                   	push   %eax
    143f:	68 a8 3e 00 00       	push   $0x3ea8
    1444:	6a 01                	push   $0x1
    1446:	e8 79 22 00 00       	call   36c4 <printf>
    exit();
    144b:	e8 3f 21 00 00       	call   358f <exit>

00001450 <linktest>:
{
    1450:	55                   	push   %ebp
    1451:	89 e5                	mov    %esp,%ebp
    1453:	53                   	push   %ebx
    1454:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "linktest\n");
    1457:	68 34 3f 00 00       	push   $0x3f34
    145c:	6a 01                	push   $0x1
    145e:	e8 61 22 00 00       	call   36c4 <printf>
  unlink("lf1");
    1463:	c7 04 24 3e 3f 00 00 	movl   $0x3f3e,(%esp)
    146a:	e8 70 21 00 00       	call   35df <unlink>
  unlink("lf2");
    146f:	c7 04 24 42 3f 00 00 	movl   $0x3f42,(%esp)
    1476:	e8 64 21 00 00       	call   35df <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    147b:	58                   	pop    %eax
    147c:	5a                   	pop    %edx
    147d:	68 02 02 00 00       	push   $0x202
    1482:	68 3e 3f 00 00       	push   $0x3f3e
    1487:	e8 43 21 00 00       	call   35cf <open>
  if(fd < 0){
    148c:	83 c4 10             	add    $0x10,%esp
    148f:	85 c0                	test   %eax,%eax
    1491:	0f 88 1a 01 00 00    	js     15b1 <linktest+0x161>
    1497:	89 c3                	mov    %eax,%ebx
  if(write(fd, "hello", 5) != 5){
    1499:	50                   	push   %eax
    149a:	6a 05                	push   $0x5
    149c:	68 a2 3e 00 00       	push   $0x3ea2
    14a1:	53                   	push   %ebx
    14a2:	e8 08 21 00 00       	call   35af <write>
    14a7:	83 c4 10             	add    $0x10,%esp
    14aa:	83 f8 05             	cmp    $0x5,%eax
    14ad:	0f 85 96 01 00 00    	jne    1649 <linktest+0x1f9>
  close(fd);
    14b3:	83 ec 0c             	sub    $0xc,%esp
    14b6:	53                   	push   %ebx
    14b7:	e8 fb 20 00 00       	call   35b7 <close>
  if(link("lf1", "lf2") < 0){
    14bc:	5b                   	pop    %ebx
    14bd:	58                   	pop    %eax
    14be:	68 42 3f 00 00       	push   $0x3f42
    14c3:	68 3e 3f 00 00       	push   $0x3f3e
    14c8:	e8 22 21 00 00       	call   35ef <link>
    14cd:	83 c4 10             	add    $0x10,%esp
    14d0:	85 c0                	test   %eax,%eax
    14d2:	0f 88 5e 01 00 00    	js     1636 <linktest+0x1e6>
  unlink("lf1");
    14d8:	83 ec 0c             	sub    $0xc,%esp
    14db:	68 3e 3f 00 00       	push   $0x3f3e
    14e0:	e8 fa 20 00 00       	call   35df <unlink>
  if(open("lf1", 0) >= 0){
    14e5:	58                   	pop    %eax
    14e6:	5a                   	pop    %edx
    14e7:	6a 00                	push   $0x0
    14e9:	68 3e 3f 00 00       	push   $0x3f3e
    14ee:	e8 dc 20 00 00       	call   35cf <open>
    14f3:	83 c4 10             	add    $0x10,%esp
    14f6:	85 c0                	test   %eax,%eax
    14f8:	0f 89 25 01 00 00    	jns    1623 <linktest+0x1d3>
  fd = open("lf2", 0);
    14fe:	83 ec 08             	sub    $0x8,%esp
    1501:	6a 00                	push   $0x0
    1503:	68 42 3f 00 00       	push   $0x3f42
    1508:	e8 c2 20 00 00       	call   35cf <open>
    150d:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    150f:	83 c4 10             	add    $0x10,%esp
    1512:	85 c0                	test   %eax,%eax
    1514:	0f 88 f6 00 00 00    	js     1610 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != 5){
    151a:	50                   	push   %eax
    151b:	68 00 20 00 00       	push   $0x2000
    1520:	68 00 79 00 00       	push   $0x7900
    1525:	53                   	push   %ebx
    1526:	e8 7c 20 00 00       	call   35a7 <read>
    152b:	83 c4 10             	add    $0x10,%esp
    152e:	83 f8 05             	cmp    $0x5,%eax
    1531:	0f 85 c6 00 00 00    	jne    15fd <linktest+0x1ad>
  close(fd);
    1537:	83 ec 0c             	sub    $0xc,%esp
    153a:	53                   	push   %ebx
    153b:	e8 77 20 00 00       	call   35b7 <close>
  if(link("lf2", "lf2") >= 0){
    1540:	58                   	pop    %eax
    1541:	5a                   	pop    %edx
    1542:	68 42 3f 00 00       	push   $0x3f42
    1547:	68 42 3f 00 00       	push   $0x3f42
    154c:	e8 9e 20 00 00       	call   35ef <link>
    1551:	83 c4 10             	add    $0x10,%esp
    1554:	85 c0                	test   %eax,%eax
    1556:	0f 89 8e 00 00 00    	jns    15ea <linktest+0x19a>
  unlink("lf2");
    155c:	83 ec 0c             	sub    $0xc,%esp
    155f:	68 42 3f 00 00       	push   $0x3f42
    1564:	e8 76 20 00 00       	call   35df <unlink>
  if(link("lf2", "lf1") >= 0){
    1569:	59                   	pop    %ecx
    156a:	5b                   	pop    %ebx
    156b:	68 3e 3f 00 00       	push   $0x3f3e
    1570:	68 42 3f 00 00       	push   $0x3f42
    1575:	e8 75 20 00 00       	call   35ef <link>
    157a:	83 c4 10             	add    $0x10,%esp
    157d:	85 c0                	test   %eax,%eax
    157f:	79 56                	jns    15d7 <linktest+0x187>
  if(link(".", "lf1") >= 0){
    1581:	83 ec 08             	sub    $0x8,%esp
    1584:	68 3e 3f 00 00       	push   $0x3f3e
    1589:	68 06 42 00 00       	push   $0x4206
    158e:	e8 5c 20 00 00       	call   35ef <link>
    1593:	83 c4 10             	add    $0x10,%esp
    1596:	85 c0                	test   %eax,%eax
    1598:	79 2a                	jns    15c4 <linktest+0x174>
  printf(1, "linktest ok\n");
    159a:	83 ec 08             	sub    $0x8,%esp
    159d:	68 dc 3f 00 00       	push   $0x3fdc
    15a2:	6a 01                	push   $0x1
    15a4:	e8 1b 21 00 00       	call   36c4 <printf>
}
    15a9:	83 c4 10             	add    $0x10,%esp
    15ac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    15af:	c9                   	leave
    15b0:	c3                   	ret
    printf(1, "create lf1 failed\n");
    15b1:	50                   	push   %eax
    15b2:	50                   	push   %eax
    15b3:	68 46 3f 00 00       	push   $0x3f46
    15b8:	6a 01                	push   $0x1
    15ba:	e8 05 21 00 00       	call   36c4 <printf>
    exit();
    15bf:	e8 cb 1f 00 00       	call   358f <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    15c4:	50                   	push   %eax
    15c5:	50                   	push   %eax
    15c6:	68 c0 3f 00 00       	push   $0x3fc0
    15cb:	6a 01                	push   $0x1
    15cd:	e8 f2 20 00 00       	call   36c4 <printf>
    exit();
    15d2:	e8 b8 1f 00 00       	call   358f <exit>
    printf(1, "link non-existant succeeded! oops\n");
    15d7:	52                   	push   %edx
    15d8:	52                   	push   %edx
    15d9:	68 7c 4b 00 00       	push   $0x4b7c
    15de:	6a 01                	push   $0x1
    15e0:	e8 df 20 00 00       	call   36c4 <printf>
    exit();
    15e5:	e8 a5 1f 00 00       	call   358f <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    15ea:	50                   	push   %eax
    15eb:	50                   	push   %eax
    15ec:	68 a2 3f 00 00       	push   $0x3fa2
    15f1:	6a 01                	push   $0x1
    15f3:	e8 cc 20 00 00       	call   36c4 <printf>
    exit();
    15f8:	e8 92 1f 00 00       	call   358f <exit>
    printf(1, "read lf2 failed\n");
    15fd:	51                   	push   %ecx
    15fe:	51                   	push   %ecx
    15ff:	68 91 3f 00 00       	push   $0x3f91
    1604:	6a 01                	push   $0x1
    1606:	e8 b9 20 00 00       	call   36c4 <printf>
    exit();
    160b:	e8 7f 1f 00 00       	call   358f <exit>
    printf(1, "open lf2 failed\n");
    1610:	50                   	push   %eax
    1611:	50                   	push   %eax
    1612:	68 80 3f 00 00       	push   $0x3f80
    1617:	6a 01                	push   $0x1
    1619:	e8 a6 20 00 00       	call   36c4 <printf>
    exit();
    161e:	e8 6c 1f 00 00       	call   358f <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    1623:	50                   	push   %eax
    1624:	50                   	push   %eax
    1625:	68 54 4b 00 00       	push   $0x4b54
    162a:	6a 01                	push   $0x1
    162c:	e8 93 20 00 00       	call   36c4 <printf>
    exit();
    1631:	e8 59 1f 00 00       	call   358f <exit>
    printf(1, "link lf1 lf2 failed\n");
    1636:	51                   	push   %ecx
    1637:	51                   	push   %ecx
    1638:	68 6b 3f 00 00       	push   $0x3f6b
    163d:	6a 01                	push   $0x1
    163f:	e8 80 20 00 00       	call   36c4 <printf>
    exit();
    1644:	e8 46 1f 00 00       	call   358f <exit>
    printf(1, "write lf1 failed\n");
    1649:	50                   	push   %eax
    164a:	50                   	push   %eax
    164b:	68 59 3f 00 00       	push   $0x3f59
    1650:	6a 01                	push   $0x1
    1652:	e8 6d 20 00 00       	call   36c4 <printf>
    exit();
    1657:	e8 33 1f 00 00       	call   358f <exit>

0000165c <concreate>:
{
    165c:	55                   	push   %ebp
    165d:	89 e5                	mov    %esp,%ebp
    165f:	57                   	push   %edi
    1660:	56                   	push   %esi
    1661:	53                   	push   %ebx
    1662:	83 ec 64             	sub    $0x64,%esp
  printf(1, "concreate test\n");
    1665:	68 e9 3f 00 00       	push   $0x3fe9
    166a:	6a 01                	push   $0x1
    166c:	e8 53 20 00 00       	call   36c4 <printf>
  file[0] = 'C';
    1671:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    1675:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    1679:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 40; i++){
    167c:	31 f6                	xor    %esi,%esi
    167e:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    1681:	bf 03 00 00 00       	mov    $0x3,%edi
    1686:	eb 38                	jmp    16c0 <concreate+0x64>
    1688:	89 f0                	mov    %esi,%eax
    168a:	99                   	cltd
    168b:	f7 ff                	idiv   %edi
    if(pid && (i % 3) == 1){
    168d:	4a                   	dec    %edx
    168e:	0f 84 84 00 00 00    	je     1718 <concreate+0xbc>
      fd = open(file, O_CREATE | O_RDWR);
    1694:	83 ec 08             	sub    $0x8,%esp
    1697:	68 02 02 00 00       	push   $0x202
    169c:	53                   	push   %ebx
    169d:	e8 2d 1f 00 00       	call   35cf <open>
      if(fd < 0){
    16a2:	83 c4 10             	add    $0x10,%esp
    16a5:	85 c0                	test   %eax,%eax
    16a7:	78 5c                	js     1705 <concreate+0xa9>
      close(fd);
    16a9:	83 ec 0c             	sub    $0xc,%esp
    16ac:	50                   	push   %eax
    16ad:	e8 05 1f 00 00       	call   35b7 <close>
    16b2:	83 c4 10             	add    $0x10,%esp
      wait();
    16b5:	e8 dd 1e 00 00       	call   3597 <wait>
  for(i = 0; i < 40; i++){
    16ba:	46                   	inc    %esi
    16bb:	83 fe 28             	cmp    $0x28,%esi
    16be:	74 74                	je     1734 <concreate+0xd8>
    file[1] = '0' + i;
    16c0:	8d 46 30             	lea    0x30(%esi),%eax
    16c3:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    16c6:	83 ec 0c             	sub    $0xc,%esp
    16c9:	53                   	push   %ebx
    16ca:	e8 10 1f 00 00       	call   35df <unlink>
    pid = fork();
    16cf:	e8 b3 1e 00 00       	call   3587 <fork>
    if(pid && (i % 3) == 1){
    16d4:	83 c4 10             	add    $0x10,%esp
    16d7:	85 c0                	test   %eax,%eax
    16d9:	75 ad                	jne    1688 <concreate+0x2c>
      link("C0", file);
    16db:	b9 05 00 00 00       	mov    $0x5,%ecx
    16e0:	89 f0                	mov    %esi,%eax
    16e2:	99                   	cltd
    16e3:	f7 f9                	idiv   %ecx
    } else if(pid == 0 && (i % 5) == 1){
    16e5:	4a                   	dec    %edx
    16e6:	0f 84 c0 00 00 00    	je     17ac <concreate+0x150>
      fd = open(file, O_CREATE | O_RDWR);
    16ec:	83 ec 08             	sub    $0x8,%esp
    16ef:	68 02 02 00 00       	push   $0x202
    16f4:	53                   	push   %ebx
    16f5:	e8 d5 1e 00 00       	call   35cf <open>
      if(fd < 0){
    16fa:	83 c4 10             	add    $0x10,%esp
    16fd:	85 c0                	test   %eax,%eax
    16ff:	0f 89 be 01 00 00    	jns    18c3 <concreate+0x267>
        printf(1, "concreate create %s failed\n", file);
    1705:	51                   	push   %ecx
    1706:	53                   	push   %ebx
    1707:	68 fc 3f 00 00       	push   $0x3ffc
    170c:	6a 01                	push   $0x1
    170e:	e8 b1 1f 00 00       	call   36c4 <printf>
        exit();
    1713:	e8 77 1e 00 00       	call   358f <exit>
      link("C0", file);
    1718:	83 ec 08             	sub    $0x8,%esp
    171b:	53                   	push   %ebx
    171c:	68 f9 3f 00 00       	push   $0x3ff9
    1721:	e8 c9 1e 00 00       	call   35ef <link>
    1726:	83 c4 10             	add    $0x10,%esp
      wait();
    1729:	e8 69 1e 00 00       	call   3597 <wait>
  for(i = 0; i < 40; i++){
    172e:	46                   	inc    %esi
    172f:	83 fe 28             	cmp    $0x28,%esi
    1732:	75 8c                	jne    16c0 <concreate+0x64>
  memset(fa, 0, sizeof(fa));
    1734:	50                   	push   %eax
    1735:	6a 28                	push   $0x28
    1737:	6a 00                	push   $0x0
    1739:	8d 45 c0             	lea    -0x40(%ebp),%eax
    173c:	50                   	push   %eax
    173d:	e8 16 1d 00 00       	call   3458 <memset>
  fd = open(".", 0);
    1742:	58                   	pop    %eax
    1743:	5a                   	pop    %edx
    1744:	6a 00                	push   $0x0
    1746:	68 06 42 00 00       	push   $0x4206
    174b:	e8 7f 1e 00 00       	call   35cf <open>
    1750:	89 c6                	mov    %eax,%esi
  while(read(fd, &de, sizeof(de)) > 0){
    1752:	83 c4 10             	add    $0x10,%esp
  n = 0;
    1755:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    175c:	8d 7d b0             	lea    -0x50(%ebp),%edi
    175f:	90                   	nop
  while(read(fd, &de, sizeof(de)) > 0){
    1760:	50                   	push   %eax
    1761:	6a 10                	push   $0x10
    1763:	57                   	push   %edi
    1764:	56                   	push   %esi
    1765:	e8 3d 1e 00 00       	call   35a7 <read>
    176a:	83 c4 10             	add    $0x10,%esp
    176d:	85 c0                	test   %eax,%eax
    176f:	7e 53                	jle    17c4 <concreate+0x168>
    if(de.inum == 0)
    1771:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1776:	74 e8                	je     1760 <concreate+0x104>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1778:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    177c:	75 e2                	jne    1760 <concreate+0x104>
    177e:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1782:	75 dc                	jne    1760 <concreate+0x104>
      i = de.name[1] - '0';
    1784:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    1788:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    178b:	83 f8 27             	cmp    $0x27,%eax
    178e:	0f 87 40 01 00 00    	ja     18d4 <concreate+0x278>
      if(fa[i]){
    1794:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    1799:	0f 85 5e 01 00 00    	jne    18fd <concreate+0x2a1>
      fa[i] = 1;
    179f:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    17a4:	ff 45 a4             	incl   -0x5c(%ebp)
    17a7:	eb b7                	jmp    1760 <concreate+0x104>
    17a9:	8d 76 00             	lea    0x0(%esi),%esi
      link("C0", file);
    17ac:	83 ec 08             	sub    $0x8,%esp
    17af:	53                   	push   %ebx
    17b0:	68 f9 3f 00 00       	push   $0x3ff9
    17b5:	e8 35 1e 00 00       	call   35ef <link>
    17ba:	83 c4 10             	add    $0x10,%esp
      exit();
    17bd:	e8 cd 1d 00 00       	call   358f <exit>
    17c2:	66 90                	xchg   %ax,%ax
  close(fd);
    17c4:	83 ec 0c             	sub    $0xc,%esp
    17c7:	56                   	push   %esi
    17c8:	e8 ea 1d 00 00       	call   35b7 <close>
  if(n != 40){
    17cd:	83 c4 10             	add    $0x10,%esp
    17d0:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    17d4:	0f 85 10 01 00 00    	jne    18ea <concreate+0x28e>
  for(i = 0; i < 40; i++){
    17da:	31 f6                	xor    %esi,%esi
    17dc:	eb 65                	jmp    1843 <concreate+0x1e7>
    17de:	66 90                	xchg   %ax,%ax
    if(((i % 3) == 0 && pid == 0) ||
    17e0:	85 ff                	test   %edi,%edi
    17e2:	0f 85 89 00 00 00    	jne    1871 <concreate+0x215>
      close(open(file, 0));
    17e8:	83 ec 08             	sub    $0x8,%esp
    17eb:	6a 00                	push   $0x0
    17ed:	53                   	push   %ebx
    17ee:	e8 dc 1d 00 00       	call   35cf <open>
    17f3:	89 04 24             	mov    %eax,(%esp)
    17f6:	e8 bc 1d 00 00       	call   35b7 <close>
      close(open(file, 0));
    17fb:	58                   	pop    %eax
    17fc:	5a                   	pop    %edx
    17fd:	6a 00                	push   $0x0
    17ff:	53                   	push   %ebx
    1800:	e8 ca 1d 00 00       	call   35cf <open>
    1805:	89 04 24             	mov    %eax,(%esp)
    1808:	e8 aa 1d 00 00       	call   35b7 <close>
      close(open(file, 0));
    180d:	59                   	pop    %ecx
    180e:	58                   	pop    %eax
    180f:	6a 00                	push   $0x0
    1811:	53                   	push   %ebx
    1812:	e8 b8 1d 00 00       	call   35cf <open>
    1817:	89 04 24             	mov    %eax,(%esp)
    181a:	e8 98 1d 00 00       	call   35b7 <close>
      close(open(file, 0));
    181f:	58                   	pop    %eax
    1820:	5a                   	pop    %edx
    1821:	6a 00                	push   $0x0
    1823:	53                   	push   %ebx
    1824:	e8 a6 1d 00 00       	call   35cf <open>
    1829:	89 04 24             	mov    %eax,(%esp)
    182c:	e8 86 1d 00 00       	call   35b7 <close>
    1831:	83 c4 10             	add    $0x10,%esp
    if(pid == 0)
    1834:	85 ff                	test   %edi,%edi
    1836:	74 85                	je     17bd <concreate+0x161>
      wait();
    1838:	e8 5a 1d 00 00       	call   3597 <wait>
  for(i = 0; i < 40; i++){
    183d:	46                   	inc    %esi
    183e:	83 fe 28             	cmp    $0x28,%esi
    1841:	74 55                	je     1898 <concreate+0x23c>
    file[1] = '0' + i;
    1843:	8d 46 30             	lea    0x30(%esi),%eax
    1846:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork();
    1849:	e8 39 1d 00 00       	call   3587 <fork>
    184e:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    1850:	85 c0                	test   %eax,%eax
    1852:	78 5b                	js     18af <concreate+0x253>
    if(((i % 3) == 0 && pid == 0) ||
    1854:	89 f0                	mov    %esi,%eax
    1856:	b9 03 00 00 00       	mov    $0x3,%ecx
    185b:	99                   	cltd
    185c:	f7 f9                	idiv   %ecx
    185e:	85 d2                	test   %edx,%edx
    1860:	0f 84 7a ff ff ff    	je     17e0 <concreate+0x184>
    1866:	4a                   	dec    %edx
    1867:	75 08                	jne    1871 <concreate+0x215>
       ((i % 3) == 1 && pid != 0)){
    1869:	85 ff                	test   %edi,%edi
    186b:	0f 85 77 ff ff ff    	jne    17e8 <concreate+0x18c>
      unlink(file);
    1871:	83 ec 0c             	sub    $0xc,%esp
    1874:	53                   	push   %ebx
    1875:	e8 65 1d 00 00       	call   35df <unlink>
      unlink(file);
    187a:	89 1c 24             	mov    %ebx,(%esp)
    187d:	e8 5d 1d 00 00       	call   35df <unlink>
      unlink(file);
    1882:	89 1c 24             	mov    %ebx,(%esp)
    1885:	e8 55 1d 00 00       	call   35df <unlink>
      unlink(file);
    188a:	89 1c 24             	mov    %ebx,(%esp)
    188d:	e8 4d 1d 00 00       	call   35df <unlink>
    1892:	83 c4 10             	add    $0x10,%esp
    1895:	eb 9d                	jmp    1834 <concreate+0x1d8>
    1897:	90                   	nop
  printf(1, "concreate ok\n");
    1898:	83 ec 08             	sub    $0x8,%esp
    189b:	68 4e 40 00 00       	push   $0x404e
    18a0:	6a 01                	push   $0x1
    18a2:	e8 1d 1e 00 00       	call   36c4 <printf>
}
    18a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    18aa:	5b                   	pop    %ebx
    18ab:	5e                   	pop    %esi
    18ac:	5f                   	pop    %edi
    18ad:	5d                   	pop    %ebp
    18ae:	c3                   	ret
      printf(1, "fork failed\n");
    18af:	83 ec 08             	sub    $0x8,%esp
    18b2:	68 d1 48 00 00       	push   $0x48d1
    18b7:	6a 01                	push   $0x1
    18b9:	e8 06 1e 00 00       	call   36c4 <printf>
      exit();
    18be:	e8 cc 1c 00 00       	call   358f <exit>
      close(fd);
    18c3:	83 ec 0c             	sub    $0xc,%esp
    18c6:	50                   	push   %eax
    18c7:	e8 eb 1c 00 00       	call   35b7 <close>
    18cc:	83 c4 10             	add    $0x10,%esp
    18cf:	e9 e9 fe ff ff       	jmp    17bd <concreate+0x161>
        printf(1, "concreate weird file %s\n", de.name);
    18d4:	50                   	push   %eax
    18d5:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    18d8:	50                   	push   %eax
    18d9:	68 18 40 00 00       	push   $0x4018
    18de:	6a 01                	push   $0x1
    18e0:	e8 df 1d 00 00       	call   36c4 <printf>
        exit();
    18e5:	e8 a5 1c 00 00       	call   358f <exit>
    printf(1, "concreate not enough files in directory listing\n");
    18ea:	51                   	push   %ecx
    18eb:	51                   	push   %ecx
    18ec:	68 a0 4b 00 00       	push   $0x4ba0
    18f1:	6a 01                	push   $0x1
    18f3:	e8 cc 1d 00 00       	call   36c4 <printf>
    exit();
    18f8:	e8 92 1c 00 00       	call   358f <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    18fd:	50                   	push   %eax
    18fe:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1901:	50                   	push   %eax
    1902:	68 31 40 00 00       	push   $0x4031
    1907:	6a 01                	push   $0x1
    1909:	e8 b6 1d 00 00       	call   36c4 <printf>
        exit();
    190e:	e8 7c 1c 00 00       	call   358f <exit>
    1913:	90                   	nop

00001914 <linkunlink>:
{
    1914:	55                   	push   %ebp
    1915:	89 e5                	mov    %esp,%ebp
    1917:	57                   	push   %edi
    1918:	56                   	push   %esi
    1919:	53                   	push   %ebx
    191a:	83 ec 24             	sub    $0x24,%esp
  printf(1, "linkunlink test\n");
    191d:	68 5c 40 00 00       	push   $0x405c
    1922:	6a 01                	push   $0x1
    1924:	e8 9b 1d 00 00       	call   36c4 <printf>
  unlink("x");
    1929:	c7 04 24 e9 42 00 00 	movl   $0x42e9,(%esp)
    1930:	e8 aa 1c 00 00       	call   35df <unlink>
  pid = fork();
    1935:	e8 4d 1c 00 00       	call   3587 <fork>
    193a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    193d:	83 c4 10             	add    $0x10,%esp
    1940:	85 c0                	test   %eax,%eax
    1942:	0f 88 c2 00 00 00    	js     1a0a <linkunlink+0xf6>
  unsigned int x = (pid ? 1 : 97);
    1948:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    194c:	19 ff                	sbb    %edi,%edi
    194e:	83 e7 60             	and    $0x60,%edi
    1951:	47                   	inc    %edi
    1952:	bb 64 00 00 00       	mov    $0x64,%ebx
    if((x % 3) == 0){
    1957:	be 03 00 00 00       	mov    $0x3,%esi
    195c:	eb 1c                	jmp    197a <linkunlink+0x66>
    195e:	66 90                	xchg   %ax,%ax
    } else if((x % 3) == 1){
    1960:	4a                   	dec    %edx
    1961:	0f 84 89 00 00 00    	je     19f0 <linkunlink+0xdc>
      unlink("x");
    1967:	83 ec 0c             	sub    $0xc,%esp
    196a:	68 e9 42 00 00       	push   $0x42e9
    196f:	e8 6b 1c 00 00       	call   35df <unlink>
    1974:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1977:	4b                   	dec    %ebx
    1978:	74 52                	je     19cc <linkunlink+0xb8>
    x = x * 1103515245 + 12345;
    197a:	89 f8                	mov    %edi,%eax
    197c:	c1 e0 09             	shl    $0x9,%eax
    197f:	29 f8                	sub    %edi,%eax
    1981:	8d 14 87             	lea    (%edi,%eax,4),%edx
    1984:	89 d0                	mov    %edx,%eax
    1986:	c1 e0 09             	shl    $0x9,%eax
    1989:	29 d0                	sub    %edx,%eax
    198b:	01 c0                	add    %eax,%eax
    198d:	01 f8                	add    %edi,%eax
    198f:	89 c2                	mov    %eax,%edx
    1991:	c1 e2 05             	shl    $0x5,%edx
    1994:	01 d0                	add    %edx,%eax
    1996:	c1 e0 02             	shl    $0x2,%eax
    1999:	29 f8                	sub    %edi,%eax
    199b:	8d bc 87 39 30 00 00 	lea    0x3039(%edi,%eax,4),%edi
    if((x % 3) == 0){
    19a2:	89 f8                	mov    %edi,%eax
    19a4:	31 d2                	xor    %edx,%edx
    19a6:	f7 f6                	div    %esi
    19a8:	85 d2                	test   %edx,%edx
    19aa:	75 b4                	jne    1960 <linkunlink+0x4c>
      close(open("x", O_RDWR | O_CREATE));
    19ac:	83 ec 08             	sub    $0x8,%esp
    19af:	68 02 02 00 00       	push   $0x202
    19b4:	68 e9 42 00 00       	push   $0x42e9
    19b9:	e8 11 1c 00 00       	call   35cf <open>
    19be:	89 04 24             	mov    %eax,(%esp)
    19c1:	e8 f1 1b 00 00       	call   35b7 <close>
    19c6:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    19c9:	4b                   	dec    %ebx
    19ca:	75 ae                	jne    197a <linkunlink+0x66>
  if(pid)
    19cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19cf:	85 c0                	test   %eax,%eax
    19d1:	74 4a                	je     1a1d <linkunlink+0x109>
    wait();
    19d3:	e8 bf 1b 00 00       	call   3597 <wait>
  printf(1, "linkunlink ok\n");
    19d8:	83 ec 08             	sub    $0x8,%esp
    19db:	68 71 40 00 00       	push   $0x4071
    19e0:	6a 01                	push   $0x1
    19e2:	e8 dd 1c 00 00       	call   36c4 <printf>
}
    19e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    19ea:	5b                   	pop    %ebx
    19eb:	5e                   	pop    %esi
    19ec:	5f                   	pop    %edi
    19ed:	5d                   	pop    %ebp
    19ee:	c3                   	ret
    19ef:	90                   	nop
      link("cat", "x");
    19f0:	83 ec 08             	sub    $0x8,%esp
    19f3:	68 e9 42 00 00       	push   $0x42e9
    19f8:	68 6d 40 00 00       	push   $0x406d
    19fd:	e8 ed 1b 00 00       	call   35ef <link>
    1a02:	83 c4 10             	add    $0x10,%esp
    1a05:	e9 6d ff ff ff       	jmp    1977 <linkunlink+0x63>
    printf(1, "fork failed\n");
    1a0a:	52                   	push   %edx
    1a0b:	52                   	push   %edx
    1a0c:	68 d1 48 00 00       	push   $0x48d1
    1a11:	6a 01                	push   $0x1
    1a13:	e8 ac 1c 00 00       	call   36c4 <printf>
    exit();
    1a18:	e8 72 1b 00 00       	call   358f <exit>
    exit();
    1a1d:	e8 6d 1b 00 00       	call   358f <exit>
    1a22:	66 90                	xchg   %ax,%ax

00001a24 <bigdir>:
{
    1a24:	55                   	push   %ebp
    1a25:	89 e5                	mov    %esp,%ebp
    1a27:	57                   	push   %edi
    1a28:	56                   	push   %esi
    1a29:	53                   	push   %ebx
    1a2a:	83 ec 24             	sub    $0x24,%esp
  printf(1, "bigdir test\n");
    1a2d:	68 80 40 00 00       	push   $0x4080
    1a32:	6a 01                	push   $0x1
    1a34:	e8 8b 1c 00 00       	call   36c4 <printf>
  unlink("bd");
    1a39:	c7 04 24 8d 40 00 00 	movl   $0x408d,(%esp)
    1a40:	e8 9a 1b 00 00       	call   35df <unlink>
  fd = open("bd", O_CREATE);
    1a45:	5a                   	pop    %edx
    1a46:	59                   	pop    %ecx
    1a47:	68 00 02 00 00       	push   $0x200
    1a4c:	68 8d 40 00 00       	push   $0x408d
    1a51:	e8 79 1b 00 00       	call   35cf <open>
  if(fd < 0){
    1a56:	83 c4 10             	add    $0x10,%esp
    1a59:	85 c0                	test   %eax,%eax
    1a5b:	0f 88 dc 00 00 00    	js     1b3d <bigdir+0x119>
  close(fd);
    1a61:	83 ec 0c             	sub    $0xc,%esp
    1a64:	50                   	push   %eax
    1a65:	e8 4d 1b 00 00       	call   35b7 <close>
    1a6a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    1a6d:	31 f6                	xor    %esi,%esi
    1a6f:	8d 7d de             	lea    -0x22(%ebp),%edi
    1a72:	66 90                	xchg   %ax,%ax
    name[0] = 'x';
    1a74:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1a78:	89 f0                	mov    %esi,%eax
    1a7a:	c1 f8 06             	sar    $0x6,%eax
    1a7d:	83 c0 30             	add    $0x30,%eax
    1a80:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1a83:	89 f0                	mov    %esi,%eax
    1a85:	83 e0 3f             	and    $0x3f,%eax
    1a88:	83 c0 30             	add    $0x30,%eax
    1a8b:	88 45 e0             	mov    %al,-0x20(%ebp)
    name[3] = '\0';
    1a8e:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    if(link("bd", name) != 0){
    1a92:	83 ec 08             	sub    $0x8,%esp
    1a95:	57                   	push   %edi
    1a96:	68 8d 40 00 00       	push   $0x408d
    1a9b:	e8 4f 1b 00 00       	call   35ef <link>
    1aa0:	89 c3                	mov    %eax,%ebx
    1aa2:	83 c4 10             	add    $0x10,%esp
    1aa5:	85 c0                	test   %eax,%eax
    1aa7:	75 6c                	jne    1b15 <bigdir+0xf1>
  for(i = 0; i < 500; i++){
    1aa9:	46                   	inc    %esi
    1aaa:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1ab0:	75 c2                	jne    1a74 <bigdir+0x50>
  unlink("bd");
    1ab2:	83 ec 0c             	sub    $0xc,%esp
    1ab5:	68 8d 40 00 00       	push   $0x408d
    1aba:	e8 20 1b 00 00       	call   35df <unlink>
    1abf:	83 c4 10             	add    $0x10,%esp
    1ac2:	66 90                	xchg   %ax,%ax
    name[0] = 'x';
    1ac4:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1ac8:	89 d8                	mov    %ebx,%eax
    1aca:	c1 f8 06             	sar    $0x6,%eax
    1acd:	83 c0 30             	add    $0x30,%eax
    1ad0:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1ad3:	89 d8                	mov    %ebx,%eax
    1ad5:	83 e0 3f             	and    $0x3f,%eax
    1ad8:	83 c0 30             	add    $0x30,%eax
    1adb:	88 45 e0             	mov    %al,-0x20(%ebp)
    name[3] = '\0';
    1ade:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    if(unlink(name) != 0){
    1ae2:	83 ec 0c             	sub    $0xc,%esp
    1ae5:	57                   	push   %edi
    1ae6:	e8 f4 1a 00 00       	call   35df <unlink>
    1aeb:	83 c4 10             	add    $0x10,%esp
    1aee:	85 c0                	test   %eax,%eax
    1af0:	75 37                	jne    1b29 <bigdir+0x105>
  for(i = 0; i < 500; i++){
    1af2:	43                   	inc    %ebx
    1af3:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1af9:	75 c9                	jne    1ac4 <bigdir+0xa0>
  printf(1, "bigdir ok\n");
    1afb:	83 ec 08             	sub    $0x8,%esp
    1afe:	68 cf 40 00 00       	push   $0x40cf
    1b03:	6a 01                	push   $0x1
    1b05:	e8 ba 1b 00 00       	call   36c4 <printf>
    1b0a:	83 c4 10             	add    $0x10,%esp
}
    1b0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b10:	5b                   	pop    %ebx
    1b11:	5e                   	pop    %esi
    1b12:	5f                   	pop    %edi
    1b13:	5d                   	pop    %ebp
    1b14:	c3                   	ret
      printf(1, "bigdir link failed\n");
    1b15:	83 ec 08             	sub    $0x8,%esp
    1b18:	68 a6 40 00 00       	push   $0x40a6
    1b1d:	6a 01                	push   $0x1
    1b1f:	e8 a0 1b 00 00       	call   36c4 <printf>
      exit();
    1b24:	e8 66 1a 00 00       	call   358f <exit>
      printf(1, "bigdir unlink failed");
    1b29:	83 ec 08             	sub    $0x8,%esp
    1b2c:	68 ba 40 00 00       	push   $0x40ba
    1b31:	6a 01                	push   $0x1
    1b33:	e8 8c 1b 00 00       	call   36c4 <printf>
      exit();
    1b38:	e8 52 1a 00 00       	call   358f <exit>
    printf(1, "bigdir create failed\n");
    1b3d:	50                   	push   %eax
    1b3e:	50                   	push   %eax
    1b3f:	68 90 40 00 00       	push   $0x4090
    1b44:	6a 01                	push   $0x1
    1b46:	e8 79 1b 00 00       	call   36c4 <printf>
    exit();
    1b4b:	e8 3f 1a 00 00       	call   358f <exit>

00001b50 <subdir>:
{
    1b50:	55                   	push   %ebp
    1b51:	89 e5                	mov    %esp,%ebp
    1b53:	53                   	push   %ebx
    1b54:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "subdir test\n");
    1b57:	68 da 40 00 00       	push   $0x40da
    1b5c:	6a 01                	push   $0x1
    1b5e:	e8 61 1b 00 00       	call   36c4 <printf>
  unlink("ff");
    1b63:	c7 04 24 63 41 00 00 	movl   $0x4163,(%esp)
    1b6a:	e8 70 1a 00 00       	call   35df <unlink>
  if(mkdir("dd") != 0){
    1b6f:	c7 04 24 00 42 00 00 	movl   $0x4200,(%esp)
    1b76:	e8 7c 1a 00 00       	call   35f7 <mkdir>
    1b7b:	83 c4 10             	add    $0x10,%esp
    1b7e:	85 c0                	test   %eax,%eax
    1b80:	0f 85 ab 05 00 00    	jne    2131 <subdir+0x5e1>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1b86:	83 ec 08             	sub    $0x8,%esp
    1b89:	68 02 02 00 00       	push   $0x202
    1b8e:	68 39 41 00 00       	push   $0x4139
    1b93:	e8 37 1a 00 00       	call   35cf <open>
    1b98:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1b9a:	83 c4 10             	add    $0x10,%esp
    1b9d:	85 c0                	test   %eax,%eax
    1b9f:	0f 88 79 05 00 00    	js     211e <subdir+0x5ce>
  write(fd, "ff", 2);
    1ba5:	50                   	push   %eax
    1ba6:	6a 02                	push   $0x2
    1ba8:	68 63 41 00 00       	push   $0x4163
    1bad:	53                   	push   %ebx
    1bae:	e8 fc 19 00 00       	call   35af <write>
  close(fd);
    1bb3:	89 1c 24             	mov    %ebx,(%esp)
    1bb6:	e8 fc 19 00 00       	call   35b7 <close>
  if(unlink("dd") >= 0){
    1bbb:	c7 04 24 00 42 00 00 	movl   $0x4200,(%esp)
    1bc2:	e8 18 1a 00 00       	call   35df <unlink>
    1bc7:	83 c4 10             	add    $0x10,%esp
    1bca:	85 c0                	test   %eax,%eax
    1bcc:	0f 89 39 05 00 00    	jns    210b <subdir+0x5bb>
  if(mkdir("/dd/dd") != 0){
    1bd2:	83 ec 0c             	sub    $0xc,%esp
    1bd5:	68 14 41 00 00       	push   $0x4114
    1bda:	e8 18 1a 00 00       	call   35f7 <mkdir>
    1bdf:	83 c4 10             	add    $0x10,%esp
    1be2:	85 c0                	test   %eax,%eax
    1be4:	0f 85 0e 05 00 00    	jne    20f8 <subdir+0x5a8>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1bea:	83 ec 08             	sub    $0x8,%esp
    1bed:	68 02 02 00 00       	push   $0x202
    1bf2:	68 36 41 00 00       	push   $0x4136
    1bf7:	e8 d3 19 00 00       	call   35cf <open>
    1bfc:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1bfe:	83 c4 10             	add    $0x10,%esp
    1c01:	85 c0                	test   %eax,%eax
    1c03:	0f 88 1e 04 00 00    	js     2027 <subdir+0x4d7>
  write(fd, "FF", 2);
    1c09:	50                   	push   %eax
    1c0a:	6a 02                	push   $0x2
    1c0c:	68 57 41 00 00       	push   $0x4157
    1c11:	53                   	push   %ebx
    1c12:	e8 98 19 00 00       	call   35af <write>
  close(fd);
    1c17:	89 1c 24             	mov    %ebx,(%esp)
    1c1a:	e8 98 19 00 00       	call   35b7 <close>
  fd = open("dd/dd/../ff", 0);
    1c1f:	58                   	pop    %eax
    1c20:	5a                   	pop    %edx
    1c21:	6a 00                	push   $0x0
    1c23:	68 5a 41 00 00       	push   $0x415a
    1c28:	e8 a2 19 00 00       	call   35cf <open>
    1c2d:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1c2f:	83 c4 10             	add    $0x10,%esp
    1c32:	85 c0                	test   %eax,%eax
    1c34:	0f 88 da 03 00 00    	js     2014 <subdir+0x4c4>
  cc = read(fd, buf, sizeof(buf));
    1c3a:	50                   	push   %eax
    1c3b:	68 00 20 00 00       	push   $0x2000
    1c40:	68 00 79 00 00       	push   $0x7900
    1c45:	53                   	push   %ebx
    1c46:	e8 5c 19 00 00       	call   35a7 <read>
  if(cc != 2 || buf[0] != 'f'){
    1c4b:	83 c4 10             	add    $0x10,%esp
    1c4e:	83 f8 02             	cmp    $0x2,%eax
    1c51:	0f 85 38 03 00 00    	jne    1f8f <subdir+0x43f>
    1c57:	80 3d 00 79 00 00 66 	cmpb   $0x66,0x7900
    1c5e:	0f 85 2b 03 00 00    	jne    1f8f <subdir+0x43f>
  close(fd);
    1c64:	83 ec 0c             	sub    $0xc,%esp
    1c67:	53                   	push   %ebx
    1c68:	e8 4a 19 00 00       	call   35b7 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1c6d:	58                   	pop    %eax
    1c6e:	5a                   	pop    %edx
    1c6f:	68 9a 41 00 00       	push   $0x419a
    1c74:	68 36 41 00 00       	push   $0x4136
    1c79:	e8 71 19 00 00       	call   35ef <link>
    1c7e:	83 c4 10             	add    $0x10,%esp
    1c81:	85 c0                	test   %eax,%eax
    1c83:	0f 85 c4 03 00 00    	jne    204d <subdir+0x4fd>
  if(unlink("dd/dd/ff") != 0){
    1c89:	83 ec 0c             	sub    $0xc,%esp
    1c8c:	68 36 41 00 00       	push   $0x4136
    1c91:	e8 49 19 00 00       	call   35df <unlink>
    1c96:	83 c4 10             	add    $0x10,%esp
    1c99:	85 c0                	test   %eax,%eax
    1c9b:	0f 85 14 03 00 00    	jne    1fb5 <subdir+0x465>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1ca1:	83 ec 08             	sub    $0x8,%esp
    1ca4:	6a 00                	push   $0x0
    1ca6:	68 36 41 00 00       	push   $0x4136
    1cab:	e8 1f 19 00 00       	call   35cf <open>
    1cb0:	83 c4 10             	add    $0x10,%esp
    1cb3:	85 c0                	test   %eax,%eax
    1cb5:	0f 89 2a 04 00 00    	jns    20e5 <subdir+0x595>
  if(chdir("dd") != 0){
    1cbb:	83 ec 0c             	sub    $0xc,%esp
    1cbe:	68 00 42 00 00       	push   $0x4200
    1cc3:	e8 37 19 00 00       	call   35ff <chdir>
    1cc8:	83 c4 10             	add    $0x10,%esp
    1ccb:	85 c0                	test   %eax,%eax
    1ccd:	0f 85 ff 03 00 00    	jne    20d2 <subdir+0x582>
  if(chdir("dd/../../dd") != 0){
    1cd3:	83 ec 0c             	sub    $0xc,%esp
    1cd6:	68 ce 41 00 00       	push   $0x41ce
    1cdb:	e8 1f 19 00 00       	call   35ff <chdir>
    1ce0:	83 c4 10             	add    $0x10,%esp
    1ce3:	85 c0                	test   %eax,%eax
    1ce5:	0f 85 b7 02 00 00    	jne    1fa2 <subdir+0x452>
  if(chdir("dd/../../../dd") != 0){
    1ceb:	83 ec 0c             	sub    $0xc,%esp
    1cee:	68 f4 41 00 00       	push   $0x41f4
    1cf3:	e8 07 19 00 00       	call   35ff <chdir>
    1cf8:	83 c4 10             	add    $0x10,%esp
    1cfb:	85 c0                	test   %eax,%eax
    1cfd:	0f 85 9f 02 00 00    	jne    1fa2 <subdir+0x452>
  if(chdir("./..") != 0){
    1d03:	83 ec 0c             	sub    $0xc,%esp
    1d06:	68 03 42 00 00       	push   $0x4203
    1d0b:	e8 ef 18 00 00       	call   35ff <chdir>
    1d10:	83 c4 10             	add    $0x10,%esp
    1d13:	85 c0                	test   %eax,%eax
    1d15:	0f 85 1f 03 00 00    	jne    203a <subdir+0x4ea>
  fd = open("dd/dd/ffff", 0);
    1d1b:	83 ec 08             	sub    $0x8,%esp
    1d1e:	6a 00                	push   $0x0
    1d20:	68 9a 41 00 00       	push   $0x419a
    1d25:	e8 a5 18 00 00       	call   35cf <open>
    1d2a:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d2c:	83 c4 10             	add    $0x10,%esp
    1d2f:	85 c0                	test   %eax,%eax
    1d31:	0f 88 de 04 00 00    	js     2215 <subdir+0x6c5>
  if(read(fd, buf, sizeof(buf)) != 2){
    1d37:	50                   	push   %eax
    1d38:	68 00 20 00 00       	push   $0x2000
    1d3d:	68 00 79 00 00       	push   $0x7900
    1d42:	53                   	push   %ebx
    1d43:	e8 5f 18 00 00       	call   35a7 <read>
    1d48:	83 c4 10             	add    $0x10,%esp
    1d4b:	83 f8 02             	cmp    $0x2,%eax
    1d4e:	0f 85 ae 04 00 00    	jne    2202 <subdir+0x6b2>
  close(fd);
    1d54:	83 ec 0c             	sub    $0xc,%esp
    1d57:	53                   	push   %ebx
    1d58:	e8 5a 18 00 00       	call   35b7 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1d5d:	58                   	pop    %eax
    1d5e:	5a                   	pop    %edx
    1d5f:	6a 00                	push   $0x0
    1d61:	68 36 41 00 00       	push   $0x4136
    1d66:	e8 64 18 00 00       	call   35cf <open>
    1d6b:	83 c4 10             	add    $0x10,%esp
    1d6e:	85 c0                	test   %eax,%eax
    1d70:	0f 89 65 02 00 00    	jns    1fdb <subdir+0x48b>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1d76:	83 ec 08             	sub    $0x8,%esp
    1d79:	68 02 02 00 00       	push   $0x202
    1d7e:	68 4e 42 00 00       	push   $0x424e
    1d83:	e8 47 18 00 00       	call   35cf <open>
    1d88:	83 c4 10             	add    $0x10,%esp
    1d8b:	85 c0                	test   %eax,%eax
    1d8d:	0f 89 35 02 00 00    	jns    1fc8 <subdir+0x478>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1d93:	83 ec 08             	sub    $0x8,%esp
    1d96:	68 02 02 00 00       	push   $0x202
    1d9b:	68 73 42 00 00       	push   $0x4273
    1da0:	e8 2a 18 00 00       	call   35cf <open>
    1da5:	83 c4 10             	add    $0x10,%esp
    1da8:	85 c0                	test   %eax,%eax
    1daa:	0f 89 0f 03 00 00    	jns    20bf <subdir+0x56f>
  if(open("dd", O_CREATE) >= 0){
    1db0:	83 ec 08             	sub    $0x8,%esp
    1db3:	68 00 02 00 00       	push   $0x200
    1db8:	68 00 42 00 00       	push   $0x4200
    1dbd:	e8 0d 18 00 00       	call   35cf <open>
    1dc2:	83 c4 10             	add    $0x10,%esp
    1dc5:	85 c0                	test   %eax,%eax
    1dc7:	0f 89 df 02 00 00    	jns    20ac <subdir+0x55c>
  if(open("dd", O_RDWR) >= 0){
    1dcd:	83 ec 08             	sub    $0x8,%esp
    1dd0:	6a 02                	push   $0x2
    1dd2:	68 00 42 00 00       	push   $0x4200
    1dd7:	e8 f3 17 00 00       	call   35cf <open>
    1ddc:	83 c4 10             	add    $0x10,%esp
    1ddf:	85 c0                	test   %eax,%eax
    1de1:	0f 89 b2 02 00 00    	jns    2099 <subdir+0x549>
  if(open("dd", O_WRONLY) >= 0){
    1de7:	83 ec 08             	sub    $0x8,%esp
    1dea:	6a 01                	push   $0x1
    1dec:	68 00 42 00 00       	push   $0x4200
    1df1:	e8 d9 17 00 00       	call   35cf <open>
    1df6:	83 c4 10             	add    $0x10,%esp
    1df9:	85 c0                	test   %eax,%eax
    1dfb:	0f 89 85 02 00 00    	jns    2086 <subdir+0x536>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1e01:	83 ec 08             	sub    $0x8,%esp
    1e04:	68 e2 42 00 00       	push   $0x42e2
    1e09:	68 4e 42 00 00       	push   $0x424e
    1e0e:	e8 dc 17 00 00       	call   35ef <link>
    1e13:	83 c4 10             	add    $0x10,%esp
    1e16:	85 c0                	test   %eax,%eax
    1e18:	0f 84 55 02 00 00    	je     2073 <subdir+0x523>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    1e1e:	83 ec 08             	sub    $0x8,%esp
    1e21:	68 e2 42 00 00       	push   $0x42e2
    1e26:	68 73 42 00 00       	push   $0x4273
    1e2b:	e8 bf 17 00 00       	call   35ef <link>
    1e30:	83 c4 10             	add    $0x10,%esp
    1e33:	85 c0                	test   %eax,%eax
    1e35:	0f 84 25 02 00 00    	je     2060 <subdir+0x510>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    1e3b:	83 ec 08             	sub    $0x8,%esp
    1e3e:	68 9a 41 00 00       	push   $0x419a
    1e43:	68 39 41 00 00       	push   $0x4139
    1e48:	e8 a2 17 00 00       	call   35ef <link>
    1e4d:	83 c4 10             	add    $0x10,%esp
    1e50:	85 c0                	test   %eax,%eax
    1e52:	0f 84 a9 01 00 00    	je     2001 <subdir+0x4b1>
  if(mkdir("dd/ff/ff") == 0){
    1e58:	83 ec 0c             	sub    $0xc,%esp
    1e5b:	68 4e 42 00 00       	push   $0x424e
    1e60:	e8 92 17 00 00       	call   35f7 <mkdir>
    1e65:	83 c4 10             	add    $0x10,%esp
    1e68:	85 c0                	test   %eax,%eax
    1e6a:	0f 84 7e 01 00 00    	je     1fee <subdir+0x49e>
  if(mkdir("dd/xx/ff") == 0){
    1e70:	83 ec 0c             	sub    $0xc,%esp
    1e73:	68 73 42 00 00       	push   $0x4273
    1e78:	e8 7a 17 00 00       	call   35f7 <mkdir>
    1e7d:	83 c4 10             	add    $0x10,%esp
    1e80:	85 c0                	test   %eax,%eax
    1e82:	0f 84 67 03 00 00    	je     21ef <subdir+0x69f>
  if(mkdir("dd/dd/ffff") == 0){
    1e88:	83 ec 0c             	sub    $0xc,%esp
    1e8b:	68 9a 41 00 00       	push   $0x419a
    1e90:	e8 62 17 00 00       	call   35f7 <mkdir>
    1e95:	83 c4 10             	add    $0x10,%esp
    1e98:	85 c0                	test   %eax,%eax
    1e9a:	0f 84 3c 03 00 00    	je     21dc <subdir+0x68c>
  if(unlink("dd/xx/ff") == 0){
    1ea0:	83 ec 0c             	sub    $0xc,%esp
    1ea3:	68 73 42 00 00       	push   $0x4273
    1ea8:	e8 32 17 00 00       	call   35df <unlink>
    1ead:	83 c4 10             	add    $0x10,%esp
    1eb0:	85 c0                	test   %eax,%eax
    1eb2:	0f 84 11 03 00 00    	je     21c9 <subdir+0x679>
  if(unlink("dd/ff/ff") == 0){
    1eb8:	83 ec 0c             	sub    $0xc,%esp
    1ebb:	68 4e 42 00 00       	push   $0x424e
    1ec0:	e8 1a 17 00 00       	call   35df <unlink>
    1ec5:	83 c4 10             	add    $0x10,%esp
    1ec8:	85 c0                	test   %eax,%eax
    1eca:	0f 84 e6 02 00 00    	je     21b6 <subdir+0x666>
  if(chdir("dd/ff") == 0){
    1ed0:	83 ec 0c             	sub    $0xc,%esp
    1ed3:	68 39 41 00 00       	push   $0x4139
    1ed8:	e8 22 17 00 00       	call   35ff <chdir>
    1edd:	83 c4 10             	add    $0x10,%esp
    1ee0:	85 c0                	test   %eax,%eax
    1ee2:	0f 84 bb 02 00 00    	je     21a3 <subdir+0x653>
  if(chdir("dd/xx") == 0){
    1ee8:	83 ec 0c             	sub    $0xc,%esp
    1eeb:	68 e5 42 00 00       	push   $0x42e5
    1ef0:	e8 0a 17 00 00       	call   35ff <chdir>
    1ef5:	83 c4 10             	add    $0x10,%esp
    1ef8:	85 c0                	test   %eax,%eax
    1efa:	0f 84 90 02 00 00    	je     2190 <subdir+0x640>
  if(unlink("dd/dd/ffff") != 0){
    1f00:	83 ec 0c             	sub    $0xc,%esp
    1f03:	68 9a 41 00 00       	push   $0x419a
    1f08:	e8 d2 16 00 00       	call   35df <unlink>
    1f0d:	83 c4 10             	add    $0x10,%esp
    1f10:	85 c0                	test   %eax,%eax
    1f12:	0f 85 9d 00 00 00    	jne    1fb5 <subdir+0x465>
  if(unlink("dd/ff") != 0){
    1f18:	83 ec 0c             	sub    $0xc,%esp
    1f1b:	68 39 41 00 00       	push   $0x4139
    1f20:	e8 ba 16 00 00       	call   35df <unlink>
    1f25:	83 c4 10             	add    $0x10,%esp
    1f28:	85 c0                	test   %eax,%eax
    1f2a:	0f 85 4d 02 00 00    	jne    217d <subdir+0x62d>
  if(unlink("dd") == 0){
    1f30:	83 ec 0c             	sub    $0xc,%esp
    1f33:	68 00 42 00 00       	push   $0x4200
    1f38:	e8 a2 16 00 00       	call   35df <unlink>
    1f3d:	83 c4 10             	add    $0x10,%esp
    1f40:	85 c0                	test   %eax,%eax
    1f42:	0f 84 22 02 00 00    	je     216a <subdir+0x61a>
  if(unlink("dd/dd") < 0){
    1f48:	83 ec 0c             	sub    $0xc,%esp
    1f4b:	68 15 41 00 00       	push   $0x4115
    1f50:	e8 8a 16 00 00       	call   35df <unlink>
    1f55:	83 c4 10             	add    $0x10,%esp
    1f58:	85 c0                	test   %eax,%eax
    1f5a:	0f 88 f7 01 00 00    	js     2157 <subdir+0x607>
  if(unlink("dd") < 0){
    1f60:	83 ec 0c             	sub    $0xc,%esp
    1f63:	68 00 42 00 00       	push   $0x4200
    1f68:	e8 72 16 00 00       	call   35df <unlink>
    1f6d:	83 c4 10             	add    $0x10,%esp
    1f70:	85 c0                	test   %eax,%eax
    1f72:	0f 88 cc 01 00 00    	js     2144 <subdir+0x5f4>
  printf(1, "subdir ok\n");
    1f78:	83 ec 08             	sub    $0x8,%esp
    1f7b:	68 e2 43 00 00       	push   $0x43e2
    1f80:	6a 01                	push   $0x1
    1f82:	e8 3d 17 00 00       	call   36c4 <printf>
}
    1f87:	83 c4 10             	add    $0x10,%esp
    1f8a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1f8d:	c9                   	leave
    1f8e:	c3                   	ret
    printf(1, "dd/dd/../ff wrong content\n");
    1f8f:	51                   	push   %ecx
    1f90:	51                   	push   %ecx
    1f91:	68 7f 41 00 00       	push   $0x417f
    1f96:	6a 01                	push   $0x1
    1f98:	e8 27 17 00 00       	call   36c4 <printf>
    exit();
    1f9d:	e8 ed 15 00 00       	call   358f <exit>
    printf(1, "chdir dd/../../dd failed\n");
    1fa2:	50                   	push   %eax
    1fa3:	50                   	push   %eax
    1fa4:	68 da 41 00 00       	push   $0x41da
    1fa9:	6a 01                	push   $0x1
    1fab:	e8 14 17 00 00       	call   36c4 <printf>
    exit();
    1fb0:	e8 da 15 00 00       	call   358f <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    1fb5:	51                   	push   %ecx
    1fb6:	51                   	push   %ecx
    1fb7:	68 a5 41 00 00       	push   $0x41a5
    1fbc:	6a 01                	push   $0x1
    1fbe:	e8 01 17 00 00       	call   36c4 <printf>
    exit();
    1fc3:	e8 c7 15 00 00       	call   358f <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    1fc8:	51                   	push   %ecx
    1fc9:	51                   	push   %ecx
    1fca:	68 57 42 00 00       	push   $0x4257
    1fcf:	6a 01                	push   $0x1
    1fd1:	e8 ee 16 00 00       	call   36c4 <printf>
    exit();
    1fd6:	e8 b4 15 00 00       	call   358f <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    1fdb:	53                   	push   %ebx
    1fdc:	53                   	push   %ebx
    1fdd:	68 44 4c 00 00       	push   $0x4c44
    1fe2:	6a 01                	push   $0x1
    1fe4:	e8 db 16 00 00       	call   36c4 <printf>
    exit();
    1fe9:	e8 a1 15 00 00       	call   358f <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    1fee:	51                   	push   %ecx
    1fef:	51                   	push   %ecx
    1ff0:	68 eb 42 00 00       	push   $0x42eb
    1ff5:	6a 01                	push   $0x1
    1ff7:	e8 c8 16 00 00       	call   36c4 <printf>
    exit();
    1ffc:	e8 8e 15 00 00       	call   358f <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    2001:	53                   	push   %ebx
    2002:	53                   	push   %ebx
    2003:	68 b4 4c 00 00       	push   $0x4cb4
    2008:	6a 01                	push   $0x1
    200a:	e8 b5 16 00 00       	call   36c4 <printf>
    exit();
    200f:	e8 7b 15 00 00       	call   358f <exit>
    printf(1, "open dd/dd/../ff failed\n");
    2014:	50                   	push   %eax
    2015:	50                   	push   %eax
    2016:	68 66 41 00 00       	push   $0x4166
    201b:	6a 01                	push   $0x1
    201d:	e8 a2 16 00 00       	call   36c4 <printf>
    exit();
    2022:	e8 68 15 00 00       	call   358f <exit>
    printf(1, "create dd/dd/ff failed\n");
    2027:	51                   	push   %ecx
    2028:	51                   	push   %ecx
    2029:	68 3f 41 00 00       	push   $0x413f
    202e:	6a 01                	push   $0x1
    2030:	e8 8f 16 00 00       	call   36c4 <printf>
    exit();
    2035:	e8 55 15 00 00       	call   358f <exit>
    printf(1, "chdir ./.. failed\n");
    203a:	50                   	push   %eax
    203b:	50                   	push   %eax
    203c:	68 08 42 00 00       	push   $0x4208
    2041:	6a 01                	push   $0x1
    2043:	e8 7c 16 00 00       	call   36c4 <printf>
    exit();
    2048:	e8 42 15 00 00       	call   358f <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    204d:	53                   	push   %ebx
    204e:	53                   	push   %ebx
    204f:	68 fc 4b 00 00       	push   $0x4bfc
    2054:	6a 01                	push   $0x1
    2056:	e8 69 16 00 00       	call   36c4 <printf>
    exit();
    205b:	e8 2f 15 00 00       	call   358f <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2060:	50                   	push   %eax
    2061:	50                   	push   %eax
    2062:	68 90 4c 00 00       	push   $0x4c90
    2067:	6a 01                	push   $0x1
    2069:	e8 56 16 00 00       	call   36c4 <printf>
    exit();
    206e:	e8 1c 15 00 00       	call   358f <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    2073:	50                   	push   %eax
    2074:	50                   	push   %eax
    2075:	68 6c 4c 00 00       	push   $0x4c6c
    207a:	6a 01                	push   $0x1
    207c:	e8 43 16 00 00       	call   36c4 <printf>
    exit();
    2081:	e8 09 15 00 00       	call   358f <exit>
    printf(1, "open dd wronly succeeded!\n");
    2086:	50                   	push   %eax
    2087:	50                   	push   %eax
    2088:	68 c7 42 00 00       	push   $0x42c7
    208d:	6a 01                	push   $0x1
    208f:	e8 30 16 00 00       	call   36c4 <printf>
    exit();
    2094:	e8 f6 14 00 00       	call   358f <exit>
    printf(1, "open dd rdwr succeeded!\n");
    2099:	50                   	push   %eax
    209a:	50                   	push   %eax
    209b:	68 ae 42 00 00       	push   $0x42ae
    20a0:	6a 01                	push   $0x1
    20a2:	e8 1d 16 00 00       	call   36c4 <printf>
    exit();
    20a7:	e8 e3 14 00 00       	call   358f <exit>
    printf(1, "create dd succeeded!\n");
    20ac:	50                   	push   %eax
    20ad:	50                   	push   %eax
    20ae:	68 98 42 00 00       	push   $0x4298
    20b3:	6a 01                	push   $0x1
    20b5:	e8 0a 16 00 00       	call   36c4 <printf>
    exit();
    20ba:	e8 d0 14 00 00       	call   358f <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    20bf:	52                   	push   %edx
    20c0:	52                   	push   %edx
    20c1:	68 7c 42 00 00       	push   $0x427c
    20c6:	6a 01                	push   $0x1
    20c8:	e8 f7 15 00 00       	call   36c4 <printf>
    exit();
    20cd:	e8 bd 14 00 00       	call   358f <exit>
    printf(1, "chdir dd failed\n");
    20d2:	50                   	push   %eax
    20d3:	50                   	push   %eax
    20d4:	68 bd 41 00 00       	push   $0x41bd
    20d9:	6a 01                	push   $0x1
    20db:	e8 e4 15 00 00       	call   36c4 <printf>
    exit();
    20e0:	e8 aa 14 00 00       	call   358f <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    20e5:	52                   	push   %edx
    20e6:	52                   	push   %edx
    20e7:	68 20 4c 00 00       	push   $0x4c20
    20ec:	6a 01                	push   $0x1
    20ee:	e8 d1 15 00 00       	call   36c4 <printf>
    exit();
    20f3:	e8 97 14 00 00       	call   358f <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    20f8:	53                   	push   %ebx
    20f9:	53                   	push   %ebx
    20fa:	68 1b 41 00 00       	push   $0x411b
    20ff:	6a 01                	push   $0x1
    2101:	e8 be 15 00 00       	call   36c4 <printf>
    exit();
    2106:	e8 84 14 00 00       	call   358f <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    210b:	50                   	push   %eax
    210c:	50                   	push   %eax
    210d:	68 d4 4b 00 00       	push   $0x4bd4
    2112:	6a 01                	push   $0x1
    2114:	e8 ab 15 00 00       	call   36c4 <printf>
    exit();
    2119:	e8 71 14 00 00       	call   358f <exit>
    printf(1, "create dd/ff failed\n");
    211e:	50                   	push   %eax
    211f:	50                   	push   %eax
    2120:	68 ff 40 00 00       	push   $0x40ff
    2125:	6a 01                	push   $0x1
    2127:	e8 98 15 00 00       	call   36c4 <printf>
    exit();
    212c:	e8 5e 14 00 00       	call   358f <exit>
    printf(1, "subdir mkdir dd failed\n");
    2131:	50                   	push   %eax
    2132:	50                   	push   %eax
    2133:	68 e7 40 00 00       	push   $0x40e7
    2138:	6a 01                	push   $0x1
    213a:	e8 85 15 00 00       	call   36c4 <printf>
    exit();
    213f:	e8 4b 14 00 00       	call   358f <exit>
    printf(1, "unlink dd failed\n");
    2144:	50                   	push   %eax
    2145:	50                   	push   %eax
    2146:	68 d0 43 00 00       	push   $0x43d0
    214b:	6a 01                	push   $0x1
    214d:	e8 72 15 00 00       	call   36c4 <printf>
    exit();
    2152:	e8 38 14 00 00       	call   358f <exit>
    printf(1, "unlink dd/dd failed\n");
    2157:	52                   	push   %edx
    2158:	52                   	push   %edx
    2159:	68 bb 43 00 00       	push   $0x43bb
    215e:	6a 01                	push   $0x1
    2160:	e8 5f 15 00 00       	call   36c4 <printf>
    exit();
    2165:	e8 25 14 00 00       	call   358f <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    216a:	51                   	push   %ecx
    216b:	51                   	push   %ecx
    216c:	68 d8 4c 00 00       	push   $0x4cd8
    2171:	6a 01                	push   $0x1
    2173:	e8 4c 15 00 00       	call   36c4 <printf>
    exit();
    2178:	e8 12 14 00 00       	call   358f <exit>
    printf(1, "unlink dd/ff failed\n");
    217d:	53                   	push   %ebx
    217e:	53                   	push   %ebx
    217f:	68 a6 43 00 00       	push   $0x43a6
    2184:	6a 01                	push   $0x1
    2186:	e8 39 15 00 00       	call   36c4 <printf>
    exit();
    218b:	e8 ff 13 00 00       	call   358f <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    2190:	50                   	push   %eax
    2191:	50                   	push   %eax
    2192:	68 8e 43 00 00       	push   $0x438e
    2197:	6a 01                	push   $0x1
    2199:	e8 26 15 00 00       	call   36c4 <printf>
    exit();
    219e:	e8 ec 13 00 00       	call   358f <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    21a3:	50                   	push   %eax
    21a4:	50                   	push   %eax
    21a5:	68 76 43 00 00       	push   $0x4376
    21aa:	6a 01                	push   $0x1
    21ac:	e8 13 15 00 00       	call   36c4 <printf>
    exit();
    21b1:	e8 d9 13 00 00       	call   358f <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    21b6:	50                   	push   %eax
    21b7:	50                   	push   %eax
    21b8:	68 5a 43 00 00       	push   $0x435a
    21bd:	6a 01                	push   $0x1
    21bf:	e8 00 15 00 00       	call   36c4 <printf>
    exit();
    21c4:	e8 c6 13 00 00       	call   358f <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    21c9:	50                   	push   %eax
    21ca:	50                   	push   %eax
    21cb:	68 3e 43 00 00       	push   $0x433e
    21d0:	6a 01                	push   $0x1
    21d2:	e8 ed 14 00 00       	call   36c4 <printf>
    exit();
    21d7:	e8 b3 13 00 00       	call   358f <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    21dc:	50                   	push   %eax
    21dd:	50                   	push   %eax
    21de:	68 21 43 00 00       	push   $0x4321
    21e3:	6a 01                	push   $0x1
    21e5:	e8 da 14 00 00       	call   36c4 <printf>
    exit();
    21ea:	e8 a0 13 00 00       	call   358f <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    21ef:	52                   	push   %edx
    21f0:	52                   	push   %edx
    21f1:	68 06 43 00 00       	push   $0x4306
    21f6:	6a 01                	push   $0x1
    21f8:	e8 c7 14 00 00       	call   36c4 <printf>
    exit();
    21fd:	e8 8d 13 00 00       	call   358f <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    2202:	51                   	push   %ecx
    2203:	51                   	push   %ecx
    2204:	68 33 42 00 00       	push   $0x4233
    2209:	6a 01                	push   $0x1
    220b:	e8 b4 14 00 00       	call   36c4 <printf>
    exit();
    2210:	e8 7a 13 00 00       	call   358f <exit>
    printf(1, "open dd/dd/ffff failed\n");
    2215:	50                   	push   %eax
    2216:	50                   	push   %eax
    2217:	68 1b 42 00 00       	push   $0x421b
    221c:	6a 01                	push   $0x1
    221e:	e8 a1 14 00 00       	call   36c4 <printf>
    exit();
    2223:	e8 67 13 00 00       	call   358f <exit>

00002228 <bigwrite>:
{
    2228:	55                   	push   %ebp
    2229:	89 e5                	mov    %esp,%ebp
    222b:	56                   	push   %esi
    222c:	53                   	push   %ebx
  printf(1, "bigwrite test\n");
    222d:	83 ec 08             	sub    $0x8,%esp
    2230:	68 ed 43 00 00       	push   $0x43ed
    2235:	6a 01                	push   $0x1
    2237:	e8 88 14 00 00       	call   36c4 <printf>
  unlink("bigwrite");
    223c:	c7 04 24 fc 43 00 00 	movl   $0x43fc,(%esp)
    2243:	e8 97 13 00 00       	call   35df <unlink>
    2248:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    224b:	bb f3 01 00 00       	mov    $0x1f3,%ebx
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2250:	83 ec 08             	sub    $0x8,%esp
    2253:	68 02 02 00 00       	push   $0x202
    2258:	68 fc 43 00 00       	push   $0x43fc
    225d:	e8 6d 13 00 00       	call   35cf <open>
    2262:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2264:	83 c4 10             	add    $0x10,%esp
    2267:	85 c0                	test   %eax,%eax
    2269:	78 7a                	js     22e5 <bigwrite+0xbd>
      int cc = write(fd, buf, sz);
    226b:	52                   	push   %edx
    226c:	53                   	push   %ebx
    226d:	68 00 79 00 00       	push   $0x7900
    2272:	50                   	push   %eax
    2273:	e8 37 13 00 00       	call   35af <write>
      if(cc != sz){
    2278:	83 c4 10             	add    $0x10,%esp
    227b:	39 c3                	cmp    %eax,%ebx
    227d:	75 53                	jne    22d2 <bigwrite+0xaa>
      int cc = write(fd, buf, sz);
    227f:	50                   	push   %eax
    2280:	53                   	push   %ebx
    2281:	68 00 79 00 00       	push   $0x7900
    2286:	56                   	push   %esi
    2287:	e8 23 13 00 00       	call   35af <write>
      if(cc != sz){
    228c:	83 c4 10             	add    $0x10,%esp
    228f:	39 c3                	cmp    %eax,%ebx
    2291:	75 3f                	jne    22d2 <bigwrite+0xaa>
    close(fd);
    2293:	83 ec 0c             	sub    $0xc,%esp
    2296:	56                   	push   %esi
    2297:	e8 1b 13 00 00       	call   35b7 <close>
    unlink("bigwrite");
    229c:	c7 04 24 fc 43 00 00 	movl   $0x43fc,(%esp)
    22a3:	e8 37 13 00 00       	call   35df <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    22a8:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    22ae:	83 c4 10             	add    $0x10,%esp
    22b1:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    22b7:	75 97                	jne    2250 <bigwrite+0x28>
  printf(1, "bigwrite ok\n");
    22b9:	83 ec 08             	sub    $0x8,%esp
    22bc:	68 2f 44 00 00       	push   $0x442f
    22c1:	6a 01                	push   $0x1
    22c3:	e8 fc 13 00 00       	call   36c4 <printf>
}
    22c8:	83 c4 10             	add    $0x10,%esp
    22cb:	8d 65 f8             	lea    -0x8(%ebp),%esp
    22ce:	5b                   	pop    %ebx
    22cf:	5e                   	pop    %esi
    22d0:	5d                   	pop    %ebp
    22d1:	c3                   	ret
        printf(1, "write(%d) ret %d\n", sz, cc);
    22d2:	50                   	push   %eax
    22d3:	53                   	push   %ebx
    22d4:	68 1d 44 00 00       	push   $0x441d
    22d9:	6a 01                	push   $0x1
    22db:	e8 e4 13 00 00       	call   36c4 <printf>
        exit();
    22e0:	e8 aa 12 00 00       	call   358f <exit>
      printf(1, "cannot create bigwrite\n");
    22e5:	83 ec 08             	sub    $0x8,%esp
    22e8:	68 05 44 00 00       	push   $0x4405
    22ed:	6a 01                	push   $0x1
    22ef:	e8 d0 13 00 00       	call   36c4 <printf>
      exit();
    22f4:	e8 96 12 00 00       	call   358f <exit>
    22f9:	8d 76 00             	lea    0x0(%esi),%esi

000022fc <bigfile>:
{
    22fc:	55                   	push   %ebp
    22fd:	89 e5                	mov    %esp,%ebp
    22ff:	57                   	push   %edi
    2300:	56                   	push   %esi
    2301:	53                   	push   %ebx
    2302:	83 ec 14             	sub    $0x14,%esp
  printf(1, "bigfile test\n");
    2305:	68 3c 44 00 00       	push   $0x443c
    230a:	6a 01                	push   $0x1
    230c:	e8 b3 13 00 00       	call   36c4 <printf>
  unlink("bigfile");
    2311:	c7 04 24 58 44 00 00 	movl   $0x4458,(%esp)
    2318:	e8 c2 12 00 00       	call   35df <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    231d:	5e                   	pop    %esi
    231e:	5f                   	pop    %edi
    231f:	68 02 02 00 00       	push   $0x202
    2324:	68 58 44 00 00       	push   $0x4458
    2329:	e8 a1 12 00 00       	call   35cf <open>
  if(fd < 0){
    232e:	83 c4 10             	add    $0x10,%esp
    2331:	85 c0                	test   %eax,%eax
    2333:	0f 88 52 01 00 00    	js     248b <bigfile+0x18f>
    2339:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++){
    233b:	31 db                	xor    %ebx,%ebx
    233d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(buf, i, 600);
    2340:	51                   	push   %ecx
    2341:	68 58 02 00 00       	push   $0x258
    2346:	53                   	push   %ebx
    2347:	68 00 79 00 00       	push   $0x7900
    234c:	e8 07 11 00 00       	call   3458 <memset>
    if(write(fd, buf, 600) != 600){
    2351:	83 c4 0c             	add    $0xc,%esp
    2354:	68 58 02 00 00       	push   $0x258
    2359:	68 00 79 00 00       	push   $0x7900
    235e:	56                   	push   %esi
    235f:	e8 4b 12 00 00       	call   35af <write>
    2364:	83 c4 10             	add    $0x10,%esp
    2367:	3d 58 02 00 00       	cmp    $0x258,%eax
    236c:	0f 85 f2 00 00 00    	jne    2464 <bigfile+0x168>
  for(i = 0; i < 20; i++){
    2372:	43                   	inc    %ebx
    2373:	83 fb 14             	cmp    $0x14,%ebx
    2376:	75 c8                	jne    2340 <bigfile+0x44>
  close(fd);
    2378:	83 ec 0c             	sub    $0xc,%esp
    237b:	56                   	push   %esi
    237c:	e8 36 12 00 00       	call   35b7 <close>
  fd = open("bigfile", 0);
    2381:	58                   	pop    %eax
    2382:	5a                   	pop    %edx
    2383:	6a 00                	push   $0x0
    2385:	68 58 44 00 00       	push   $0x4458
    238a:	e8 40 12 00 00       	call   35cf <open>
    238f:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    2391:	83 c4 10             	add    $0x10,%esp
    2394:	85 c0                	test   %eax,%eax
    2396:	0f 88 dc 00 00 00    	js     2478 <bigfile+0x17c>
  total = 0;
    239c:	31 f6                	xor    %esi,%esi
  for(i = 0; ; i++){
    239e:	31 db                	xor    %ebx,%ebx
    23a0:	eb 2e                	jmp    23d0 <bigfile+0xd4>
    23a2:	66 90                	xchg   %ax,%ax
    if(cc != 300){
    23a4:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    23a9:	0f 85 8d 00 00 00    	jne    243c <bigfile+0x140>
    if(buf[0] != i/2 || buf[299] != i/2){
    23af:	89 da                	mov    %ebx,%edx
    23b1:	d1 fa                	sar    %edx
    23b3:	0f be 05 00 79 00 00 	movsbl 0x7900,%eax
    23ba:	39 d0                	cmp    %edx,%eax
    23bc:	75 6a                	jne    2428 <bigfile+0x12c>
    23be:	0f be 15 2b 7a 00 00 	movsbl 0x7a2b,%edx
    23c5:	39 d0                	cmp    %edx,%eax
    23c7:	75 5f                	jne    2428 <bigfile+0x12c>
    total += cc;
    23c9:	81 c6 2c 01 00 00    	add    $0x12c,%esi
  for(i = 0; ; i++){
    23cf:	43                   	inc    %ebx
    cc = read(fd, buf, 300);
    23d0:	50                   	push   %eax
    23d1:	68 2c 01 00 00       	push   $0x12c
    23d6:	68 00 79 00 00       	push   $0x7900
    23db:	57                   	push   %edi
    23dc:	e8 c6 11 00 00       	call   35a7 <read>
    if(cc < 0){
    23e1:	83 c4 10             	add    $0x10,%esp
    23e4:	85 c0                	test   %eax,%eax
    23e6:	78 68                	js     2450 <bigfile+0x154>
    if(cc == 0)
    23e8:	75 ba                	jne    23a4 <bigfile+0xa8>
  close(fd);
    23ea:	83 ec 0c             	sub    $0xc,%esp
    23ed:	57                   	push   %edi
    23ee:	e8 c4 11 00 00       	call   35b7 <close>
  if(total != 20*600){
    23f3:	83 c4 10             	add    $0x10,%esp
    23f6:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
    23fc:	0f 85 9c 00 00 00    	jne    249e <bigfile+0x1a2>
  unlink("bigfile");
    2402:	83 ec 0c             	sub    $0xc,%esp
    2405:	68 58 44 00 00       	push   $0x4458
    240a:	e8 d0 11 00 00       	call   35df <unlink>
  printf(1, "bigfile test ok\n");
    240f:	58                   	pop    %eax
    2410:	5a                   	pop    %edx
    2411:	68 e7 44 00 00       	push   $0x44e7
    2416:	6a 01                	push   $0x1
    2418:	e8 a7 12 00 00       	call   36c4 <printf>
}
    241d:	83 c4 10             	add    $0x10,%esp
    2420:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2423:	5b                   	pop    %ebx
    2424:	5e                   	pop    %esi
    2425:	5f                   	pop    %edi
    2426:	5d                   	pop    %ebp
    2427:	c3                   	ret
      printf(1, "read bigfile wrong data\n");
    2428:	83 ec 08             	sub    $0x8,%esp
    242b:	68 b4 44 00 00       	push   $0x44b4
    2430:	6a 01                	push   $0x1
    2432:	e8 8d 12 00 00       	call   36c4 <printf>
      exit();
    2437:	e8 53 11 00 00       	call   358f <exit>
      printf(1, "short read bigfile\n");
    243c:	83 ec 08             	sub    $0x8,%esp
    243f:	68 a0 44 00 00       	push   $0x44a0
    2444:	6a 01                	push   $0x1
    2446:	e8 79 12 00 00       	call   36c4 <printf>
      exit();
    244b:	e8 3f 11 00 00       	call   358f <exit>
      printf(1, "read bigfile failed\n");
    2450:	83 ec 08             	sub    $0x8,%esp
    2453:	68 8b 44 00 00       	push   $0x448b
    2458:	6a 01                	push   $0x1
    245a:	e8 65 12 00 00       	call   36c4 <printf>
      exit();
    245f:	e8 2b 11 00 00       	call   358f <exit>
      printf(1, "write bigfile failed\n");
    2464:	83 ec 08             	sub    $0x8,%esp
    2467:	68 60 44 00 00       	push   $0x4460
    246c:	6a 01                	push   $0x1
    246e:	e8 51 12 00 00       	call   36c4 <printf>
      exit();
    2473:	e8 17 11 00 00       	call   358f <exit>
    printf(1, "cannot open bigfile\n");
    2478:	50                   	push   %eax
    2479:	50                   	push   %eax
    247a:	68 76 44 00 00       	push   $0x4476
    247f:	6a 01                	push   $0x1
    2481:	e8 3e 12 00 00       	call   36c4 <printf>
    exit();
    2486:	e8 04 11 00 00       	call   358f <exit>
    printf(1, "cannot create bigfile");
    248b:	53                   	push   %ebx
    248c:	53                   	push   %ebx
    248d:	68 4a 44 00 00       	push   $0x444a
    2492:	6a 01                	push   $0x1
    2494:	e8 2b 12 00 00       	call   36c4 <printf>
    exit();
    2499:	e8 f1 10 00 00       	call   358f <exit>
    printf(1, "read bigfile wrong total\n");
    249e:	51                   	push   %ecx
    249f:	51                   	push   %ecx
    24a0:	68 cd 44 00 00       	push   $0x44cd
    24a5:	6a 01                	push   $0x1
    24a7:	e8 18 12 00 00       	call   36c4 <printf>
    exit();
    24ac:	e8 de 10 00 00       	call   358f <exit>
    24b1:	8d 76 00             	lea    0x0(%esi),%esi

000024b4 <fourteen>:
{
    24b4:	55                   	push   %ebp
    24b5:	89 e5                	mov    %esp,%ebp
    24b7:	83 ec 10             	sub    $0x10,%esp
  printf(1, "fourteen test\n");
    24ba:	68 f8 44 00 00       	push   $0x44f8
    24bf:	6a 01                	push   $0x1
    24c1:	e8 fe 11 00 00       	call   36c4 <printf>
  if(mkdir("12345678901234") != 0){
    24c6:	c7 04 24 33 45 00 00 	movl   $0x4533,(%esp)
    24cd:	e8 25 11 00 00       	call   35f7 <mkdir>
    24d2:	83 c4 10             	add    $0x10,%esp
    24d5:	85 c0                	test   %eax,%eax
    24d7:	0f 85 97 00 00 00    	jne    2574 <fourteen+0xc0>
  if(mkdir("12345678901234/123456789012345") != 0){
    24dd:	83 ec 0c             	sub    $0xc,%esp
    24e0:	68 f8 4c 00 00       	push   $0x4cf8
    24e5:	e8 0d 11 00 00       	call   35f7 <mkdir>
    24ea:	83 c4 10             	add    $0x10,%esp
    24ed:	85 c0                	test   %eax,%eax
    24ef:	0f 85 de 00 00 00    	jne    25d3 <fourteen+0x11f>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    24f5:	83 ec 08             	sub    $0x8,%esp
    24f8:	68 00 02 00 00       	push   $0x200
    24fd:	68 48 4d 00 00       	push   $0x4d48
    2502:	e8 c8 10 00 00       	call   35cf <open>
  if(fd < 0){
    2507:	83 c4 10             	add    $0x10,%esp
    250a:	85 c0                	test   %eax,%eax
    250c:	0f 88 ae 00 00 00    	js     25c0 <fourteen+0x10c>
  close(fd);
    2512:	83 ec 0c             	sub    $0xc,%esp
    2515:	50                   	push   %eax
    2516:	e8 9c 10 00 00       	call   35b7 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    251b:	58                   	pop    %eax
    251c:	5a                   	pop    %edx
    251d:	6a 00                	push   $0x0
    251f:	68 b8 4d 00 00       	push   $0x4db8
    2524:	e8 a6 10 00 00       	call   35cf <open>
  if(fd < 0){
    2529:	83 c4 10             	add    $0x10,%esp
    252c:	85 c0                	test   %eax,%eax
    252e:	78 7d                	js     25ad <fourteen+0xf9>
  close(fd);
    2530:	83 ec 0c             	sub    $0xc,%esp
    2533:	50                   	push   %eax
    2534:	e8 7e 10 00 00       	call   35b7 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2539:	c7 04 24 24 45 00 00 	movl   $0x4524,(%esp)
    2540:	e8 b2 10 00 00       	call   35f7 <mkdir>
    2545:	83 c4 10             	add    $0x10,%esp
    2548:	85 c0                	test   %eax,%eax
    254a:	74 4e                	je     259a <fourteen+0xe6>
  if(mkdir("123456789012345/12345678901234") == 0){
    254c:	83 ec 0c             	sub    $0xc,%esp
    254f:	68 54 4e 00 00       	push   $0x4e54
    2554:	e8 9e 10 00 00       	call   35f7 <mkdir>
    2559:	83 c4 10             	add    $0x10,%esp
    255c:	85 c0                	test   %eax,%eax
    255e:	74 27                	je     2587 <fourteen+0xd3>
  printf(1, "fourteen ok\n");
    2560:	83 ec 08             	sub    $0x8,%esp
    2563:	68 42 45 00 00       	push   $0x4542
    2568:	6a 01                	push   $0x1
    256a:	e8 55 11 00 00       	call   36c4 <printf>
}
    256f:	83 c4 10             	add    $0x10,%esp
    2572:	c9                   	leave
    2573:	c3                   	ret
    printf(1, "mkdir 12345678901234 failed\n");
    2574:	50                   	push   %eax
    2575:	50                   	push   %eax
    2576:	68 07 45 00 00       	push   $0x4507
    257b:	6a 01                	push   $0x1
    257d:	e8 42 11 00 00       	call   36c4 <printf>
    exit();
    2582:	e8 08 10 00 00       	call   358f <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2587:	50                   	push   %eax
    2588:	50                   	push   %eax
    2589:	68 74 4e 00 00       	push   $0x4e74
    258e:	6a 01                	push   $0x1
    2590:	e8 2f 11 00 00       	call   36c4 <printf>
    exit();
    2595:	e8 f5 0f 00 00       	call   358f <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    259a:	52                   	push   %edx
    259b:	52                   	push   %edx
    259c:	68 24 4e 00 00       	push   $0x4e24
    25a1:	6a 01                	push   $0x1
    25a3:	e8 1c 11 00 00       	call   36c4 <printf>
    exit();
    25a8:	e8 e2 0f 00 00       	call   358f <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    25ad:	51                   	push   %ecx
    25ae:	51                   	push   %ecx
    25af:	68 e8 4d 00 00       	push   $0x4de8
    25b4:	6a 01                	push   $0x1
    25b6:	e8 09 11 00 00       	call   36c4 <printf>
    exit();
    25bb:	e8 cf 0f 00 00       	call   358f <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    25c0:	51                   	push   %ecx
    25c1:	51                   	push   %ecx
    25c2:	68 78 4d 00 00       	push   $0x4d78
    25c7:	6a 01                	push   $0x1
    25c9:	e8 f6 10 00 00       	call   36c4 <printf>
    exit();
    25ce:	e8 bc 0f 00 00       	call   358f <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    25d3:	50                   	push   %eax
    25d4:	50                   	push   %eax
    25d5:	68 18 4d 00 00       	push   $0x4d18
    25da:	6a 01                	push   $0x1
    25dc:	e8 e3 10 00 00       	call   36c4 <printf>
    exit();
    25e1:	e8 a9 0f 00 00       	call   358f <exit>
    25e6:	66 90                	xchg   %ax,%ax

000025e8 <rmdot>:
{
    25e8:	55                   	push   %ebp
    25e9:	89 e5                	mov    %esp,%ebp
    25eb:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    25ee:	68 4f 45 00 00       	push   $0x454f
    25f3:	6a 01                	push   $0x1
    25f5:	e8 ca 10 00 00       	call   36c4 <printf>
  if(mkdir("dots") != 0){
    25fa:	c7 04 24 5b 45 00 00 	movl   $0x455b,(%esp)
    2601:	e8 f1 0f 00 00       	call   35f7 <mkdir>
    2606:	83 c4 10             	add    $0x10,%esp
    2609:	85 c0                	test   %eax,%eax
    260b:	0f 85 b0 00 00 00    	jne    26c1 <rmdot+0xd9>
  if(chdir("dots") != 0){
    2611:	83 ec 0c             	sub    $0xc,%esp
    2614:	68 5b 45 00 00       	push   $0x455b
    2619:	e8 e1 0f 00 00       	call   35ff <chdir>
    261e:	83 c4 10             	add    $0x10,%esp
    2621:	85 c0                	test   %eax,%eax
    2623:	0f 85 1d 01 00 00    	jne    2746 <rmdot+0x15e>
  if(unlink(".") == 0){
    2629:	83 ec 0c             	sub    $0xc,%esp
    262c:	68 06 42 00 00       	push   $0x4206
    2631:	e8 a9 0f 00 00       	call   35df <unlink>
    2636:	83 c4 10             	add    $0x10,%esp
    2639:	85 c0                	test   %eax,%eax
    263b:	0f 84 f2 00 00 00    	je     2733 <rmdot+0x14b>
  if(unlink("..") == 0){
    2641:	83 ec 0c             	sub    $0xc,%esp
    2644:	68 05 42 00 00       	push   $0x4205
    2649:	e8 91 0f 00 00       	call   35df <unlink>
    264e:	83 c4 10             	add    $0x10,%esp
    2651:	85 c0                	test   %eax,%eax
    2653:	0f 84 c7 00 00 00    	je     2720 <rmdot+0x138>
  if(chdir("/") != 0){
    2659:	83 ec 0c             	sub    $0xc,%esp
    265c:	68 d9 39 00 00       	push   $0x39d9
    2661:	e8 99 0f 00 00       	call   35ff <chdir>
    2666:	83 c4 10             	add    $0x10,%esp
    2669:	85 c0                	test   %eax,%eax
    266b:	0f 85 9c 00 00 00    	jne    270d <rmdot+0x125>
  if(unlink("dots/.") == 0){
    2671:	83 ec 0c             	sub    $0xc,%esp
    2674:	68 a3 45 00 00       	push   $0x45a3
    2679:	e8 61 0f 00 00       	call   35df <unlink>
    267e:	83 c4 10             	add    $0x10,%esp
    2681:	85 c0                	test   %eax,%eax
    2683:	74 75                	je     26fa <rmdot+0x112>
  if(unlink("dots/..") == 0){
    2685:	83 ec 0c             	sub    $0xc,%esp
    2688:	68 c1 45 00 00       	push   $0x45c1
    268d:	e8 4d 0f 00 00       	call   35df <unlink>
    2692:	83 c4 10             	add    $0x10,%esp
    2695:	85 c0                	test   %eax,%eax
    2697:	74 4e                	je     26e7 <rmdot+0xff>
  if(unlink("dots") != 0){
    2699:	83 ec 0c             	sub    $0xc,%esp
    269c:	68 5b 45 00 00       	push   $0x455b
    26a1:	e8 39 0f 00 00       	call   35df <unlink>
    26a6:	83 c4 10             	add    $0x10,%esp
    26a9:	85 c0                	test   %eax,%eax
    26ab:	75 27                	jne    26d4 <rmdot+0xec>
  printf(1, "rmdot ok\n");
    26ad:	83 ec 08             	sub    $0x8,%esp
    26b0:	68 f6 45 00 00       	push   $0x45f6
    26b5:	6a 01                	push   $0x1
    26b7:	e8 08 10 00 00       	call   36c4 <printf>
}
    26bc:	83 c4 10             	add    $0x10,%esp
    26bf:	c9                   	leave
    26c0:	c3                   	ret
    printf(1, "mkdir dots failed\n");
    26c1:	50                   	push   %eax
    26c2:	50                   	push   %eax
    26c3:	68 60 45 00 00       	push   $0x4560
    26c8:	6a 01                	push   $0x1
    26ca:	e8 f5 0f 00 00       	call   36c4 <printf>
    exit();
    26cf:	e8 bb 0e 00 00       	call   358f <exit>
    printf(1, "unlink dots failed!\n");
    26d4:	50                   	push   %eax
    26d5:	50                   	push   %eax
    26d6:	68 e1 45 00 00       	push   $0x45e1
    26db:	6a 01                	push   $0x1
    26dd:	e8 e2 0f 00 00       	call   36c4 <printf>
    exit();
    26e2:	e8 a8 0e 00 00       	call   358f <exit>
    printf(1, "unlink dots/.. worked!\n");
    26e7:	52                   	push   %edx
    26e8:	52                   	push   %edx
    26e9:	68 c9 45 00 00       	push   $0x45c9
    26ee:	6a 01                	push   $0x1
    26f0:	e8 cf 0f 00 00       	call   36c4 <printf>
    exit();
    26f5:	e8 95 0e 00 00       	call   358f <exit>
    printf(1, "unlink dots/. worked!\n");
    26fa:	51                   	push   %ecx
    26fb:	51                   	push   %ecx
    26fc:	68 aa 45 00 00       	push   $0x45aa
    2701:	6a 01                	push   $0x1
    2703:	e8 bc 0f 00 00       	call   36c4 <printf>
    exit();
    2708:	e8 82 0e 00 00       	call   358f <exit>
    printf(1, "chdir / failed\n");
    270d:	50                   	push   %eax
    270e:	50                   	push   %eax
    270f:	68 db 39 00 00       	push   $0x39db
    2714:	6a 01                	push   $0x1
    2716:	e8 a9 0f 00 00       	call   36c4 <printf>
    exit();
    271b:	e8 6f 0e 00 00       	call   358f <exit>
    printf(1, "rm .. worked!\n");
    2720:	50                   	push   %eax
    2721:	50                   	push   %eax
    2722:	68 94 45 00 00       	push   $0x4594
    2727:	6a 01                	push   $0x1
    2729:	e8 96 0f 00 00       	call   36c4 <printf>
    exit();
    272e:	e8 5c 0e 00 00       	call   358f <exit>
    printf(1, "rm . worked!\n");
    2733:	50                   	push   %eax
    2734:	50                   	push   %eax
    2735:	68 86 45 00 00       	push   $0x4586
    273a:	6a 01                	push   $0x1
    273c:	e8 83 0f 00 00       	call   36c4 <printf>
    exit();
    2741:	e8 49 0e 00 00       	call   358f <exit>
    printf(1, "chdir dots failed\n");
    2746:	50                   	push   %eax
    2747:	50                   	push   %eax
    2748:	68 73 45 00 00       	push   $0x4573
    274d:	6a 01                	push   $0x1
    274f:	e8 70 0f 00 00       	call   36c4 <printf>
    exit();
    2754:	e8 36 0e 00 00       	call   358f <exit>
    2759:	8d 76 00             	lea    0x0(%esi),%esi

0000275c <dirfile>:
{
    275c:	55                   	push   %ebp
    275d:	89 e5                	mov    %esp,%ebp
    275f:	53                   	push   %ebx
    2760:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "dir vs file\n");
    2763:	68 00 46 00 00       	push   $0x4600
    2768:	6a 01                	push   $0x1
    276a:	e8 55 0f 00 00       	call   36c4 <printf>
  fd = open("dirfile", O_CREATE);
    276f:	5b                   	pop    %ebx
    2770:	58                   	pop    %eax
    2771:	68 00 02 00 00       	push   $0x200
    2776:	68 0d 46 00 00       	push   $0x460d
    277b:	e8 4f 0e 00 00       	call   35cf <open>
  if(fd < 0){
    2780:	83 c4 10             	add    $0x10,%esp
    2783:	85 c0                	test   %eax,%eax
    2785:	0f 88 43 01 00 00    	js     28ce <dirfile+0x172>
  close(fd);
    278b:	83 ec 0c             	sub    $0xc,%esp
    278e:	50                   	push   %eax
    278f:	e8 23 0e 00 00       	call   35b7 <close>
  if(chdir("dirfile") == 0){
    2794:	c7 04 24 0d 46 00 00 	movl   $0x460d,(%esp)
    279b:	e8 5f 0e 00 00       	call   35ff <chdir>
    27a0:	83 c4 10             	add    $0x10,%esp
    27a3:	85 c0                	test   %eax,%eax
    27a5:	0f 84 10 01 00 00    	je     28bb <dirfile+0x15f>
  fd = open("dirfile/xx", 0);
    27ab:	83 ec 08             	sub    $0x8,%esp
    27ae:	6a 00                	push   $0x0
    27b0:	68 46 46 00 00       	push   $0x4646
    27b5:	e8 15 0e 00 00       	call   35cf <open>
  if(fd >= 0){
    27ba:	83 c4 10             	add    $0x10,%esp
    27bd:	85 c0                	test   %eax,%eax
    27bf:	0f 89 e3 00 00 00    	jns    28a8 <dirfile+0x14c>
  fd = open("dirfile/xx", O_CREATE);
    27c5:	83 ec 08             	sub    $0x8,%esp
    27c8:	68 00 02 00 00       	push   $0x200
    27cd:	68 46 46 00 00       	push   $0x4646
    27d2:	e8 f8 0d 00 00       	call   35cf <open>
  if(fd >= 0){
    27d7:	83 c4 10             	add    $0x10,%esp
    27da:	85 c0                	test   %eax,%eax
    27dc:	0f 89 c6 00 00 00    	jns    28a8 <dirfile+0x14c>
  if(mkdir("dirfile/xx") == 0){
    27e2:	83 ec 0c             	sub    $0xc,%esp
    27e5:	68 46 46 00 00       	push   $0x4646
    27ea:	e8 08 0e 00 00       	call   35f7 <mkdir>
    27ef:	83 c4 10             	add    $0x10,%esp
    27f2:	85 c0                	test   %eax,%eax
    27f4:	0f 84 46 01 00 00    	je     2940 <dirfile+0x1e4>
  if(unlink("dirfile/xx") == 0){
    27fa:	83 ec 0c             	sub    $0xc,%esp
    27fd:	68 46 46 00 00       	push   $0x4646
    2802:	e8 d8 0d 00 00       	call   35df <unlink>
    2807:	83 c4 10             	add    $0x10,%esp
    280a:	85 c0                	test   %eax,%eax
    280c:	0f 84 1b 01 00 00    	je     292d <dirfile+0x1d1>
  if(link("README", "dirfile/xx") == 0){
    2812:	83 ec 08             	sub    $0x8,%esp
    2815:	68 46 46 00 00       	push   $0x4646
    281a:	68 aa 46 00 00       	push   $0x46aa
    281f:	e8 cb 0d 00 00       	call   35ef <link>
    2824:	83 c4 10             	add    $0x10,%esp
    2827:	85 c0                	test   %eax,%eax
    2829:	0f 84 eb 00 00 00    	je     291a <dirfile+0x1be>
  if(unlink("dirfile") != 0){
    282f:	83 ec 0c             	sub    $0xc,%esp
    2832:	68 0d 46 00 00       	push   $0x460d
    2837:	e8 a3 0d 00 00       	call   35df <unlink>
    283c:	83 c4 10             	add    $0x10,%esp
    283f:	85 c0                	test   %eax,%eax
    2841:	0f 85 c0 00 00 00    	jne    2907 <dirfile+0x1ab>
  fd = open(".", O_RDWR);
    2847:	83 ec 08             	sub    $0x8,%esp
    284a:	6a 02                	push   $0x2
    284c:	68 06 42 00 00       	push   $0x4206
    2851:	e8 79 0d 00 00       	call   35cf <open>
  if(fd >= 0){
    2856:	83 c4 10             	add    $0x10,%esp
    2859:	85 c0                	test   %eax,%eax
    285b:	0f 89 93 00 00 00    	jns    28f4 <dirfile+0x198>
  fd = open(".", 0);
    2861:	83 ec 08             	sub    $0x8,%esp
    2864:	6a 00                	push   $0x0
    2866:	68 06 42 00 00       	push   $0x4206
    286b:	e8 5f 0d 00 00       	call   35cf <open>
    2870:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2872:	83 c4 0c             	add    $0xc,%esp
    2875:	6a 01                	push   $0x1
    2877:	68 e9 42 00 00       	push   $0x42e9
    287c:	50                   	push   %eax
    287d:	e8 2d 0d 00 00       	call   35af <write>
    2882:	83 c4 10             	add    $0x10,%esp
    2885:	85 c0                	test   %eax,%eax
    2887:	7f 58                	jg     28e1 <dirfile+0x185>
  close(fd);
    2889:	83 ec 0c             	sub    $0xc,%esp
    288c:	53                   	push   %ebx
    288d:	e8 25 0d 00 00       	call   35b7 <close>
  printf(1, "dir vs file OK\n");
    2892:	58                   	pop    %eax
    2893:	5a                   	pop    %edx
    2894:	68 dd 46 00 00       	push   $0x46dd
    2899:	6a 01                	push   $0x1
    289b:	e8 24 0e 00 00       	call   36c4 <printf>
}
    28a0:	83 c4 10             	add    $0x10,%esp
    28a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    28a6:	c9                   	leave
    28a7:	c3                   	ret
    printf(1, "create dirfile/xx succeeded!\n");
    28a8:	50                   	push   %eax
    28a9:	50                   	push   %eax
    28aa:	68 51 46 00 00       	push   $0x4651
    28af:	6a 01                	push   $0x1
    28b1:	e8 0e 0e 00 00       	call   36c4 <printf>
    exit();
    28b6:	e8 d4 0c 00 00       	call   358f <exit>
    printf(1, "chdir dirfile succeeded!\n");
    28bb:	52                   	push   %edx
    28bc:	52                   	push   %edx
    28bd:	68 2c 46 00 00       	push   $0x462c
    28c2:	6a 01                	push   $0x1
    28c4:	e8 fb 0d 00 00       	call   36c4 <printf>
    exit();
    28c9:	e8 c1 0c 00 00       	call   358f <exit>
    printf(1, "create dirfile failed\n");
    28ce:	51                   	push   %ecx
    28cf:	51                   	push   %ecx
    28d0:	68 15 46 00 00       	push   $0x4615
    28d5:	6a 01                	push   $0x1
    28d7:	e8 e8 0d 00 00       	call   36c4 <printf>
    exit();
    28dc:	e8 ae 0c 00 00       	call   358f <exit>
    printf(1, "write . succeeded!\n");
    28e1:	51                   	push   %ecx
    28e2:	51                   	push   %ecx
    28e3:	68 c9 46 00 00       	push   $0x46c9
    28e8:	6a 01                	push   $0x1
    28ea:	e8 d5 0d 00 00       	call   36c4 <printf>
    exit();
    28ef:	e8 9b 0c 00 00       	call   358f <exit>
    printf(1, "open . for writing succeeded!\n");
    28f4:	53                   	push   %ebx
    28f5:	53                   	push   %ebx
    28f6:	68 c8 4e 00 00       	push   $0x4ec8
    28fb:	6a 01                	push   $0x1
    28fd:	e8 c2 0d 00 00       	call   36c4 <printf>
    exit();
    2902:	e8 88 0c 00 00       	call   358f <exit>
    printf(1, "unlink dirfile failed!\n");
    2907:	50                   	push   %eax
    2908:	50                   	push   %eax
    2909:	68 b1 46 00 00       	push   $0x46b1
    290e:	6a 01                	push   $0x1
    2910:	e8 af 0d 00 00       	call   36c4 <printf>
    exit();
    2915:	e8 75 0c 00 00       	call   358f <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    291a:	50                   	push   %eax
    291b:	50                   	push   %eax
    291c:	68 a8 4e 00 00       	push   $0x4ea8
    2921:	6a 01                	push   $0x1
    2923:	e8 9c 0d 00 00       	call   36c4 <printf>
    exit();
    2928:	e8 62 0c 00 00       	call   358f <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    292d:	50                   	push   %eax
    292e:	50                   	push   %eax
    292f:	68 8c 46 00 00       	push   $0x468c
    2934:	6a 01                	push   $0x1
    2936:	e8 89 0d 00 00       	call   36c4 <printf>
    exit();
    293b:	e8 4f 0c 00 00       	call   358f <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2940:	50                   	push   %eax
    2941:	50                   	push   %eax
    2942:	68 6f 46 00 00       	push   $0x466f
    2947:	6a 01                	push   $0x1
    2949:	e8 76 0d 00 00       	call   36c4 <printf>
    exit();
    294e:	e8 3c 0c 00 00       	call   358f <exit>
    2953:	90                   	nop

00002954 <iref>:
{
    2954:	55                   	push   %ebp
    2955:	89 e5                	mov    %esp,%ebp
    2957:	53                   	push   %ebx
    2958:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "empty file name\n");
    295b:	68 ed 46 00 00       	push   $0x46ed
    2960:	6a 01                	push   $0x1
    2962:	e8 5d 0d 00 00       	call   36c4 <printf>
    2967:	83 c4 10             	add    $0x10,%esp
    296a:	bb 33 00 00 00       	mov    $0x33,%ebx
    296f:	90                   	nop
    if(mkdir("irefd") != 0){
    2970:	83 ec 0c             	sub    $0xc,%esp
    2973:	68 fe 46 00 00       	push   $0x46fe
    2978:	e8 7a 0c 00 00       	call   35f7 <mkdir>
    297d:	83 c4 10             	add    $0x10,%esp
    2980:	85 c0                	test   %eax,%eax
    2982:	0f 85 b9 00 00 00    	jne    2a41 <iref+0xed>
    if(chdir("irefd") != 0){
    2988:	83 ec 0c             	sub    $0xc,%esp
    298b:	68 fe 46 00 00       	push   $0x46fe
    2990:	e8 6a 0c 00 00       	call   35ff <chdir>
    2995:	83 c4 10             	add    $0x10,%esp
    2998:	85 c0                	test   %eax,%eax
    299a:	0f 85 b5 00 00 00    	jne    2a55 <iref+0x101>
    mkdir("");
    29a0:	83 ec 0c             	sub    $0xc,%esp
    29a3:	68 b3 3d 00 00       	push   $0x3db3
    29a8:	e8 4a 0c 00 00       	call   35f7 <mkdir>
    link("README", "");
    29ad:	59                   	pop    %ecx
    29ae:	58                   	pop    %eax
    29af:	68 b3 3d 00 00       	push   $0x3db3
    29b4:	68 aa 46 00 00       	push   $0x46aa
    29b9:	e8 31 0c 00 00       	call   35ef <link>
    fd = open("", O_CREATE);
    29be:	58                   	pop    %eax
    29bf:	5a                   	pop    %edx
    29c0:	68 00 02 00 00       	push   $0x200
    29c5:	68 b3 3d 00 00       	push   $0x3db3
    29ca:	e8 00 0c 00 00       	call   35cf <open>
    if(fd >= 0)
    29cf:	83 c4 10             	add    $0x10,%esp
    29d2:	85 c0                	test   %eax,%eax
    29d4:	78 0c                	js     29e2 <iref+0x8e>
      close(fd);
    29d6:	83 ec 0c             	sub    $0xc,%esp
    29d9:	50                   	push   %eax
    29da:	e8 d8 0b 00 00       	call   35b7 <close>
    29df:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    29e2:	83 ec 08             	sub    $0x8,%esp
    29e5:	68 00 02 00 00       	push   $0x200
    29ea:	68 e8 42 00 00       	push   $0x42e8
    29ef:	e8 db 0b 00 00       	call   35cf <open>
    if(fd >= 0)
    29f4:	83 c4 10             	add    $0x10,%esp
    29f7:	85 c0                	test   %eax,%eax
    29f9:	78 0c                	js     2a07 <iref+0xb3>
      close(fd);
    29fb:	83 ec 0c             	sub    $0xc,%esp
    29fe:	50                   	push   %eax
    29ff:	e8 b3 0b 00 00       	call   35b7 <close>
    2a04:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2a07:	83 ec 0c             	sub    $0xc,%esp
    2a0a:	68 e8 42 00 00       	push   $0x42e8
    2a0f:	e8 cb 0b 00 00       	call   35df <unlink>
  for(i = 0; i < 50 + 1; i++){
    2a14:	83 c4 10             	add    $0x10,%esp
    2a17:	4b                   	dec    %ebx
    2a18:	0f 85 52 ff ff ff    	jne    2970 <iref+0x1c>
  chdir("/");
    2a1e:	83 ec 0c             	sub    $0xc,%esp
    2a21:	68 d9 39 00 00       	push   $0x39d9
    2a26:	e8 d4 0b 00 00       	call   35ff <chdir>
  printf(1, "empty file name OK\n");
    2a2b:	58                   	pop    %eax
    2a2c:	5a                   	pop    %edx
    2a2d:	68 2c 47 00 00       	push   $0x472c
    2a32:	6a 01                	push   $0x1
    2a34:	e8 8b 0c 00 00       	call   36c4 <printf>
}
    2a39:	83 c4 10             	add    $0x10,%esp
    2a3c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2a3f:	c9                   	leave
    2a40:	c3                   	ret
      printf(1, "mkdir irefd failed\n");
    2a41:	83 ec 08             	sub    $0x8,%esp
    2a44:	68 04 47 00 00       	push   $0x4704
    2a49:	6a 01                	push   $0x1
    2a4b:	e8 74 0c 00 00       	call   36c4 <printf>
      exit();
    2a50:	e8 3a 0b 00 00       	call   358f <exit>
      printf(1, "chdir irefd failed\n");
    2a55:	83 ec 08             	sub    $0x8,%esp
    2a58:	68 18 47 00 00       	push   $0x4718
    2a5d:	6a 01                	push   $0x1
    2a5f:	e8 60 0c 00 00       	call   36c4 <printf>
      exit();
    2a64:	e8 26 0b 00 00       	call   358f <exit>
    2a69:	8d 76 00             	lea    0x0(%esi),%esi

00002a6c <forktest>:
{
    2a6c:	55                   	push   %ebp
    2a6d:	89 e5                	mov    %esp,%ebp
    2a6f:	53                   	push   %ebx
    2a70:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "fork test\n");
    2a73:	68 40 47 00 00       	push   $0x4740
    2a78:	6a 01                	push   $0x1
    2a7a:	e8 45 0c 00 00       	call   36c4 <printf>
    2a7f:	83 c4 10             	add    $0x10,%esp
  for(n=0; n<1000; n++){
    2a82:	31 db                	xor    %ebx,%ebx
    2a84:	eb 0d                	jmp    2a93 <forktest+0x27>
    2a86:	66 90                	xchg   %ax,%ax
    if(pid == 0)
    2a88:	74 3e                	je     2ac8 <forktest+0x5c>
  for(n=0; n<1000; n++){
    2a8a:	43                   	inc    %ebx
    2a8b:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2a91:	74 61                	je     2af4 <forktest+0x88>
    pid = fork();
    2a93:	e8 ef 0a 00 00       	call   3587 <fork>
    if(pid < 0)
    2a98:	85 c0                	test   %eax,%eax
    2a9a:	79 ec                	jns    2a88 <forktest+0x1c>
  for(; n > 0; n--){
    2a9c:	85 db                	test   %ebx,%ebx
    2a9e:	74 0c                	je     2aac <forktest+0x40>
    if(wait() < 0){
    2aa0:	e8 f2 0a 00 00       	call   3597 <wait>
    2aa5:	85 c0                	test   %eax,%eax
    2aa7:	78 24                	js     2acd <forktest+0x61>
  for(; n > 0; n--){
    2aa9:	4b                   	dec    %ebx
    2aaa:	75 f4                	jne    2aa0 <forktest+0x34>
  if(wait() != -1){
    2aac:	e8 e6 0a 00 00       	call   3597 <wait>
    2ab1:	40                   	inc    %eax
    2ab2:	75 2d                	jne    2ae1 <forktest+0x75>
  printf(1, "fork test OK\n");
    2ab4:	83 ec 08             	sub    $0x8,%esp
    2ab7:	68 72 47 00 00       	push   $0x4772
    2abc:	6a 01                	push   $0x1
    2abe:	e8 01 0c 00 00       	call   36c4 <printf>
}
    2ac3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2ac6:	c9                   	leave
    2ac7:	c3                   	ret
      exit();
    2ac8:	e8 c2 0a 00 00       	call   358f <exit>
      printf(1, "wait stopped early\n");
    2acd:	83 ec 08             	sub    $0x8,%esp
    2ad0:	68 4b 47 00 00       	push   $0x474b
    2ad5:	6a 01                	push   $0x1
    2ad7:	e8 e8 0b 00 00       	call   36c4 <printf>
      exit();
    2adc:	e8 ae 0a 00 00       	call   358f <exit>
    printf(1, "wait got too many\n");
    2ae1:	52                   	push   %edx
    2ae2:	52                   	push   %edx
    2ae3:	68 5f 47 00 00       	push   $0x475f
    2ae8:	6a 01                	push   $0x1
    2aea:	e8 d5 0b 00 00       	call   36c4 <printf>
    exit();
    2aef:	e8 9b 0a 00 00       	call   358f <exit>
    printf(1, "fork claimed to work 1000 times!\n");
    2af4:	50                   	push   %eax
    2af5:	50                   	push   %eax
    2af6:	68 e8 4e 00 00       	push   $0x4ee8
    2afb:	6a 01                	push   $0x1
    2afd:	e8 c2 0b 00 00       	call   36c4 <printf>
    exit();
    2b02:	e8 88 0a 00 00       	call   358f <exit>
    2b07:	90                   	nop

00002b08 <sbrktest>:
{
    2b08:	55                   	push   %ebp
    2b09:	89 e5                	mov    %esp,%ebp
    2b0b:	57                   	push   %edi
    2b0c:	56                   	push   %esi
    2b0d:	53                   	push   %ebx
    2b0e:	83 ec 64             	sub    $0x64,%esp
  printf(stdout, "sbrk test\n");
    2b11:	68 80 47 00 00       	push   $0x4780
    2b16:	ff 35 b0 51 00 00    	push   0x51b0
    2b1c:	e8 a3 0b 00 00       	call   36c4 <printf>
  oldbrk = sbrk(0);
    2b21:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b28:	e8 ea 0a 00 00       	call   3617 <sbrk>
    2b2d:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  a = sbrk(0);
    2b30:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2b37:	e8 db 0a 00 00       	call   3617 <sbrk>
    2b3c:	89 c3                	mov    %eax,%ebx
    2b3e:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 5000; i++){
    2b41:	31 f6                	xor    %esi,%esi
    2b43:	eb 05                	jmp    2b4a <sbrktest+0x42>
    2b45:	8d 76 00             	lea    0x0(%esi),%esi
    2b48:	89 c3                	mov    %eax,%ebx
    b = sbrk(1);
    2b4a:	83 ec 0c             	sub    $0xc,%esp
    2b4d:	6a 01                	push   $0x1
    2b4f:	e8 c3 0a 00 00       	call   3617 <sbrk>
    if(b != a){
    2b54:	83 c4 10             	add    $0x10,%esp
    2b57:	39 d8                	cmp    %ebx,%eax
    2b59:	0f 85 81 02 00 00    	jne    2de0 <sbrktest+0x2d8>
    *b = 1;
    2b5f:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    2b62:	8d 43 01             	lea    0x1(%ebx),%eax
  for(i = 0; i < 5000; i++){
    2b65:	46                   	inc    %esi
    2b66:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
    2b6c:	75 da                	jne    2b48 <sbrktest+0x40>
  pid = fork();
    2b6e:	e8 14 0a 00 00       	call   3587 <fork>
    2b73:	89 c6                	mov    %eax,%esi
  if(pid < 0){
    2b75:	85 c0                	test   %eax,%eax
    2b77:	0f 88 e9 02 00 00    	js     2e66 <sbrktest+0x35e>
  c = sbrk(1);
    2b7d:	83 ec 0c             	sub    $0xc,%esp
    2b80:	6a 01                	push   $0x1
    2b82:	e8 90 0a 00 00       	call   3617 <sbrk>
  c = sbrk(1);
    2b87:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b8e:	e8 84 0a 00 00       	call   3617 <sbrk>
  if(c != a + 1){
    2b93:	83 c3 02             	add    $0x2,%ebx
    2b96:	83 c4 10             	add    $0x10,%esp
    2b99:	39 c3                	cmp    %eax,%ebx
    2b9b:	0f 85 22 03 00 00    	jne    2ec3 <sbrktest+0x3bb>
  if(pid == 0)
    2ba1:	85 f6                	test   %esi,%esi
    2ba3:	0f 84 15 03 00 00    	je     2ebe <sbrktest+0x3b6>
  wait();
    2ba9:	e8 e9 09 00 00       	call   3597 <wait>
  a = sbrk(0);
    2bae:	83 ec 0c             	sub    $0xc,%esp
    2bb1:	6a 00                	push   $0x0
    2bb3:	e8 5f 0a 00 00       	call   3617 <sbrk>
    2bb8:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
    2bba:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2bbf:	29 d8                	sub    %ebx,%eax
  p = sbrk(amt);
    2bc1:	89 04 24             	mov    %eax,(%esp)
    2bc4:	e8 4e 0a 00 00       	call   3617 <sbrk>
  if (p != a) {
    2bc9:	83 c4 10             	add    $0x10,%esp
    2bcc:	39 c3                	cmp    %eax,%ebx
    2bce:	0f 85 7b 02 00 00    	jne    2e4f <sbrktest+0x347>
  *lastaddr = 99;
    2bd4:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
  a = sbrk(0);
    2bdb:	83 ec 0c             	sub    $0xc,%esp
    2bde:	6a 00                	push   $0x0
    2be0:	e8 32 0a 00 00       	call   3617 <sbrk>
    2be5:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    2be7:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    2bee:	e8 24 0a 00 00       	call   3617 <sbrk>
  if(c == (char*)0xffffffff){
    2bf3:	83 c4 10             	add    $0x10,%esp
    2bf6:	40                   	inc    %eax
    2bf7:	0f 84 0b 03 00 00    	je     2f08 <sbrktest+0x400>
  c = sbrk(0);
    2bfd:	83 ec 0c             	sub    $0xc,%esp
    2c00:	6a 00                	push   $0x0
    2c02:	e8 10 0a 00 00       	call   3617 <sbrk>
  if(c != a - 4096){
    2c07:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    2c0d:	83 c4 10             	add    $0x10,%esp
    2c10:	39 d0                	cmp    %edx,%eax
    2c12:	0f 85 d9 02 00 00    	jne    2ef1 <sbrktest+0x3e9>
  a = sbrk(0);
    2c18:	83 ec 0c             	sub    $0xc,%esp
    2c1b:	6a 00                	push   $0x0
    2c1d:	e8 f5 09 00 00       	call   3617 <sbrk>
    2c22:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    2c24:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2c2b:	e8 e7 09 00 00       	call   3617 <sbrk>
    2c30:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
    2c32:	83 c4 10             	add    $0x10,%esp
    2c35:	39 c3                	cmp    %eax,%ebx
    2c37:	0f 85 9d 02 00 00    	jne    2eda <sbrktest+0x3d2>
    2c3d:	83 ec 0c             	sub    $0xc,%esp
    2c40:	6a 00                	push   $0x0
    2c42:	e8 d0 09 00 00       	call   3617 <sbrk>
    2c47:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    2c4d:	83 c4 10             	add    $0x10,%esp
    2c50:	39 c2                	cmp    %eax,%edx
    2c52:	0f 85 82 02 00 00    	jne    2eda <sbrktest+0x3d2>
  if(*lastaddr == 99){
    2c58:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2c5f:	0f 84 18 02 00 00    	je     2e7d <sbrktest+0x375>
  a = sbrk(0);
    2c65:	83 ec 0c             	sub    $0xc,%esp
    2c68:	6a 00                	push   $0x0
    2c6a:	e8 a8 09 00 00       	call   3617 <sbrk>
    2c6f:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    2c71:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2c78:	e8 9a 09 00 00       	call   3617 <sbrk>
    2c7d:	89 c2                	mov    %eax,%edx
    2c7f:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    2c82:	29 d0                	sub    %edx,%eax
    2c84:	89 04 24             	mov    %eax,(%esp)
    2c87:	e8 8b 09 00 00       	call   3617 <sbrk>
  if(c != a){
    2c8c:	83 c4 10             	add    $0x10,%esp
    2c8f:	39 c3                	cmp    %eax,%ebx
    2c91:	0f 85 a1 01 00 00    	jne    2e38 <sbrktest+0x330>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2c97:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    ppid = getpid();
    2c9c:	e8 6e 09 00 00       	call   360f <getpid>
    2ca1:	89 c6                	mov    %eax,%esi
    pid = fork();
    2ca3:	e8 df 08 00 00       	call   3587 <fork>
    if(pid < 0){
    2ca8:	85 c0                	test   %eax,%eax
    2caa:	0f 88 4e 01 00 00    	js     2dfe <sbrktest+0x2f6>
    if(pid == 0){
    2cb0:	0f 84 60 01 00 00    	je     2e16 <sbrktest+0x30e>
    wait();
    2cb6:	e8 dc 08 00 00       	call   3597 <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2cbb:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    2cc1:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    2cc7:	75 d3                	jne    2c9c <sbrktest+0x194>
  if(pipe(fds) != 0){
    2cc9:	83 ec 0c             	sub    $0xc,%esp
    2ccc:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2ccf:	50                   	push   %eax
    2cd0:	e8 ca 08 00 00       	call   359f <pipe>
    2cd5:	83 c4 10             	add    $0x10,%esp
    2cd8:	85 c0                	test   %eax,%eax
    2cda:	0f 85 cb 01 00 00    	jne    2eab <sbrktest+0x3a3>
    2ce0:	8d 5d c0             	lea    -0x40(%ebp),%ebx
    2ce3:	8d 7d e8             	lea    -0x18(%ebp),%edi
    2ce6:	89 de                	mov    %ebx,%esi
    if((pids[i] = fork()) == 0){
    2ce8:	e8 9a 08 00 00       	call   3587 <fork>
    2ced:	89 06                	mov    %eax,(%esi)
    2cef:	85 c0                	test   %eax,%eax
    2cf1:	0f 84 87 00 00 00    	je     2d7e <sbrktest+0x276>
    if(pids[i] != -1)
    2cf7:	40                   	inc    %eax
    2cf8:	74 12                	je     2d0c <sbrktest+0x204>
      read(fds[0], &scratch, 1);
    2cfa:	52                   	push   %edx
    2cfb:	6a 01                	push   $0x1
    2cfd:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2d00:	50                   	push   %eax
    2d01:	ff 75 b8             	push   -0x48(%ebp)
    2d04:	e8 9e 08 00 00       	call   35a7 <read>
    2d09:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2d0c:	83 c6 04             	add    $0x4,%esi
    2d0f:	39 fe                	cmp    %edi,%esi
    2d11:	75 d5                	jne    2ce8 <sbrktest+0x1e0>
  c = sbrk(4096);
    2d13:	83 ec 0c             	sub    $0xc,%esp
    2d16:	68 00 10 00 00       	push   $0x1000
    2d1b:	e8 f7 08 00 00       	call   3617 <sbrk>
    2d20:	89 c6                	mov    %eax,%esi
    2d22:	83 c4 10             	add    $0x10,%esp
    2d25:	8d 76 00             	lea    0x0(%esi),%esi
    if(pids[i] == -1)
    2d28:	8b 03                	mov    (%ebx),%eax
    2d2a:	83 f8 ff             	cmp    $0xffffffff,%eax
    2d2d:	74 11                	je     2d40 <sbrktest+0x238>
    kill(pids[i]);
    2d2f:	83 ec 0c             	sub    $0xc,%esp
    2d32:	50                   	push   %eax
    2d33:	e8 87 08 00 00       	call   35bf <kill>
    wait();
    2d38:	e8 5a 08 00 00       	call   3597 <wait>
    2d3d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2d40:	83 c3 04             	add    $0x4,%ebx
    2d43:	39 fb                	cmp    %edi,%ebx
    2d45:	75 e1                	jne    2d28 <sbrktest+0x220>
  if(c == (char*)0xffffffff){
    2d47:	46                   	inc    %esi
    2d48:	0f 84 46 01 00 00    	je     2e94 <sbrktest+0x38c>
  if(sbrk(0) > oldbrk)
    2d4e:	83 ec 0c             	sub    $0xc,%esp
    2d51:	6a 00                	push   $0x0
    2d53:	e8 bf 08 00 00       	call   3617 <sbrk>
    2d58:	83 c4 10             	add    $0x10,%esp
    2d5b:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    2d5e:	72 62                	jb     2dc2 <sbrktest+0x2ba>
  printf(stdout, "sbrk test OK\n");
    2d60:	83 ec 08             	sub    $0x8,%esp
    2d63:	68 28 48 00 00       	push   $0x4828
    2d68:	ff 35 b0 51 00 00    	push   0x51b0
    2d6e:	e8 51 09 00 00       	call   36c4 <printf>
}
    2d73:	83 c4 10             	add    $0x10,%esp
    2d76:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2d79:	5b                   	pop    %ebx
    2d7a:	5e                   	pop    %esi
    2d7b:	5f                   	pop    %edi
    2d7c:	5d                   	pop    %ebp
    2d7d:	c3                   	ret
      sbrk(BIG - (uint)sbrk(0));
    2d7e:	83 ec 0c             	sub    $0xc,%esp
    2d81:	6a 00                	push   $0x0
    2d83:	e8 8f 08 00 00       	call   3617 <sbrk>
    2d88:	89 c2                	mov    %eax,%edx
    2d8a:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2d8f:	29 d0                	sub    %edx,%eax
    2d91:	89 04 24             	mov    %eax,(%esp)
    2d94:	e8 7e 08 00 00       	call   3617 <sbrk>
      write(fds[1], "x", 1);
    2d99:	83 c4 0c             	add    $0xc,%esp
    2d9c:	6a 01                	push   $0x1
    2d9e:	68 e9 42 00 00       	push   $0x42e9
    2da3:	ff 75 bc             	push   -0x44(%ebp)
    2da6:	e8 04 08 00 00       	call   35af <write>
    2dab:	83 c4 10             	add    $0x10,%esp
    2dae:	66 90                	xchg   %ax,%ax
      for(;;) sleep(1000);
    2db0:	83 ec 0c             	sub    $0xc,%esp
    2db3:	68 e8 03 00 00       	push   $0x3e8
    2db8:	e8 62 08 00 00       	call   361f <sleep>
    2dbd:	83 c4 10             	add    $0x10,%esp
    2dc0:	eb ee                	jmp    2db0 <sbrktest+0x2a8>
    sbrk(-(sbrk(0) - oldbrk));
    2dc2:	83 ec 0c             	sub    $0xc,%esp
    2dc5:	6a 00                	push   $0x0
    2dc7:	e8 4b 08 00 00       	call   3617 <sbrk>
    2dcc:	89 c2                	mov    %eax,%edx
    2dce:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    2dd1:	29 d0                	sub    %edx,%eax
    2dd3:	89 04 24             	mov    %eax,(%esp)
    2dd6:	e8 3c 08 00 00       	call   3617 <sbrk>
    2ddb:	83 c4 10             	add    $0x10,%esp
    2dde:	eb 80                	jmp    2d60 <sbrktest+0x258>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    2de0:	83 ec 0c             	sub    $0xc,%esp
    2de3:	50                   	push   %eax
    2de4:	53                   	push   %ebx
    2de5:	56                   	push   %esi
    2de6:	68 8b 47 00 00       	push   $0x478b
    2deb:	ff 35 b0 51 00 00    	push   0x51b0
    2df1:	e8 ce 08 00 00       	call   36c4 <printf>
      exit();
    2df6:	83 c4 20             	add    $0x20,%esp
    2df9:	e8 91 07 00 00       	call   358f <exit>
      printf(stdout, "fork failed\n");
    2dfe:	83 ec 08             	sub    $0x8,%esp
    2e01:	68 d1 48 00 00       	push   $0x48d1
    2e06:	ff 35 b0 51 00 00    	push   0x51b0
    2e0c:	e8 b3 08 00 00       	call   36c4 <printf>
      exit();
    2e11:	e8 79 07 00 00       	call   358f <exit>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    2e16:	0f be 03             	movsbl (%ebx),%eax
    2e19:	50                   	push   %eax
    2e1a:	53                   	push   %ebx
    2e1b:	68 f4 47 00 00       	push   $0x47f4
    2e20:	ff 35 b0 51 00 00    	push   0x51b0
    2e26:	e8 99 08 00 00       	call   36c4 <printf>
      kill(ppid);
    2e2b:	89 34 24             	mov    %esi,(%esp)
    2e2e:	e8 8c 07 00 00       	call   35bf <kill>
      exit();
    2e33:	e8 57 07 00 00       	call   358f <exit>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    2e38:	50                   	push   %eax
    2e39:	53                   	push   %ebx
    2e3a:	68 dc 4f 00 00       	push   $0x4fdc
    2e3f:	ff 35 b0 51 00 00    	push   0x51b0
    2e45:	e8 7a 08 00 00       	call   36c4 <printf>
    exit();
    2e4a:	e8 40 07 00 00       	call   358f <exit>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    2e4f:	57                   	push   %edi
    2e50:	57                   	push   %edi
    2e51:	68 0c 4f 00 00       	push   $0x4f0c
    2e56:	ff 35 b0 51 00 00    	push   0x51b0
    2e5c:	e8 63 08 00 00       	call   36c4 <printf>
    exit();
    2e61:	e8 29 07 00 00       	call   358f <exit>
    printf(stdout, "sbrk test fork failed\n");
    2e66:	50                   	push   %eax
    2e67:	50                   	push   %eax
    2e68:	68 a6 47 00 00       	push   $0x47a6
    2e6d:	ff 35 b0 51 00 00    	push   0x51b0
    2e73:	e8 4c 08 00 00       	call   36c4 <printf>
    exit();
    2e78:	e8 12 07 00 00       	call   358f <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    2e7d:	53                   	push   %ebx
    2e7e:	53                   	push   %ebx
    2e7f:	68 ac 4f 00 00       	push   $0x4fac
    2e84:	ff 35 b0 51 00 00    	push   0x51b0
    2e8a:	e8 35 08 00 00       	call   36c4 <printf>
    exit();
    2e8f:	e8 fb 06 00 00       	call   358f <exit>
    printf(stdout, "failed sbrk leaked memory\n");
    2e94:	50                   	push   %eax
    2e95:	50                   	push   %eax
    2e96:	68 0d 48 00 00       	push   $0x480d
    2e9b:	ff 35 b0 51 00 00    	push   0x51b0
    2ea1:	e8 1e 08 00 00       	call   36c4 <printf>
    exit();
    2ea6:	e8 e4 06 00 00       	call   358f <exit>
    printf(1, "pipe() failed\n");
    2eab:	51                   	push   %ecx
    2eac:	51                   	push   %ecx
    2ead:	68 c9 3c 00 00       	push   $0x3cc9
    2eb2:	6a 01                	push   $0x1
    2eb4:	e8 0b 08 00 00       	call   36c4 <printf>
    exit();
    2eb9:	e8 d1 06 00 00       	call   358f <exit>
    exit();
    2ebe:	e8 cc 06 00 00       	call   358f <exit>
    printf(stdout, "sbrk test failed post-fork\n");
    2ec3:	50                   	push   %eax
    2ec4:	50                   	push   %eax
    2ec5:	68 bd 47 00 00       	push   $0x47bd
    2eca:	ff 35 b0 51 00 00    	push   0x51b0
    2ed0:	e8 ef 07 00 00       	call   36c4 <printf>
    exit();
    2ed5:	e8 b5 06 00 00       	call   358f <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    2eda:	56                   	push   %esi
    2edb:	53                   	push   %ebx
    2edc:	68 84 4f 00 00       	push   $0x4f84
    2ee1:	ff 35 b0 51 00 00    	push   0x51b0
    2ee7:	e8 d8 07 00 00       	call   36c4 <printf>
    exit();
    2eec:	e8 9e 06 00 00       	call   358f <exit>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    2ef1:	50                   	push   %eax
    2ef2:	53                   	push   %ebx
    2ef3:	68 4c 4f 00 00       	push   $0x4f4c
    2ef8:	ff 35 b0 51 00 00    	push   0x51b0
    2efe:	e8 c1 07 00 00       	call   36c4 <printf>
    exit();
    2f03:	e8 87 06 00 00       	call   358f <exit>
    printf(stdout, "sbrk could not deallocate\n");
    2f08:	56                   	push   %esi
    2f09:	56                   	push   %esi
    2f0a:	68 d9 47 00 00       	push   $0x47d9
    2f0f:	ff 35 b0 51 00 00    	push   0x51b0
    2f15:	e8 aa 07 00 00       	call   36c4 <printf>
    exit();
    2f1a:	e8 70 06 00 00       	call   358f <exit>
    2f1f:	90                   	nop

00002f20 <validateint>:
}
    2f20:	c3                   	ret
    2f21:	8d 76 00             	lea    0x0(%esi),%esi

00002f24 <validatetest>:
{
    2f24:	55                   	push   %ebp
    2f25:	89 e5                	mov    %esp,%ebp
    2f27:	56                   	push   %esi
    2f28:	53                   	push   %ebx
  printf(stdout, "validate test\n");
    2f29:	83 ec 08             	sub    $0x8,%esp
    2f2c:	68 36 48 00 00       	push   $0x4836
    2f31:	ff 35 b0 51 00 00    	push   0x51b0
    2f37:	e8 88 07 00 00       	call   36c4 <printf>
    2f3c:	83 c4 10             	add    $0x10,%esp
  for(p = 0; p <= (uint)hi; p += 4096){
    2f3f:	31 f6                	xor    %esi,%esi
    2f41:	8d 76 00             	lea    0x0(%esi),%esi
    if((pid = fork()) == 0){
    2f44:	e8 3e 06 00 00       	call   3587 <fork>
    2f49:	89 c3                	mov    %eax,%ebx
    2f4b:	85 c0                	test   %eax,%eax
    2f4d:	74 61                	je     2fb0 <validatetest+0x8c>
    sleep(0);
    2f4f:	83 ec 0c             	sub    $0xc,%esp
    2f52:	6a 00                	push   $0x0
    2f54:	e8 c6 06 00 00       	call   361f <sleep>
    sleep(0);
    2f59:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f60:	e8 ba 06 00 00       	call   361f <sleep>
    kill(pid);
    2f65:	89 1c 24             	mov    %ebx,(%esp)
    2f68:	e8 52 06 00 00       	call   35bf <kill>
    wait();
    2f6d:	e8 25 06 00 00       	call   3597 <wait>
    if(link("nosuchfile", (char*)p) != -1){
    2f72:	58                   	pop    %eax
    2f73:	5a                   	pop    %edx
    2f74:	56                   	push   %esi
    2f75:	68 45 48 00 00       	push   $0x4845
    2f7a:	e8 70 06 00 00       	call   35ef <link>
    2f7f:	83 c4 10             	add    $0x10,%esp
    2f82:	40                   	inc    %eax
    2f83:	75 30                	jne    2fb5 <validatetest+0x91>
  for(p = 0; p <= (uint)hi; p += 4096){
    2f85:	81 c6 00 10 00 00    	add    $0x1000,%esi
    2f8b:	81 fe 00 40 11 00    	cmp    $0x114000,%esi
    2f91:	75 b1                	jne    2f44 <validatetest+0x20>
  printf(stdout, "validate ok\n");
    2f93:	83 ec 08             	sub    $0x8,%esp
    2f96:	68 69 48 00 00       	push   $0x4869
    2f9b:	ff 35 b0 51 00 00    	push   0x51b0
    2fa1:	e8 1e 07 00 00       	call   36c4 <printf>
}
    2fa6:	83 c4 10             	add    $0x10,%esp
    2fa9:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2fac:	5b                   	pop    %ebx
    2fad:	5e                   	pop    %esi
    2fae:	5d                   	pop    %ebp
    2faf:	c3                   	ret
      exit();
    2fb0:	e8 da 05 00 00       	call   358f <exit>
      printf(stdout, "link should not succeed\n");
    2fb5:	83 ec 08             	sub    $0x8,%esp
    2fb8:	68 50 48 00 00       	push   $0x4850
    2fbd:	ff 35 b0 51 00 00    	push   0x51b0
    2fc3:	e8 fc 06 00 00       	call   36c4 <printf>
      exit();
    2fc8:	e8 c2 05 00 00       	call   358f <exit>
    2fcd:	8d 76 00             	lea    0x0(%esi),%esi

00002fd0 <bsstest>:
{
    2fd0:	55                   	push   %ebp
    2fd1:	89 e5                	mov    %esp,%ebp
    2fd3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "bss test\n");
    2fd6:	68 76 48 00 00       	push   $0x4876
    2fdb:	ff 35 b0 51 00 00    	push   0x51b0
    2fe1:	e8 de 06 00 00       	call   36c4 <printf>
    2fe6:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    2fe9:	31 c0                	xor    %eax,%eax
    2feb:	90                   	nop
    if(uninit[i] != '\0'){
    2fec:	80 b8 e0 51 00 00 00 	cmpb   $0x0,0x51e0(%eax)
    2ff3:	75 20                	jne    3015 <bsstest+0x45>
  for(i = 0; i < sizeof(uninit); i++){
    2ff5:	40                   	inc    %eax
    2ff6:	3d 10 27 00 00       	cmp    $0x2710,%eax
    2ffb:	75 ef                	jne    2fec <bsstest+0x1c>
  printf(stdout, "bss test ok\n");
    2ffd:	83 ec 08             	sub    $0x8,%esp
    3000:	68 91 48 00 00       	push   $0x4891
    3005:	ff 35 b0 51 00 00    	push   0x51b0
    300b:	e8 b4 06 00 00       	call   36c4 <printf>
}
    3010:	83 c4 10             	add    $0x10,%esp
    3013:	c9                   	leave
    3014:	c3                   	ret
      printf(stdout, "bss test failed\n");
    3015:	83 ec 08             	sub    $0x8,%esp
    3018:	68 80 48 00 00       	push   $0x4880
    301d:	ff 35 b0 51 00 00    	push   0x51b0
    3023:	e8 9c 06 00 00       	call   36c4 <printf>
      exit();
    3028:	e8 62 05 00 00       	call   358f <exit>
    302d:	8d 76 00             	lea    0x0(%esi),%esi

00003030 <bigargtest>:
{
    3030:	55                   	push   %ebp
    3031:	89 e5                	mov    %esp,%ebp
    3033:	83 ec 14             	sub    $0x14,%esp
  unlink("bigarg-ok");
    3036:	68 9e 48 00 00       	push   $0x489e
    303b:	e8 9f 05 00 00       	call   35df <unlink>
  pid = fork();
    3040:	e8 42 05 00 00       	call   3587 <fork>
  if(pid == 0){
    3045:	83 c4 10             	add    $0x10,%esp
    3048:	85 c0                	test   %eax,%eax
    304a:	74 3f                	je     308b <bigargtest+0x5b>
  } else if(pid < 0){
    304c:	0f 88 d9 00 00 00    	js     312b <bigargtest+0xfb>
  wait();
    3052:	e8 40 05 00 00       	call   3597 <wait>
  fd = open("bigarg-ok", 0);
    3057:	83 ec 08             	sub    $0x8,%esp
    305a:	6a 00                	push   $0x0
    305c:	68 9e 48 00 00       	push   $0x489e
    3061:	e8 69 05 00 00       	call   35cf <open>
  if(fd < 0){
    3066:	83 c4 10             	add    $0x10,%esp
    3069:	85 c0                	test   %eax,%eax
    306b:	0f 88 a3 00 00 00    	js     3114 <bigargtest+0xe4>
  close(fd);
    3071:	83 ec 0c             	sub    $0xc,%esp
    3074:	50                   	push   %eax
    3075:	e8 3d 05 00 00       	call   35b7 <close>
  unlink("bigarg-ok");
    307a:	c7 04 24 9e 48 00 00 	movl   $0x489e,(%esp)
    3081:	e8 59 05 00 00       	call   35df <unlink>
}
    3086:	83 c4 10             	add    $0x10,%esp
    3089:	c9                   	leave
    308a:	c3                   	ret
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    308b:	c7 04 85 00 99 00 00 	movl   $0x5000,0x9900(,%eax,4)
    3092:	00 50 00 00 
    for(i = 0; i < MAXARG-1; i++)
    3096:	b8 01 00 00 00       	mov    $0x1,%eax
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    309b:	c7 04 85 00 99 00 00 	movl   $0x5000,0x9900(,%eax,4)
    30a2:	00 50 00 00 
    30a6:	c7 04 85 04 99 00 00 	movl   $0x5000,0x9904(,%eax,4)
    30ad:	00 50 00 00 
    for(i = 0; i < MAXARG-1; i++)
    30b1:	83 c0 02             	add    $0x2,%eax
    30b4:	83 f8 1f             	cmp    $0x1f,%eax
    30b7:	75 e2                	jne    309b <bigargtest+0x6b>
    args[MAXARG-1] = 0;
    30b9:	31 c9                	xor    %ecx,%ecx
    30bb:	89 0d 7c 99 00 00    	mov    %ecx,0x997c
    printf(stdout, "bigarg test\n");
    30c1:	50                   	push   %eax
    30c2:	50                   	push   %eax
    30c3:	68 a8 48 00 00       	push   $0x48a8
    30c8:	ff 35 b0 51 00 00    	push   0x51b0
    30ce:	e8 f1 05 00 00       	call   36c4 <printf>
    exec("echo", args);
    30d3:	58                   	pop    %eax
    30d4:	5a                   	pop    %edx
    30d5:	68 00 99 00 00       	push   $0x9900
    30da:	68 75 3a 00 00       	push   $0x3a75
    30df:	e8 e3 04 00 00       	call   35c7 <exec>
    printf(stdout, "bigarg test ok\n");
    30e4:	59                   	pop    %ecx
    30e5:	58                   	pop    %eax
    30e6:	68 b5 48 00 00       	push   $0x48b5
    30eb:	ff 35 b0 51 00 00    	push   0x51b0
    30f1:	e8 ce 05 00 00       	call   36c4 <printf>
    fd = open("bigarg-ok", O_CREATE);
    30f6:	58                   	pop    %eax
    30f7:	5a                   	pop    %edx
    30f8:	68 00 02 00 00       	push   $0x200
    30fd:	68 9e 48 00 00       	push   $0x489e
    3102:	e8 c8 04 00 00       	call   35cf <open>
    close(fd);
    3107:	89 04 24             	mov    %eax,(%esp)
    310a:	e8 a8 04 00 00       	call   35b7 <close>
    exit();
    310f:	e8 7b 04 00 00       	call   358f <exit>
    printf(stdout, "bigarg test failed!\n");
    3114:	50                   	push   %eax
    3115:	50                   	push   %eax
    3116:	68 de 48 00 00       	push   $0x48de
    311b:	ff 35 b0 51 00 00    	push   0x51b0
    3121:	e8 9e 05 00 00       	call   36c4 <printf>
    exit();
    3126:	e8 64 04 00 00       	call   358f <exit>
    printf(stdout, "bigargtest: fork failed\n");
    312b:	52                   	push   %edx
    312c:	52                   	push   %edx
    312d:	68 c5 48 00 00       	push   $0x48c5
    3132:	ff 35 b0 51 00 00    	push   0x51b0
    3138:	e8 87 05 00 00       	call   36c4 <printf>
    exit();
    313d:	e8 4d 04 00 00       	call   358f <exit>
    3142:	66 90                	xchg   %ax,%ax

00003144 <fsfull>:
{
    3144:	55                   	push   %ebp
    3145:	89 e5                	mov    %esp,%ebp
    3147:	57                   	push   %edi
    3148:	56                   	push   %esi
    3149:	53                   	push   %ebx
    314a:	83 ec 54             	sub    $0x54,%esp
  printf(1, "fsfull test\n");
    314d:	68 f3 48 00 00       	push   $0x48f3
    3152:	6a 01                	push   $0x1
    3154:	e8 6b 05 00 00       	call   36c4 <printf>
    3159:	83 c4 10             	add    $0x10,%esp
  for(nfiles = 0; ; nfiles++){
    315c:	31 f6                	xor    %esi,%esi
    315e:	66 90                	xchg   %ax,%ax
    name[0] = 'f';
    3160:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    3164:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3169:	f7 e6                	mul    %esi
    316b:	c1 ea 06             	shr    $0x6,%edx
    316e:	83 c2 30             	add    $0x30,%edx
    3171:	88 55 a9             	mov    %dl,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3174:	89 f0                	mov    %esi,%eax
    3176:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
    317b:	99                   	cltd
    317c:	f7 f9                	idiv   %ecx
    317e:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3183:	f7 e2                	mul    %edx
    3185:	c1 ea 05             	shr    $0x5,%edx
    3188:	83 c2 30             	add    $0x30,%edx
    318b:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    318e:	b9 64 00 00 00       	mov    $0x64,%ecx
    3193:	89 f0                	mov    %esi,%eax
    3195:	99                   	cltd
    3196:	f7 f9                	idiv   %ecx
    3198:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
    319d:	f7 e2                	mul    %edx
    319f:	c1 ea 03             	shr    $0x3,%edx
    31a2:	83 c2 30             	add    $0x30,%edx
    31a5:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    31a8:	b9 0a 00 00 00       	mov    $0xa,%ecx
    31ad:	89 f0                	mov    %esi,%eax
    31af:	99                   	cltd
    31b0:	f7 f9                	idiv   %ecx
    31b2:	83 c2 30             	add    $0x30,%edx
    31b5:	88 55 ac             	mov    %dl,-0x54(%ebp)
    name[5] = '\0';
    31b8:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    printf(1, "writing %s\n", name);
    31bc:	53                   	push   %ebx
    31bd:	8d 45 a8             	lea    -0x58(%ebp),%eax
    31c0:	50                   	push   %eax
    31c1:	68 00 49 00 00       	push   $0x4900
    31c6:	6a 01                	push   $0x1
    31c8:	e8 f7 04 00 00       	call   36c4 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    31cd:	5f                   	pop    %edi
    31ce:	58                   	pop    %eax
    31cf:	68 02 02 00 00       	push   $0x202
    31d4:	8d 45 a8             	lea    -0x58(%ebp),%eax
    31d7:	50                   	push   %eax
    31d8:	e8 f2 03 00 00       	call   35cf <open>
    31dd:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    31df:	83 c4 10             	add    $0x10,%esp
    31e2:	85 c0                	test   %eax,%eax
    31e4:	78 46                	js     322c <fsfull+0xe8>
    int total = 0;
    31e6:	31 db                	xor    %ebx,%ebx
    31e8:	eb 04                	jmp    31ee <fsfull+0xaa>
    31ea:	66 90                	xchg   %ax,%ax
      total += cc;
    31ec:	01 c3                	add    %eax,%ebx
      int cc = write(fd, buf, 512);
    31ee:	52                   	push   %edx
    31ef:	68 00 02 00 00       	push   $0x200
    31f4:	68 00 79 00 00       	push   $0x7900
    31f9:	57                   	push   %edi
    31fa:	e8 b0 03 00 00       	call   35af <write>
      if(cc < 512)
    31ff:	83 c4 10             	add    $0x10,%esp
    3202:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    3207:	7f e3                	jg     31ec <fsfull+0xa8>
    printf(1, "wrote %d bytes\n", total);
    3209:	50                   	push   %eax
    320a:	53                   	push   %ebx
    320b:	68 1c 49 00 00       	push   $0x491c
    3210:	6a 01                	push   $0x1
    3212:	e8 ad 04 00 00       	call   36c4 <printf>
    close(fd);
    3217:	89 3c 24             	mov    %edi,(%esp)
    321a:	e8 98 03 00 00       	call   35b7 <close>
    if(total == 0)
    321f:	83 c4 10             	add    $0x10,%esp
    3222:	85 db                	test   %ebx,%ebx
    3224:	74 1a                	je     3240 <fsfull+0xfc>
  for(nfiles = 0; ; nfiles++){
    3226:	46                   	inc    %esi
    3227:	e9 34 ff ff ff       	jmp    3160 <fsfull+0x1c>
      printf(1, "open %s failed\n", name);
    322c:	51                   	push   %ecx
    322d:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3230:	50                   	push   %eax
    3231:	68 0c 49 00 00       	push   $0x490c
    3236:	6a 01                	push   $0x1
    3238:	e8 87 04 00 00       	call   36c4 <printf>
      break;
    323d:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + nfiles / 1000;
    3240:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    name[2] = '0' + (nfiles % 1000) / 100;
    3245:	bb e8 03 00 00       	mov    $0x3e8,%ebx
    324a:	66 90                	xchg   %ax,%ax
    name[0] = 'f';
    324c:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    3250:	89 f0                	mov    %esi,%eax
    3252:	f7 e7                	mul    %edi
    3254:	c1 ea 06             	shr    $0x6,%edx
    3257:	83 c2 30             	add    $0x30,%edx
    325a:	88 55 a9             	mov    %dl,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    325d:	89 f0                	mov    %esi,%eax
    325f:	99                   	cltd
    3260:	f7 fb                	idiv   %ebx
    3262:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3267:	f7 e2                	mul    %edx
    3269:	c1 ea 05             	shr    $0x5,%edx
    326c:	83 c2 30             	add    $0x30,%edx
    326f:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3272:	b9 64 00 00 00       	mov    $0x64,%ecx
    3277:	89 f0                	mov    %esi,%eax
    3279:	99                   	cltd
    327a:	f7 f9                	idiv   %ecx
    327c:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
    3281:	f7 e2                	mul    %edx
    3283:	c1 ea 03             	shr    $0x3,%edx
    3286:	83 c2 30             	add    $0x30,%edx
    3289:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    328c:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3291:	89 f0                	mov    %esi,%eax
    3293:	99                   	cltd
    3294:	f7 f9                	idiv   %ecx
    3296:	83 c2 30             	add    $0x30,%edx
    3299:	88 55 ac             	mov    %dl,-0x54(%ebp)
    name[5] = '\0';
    329c:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    unlink(name);
    32a0:	83 ec 0c             	sub    $0xc,%esp
    32a3:	8d 45 a8             	lea    -0x58(%ebp),%eax
    32a6:	50                   	push   %eax
    32a7:	e8 33 03 00 00       	call   35df <unlink>
    nfiles--;
    32ac:	4e                   	dec    %esi
  while(nfiles >= 0){
    32ad:	83 c4 10             	add    $0x10,%esp
    32b0:	83 fe ff             	cmp    $0xffffffff,%esi
    32b3:	75 97                	jne    324c <fsfull+0x108>
  printf(1, "fsfull test finished\n");
    32b5:	83 ec 08             	sub    $0x8,%esp
    32b8:	68 2c 49 00 00       	push   $0x492c
    32bd:	6a 01                	push   $0x1
    32bf:	e8 00 04 00 00       	call   36c4 <printf>
}
    32c4:	83 c4 10             	add    $0x10,%esp
    32c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    32ca:	5b                   	pop    %ebx
    32cb:	5e                   	pop    %esi
    32cc:	5f                   	pop    %edi
    32cd:	5d                   	pop    %ebp
    32ce:	c3                   	ret
    32cf:	90                   	nop

000032d0 <uio>:
{
    32d0:	55                   	push   %ebp
    32d1:	89 e5                	mov    %esp,%ebp
    32d3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "uio test\n");
    32d6:	68 42 49 00 00       	push   $0x4942
    32db:	6a 01                	push   $0x1
    32dd:	e8 e2 03 00 00       	call   36c4 <printf>
  pid = fork();
    32e2:	e8 a0 02 00 00       	call   3587 <fork>
  if(pid == 0){
    32e7:	83 c4 10             	add    $0x10,%esp
    32ea:	85 c0                	test   %eax,%eax
    32ec:	74 1b                	je     3309 <uio+0x39>
  } else if(pid < 0){
    32ee:	78 3a                	js     332a <uio+0x5a>
  wait();
    32f0:	e8 a2 02 00 00       	call   3597 <wait>
  printf(1, "uio test done\n");
    32f5:	83 ec 08             	sub    $0x8,%esp
    32f8:	68 4c 49 00 00       	push   $0x494c
    32fd:	6a 01                	push   $0x1
    32ff:	e8 c0 03 00 00       	call   36c4 <printf>
}
    3304:	83 c4 10             	add    $0x10,%esp
    3307:	c9                   	leave
    3308:	c3                   	ret
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    3309:	b0 09                	mov    $0x9,%al
    330b:	ba 70 00 00 00       	mov    $0x70,%edx
    3310:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    3311:	ba 71 00 00 00       	mov    $0x71,%edx
    3316:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    3317:	52                   	push   %edx
    3318:	52                   	push   %edx
    3319:	68 e0 50 00 00       	push   $0x50e0
    331e:	6a 01                	push   $0x1
    3320:	e8 9f 03 00 00       	call   36c4 <printf>
    exit();
    3325:	e8 65 02 00 00       	call   358f <exit>
    printf (1, "fork failed\n");
    332a:	50                   	push   %eax
    332b:	50                   	push   %eax
    332c:	68 d1 48 00 00       	push   $0x48d1
    3331:	6a 01                	push   $0x1
    3333:	e8 8c 03 00 00       	call   36c4 <printf>
    exit();
    3338:	e8 52 02 00 00       	call   358f <exit>
    333d:	8d 76 00             	lea    0x0(%esi),%esi

00003340 <argptest>:
{
    3340:	55                   	push   %ebp
    3341:	89 e5                	mov    %esp,%ebp
    3343:	53                   	push   %ebx
    3344:	83 ec 0c             	sub    $0xc,%esp
  fd = open("init", O_RDONLY);
    3347:	6a 00                	push   $0x0
    3349:	68 5b 49 00 00       	push   $0x495b
    334e:	e8 7c 02 00 00       	call   35cf <open>
  if (fd < 0) {
    3353:	83 c4 10             	add    $0x10,%esp
    3356:	85 c0                	test   %eax,%eax
    3358:	78 37                	js     3391 <argptest+0x51>
    335a:	89 c3                	mov    %eax,%ebx
  read(fd, sbrk(0) - 1, -1);
    335c:	83 ec 0c             	sub    $0xc,%esp
    335f:	6a 00                	push   $0x0
    3361:	e8 b1 02 00 00       	call   3617 <sbrk>
    3366:	83 c4 0c             	add    $0xc,%esp
    3369:	6a ff                	push   $0xffffffff
    336b:	48                   	dec    %eax
    336c:	50                   	push   %eax
    336d:	53                   	push   %ebx
    336e:	e8 34 02 00 00       	call   35a7 <read>
  close(fd);
    3373:	89 1c 24             	mov    %ebx,(%esp)
    3376:	e8 3c 02 00 00       	call   35b7 <close>
  printf(1, "arg test passed\n");
    337b:	58                   	pop    %eax
    337c:	5a                   	pop    %edx
    337d:	68 6d 49 00 00       	push   $0x496d
    3382:	6a 01                	push   $0x1
    3384:	e8 3b 03 00 00       	call   36c4 <printf>
}
    3389:	83 c4 10             	add    $0x10,%esp
    338c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    338f:	c9                   	leave
    3390:	c3                   	ret
    printf(2, "open failed\n");
    3391:	51                   	push   %ecx
    3392:	51                   	push   %ecx
    3393:	68 60 49 00 00       	push   $0x4960
    3398:	6a 02                	push   $0x2
    339a:	e8 25 03 00 00       	call   36c4 <printf>
    exit();
    339f:	e8 eb 01 00 00       	call   358f <exit>

000033a4 <rand>:
  randstate = randstate * 1664525 + 1013904223;
    33a4:	a1 ac 51 00 00       	mov    0x51ac,%eax
    33a9:	8d 14 00             	lea    (%eax,%eax,1),%edx
    33ac:	01 c2                	add    %eax,%edx
    33ae:	8d 14 90             	lea    (%eax,%edx,4),%edx
    33b1:	c1 e2 08             	shl    $0x8,%edx
    33b4:	01 c2                	add    %eax,%edx
    33b6:	8d 14 92             	lea    (%edx,%edx,4),%edx
    33b9:	8d 04 90             	lea    (%eax,%edx,4),%eax
    33bc:	8d 04 80             	lea    (%eax,%eax,4),%eax
    33bf:	8d 84 80 5f f3 6e 3c 	lea    0x3c6ef35f(%eax,%eax,4),%eax
    33c6:	a3 ac 51 00 00       	mov    %eax,0x51ac
}
    33cb:	c3                   	ret

000033cc <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    33cc:	55                   	push   %ebp
    33cd:	89 e5                	mov    %esp,%ebp
    33cf:	53                   	push   %ebx
    33d0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    33d3:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    33d6:	31 c0                	xor    %eax,%eax
    33d8:	8a 14 03             	mov    (%ebx,%eax,1),%dl
    33db:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    33de:	40                   	inc    %eax
    33df:	84 d2                	test   %dl,%dl
    33e1:	75 f5                	jne    33d8 <strcpy+0xc>
    ;
  return os;
}
    33e3:	89 c8                	mov    %ecx,%eax
    33e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    33e8:	c9                   	leave
    33e9:	c3                   	ret
    33ea:	66 90                	xchg   %ax,%ax

000033ec <strcmp>:

int
strcmp(const char *p, const char *q)
{
    33ec:	55                   	push   %ebp
    33ed:	89 e5                	mov    %esp,%ebp
    33ef:	53                   	push   %ebx
    33f0:	8b 55 08             	mov    0x8(%ebp),%edx
    33f3:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(*p && *p == *q)
    33f6:	0f b6 02             	movzbl (%edx),%eax
    33f9:	84 c0                	test   %al,%al
    33fb:	75 10                	jne    340d <strcmp+0x21>
    33fd:	eb 2a                	jmp    3429 <strcmp+0x3d>
    33ff:	90                   	nop
    p++, q++;
    3400:	42                   	inc    %edx
    3401:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(*p && *p == *q)
    3404:	0f b6 02             	movzbl (%edx),%eax
    3407:	84 c0                	test   %al,%al
    3409:	74 11                	je     341c <strcmp+0x30>
    340b:	89 cb                	mov    %ecx,%ebx
    340d:	0f b6 0b             	movzbl (%ebx),%ecx
    3410:	38 c1                	cmp    %al,%cl
    3412:	74 ec                	je     3400 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
    3414:	29 c8                	sub    %ecx,%eax
}
    3416:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3419:	c9                   	leave
    341a:	c3                   	ret
    341b:	90                   	nop
  return (uchar)*p - (uchar)*q;
    341c:	0f b6 4b 01          	movzbl 0x1(%ebx),%ecx
    3420:	31 c0                	xor    %eax,%eax
    3422:	29 c8                	sub    %ecx,%eax
}
    3424:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3427:	c9                   	leave
    3428:	c3                   	ret
  return (uchar)*p - (uchar)*q;
    3429:	0f b6 0b             	movzbl (%ebx),%ecx
    342c:	31 c0                	xor    %eax,%eax
    342e:	eb e4                	jmp    3414 <strcmp+0x28>

00003430 <strlen>:

uint
strlen(const char *s)
{
    3430:	55                   	push   %ebp
    3431:	89 e5                	mov    %esp,%ebp
    3433:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    3436:	80 3a 00             	cmpb   $0x0,(%edx)
    3439:	74 15                	je     3450 <strlen+0x20>
    343b:	31 c0                	xor    %eax,%eax
    343d:	8d 76 00             	lea    0x0(%esi),%esi
    3440:	40                   	inc    %eax
    3441:	89 c1                	mov    %eax,%ecx
    3443:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3447:	75 f7                	jne    3440 <strlen+0x10>
    ;
  return n;
}
    3449:	89 c8                	mov    %ecx,%eax
    344b:	5d                   	pop    %ebp
    344c:	c3                   	ret
    344d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    3450:	31 c9                	xor    %ecx,%ecx
}
    3452:	89 c8                	mov    %ecx,%eax
    3454:	5d                   	pop    %ebp
    3455:	c3                   	ret
    3456:	66 90                	xchg   %ax,%ax

00003458 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3458:	55                   	push   %ebp
    3459:	89 e5                	mov    %esp,%ebp
    345b:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    345c:	8b 7d 08             	mov    0x8(%ebp),%edi
    345f:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3462:	8b 45 0c             	mov    0xc(%ebp),%eax
    3465:	fc                   	cld
    3466:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3468:	8b 45 08             	mov    0x8(%ebp),%eax
    346b:	8b 7d fc             	mov    -0x4(%ebp),%edi
    346e:	c9                   	leave
    346f:	c3                   	ret

00003470 <strchr>:

char*
strchr(const char *s, char c)
{
    3470:	55                   	push   %ebp
    3471:	89 e5                	mov    %esp,%ebp
    3473:	8b 45 08             	mov    0x8(%ebp),%eax
    3476:	8a 4d 0c             	mov    0xc(%ebp),%cl
  for(; *s; s++)
    3479:	8a 10                	mov    (%eax),%dl
    347b:	84 d2                	test   %dl,%dl
    347d:	75 0c                	jne    348b <strchr+0x1b>
    347f:	eb 13                	jmp    3494 <strchr+0x24>
    3481:	8d 76 00             	lea    0x0(%esi),%esi
    3484:	40                   	inc    %eax
    3485:	8a 10                	mov    (%eax),%dl
    3487:	84 d2                	test   %dl,%dl
    3489:	74 09                	je     3494 <strchr+0x24>
    if(*s == c)
    348b:	38 d1                	cmp    %dl,%cl
    348d:	75 f5                	jne    3484 <strchr+0x14>
      return (char*)s;
  return 0;
}
    348f:	5d                   	pop    %ebp
    3490:	c3                   	ret
    3491:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
    3494:	31 c0                	xor    %eax,%eax
}
    3496:	5d                   	pop    %ebp
    3497:	c3                   	ret

00003498 <gets>:

char*
gets(char *buf, int max)
{
    3498:	55                   	push   %ebp
    3499:	89 e5                	mov    %esp,%ebp
    349b:	57                   	push   %edi
    349c:	56                   	push   %esi
    349d:	53                   	push   %ebx
    349e:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    34a1:	31 db                	xor    %ebx,%ebx
    cc = read(0, &c, 1);
    34a3:	8d 75 e7             	lea    -0x19(%ebp),%esi
  for(i=0; i+1 < max; ){
    34a6:	eb 24                	jmp    34cc <gets+0x34>
    cc = read(0, &c, 1);
    34a8:	50                   	push   %eax
    34a9:	6a 01                	push   $0x1
    34ab:	56                   	push   %esi
    34ac:	6a 00                	push   $0x0
    34ae:	e8 f4 00 00 00       	call   35a7 <read>
    if(cc < 1)
    34b3:	83 c4 10             	add    $0x10,%esp
    34b6:	85 c0                	test   %eax,%eax
    34b8:	7e 1a                	jle    34d4 <gets+0x3c>
      break;
    buf[i++] = c;
    34ba:	8a 45 e7             	mov    -0x19(%ebp),%al
    34bd:	8b 55 08             	mov    0x8(%ebp),%edx
    34c0:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    34c4:	3c 0a                	cmp    $0xa,%al
    34c6:	74 0e                	je     34d6 <gets+0x3e>
    34c8:	3c 0d                	cmp    $0xd,%al
    34ca:	74 0a                	je     34d6 <gets+0x3e>
  for(i=0; i+1 < max; ){
    34cc:	89 df                	mov    %ebx,%edi
    34ce:	43                   	inc    %ebx
    34cf:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    34d2:	7c d4                	jl     34a8 <gets+0x10>
    34d4:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
    34d6:	8b 45 08             	mov    0x8(%ebp),%eax
    34d9:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
    34dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    34e0:	5b                   	pop    %ebx
    34e1:	5e                   	pop    %esi
    34e2:	5f                   	pop    %edi
    34e3:	5d                   	pop    %ebp
    34e4:	c3                   	ret
    34e5:	8d 76 00             	lea    0x0(%esi),%esi

000034e8 <stat>:

int
stat(const char *n, struct stat *st)
{
    34e8:	55                   	push   %ebp
    34e9:	89 e5                	mov    %esp,%ebp
    34eb:	56                   	push   %esi
    34ec:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    34ed:	83 ec 08             	sub    $0x8,%esp
    34f0:	6a 00                	push   $0x0
    34f2:	ff 75 08             	push   0x8(%ebp)
    34f5:	e8 d5 00 00 00       	call   35cf <open>
  if(fd < 0)
    34fa:	83 c4 10             	add    $0x10,%esp
    34fd:	85 c0                	test   %eax,%eax
    34ff:	78 27                	js     3528 <stat+0x40>
    3501:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
    3503:	83 ec 08             	sub    $0x8,%esp
    3506:	ff 75 0c             	push   0xc(%ebp)
    3509:	50                   	push   %eax
    350a:	e8 d8 00 00 00       	call   35e7 <fstat>
    350f:	89 c6                	mov    %eax,%esi
  close(fd);
    3511:	89 1c 24             	mov    %ebx,(%esp)
    3514:	e8 9e 00 00 00       	call   35b7 <close>
  return r;
    3519:	83 c4 10             	add    $0x10,%esp
}
    351c:	89 f0                	mov    %esi,%eax
    351e:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3521:	5b                   	pop    %ebx
    3522:	5e                   	pop    %esi
    3523:	5d                   	pop    %ebp
    3524:	c3                   	ret
    3525:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3528:	be ff ff ff ff       	mov    $0xffffffff,%esi
    352d:	eb ed                	jmp    351c <stat+0x34>
    352f:	90                   	nop

00003530 <atoi>:

int
atoi(const char *s)
{
    3530:	55                   	push   %ebp
    3531:	89 e5                	mov    %esp,%ebp
    3533:	53                   	push   %ebx
    3534:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3537:	0f be 01             	movsbl (%ecx),%eax
    353a:	8d 50 d0             	lea    -0x30(%eax),%edx
    353d:	80 fa 09             	cmp    $0x9,%dl
  n = 0;
    3540:	ba 00 00 00 00       	mov    $0x0,%edx
  while('0' <= *s && *s <= '9')
    3545:	77 16                	ja     355d <atoi+0x2d>
    3547:	90                   	nop
    n = n*10 + *s++ - '0';
    3548:	41                   	inc    %ecx
    3549:	8d 14 92             	lea    (%edx,%edx,4),%edx
    354c:	01 d2                	add    %edx,%edx
    354e:	8d 54 02 d0          	lea    -0x30(%edx,%eax,1),%edx
  while('0' <= *s && *s <= '9')
    3552:	0f be 01             	movsbl (%ecx),%eax
    3555:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3558:	80 fb 09             	cmp    $0x9,%bl
    355b:	76 eb                	jbe    3548 <atoi+0x18>
  return n;
}
    355d:	89 d0                	mov    %edx,%eax
    355f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3562:	c9                   	leave
    3563:	c3                   	ret

00003564 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3564:	55                   	push   %ebp
    3565:	89 e5                	mov    %esp,%ebp
    3567:	57                   	push   %edi
    3568:	56                   	push   %esi
    3569:	8b 55 08             	mov    0x8(%ebp),%edx
    356c:	8b 75 0c             	mov    0xc(%ebp),%esi
    356f:	8b 45 10             	mov    0x10(%ebp),%eax
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3572:	85 c0                	test   %eax,%eax
    3574:	7e 0b                	jle    3581 <memmove+0x1d>
    3576:	01 d0                	add    %edx,%eax
  dst = vdst;
    3578:	89 d7                	mov    %edx,%edi
    357a:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
    357c:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    357d:	39 f8                	cmp    %edi,%eax
    357f:	75 fb                	jne    357c <memmove+0x18>
  return vdst;
}
    3581:	89 d0                	mov    %edx,%eax
    3583:	5e                   	pop    %esi
    3584:	5f                   	pop    %edi
    3585:	5d                   	pop    %ebp
    3586:	c3                   	ret

00003587 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3587:	b8 01 00 00 00       	mov    $0x1,%eax
    358c:	cd 40                	int    $0x40
    358e:	c3                   	ret

0000358f <exit>:
SYSCALL(exit)
    358f:	b8 02 00 00 00       	mov    $0x2,%eax
    3594:	cd 40                	int    $0x40
    3596:	c3                   	ret

00003597 <wait>:
SYSCALL(wait)
    3597:	b8 03 00 00 00       	mov    $0x3,%eax
    359c:	cd 40                	int    $0x40
    359e:	c3                   	ret

0000359f <pipe>:
SYSCALL(pipe)
    359f:	b8 04 00 00 00       	mov    $0x4,%eax
    35a4:	cd 40                	int    $0x40
    35a6:	c3                   	ret

000035a7 <read>:
SYSCALL(read)
    35a7:	b8 05 00 00 00       	mov    $0x5,%eax
    35ac:	cd 40                	int    $0x40
    35ae:	c3                   	ret

000035af <write>:
SYSCALL(write)
    35af:	b8 10 00 00 00       	mov    $0x10,%eax
    35b4:	cd 40                	int    $0x40
    35b6:	c3                   	ret

000035b7 <close>:
SYSCALL(close)
    35b7:	b8 15 00 00 00       	mov    $0x15,%eax
    35bc:	cd 40                	int    $0x40
    35be:	c3                   	ret

000035bf <kill>:
SYSCALL(kill)
    35bf:	b8 06 00 00 00       	mov    $0x6,%eax
    35c4:	cd 40                	int    $0x40
    35c6:	c3                   	ret

000035c7 <exec>:
SYSCALL(exec)
    35c7:	b8 07 00 00 00       	mov    $0x7,%eax
    35cc:	cd 40                	int    $0x40
    35ce:	c3                   	ret

000035cf <open>:
SYSCALL(open)
    35cf:	b8 0f 00 00 00       	mov    $0xf,%eax
    35d4:	cd 40                	int    $0x40
    35d6:	c3                   	ret

000035d7 <mknod>:
SYSCALL(mknod)
    35d7:	b8 11 00 00 00       	mov    $0x11,%eax
    35dc:	cd 40                	int    $0x40
    35de:	c3                   	ret

000035df <unlink>:
SYSCALL(unlink)
    35df:	b8 12 00 00 00       	mov    $0x12,%eax
    35e4:	cd 40                	int    $0x40
    35e6:	c3                   	ret

000035e7 <fstat>:
SYSCALL(fstat)
    35e7:	b8 08 00 00 00       	mov    $0x8,%eax
    35ec:	cd 40                	int    $0x40
    35ee:	c3                   	ret

000035ef <link>:
SYSCALL(link)
    35ef:	b8 13 00 00 00       	mov    $0x13,%eax
    35f4:	cd 40                	int    $0x40
    35f6:	c3                   	ret

000035f7 <mkdir>:
SYSCALL(mkdir)
    35f7:	b8 14 00 00 00       	mov    $0x14,%eax
    35fc:	cd 40                	int    $0x40
    35fe:	c3                   	ret

000035ff <chdir>:
SYSCALL(chdir)
    35ff:	b8 09 00 00 00       	mov    $0x9,%eax
    3604:	cd 40                	int    $0x40
    3606:	c3                   	ret

00003607 <dup>:
SYSCALL(dup)
    3607:	b8 0a 00 00 00       	mov    $0xa,%eax
    360c:	cd 40                	int    $0x40
    360e:	c3                   	ret

0000360f <getpid>:
SYSCALL(getpid)
    360f:	b8 0b 00 00 00       	mov    $0xb,%eax
    3614:	cd 40                	int    $0x40
    3616:	c3                   	ret

00003617 <sbrk>:
SYSCALL(sbrk)
    3617:	b8 0c 00 00 00       	mov    $0xc,%eax
    361c:	cd 40                	int    $0x40
    361e:	c3                   	ret

0000361f <sleep>:
SYSCALL(sleep)
    361f:	b8 0d 00 00 00       	mov    $0xd,%eax
    3624:	cd 40                	int    $0x40
    3626:	c3                   	ret

00003627 <uptime>:
SYSCALL(uptime)
    3627:	b8 0e 00 00 00       	mov    $0xe,%eax
    362c:	cd 40                	int    $0x40
    362e:	c3                   	ret

0000362f <countfp>:
SYSCALL(countfp)
    362f:	b8 16 00 00 00       	mov    $0x16,%eax
    3634:	cd 40                	int    $0x40
    3636:	c3                   	ret
    3637:	90                   	nop

00003638 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3638:	55                   	push   %ebp
    3639:	89 e5                	mov    %esp,%ebp
    363b:	57                   	push   %edi
    363c:	56                   	push   %esi
    363d:	53                   	push   %ebx
    363e:	83 ec 3c             	sub    $0x3c,%esp
    3641:	89 45 c0             	mov    %eax,-0x40(%ebp)
    3644:	89 cb                	mov    %ecx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3646:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3649:	85 c9                	test   %ecx,%ecx
    364b:	74 04                	je     3651 <printint+0x19>
    364d:	85 d2                	test   %edx,%edx
    364f:	78 6b                	js     36bc <printint+0x84>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3651:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  neg = 0;
    3654:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
  }

  i = 0;
    365b:	31 c9                	xor    %ecx,%ecx
    365d:	8d 75 d7             	lea    -0x29(%ebp),%esi
  do{
    buf[i++] = digits[x % base];
    3660:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    3663:	31 d2                	xor    %edx,%edx
    3665:	f7 f3                	div    %ebx
    3667:	89 cf                	mov    %ecx,%edi
    3669:	8d 49 01             	lea    0x1(%ecx),%ecx
    366c:	8a 92 98 51 00 00    	mov    0x5198(%edx),%dl
    3672:	88 54 3e 01          	mov    %dl,0x1(%esi,%edi,1)
  }while((x /= base) != 0);
    3676:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    3679:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    367c:	39 da                	cmp    %ebx,%edx
    367e:	73 e0                	jae    3660 <printint+0x28>
  if(neg)
    3680:	8b 55 08             	mov    0x8(%ebp),%edx
    3683:	85 d2                	test   %edx,%edx
    3685:	74 07                	je     368e <printint+0x56>
    buf[i++] = '-';
    3687:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)

  while(--i >= 0)
    368c:	89 cf                	mov    %ecx,%edi
    368e:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    3691:	8d 7c 3d d8          	lea    -0x28(%ebp,%edi,1),%edi
    3695:	8d 76 00             	lea    0x0(%esi),%esi
    putc(fd, buf[i]);
    3698:	8a 07                	mov    (%edi),%al
    369a:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
    369d:	50                   	push   %eax
    369e:	6a 01                	push   $0x1
    36a0:	56                   	push   %esi
    36a1:	ff 75 c0             	push   -0x40(%ebp)
    36a4:	e8 06 ff ff ff       	call   35af <write>
  while(--i >= 0)
    36a9:	89 f8                	mov    %edi,%eax
    36ab:	4f                   	dec    %edi
    36ac:	83 c4 10             	add    $0x10,%esp
    36af:	39 c3                	cmp    %eax,%ebx
    36b1:	75 e5                	jne    3698 <printint+0x60>
}
    36b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    36b6:	5b                   	pop    %ebx
    36b7:	5e                   	pop    %esi
    36b8:	5f                   	pop    %edi
    36b9:	5d                   	pop    %ebp
    36ba:	c3                   	ret
    36bb:	90                   	nop
    x = -xx;
    36bc:	f7 da                	neg    %edx
    36be:	89 55 c4             	mov    %edx,-0x3c(%ebp)
    36c1:	eb 98                	jmp    365b <printint+0x23>
    36c3:	90                   	nop

000036c4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    36c4:	55                   	push   %ebp
    36c5:	89 e5                	mov    %esp,%ebp
    36c7:	57                   	push   %edi
    36c8:	56                   	push   %esi
    36c9:	53                   	push   %ebx
    36ca:	83 ec 2c             	sub    $0x2c,%esp
    36cd:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    36d0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    36d3:	8a 13                	mov    (%ebx),%dl
    36d5:	84 d2                	test   %dl,%dl
    36d7:	74 5c                	je     3735 <printf+0x71>
    36d9:	43                   	inc    %ebx
  ap = (uint*)(void*)&fmt + 1;
    36da:	8d 45 10             	lea    0x10(%ebp),%eax
    36dd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
    36e0:	31 ff                	xor    %edi,%edi
    36e2:	eb 20                	jmp    3704 <printf+0x40>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    36e4:	83 f8 25             	cmp    $0x25,%eax
    36e7:	74 3f                	je     3728 <printf+0x64>
        state = '%';
      } else {
        putc(fd, c);
    36e9:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    36ec:	50                   	push   %eax
    36ed:	6a 01                	push   $0x1
    36ef:	8d 45 e7             	lea    -0x19(%ebp),%eax
    36f2:	50                   	push   %eax
    36f3:	56                   	push   %esi
    36f4:	e8 b6 fe ff ff       	call   35af <write>
        putc(fd, c);
    36f9:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    36fc:	43                   	inc    %ebx
    36fd:	8a 53 ff             	mov    -0x1(%ebx),%dl
    3700:	84 d2                	test   %dl,%dl
    3702:	74 31                	je     3735 <printf+0x71>
    c = fmt[i] & 0xff;
    3704:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    3707:	85 ff                	test   %edi,%edi
    3709:	74 d9                	je     36e4 <printf+0x20>
      }
    } else if(state == '%'){
    370b:	83 ff 25             	cmp    $0x25,%edi
    370e:	75 ec                	jne    36fc <printf+0x38>
      if(c == 'd'){
    3710:	83 f8 25             	cmp    $0x25,%eax
    3713:	0f 84 f3 00 00 00    	je     380c <printf+0x148>
    3719:	83 e8 63             	sub    $0x63,%eax
    371c:	83 f8 15             	cmp    $0x15,%eax
    371f:	77 1f                	ja     3740 <printf+0x7c>
    3721:	ff 24 85 40 51 00 00 	jmp    *0x5140(,%eax,4)
        state = '%';
    3728:	bf 25 00 00 00       	mov    $0x25,%edi
  for(i = 0; fmt[i]; i++){
    372d:	43                   	inc    %ebx
    372e:	8a 53 ff             	mov    -0x1(%ebx),%dl
    3731:	84 d2                	test   %dl,%dl
    3733:	75 cf                	jne    3704 <printf+0x40>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3735:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3738:	5b                   	pop    %ebx
    3739:	5e                   	pop    %esi
    373a:	5f                   	pop    %edi
    373b:	5d                   	pop    %ebp
    373c:	c3                   	ret
    373d:	8d 76 00             	lea    0x0(%esi),%esi
    3740:	88 55 d0             	mov    %dl,-0x30(%ebp)
        putc(fd, '%');
    3743:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
    3747:	50                   	push   %eax
    3748:	6a 01                	push   $0x1
    374a:	8d 7d e7             	lea    -0x19(%ebp),%edi
    374d:	57                   	push   %edi
    374e:	56                   	push   %esi
    374f:	e8 5b fe ff ff       	call   35af <write>
        putc(fd, c);
    3754:	8a 55 d0             	mov    -0x30(%ebp),%dl
    3757:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    375a:	83 c4 0c             	add    $0xc,%esp
    375d:	6a 01                	push   $0x1
    375f:	57                   	push   %edi
    3760:	56                   	push   %esi
    3761:	e8 49 fe ff ff       	call   35af <write>
        putc(fd, c);
    3766:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3769:	31 ff                	xor    %edi,%edi
    376b:	eb 8f                	jmp    36fc <printf+0x38>
    376d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3770:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    3773:	8b 17                	mov    (%edi),%edx
    3775:	83 ec 0c             	sub    $0xc,%esp
    3778:	6a 00                	push   $0x0
    377a:	b9 10 00 00 00       	mov    $0x10,%ecx
    377f:	89 f0                	mov    %esi,%eax
    3781:	e8 b2 fe ff ff       	call   3638 <printint>
        ap++;
    3786:	83 c7 04             	add    $0x4,%edi
    3789:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    378c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    378f:	31 ff                	xor    %edi,%edi
        ap++;
    3791:	e9 66 ff ff ff       	jmp    36fc <printf+0x38>
        s = (char*)*ap;
    3796:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3799:	8b 10                	mov    (%eax),%edx
        ap++;
    379b:	83 c0 04             	add    $0x4,%eax
    379e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    37a1:	85 d2                	test   %edx,%edx
    37a3:	74 77                	je     381c <printf+0x158>
        while(*s != 0){
    37a5:	8a 02                	mov    (%edx),%al
    37a7:	84 c0                	test   %al,%al
    37a9:	74 7a                	je     3825 <printf+0x161>
    37ab:	8d 7d e7             	lea    -0x19(%ebp),%edi
    37ae:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    37b1:	89 d3                	mov    %edx,%ebx
    37b3:	90                   	nop
          putc(fd, *s);
    37b4:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    37b7:	50                   	push   %eax
    37b8:	6a 01                	push   $0x1
    37ba:	57                   	push   %edi
    37bb:	56                   	push   %esi
    37bc:	e8 ee fd ff ff       	call   35af <write>
          s++;
    37c1:	43                   	inc    %ebx
        while(*s != 0){
    37c2:	8a 03                	mov    (%ebx),%al
    37c4:	83 c4 10             	add    $0x10,%esp
    37c7:	84 c0                	test   %al,%al
    37c9:	75 e9                	jne    37b4 <printf+0xf0>
      state = 0;
    37cb:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    37ce:	31 ff                	xor    %edi,%edi
    37d0:	e9 27 ff ff ff       	jmp    36fc <printf+0x38>
        printint(fd, *ap, 10, 1);
    37d5:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    37d8:	8b 17                	mov    (%edi),%edx
    37da:	83 ec 0c             	sub    $0xc,%esp
    37dd:	6a 01                	push   $0x1
    37df:	b9 0a 00 00 00       	mov    $0xa,%ecx
    37e4:	eb 99                	jmp    377f <printf+0xbb>
        putc(fd, *ap);
    37e6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    37e9:	8b 00                	mov    (%eax),%eax
    37eb:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    37ee:	51                   	push   %ecx
    37ef:	6a 01                	push   $0x1
    37f1:	8d 7d e7             	lea    -0x19(%ebp),%edi
    37f4:	57                   	push   %edi
    37f5:	56                   	push   %esi
    37f6:	e8 b4 fd ff ff       	call   35af <write>
        ap++;
    37fb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    37ff:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3802:	31 ff                	xor    %edi,%edi
    3804:	e9 f3 fe ff ff       	jmp    36fc <printf+0x38>
    3809:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    380c:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    380f:	52                   	push   %edx
    3810:	6a 01                	push   $0x1
    3812:	8d 7d e7             	lea    -0x19(%ebp),%edi
    3815:	e9 45 ff ff ff       	jmp    375f <printf+0x9b>
    381a:	66 90                	xchg   %ax,%ax
    381c:	b0 28                	mov    $0x28,%al
          s = "(null)";
    381e:	ba b1 49 00 00       	mov    $0x49b1,%edx
    3823:	eb 86                	jmp    37ab <printf+0xe7>
      state = 0;
    3825:	31 ff                	xor    %edi,%edi
    3827:	e9 d0 fe ff ff       	jmp    36fc <printf+0x38>

0000382c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    382c:	55                   	push   %ebp
    382d:	89 e5                	mov    %esp,%ebp
    382f:	57                   	push   %edi
    3830:	56                   	push   %esi
    3831:	53                   	push   %ebx
    3832:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3835:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3838:	a1 80 99 00 00       	mov    0x9980,%eax
    383d:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3840:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3842:	39 c8                	cmp    %ecx,%eax
    3844:	73 2e                	jae    3874 <free+0x48>
    3846:	39 d1                	cmp    %edx,%ecx
    3848:	72 04                	jb     384e <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    384a:	39 d0                	cmp    %edx,%eax
    384c:	72 2e                	jb     387c <free+0x50>
      break;
  if(bp + bp->s.size == p->s.ptr){
    384e:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3851:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3854:	39 fa                	cmp    %edi,%edx
    3856:	74 28                	je     3880 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    3858:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    385b:	8b 50 04             	mov    0x4(%eax),%edx
    385e:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3861:	39 f1                	cmp    %esi,%ecx
    3863:	74 32                	je     3897 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    3865:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    3867:	a3 80 99 00 00       	mov    %eax,0x9980
}
    386c:	5b                   	pop    %ebx
    386d:	5e                   	pop    %esi
    386e:	5f                   	pop    %edi
    386f:	5d                   	pop    %ebp
    3870:	c3                   	ret
    3871:	8d 76 00             	lea    0x0(%esi),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3874:	39 d0                	cmp    %edx,%eax
    3876:	72 04                	jb     387c <free+0x50>
    3878:	39 d1                	cmp    %edx,%ecx
    387a:	72 d2                	jb     384e <free+0x22>
{
    387c:	89 d0                	mov    %edx,%eax
    387e:	eb c0                	jmp    3840 <free+0x14>
    bp->s.size += p->s.ptr->s.size;
    3880:	03 72 04             	add    0x4(%edx),%esi
    3883:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3886:	8b 10                	mov    (%eax),%edx
    3888:	8b 12                	mov    (%edx),%edx
    388a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    388d:	8b 50 04             	mov    0x4(%eax),%edx
    3890:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3893:	39 f1                	cmp    %esi,%ecx
    3895:	75 ce                	jne    3865 <free+0x39>
    p->s.size += bp->s.size;
    3897:	03 53 fc             	add    -0x4(%ebx),%edx
    389a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    389d:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    38a0:	89 08                	mov    %ecx,(%eax)
  freep = p;
    38a2:	a3 80 99 00 00       	mov    %eax,0x9980
}
    38a7:	5b                   	pop    %ebx
    38a8:	5e                   	pop    %esi
    38a9:	5f                   	pop    %edi
    38aa:	5d                   	pop    %ebp
    38ab:	c3                   	ret

000038ac <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    38ac:	55                   	push   %ebp
    38ad:	89 e5                	mov    %esp,%ebp
    38af:	57                   	push   %edi
    38b0:	56                   	push   %esi
    38b1:	53                   	push   %ebx
    38b2:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    38b5:	8b 45 08             	mov    0x8(%ebp),%eax
    38b8:	8d 78 07             	lea    0x7(%eax),%edi
    38bb:	c1 ef 03             	shr    $0x3,%edi
    38be:	47                   	inc    %edi
  if((prevp = freep) == 0){
    38bf:	8b 15 80 99 00 00    	mov    0x9980,%edx
    38c5:	85 d2                	test   %edx,%edx
    38c7:	0f 84 93 00 00 00    	je     3960 <malloc+0xb4>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    38cd:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    38cf:	8b 48 04             	mov    0x4(%eax),%ecx
    38d2:	39 f9                	cmp    %edi,%ecx
    38d4:	73 62                	jae    3938 <malloc+0x8c>
  if(nu < 4096)
    38d6:	89 fb                	mov    %edi,%ebx
    38d8:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    38de:	72 78                	jb     3958 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
    38e0:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    38e7:	eb 0e                	jmp    38f7 <malloc+0x4b>
    38e9:	8d 76 00             	lea    0x0(%esi),%esi
    38ec:	89 c2                	mov    %eax,%edx
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    38ee:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    38f0:	8b 48 04             	mov    0x4(%eax),%ecx
    38f3:	39 f9                	cmp    %edi,%ecx
    38f5:	73 41                	jae    3938 <malloc+0x8c>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    38f7:	3b 05 80 99 00 00    	cmp    0x9980,%eax
    38fd:	75 ed                	jne    38ec <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    38ff:	83 ec 0c             	sub    $0xc,%esp
    3902:	56                   	push   %esi
    3903:	e8 0f fd ff ff       	call   3617 <sbrk>
  if(p == (char*)-1)
    3908:	83 c4 10             	add    $0x10,%esp
    390b:	83 f8 ff             	cmp    $0xffffffff,%eax
    390e:	74 1c                	je     392c <malloc+0x80>
  hp->s.size = nu;
    3910:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3913:	83 ec 0c             	sub    $0xc,%esp
    3916:	83 c0 08             	add    $0x8,%eax
    3919:	50                   	push   %eax
    391a:	e8 0d ff ff ff       	call   382c <free>
  return freep;
    391f:	8b 15 80 99 00 00    	mov    0x9980,%edx
      if((p = morecore(nunits)) == 0)
    3925:	83 c4 10             	add    $0x10,%esp
    3928:	85 d2                	test   %edx,%edx
    392a:	75 c2                	jne    38ee <malloc+0x42>
        return 0;
    392c:	31 c0                	xor    %eax,%eax
  }
}
    392e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3931:	5b                   	pop    %ebx
    3932:	5e                   	pop    %esi
    3933:	5f                   	pop    %edi
    3934:	5d                   	pop    %ebp
    3935:	c3                   	ret
    3936:	66 90                	xchg   %ax,%ax
      if(p->s.size == nunits)
    3938:	39 cf                	cmp    %ecx,%edi
    393a:	74 4c                	je     3988 <malloc+0xdc>
        p->s.size -= nunits;
    393c:	29 f9                	sub    %edi,%ecx
    393e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3941:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    3944:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    3947:	89 15 80 99 00 00    	mov    %edx,0x9980
      return (void*)(p + 1);
    394d:	83 c0 08             	add    $0x8,%eax
}
    3950:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3953:	5b                   	pop    %ebx
    3954:	5e                   	pop    %esi
    3955:	5f                   	pop    %edi
    3956:	5d                   	pop    %ebp
    3957:	c3                   	ret
  if(nu < 4096)
    3958:	bb 00 10 00 00       	mov    $0x1000,%ebx
    395d:	eb 81                	jmp    38e0 <malloc+0x34>
    395f:	90                   	nop
    base.s.ptr = freep = prevp = &base;
    3960:	c7 05 80 99 00 00 84 	movl   $0x9984,0x9980
    3967:	99 00 00 
    396a:	c7 05 84 99 00 00 84 	movl   $0x9984,0x9984
    3971:	99 00 00 
    base.s.size = 0;
    3974:	c7 05 88 99 00 00 00 	movl   $0x0,0x9988
    397b:	00 00 00 
    397e:	b8 84 99 00 00       	mov    $0x9984,%eax
    3983:	e9 4e ff ff ff       	jmp    38d6 <malloc+0x2a>
        prevp->s.ptr = p->s.ptr;
    3988:	8b 08                	mov    (%eax),%ecx
    398a:	89 0a                	mov    %ecx,(%edx)
    398c:	eb b9                	jmp    3947 <malloc+0x9b>
