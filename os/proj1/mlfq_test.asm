
_mlfq_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    exit();
  while (wait() != -1);
}

int main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 2c             	sub    $0x2c,%esp
  int i, pid;
  int count[MAX_LEVEL] = {0};
  13:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  1a:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  21:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  28:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  2f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  int child;

  parent = getpid();
  36:	e8 28 09 00 00       	call   963 <getpid>

  printf(1, "MLFQ test start\n");
  3b:	83 ec 08             	sub    $0x8,%esp
  3e:	68 91 0d 00 00       	push   $0xd91
  43:	6a 01                	push   $0x1
  parent = getpid();
  45:	a3 ac 10 00 00       	mov    %eax,0x10ac
  printf(1, "MLFQ test start\n");
  4a:	e8 01 0a 00 00       	call   a50 <printf>

  printf(1, "[Test 1] default\n");
  4f:	58                   	pop    %eax
  50:	5a                   	pop    %edx
  51:	68 a2 0d 00 00       	push   $0xda2
  56:	6a 01                	push   $0x1
  58:	e8 f3 09 00 00       	call   a50 <printf>
  pid = fork_children();
  5d:	e8 fe 04 00 00       	call   560 <fork_children>

  if (pid != parent)
  62:	83 c4 10             	add    $0x10,%esp
  65:	39 05 ac 10 00 00    	cmp    %eax,0x10ac
  6b:	74 6d                	je     da <main+0xda>
  6d:	89 c6                	mov    %eax,%esi
  6f:	bb a0 86 01 00       	mov    $0x186a0,%ebx
  74:	eb 14                	jmp    8a <main+0x8a>
  76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  7d:	8d 76 00             	lea    0x0(%esi),%esi
      if (x < 0 || x > 4)
      {
        printf(1, "Wrong level: %d\n", x);
        exit();
      }
      count[x]++;
  80:	83 44 85 d4 01       	addl   $0x1,-0x2c(%ebp,%eax,4)
    for (i = 0; i < NUM_LOOP; i++)
  85:	83 eb 01             	sub    $0x1,%ebx
  88:	74 1f                	je     a9 <main+0xa9>
      int x = getlev();
  8a:	e8 fc 08 00 00       	call   98b <getlev>
      if (x < 0 || x > 4)
  8f:	83 f8 04             	cmp    $0x4,%eax
  92:	76 ec                	jbe    80 <main+0x80>
    for (i = 0; i < NUM_LOOP; i++)
    {
      int x = getlev();
      if (x < 0 || x > 4)
      {
        printf(1, "Wrong level: %d\n", x);
  94:	83 ec 04             	sub    $0x4,%esp
  97:	50                   	push   %eax
  98:	68 b4 0d 00 00       	push   $0xdb4
  9d:	6a 01                	push   $0x1
  9f:	e8 ac 09 00 00       	call   a50 <printf>
        exit();
  a4:	e8 3a 08 00 00       	call   8e3 <exit>
    printf(1, "Process %d\n", pid);
  a9:	50                   	push   %eax
    for (i = 0; i < MAX_LEVEL; i++)
  aa:	31 db                	xor    %ebx,%ebx
    printf(1, "Process %d\n", pid);
  ac:	56                   	push   %esi
  ad:	8d 75 d4             	lea    -0x2c(%ebp),%esi
  b0:	68 c5 0d 00 00       	push   $0xdc5
  b5:	6a 01                	push   $0x1
  b7:	e8 94 09 00 00       	call   a50 <printf>
  bc:	83 c4 10             	add    $0x10,%esp
      printf(1, "L%d: %d\n", i, count[i]);
  bf:	ff 34 9e             	push   (%esi,%ebx,4)
  c2:	53                   	push   %ebx
    for (i = 0; i < MAX_LEVEL; i++)
  c3:	83 c3 01             	add    $0x1,%ebx
      printf(1, "L%d: %d\n", i, count[i]);
  c6:	68 d1 0d 00 00       	push   $0xdd1
  cb:	6a 01                	push   $0x1
  cd:	e8 7e 09 00 00       	call   a50 <printf>
    for (i = 0; i < MAX_LEVEL; i++)
  d2:	83 c4 10             	add    $0x10,%esp
  d5:	83 fb 05             	cmp    $0x5,%ebx
  d8:	75 e5                	jne    bf <main+0xbf>
  exit_children();
  da:	e8 81 05 00 00       	call   660 <exit_children>
  printf(1, "[Test 1] finished\n");
  df:	53                   	push   %ebx
  e0:	53                   	push   %ebx
  e1:	68 da 0d 00 00       	push   $0xdda
  e6:	6a 01                	push   $0x1
  e8:	e8 63 09 00 00       	call   a50 <printf>
  printf(1, "[Test 2] priorities\n");
  ed:	5e                   	pop    %esi
  ee:	58                   	pop    %eax
  ef:	68 ed 0d 00 00       	push   $0xded
  f4:	6a 01                	push   $0x1
  f6:	e8 55 09 00 00       	call   a50 <printf>
  pid = fork_children2();
  fb:	e8 a0 04 00 00       	call   5a0 <fork_children2>
  if (pid != parent)
 100:	83 c4 10             	add    $0x10,%esp
  pid = fork_children2();
 103:	89 c6                	mov    %eax,%esi
  if (pid != parent)
 105:	39 05 ac 10 00 00    	cmp    %eax,0x10ac
 10b:	74 55                	je     162 <main+0x162>
 10d:	bb a0 86 01 00       	mov    $0x186a0,%ebx
 112:	eb 0e                	jmp    122 <main+0x122>
 114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      count[x]++;
 118:	83 44 85 d4 01       	addl   $0x1,-0x2c(%ebp,%eax,4)
    for (i = 0; i < NUM_LOOP; i++)
 11d:	83 eb 01             	sub    $0x1,%ebx
 120:	74 0f                	je     131 <main+0x131>
      int x = getlev();
 122:	e8 64 08 00 00       	call   98b <getlev>
      if (x < 0 || x > 4)
 127:	83 f8 04             	cmp    $0x4,%eax
 12a:	76 ec                	jbe    118 <main+0x118>
 12c:	e9 63 ff ff ff       	jmp    94 <main+0x94>
    printf(1, "Process %d\n", pid);
 131:	51                   	push   %ecx
    for (i = 0; i < MAX_LEVEL; i++)
 132:	31 db                	xor    %ebx,%ebx
    printf(1, "Process %d\n", pid);
 134:	56                   	push   %esi
 135:	8d 75 d4             	lea    -0x2c(%ebp),%esi
 138:	68 c5 0d 00 00       	push   $0xdc5
 13d:	6a 01                	push   $0x1
 13f:	e8 0c 09 00 00       	call   a50 <printf>
 144:	83 c4 10             	add    $0x10,%esp
      printf(1, "L%d: %d\n", i, count[i]);
 147:	ff 34 9e             	push   (%esi,%ebx,4)
 14a:	53                   	push   %ebx
    for (i = 0; i < MAX_LEVEL; i++)
 14b:	83 c3 01             	add    $0x1,%ebx
      printf(1, "L%d: %d\n", i, count[i]);
 14e:	68 d1 0d 00 00       	push   $0xdd1
 153:	6a 01                	push   $0x1
 155:	e8 f6 08 00 00       	call   a50 <printf>
    for (i = 0; i < MAX_LEVEL; i++)
 15a:	83 c4 10             	add    $0x10,%esp
 15d:	83 fb 05             	cmp    $0x5,%ebx
 160:	75 e5                	jne    147 <main+0x147>
  exit_children();
 162:	e8 f9 04 00 00       	call   660 <exit_children>
  printf(1, "[Test 2] finished\n");
 167:	50                   	push   %eax
 168:	50                   	push   %eax
 169:	68 02 0e 00 00       	push   $0xe02
 16e:	6a 01                	push   $0x1
 170:	e8 db 08 00 00       	call   a50 <printf>
  printf(1, "[Test 3] yield\n");
 175:	58                   	pop    %eax
 176:	5a                   	pop    %edx
 177:	68 15 0e 00 00       	push   $0xe15
 17c:	6a 01                	push   $0x1
 17e:	e8 cd 08 00 00       	call   a50 <printf>
  pid = fork_children2();
 183:	e8 18 04 00 00       	call   5a0 <fork_children2>
  if (pid != parent)
 188:	83 c4 10             	add    $0x10,%esp
  pid = fork_children2();
 18b:	89 c6                	mov    %eax,%esi
  if (pid != parent)
 18d:	39 05 ac 10 00 00    	cmp    %eax,0x10ac
 193:	74 5a                	je     1ef <main+0x1ef>
 195:	bb 20 4e 00 00       	mov    $0x4e20,%ebx
 19a:	eb 13                	jmp    1af <main+0x1af>
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      count[x]++;
 1a0:	83 44 85 d4 01       	addl   $0x1,-0x2c(%ebp,%eax,4)
      yield();
 1a5:	e8 d9 07 00 00       	call   983 <yield>
    for (i = 0; i < NUM_YIELD; i++)
 1aa:	83 eb 01             	sub    $0x1,%ebx
 1ad:	74 0f                	je     1be <main+0x1be>
      int x = getlev();
 1af:	e8 d7 07 00 00       	call   98b <getlev>
      if (x < 0 || x > 4)
 1b4:	83 f8 04             	cmp    $0x4,%eax
 1b7:	76 e7                	jbe    1a0 <main+0x1a0>
 1b9:	e9 d6 fe ff ff       	jmp    94 <main+0x94>
    printf(1, "Process %d\n", pid);
 1be:	50                   	push   %eax
    for (i = 0; i < MAX_LEVEL; i++)
 1bf:	31 db                	xor    %ebx,%ebx
    printf(1, "Process %d\n", pid);
 1c1:	56                   	push   %esi
 1c2:	8d 75 d4             	lea    -0x2c(%ebp),%esi
 1c5:	68 c5 0d 00 00       	push   $0xdc5
 1ca:	6a 01                	push   $0x1
 1cc:	e8 7f 08 00 00       	call   a50 <printf>
 1d1:	83 c4 10             	add    $0x10,%esp
      printf(1, "L%d: %d\n", i, count[i]);
 1d4:	ff 34 9e             	push   (%esi,%ebx,4)
 1d7:	53                   	push   %ebx
    for (i = 0; i < MAX_LEVEL; i++)
 1d8:	83 c3 01             	add    $0x1,%ebx
      printf(1, "L%d: %d\n", i, count[i]);
 1db:	68 d1 0d 00 00       	push   $0xdd1
 1e0:	6a 01                	push   $0x1
 1e2:	e8 69 08 00 00       	call   a50 <printf>
    for (i = 0; i < MAX_LEVEL; i++)
 1e7:	83 c4 10             	add    $0x10,%esp
 1ea:	83 fb 05             	cmp    $0x5,%ebx
 1ed:	75 e5                	jne    1d4 <main+0x1d4>
  exit_children();
 1ef:	e8 6c 04 00 00       	call   660 <exit_children>
  printf(1, "[Test 3] finished\n");
 1f4:	53                   	push   %ebx
 1f5:	53                   	push   %ebx
 1f6:	68 25 0e 00 00       	push   $0xe25
 1fb:	6a 01                	push   $0x1
 1fd:	e8 4e 08 00 00       	call   a50 <printf>
  printf(1, "[Test 4] sleep\n");
 202:	5e                   	pop    %esi
 203:	58                   	pop    %eax
 204:	68 38 0e 00 00       	push   $0xe38
 209:	6a 01                	push   $0x1
 20b:	e8 40 08 00 00       	call   a50 <printf>
  pid = fork_children2();
 210:	e8 8b 03 00 00       	call   5a0 <fork_children2>
  if (pid != parent)
 215:	83 c4 10             	add    $0x10,%esp
  pid = fork_children2();
 218:	89 c6                	mov    %eax,%esi
  if (pid != parent)
 21a:	39 05 ac 10 00 00    	cmp    %eax,0x10ac
 220:	74 5e                	je     280 <main+0x280>
 222:	bb f4 01 00 00       	mov    $0x1f4,%ebx
 227:	eb 17                	jmp    240 <main+0x240>
      sleep(1);
 229:	83 ec 0c             	sub    $0xc,%esp
      count[x]++;
 22c:	83 44 85 d4 01       	addl   $0x1,-0x2c(%ebp,%eax,4)
      sleep(1);
 231:	6a 01                	push   $0x1
 233:	e8 3b 07 00 00       	call   973 <sleep>
    for (i = 0; i < NUM_SLEEP; i++)
 238:	83 c4 10             	add    $0x10,%esp
 23b:	83 eb 01             	sub    $0x1,%ebx
 23e:	74 0f                	je     24f <main+0x24f>
      int x = getlev();
 240:	e8 46 07 00 00       	call   98b <getlev>
      if (x < 0 || x > 4)
 245:	83 f8 04             	cmp    $0x4,%eax
 248:	76 df                	jbe    229 <main+0x229>
 24a:	e9 45 fe ff ff       	jmp    94 <main+0x94>
    printf(1, "Process %d\n", pid);
 24f:	51                   	push   %ecx
    for (i = 0; i < MAX_LEVEL; i++)
 250:	31 db                	xor    %ebx,%ebx
    printf(1, "Process %d\n", pid);
 252:	56                   	push   %esi
 253:	8d 75 d4             	lea    -0x2c(%ebp),%esi
 256:	68 c5 0d 00 00       	push   $0xdc5
 25b:	6a 01                	push   $0x1
 25d:	e8 ee 07 00 00       	call   a50 <printf>
 262:	83 c4 10             	add    $0x10,%esp
      printf(1, "L%d: %d\n", i, count[i]);
 265:	ff 34 9e             	push   (%esi,%ebx,4)
 268:	53                   	push   %ebx
    for (i = 0; i < MAX_LEVEL; i++)
 269:	83 c3 01             	add    $0x1,%ebx
      printf(1, "L%d: %d\n", i, count[i]);
 26c:	68 d1 0d 00 00       	push   $0xdd1
 271:	6a 01                	push   $0x1
 273:	e8 d8 07 00 00       	call   a50 <printf>
    for (i = 0; i < MAX_LEVEL; i++)
 278:	83 c4 10             	add    $0x10,%esp
 27b:	83 fb 05             	cmp    $0x5,%ebx
 27e:	75 e5                	jne    265 <main+0x265>
  exit_children();
 280:	e8 db 03 00 00       	call   660 <exit_children>
  printf(1, "[Test 4] finished\n");
 285:	50                   	push   %eax
 286:	50                   	push   %eax
 287:	68 48 0e 00 00       	push   $0xe48
 28c:	6a 01                	push   $0x1
 28e:	e8 bd 07 00 00       	call   a50 <printf>
  printf(1, "[Test 5] max level\n");
 293:	58                   	pop    %eax
 294:	5a                   	pop    %edx
 295:	68 5b 0e 00 00       	push   $0xe5b
 29a:	6a 01                	push   $0x1
 29c:	e8 af 07 00 00       	call   a50 <printf>
  pid = fork_children3();
 2a1:	e8 6a 03 00 00       	call   610 <fork_children3>
  if (pid != parent)
 2a6:	83 c4 10             	add    $0x10,%esp
  pid = fork_children3();
 2a9:	89 c6                	mov    %eax,%esi
  if (pid != parent)
 2ab:	39 05 ac 10 00 00    	cmp    %eax,0x10ac
 2b1:	74 5f                	je     312 <main+0x312>
 2b3:	bb a0 86 01 00       	mov    $0x186a0,%ebx
 2b8:	eb 05                	jmp    2bf <main+0x2bf>
    for (i = 0; i < NUM_LOOP; i++)
 2ba:	83 eb 01             	sub    $0x1,%ebx
 2bd:	74 22                	je     2e1 <main+0x2e1>
      int x = getlev();
 2bf:	e8 c7 06 00 00       	call   98b <getlev>
      if (x < 0 || x > 4)
 2c4:	83 f8 04             	cmp    $0x4,%eax
 2c7:	0f 87 c7 fd ff ff    	ja     94 <main+0x94>
      }
      count[x]++;
 2cd:	83 44 85 d4 01       	addl   $0x1,-0x2c(%ebp,%eax,4)
      if (x > max_level)
 2d2:	39 05 a8 10 00 00    	cmp    %eax,0x10a8
 2d8:	7d e0                	jge    2ba <main+0x2ba>
        yield();
 2da:	e8 a4 06 00 00       	call   983 <yield>
 2df:	eb d9                	jmp    2ba <main+0x2ba>
    }
    printf(1, "Process %d\n", pid);
 2e1:	50                   	push   %eax
    for (i = 0; i < MAX_LEVEL; i++)
 2e2:	31 db                	xor    %ebx,%ebx
    printf(1, "Process %d\n", pid);
 2e4:	56                   	push   %esi
 2e5:	8d 75 d4             	lea    -0x2c(%ebp),%esi
 2e8:	68 c5 0d 00 00       	push   $0xdc5
 2ed:	6a 01                	push   $0x1
 2ef:	e8 5c 07 00 00       	call   a50 <printf>
 2f4:	83 c4 10             	add    $0x10,%esp
      printf(1, "L%d: %d\n", i, count[i]);
 2f7:	ff 34 9e             	push   (%esi,%ebx,4)
 2fa:	53                   	push   %ebx
    for (i = 0; i < MAX_LEVEL; i++)
 2fb:	83 c3 01             	add    $0x1,%ebx
      printf(1, "L%d: %d\n", i, count[i]);
 2fe:	68 d1 0d 00 00       	push   $0xdd1
 303:	6a 01                	push   $0x1
 305:	e8 46 07 00 00       	call   a50 <printf>
    for (i = 0; i < MAX_LEVEL; i++)
 30a:	83 c4 10             	add    $0x10,%esp
 30d:	83 fb 05             	cmp    $0x5,%ebx
 310:	75 e5                	jne    2f7 <main+0x2f7>
  }
  exit_children();
 312:	e8 49 03 00 00       	call   660 <exit_children>
  printf(1, "[Test 5] finished\n");
 317:	53                   	push   %ebx
 318:	53                   	push   %ebx
 319:	68 6f 0e 00 00       	push   $0xe6f
 31e:	6a 01                	push   $0x1
 320:	e8 2b 07 00 00       	call   a50 <printf>
  
  printf(1, "[Test 6] setpriority return value\n");
 325:	5e                   	pop    %esi
 326:	58                   	pop    %eax
 327:	68 9c 0e 00 00       	push   $0xe9c
 32c:	6a 01                	push   $0x1
 32e:	e8 1d 07 00 00       	call   a50 <printf>
  child = fork();
 333:	e8 a3 05 00 00       	call   8db <fork>

  if (child == 0)
 338:	83 c4 10             	add    $0x10,%esp
  child = fork();
 33b:	89 c3                	mov    %eax,%ebx
  if (child == 0)
 33d:	85 c0                	test   %eax,%eax
 33f:	0f 85 ea 00 00 00    	jne    42f <main+0x42f>
  {
    int r;
    int grandson;
    sleep(10);
 345:	83 ec 0c             	sub    $0xc,%esp
 348:	6a 0a                	push   $0xa
 34a:	e8 24 06 00 00       	call   973 <sleep>
    grandson = fork();
 34f:	e8 87 05 00 00       	call   8db <fork>
    if (grandson == 0)
 354:	83 c4 10             	add    $0x10,%esp
 357:	85 c0                	test   %eax,%eax
 359:	0f 85 8e 00 00 00    	jne    3ed <main+0x3ed>
    {
      r = setpriority(getpid() - 2, 0);
 35f:	e8 ff 05 00 00       	call   963 <getpid>
 364:	83 e8 02             	sub    $0x2,%eax
 367:	51                   	push   %ecx
 368:	51                   	push   %ecx
 369:	6a 00                	push   $0x0
 36b:	50                   	push   %eax
 36c:	e8 22 06 00 00       	call   993 <setpriority>
      if (r != -1)
 371:	83 c4 10             	add    $0x10,%esp
 374:	83 f8 ff             	cmp    $0xffffffff,%eax
 377:	74 11                	je     38a <main+0x38a>
        printf(1, "wrong: setpriority of parent: expected -1, got %d\n", r);
 379:	52                   	push   %edx
 37a:	50                   	push   %eax
 37b:	68 c0 0e 00 00       	push   $0xec0
 380:	6a 01                	push   $0x1
 382:	e8 c9 06 00 00       	call   a50 <printf>
 387:	83 c4 10             	add    $0x10,%esp
      r = setpriority(getpid() - 3, 0);
 38a:	e8 d4 05 00 00       	call   963 <getpid>
 38f:	56                   	push   %esi
 390:	83 e8 03             	sub    $0x3,%eax
 393:	56                   	push   %esi
 394:	6a 00                	push   $0x0
 396:	50                   	push   %eax
 397:	e8 f7 05 00 00       	call   993 <setpriority>
      if (r != -1)
 39c:	83 c4 10             	add    $0x10,%esp
 39f:	83 f8 ff             	cmp    $0xffffffff,%eax
 3a2:	74 11                	je     3b5 <main+0x3b5>
        printf(1, "wrong: setpriority of ancestor: expected -1, got %d\n", r);
 3a4:	53                   	push   %ebx
 3a5:	50                   	push   %eax
 3a6:	68 f4 0e 00 00       	push   $0xef4
 3ab:	6a 01                	push   $0x1
 3ad:	e8 9e 06 00 00       	call   a50 <printf>
 3b2:	83 c4 10             	add    $0x10,%esp
        printf(1, "wrong: setpriority of child: expected 0, got %d\n", r);
      r = setpriority(getpid() + 1, 0);
      if (r != -1)
        printf(1, "wrong: setpriority of other: expected -1, got %d\n", r);
    }
    sleep(20);
 3b5:	83 ec 0c             	sub    $0xc,%esp
 3b8:	6a 14                	push   $0x14
 3ba:	e8 b4 05 00 00       	call   973 <sleep>
    wait();
 3bf:	e8 27 05 00 00       	call   8eb <wait>
 3c4:	83 c4 10             	add    $0x10,%esp
      if (r != -1)
        printf(1, "wrong: setpriority of self: expected -1, got %d\n", r);
    }
  }

  exit_children();
 3c7:	e8 94 02 00 00       	call   660 <exit_children>
  printf(1, "done\n");
 3cc:	50                   	push   %eax
 3cd:	50                   	push   %eax
 3ce:	68 82 0e 00 00       	push   $0xe82
 3d3:	6a 01                	push   $0x1
 3d5:	e8 76 06 00 00       	call   a50 <printf>
  printf(1, "[Test 6] finished\n");
 3da:	5a                   	pop    %edx
 3db:	59                   	pop    %ecx
 3dc:	68 88 0e 00 00       	push   $0xe88
 3e1:	6a 01                	push   $0x1
 3e3:	e8 68 06 00 00       	call   a50 <printf>

  exit();
 3e8:	e8 f6 04 00 00       	call   8e3 <exit>
      r = setpriority(grandson, 0);
 3ed:	51                   	push   %ecx
 3ee:	51                   	push   %ecx
 3ef:	6a 00                	push   $0x0
 3f1:	50                   	push   %eax
 3f2:	e8 9c 05 00 00       	call   993 <setpriority>
      if (r != 0)
 3f7:	83 c4 10             	add    $0x10,%esp
 3fa:	85 c0                	test   %eax,%eax
 3fc:	0f 85 42 01 00 00    	jne    544 <main+0x544>
      r = setpriority(getpid() + 1, 0);
 402:	e8 5c 05 00 00       	call   963 <getpid>
 407:	56                   	push   %esi
 408:	83 c0 01             	add    $0x1,%eax
 40b:	56                   	push   %esi
 40c:	6a 00                	push   $0x0
 40e:	50                   	push   %eax
 40f:	e8 7f 05 00 00       	call   993 <setpriority>
      if (r != -1)
 414:	83 c4 10             	add    $0x10,%esp
 417:	83 f8 ff             	cmp    $0xffffffff,%eax
 41a:	74 99                	je     3b5 <main+0x3b5>
        printf(1, "wrong: setpriority of other: expected -1, got %d\n", r);
 41c:	53                   	push   %ebx
 41d:	50                   	push   %eax
 41e:	68 60 0f 00 00       	push   $0xf60
 423:	6a 01                	push   $0x1
 425:	e8 26 06 00 00       	call   a50 <printf>
 42a:	83 c4 10             	add    $0x10,%esp
 42d:	eb 86                	jmp    3b5 <main+0x3b5>
    int child2 = fork();
 42f:	e8 a7 04 00 00       	call   8db <fork>
    sleep(20);
 434:	83 ec 0c             	sub    $0xc,%esp
 437:	6a 14                	push   $0x14
    int child2 = fork();
 439:	89 c6                	mov    %eax,%esi
    sleep(20);
 43b:	e8 33 05 00 00       	call   973 <sleep>
    if (child2 == 0)
 440:	83 c4 10             	add    $0x10,%esp
 443:	85 f6                	test   %esi,%esi
 445:	75 12                	jne    459 <main+0x459>
      sleep(10);
 447:	83 ec 0c             	sub    $0xc,%esp
 44a:	6a 0a                	push   $0xa
 44c:	e8 22 05 00 00       	call   973 <sleep>
 451:	83 c4 10             	add    $0x10,%esp
 454:	e9 6e ff ff ff       	jmp    3c7 <main+0x3c7>
      r = setpriority(child, -1);
 459:	51                   	push   %ecx
 45a:	51                   	push   %ecx
 45b:	6a ff                	push   $0xffffffff
 45d:	53                   	push   %ebx
 45e:	e8 30 05 00 00       	call   993 <setpriority>
      if (r != -2)
 463:	83 c4 10             	add    $0x10,%esp
 466:	83 f8 fe             	cmp    $0xfffffffe,%eax
 469:	74 11                	je     47c <main+0x47c>
        printf(1, "wrong: setpriority out of range: expected -2, got %d\n", r);
 46b:	52                   	push   %edx
 46c:	50                   	push   %eax
 46d:	68 94 0f 00 00       	push   $0xf94
 472:	6a 01                	push   $0x1
 474:	e8 d7 05 00 00       	call   a50 <printf>
 479:	83 c4 10             	add    $0x10,%esp
      r = setpriority(child, 11);
 47c:	50                   	push   %eax
 47d:	50                   	push   %eax
 47e:	6a 0b                	push   $0xb
 480:	53                   	push   %ebx
 481:	e8 0d 05 00 00       	call   993 <setpriority>
      if (r != -2)
 486:	83 c4 10             	add    $0x10,%esp
 489:	83 f8 fe             	cmp    $0xfffffffe,%eax
 48c:	74 11                	je     49f <main+0x49f>
        printf(1, "wrong: setpriority out of range: expected -2, got %d\n", r);
 48e:	56                   	push   %esi
 48f:	50                   	push   %eax
 490:	68 94 0f 00 00       	push   $0xf94
 495:	6a 01                	push   $0x1
 497:	e8 b4 05 00 00       	call   a50 <printf>
 49c:	83 c4 10             	add    $0x10,%esp
      r = setpriority(child, 10);
 49f:	51                   	push   %ecx
 4a0:	51                   	push   %ecx
 4a1:	6a 0a                	push   $0xa
 4a3:	53                   	push   %ebx
 4a4:	e8 ea 04 00 00       	call   993 <setpriority>
      if (r != 0)
 4a9:	83 c4 10             	add    $0x10,%esp
 4ac:	85 c0                	test   %eax,%eax
 4ae:	75 7e                	jne    52e <main+0x52e>
      r = setpriority(child + 1, 10);
 4b0:	50                   	push   %eax
 4b1:	50                   	push   %eax
 4b2:	8d 43 01             	lea    0x1(%ebx),%eax
 4b5:	6a 0a                	push   $0xa
 4b7:	50                   	push   %eax
 4b8:	e8 d6 04 00 00       	call   993 <setpriority>
      if (r != 0)
 4bd:	83 c4 10             	add    $0x10,%esp
 4c0:	85 c0                	test   %eax,%eax
 4c2:	75 57                	jne    51b <main+0x51b>
      r = setpriority(child + 2, 10);
 4c4:	83 c3 02             	add    $0x2,%ebx
 4c7:	51                   	push   %ecx
 4c8:	51                   	push   %ecx
 4c9:	6a 0a                	push   $0xa
 4cb:	53                   	push   %ebx
 4cc:	e8 c2 04 00 00       	call   993 <setpriority>
      if (r != -1)
 4d1:	83 c4 10             	add    $0x10,%esp
 4d4:	83 f8 ff             	cmp    $0xffffffff,%eax
 4d7:	74 11                	je     4ea <main+0x4ea>
        printf(1, "wrong: setpriority of grandson: expected -1, got %d\n", r);
 4d9:	52                   	push   %edx
 4da:	50                   	push   %eax
 4db:	68 cc 0f 00 00       	push   $0xfcc
 4e0:	6a 01                	push   $0x1
 4e2:	e8 69 05 00 00       	call   a50 <printf>
 4e7:	83 c4 10             	add    $0x10,%esp
      r = setpriority(parent, 5);
 4ea:	56                   	push   %esi
 4eb:	56                   	push   %esi
 4ec:	6a 05                	push   $0x5
 4ee:	ff 35 ac 10 00 00    	push   0x10ac
 4f4:	e8 9a 04 00 00       	call   993 <setpriority>
      if (r != -1)
 4f9:	83 c4 10             	add    $0x10,%esp
 4fc:	83 f8 ff             	cmp    $0xffffffff,%eax
 4ff:	0f 84 c2 fe ff ff    	je     3c7 <main+0x3c7>
        printf(1, "wrong: setpriority of self: expected -1, got %d\n", r);
 505:	53                   	push   %ebx
 506:	50                   	push   %eax
 507:	68 04 10 00 00       	push   $0x1004
 50c:	6a 01                	push   $0x1
 50e:	e8 3d 05 00 00       	call   a50 <printf>
 513:	83 c4 10             	add    $0x10,%esp
 516:	e9 ac fe ff ff       	jmp    3c7 <main+0x3c7>
        printf(1, "wrong: setpriority of child: expected 0, got %d\n", r);
 51b:	56                   	push   %esi
 51c:	50                   	push   %eax
 51d:	68 2c 0f 00 00       	push   $0xf2c
 522:	6a 01                	push   $0x1
 524:	e8 27 05 00 00       	call   a50 <printf>
 529:	83 c4 10             	add    $0x10,%esp
 52c:	eb 96                	jmp    4c4 <main+0x4c4>
        printf(1, "wrong: setpriority of child: expected 0, got %d\n", r);
 52e:	52                   	push   %edx
 52f:	50                   	push   %eax
 530:	68 2c 0f 00 00       	push   $0xf2c
 535:	6a 01                	push   $0x1
 537:	e8 14 05 00 00       	call   a50 <printf>
 53c:	83 c4 10             	add    $0x10,%esp
 53f:	e9 6c ff ff ff       	jmp    4b0 <main+0x4b0>
        printf(1, "wrong: setpriority of child: expected 0, got %d\n", r);
 544:	52                   	push   %edx
 545:	50                   	push   %eax
 546:	68 2c 0f 00 00       	push   $0xf2c
 54b:	6a 01                	push   $0x1
 54d:	e8 fe 04 00 00       	call   a50 <printf>
 552:	83 c4 10             	add    $0x10,%esp
 555:	e9 a8 fe ff ff       	jmp    402 <main+0x402>
 55a:	66 90                	xchg   %ax,%ax
 55c:	66 90                	xchg   %ax,%ax
 55e:	66 90                	xchg   %ax,%ax

00000560 <fork_children>:
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	53                   	push   %ebx
 564:	bb 04 00 00 00       	mov    $0x4,%ebx
 569:	83 ec 04             	sub    $0x4,%esp
    if ((p = fork()) == 0)
 56c:	e8 6a 03 00 00       	call   8db <fork>
 571:	85 c0                	test   %eax,%eax
 573:	74 13                	je     588 <fork_children+0x28>
  for (i = 0; i < NUM_THREAD; i++)
 575:	83 eb 01             	sub    $0x1,%ebx
 578:	75 f2                	jne    56c <fork_children+0xc>
}
 57a:	a1 ac 10 00 00       	mov    0x10ac,%eax
 57f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 582:	c9                   	leave  
 583:	c3                   	ret    
 584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      sleep(10);
 588:	83 ec 0c             	sub    $0xc,%esp
 58b:	6a 0a                	push   $0xa
 58d:	e8 e1 03 00 00       	call   973 <sleep>
}
 592:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return getpid();
 595:	83 c4 10             	add    $0x10,%esp
}
 598:	c9                   	leave  
      return getpid();
 599:	e9 c5 03 00 00       	jmp    963 <getpid>
 59e:	66 90                	xchg   %ax,%ax

000005a0 <fork_children2>:
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	53                   	push   %ebx
  for (i = 0; i < NUM_THREAD; i++)
 5a4:	31 db                	xor    %ebx,%ebx
{
 5a6:	83 ec 04             	sub    $0x4,%esp
    if ((p = fork()) == 0)
 5a9:	e8 2d 03 00 00       	call   8db <fork>
 5ae:	85 c0                	test   %eax,%eax
 5b0:	74 26                	je     5d8 <fork_children2+0x38>
      int r = setpriority(p, i);
 5b2:	83 ec 08             	sub    $0x8,%esp
 5b5:	53                   	push   %ebx
 5b6:	50                   	push   %eax
 5b7:	e8 d7 03 00 00       	call   993 <setpriority>
      if (r < 0)
 5bc:	83 c4 10             	add    $0x10,%esp
 5bf:	85 c0                	test   %eax,%eax
 5c1:	78 2b                	js     5ee <fork_children2+0x4e>
  for (i = 0; i < NUM_THREAD; i++)
 5c3:	83 c3 01             	add    $0x1,%ebx
 5c6:	83 fb 04             	cmp    $0x4,%ebx
 5c9:	75 de                	jne    5a9 <fork_children2+0x9>
}
 5cb:	a1 ac 10 00 00       	mov    0x10ac,%eax
 5d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5d3:	c9                   	leave  
 5d4:	c3                   	ret    
 5d5:	8d 76 00             	lea    0x0(%esi),%esi
      sleep(10);
 5d8:	83 ec 0c             	sub    $0xc,%esp
 5db:	6a 0a                	push   $0xa
 5dd:	e8 91 03 00 00       	call   973 <sleep>
}
 5e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return getpid();
 5e5:	83 c4 10             	add    $0x10,%esp
}
 5e8:	c9                   	leave  
      return getpid();
 5e9:	e9 75 03 00 00       	jmp    963 <getpid>
        printf(1, "setpriority returned %d\n", r);
 5ee:	83 ec 04             	sub    $0x4,%esp
 5f1:	50                   	push   %eax
 5f2:	68 78 0d 00 00       	push   $0xd78
 5f7:	6a 01                	push   $0x1
 5f9:	e8 52 04 00 00       	call   a50 <printf>
        exit();
 5fe:	e8 e0 02 00 00       	call   8e3 <exit>
 603:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 60a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000610 <fork_children3>:
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	53                   	push   %ebx
  for (i = 0; i < NUM_THREAD; i++)
 614:	31 db                	xor    %ebx,%ebx
{
 616:	83 ec 04             	sub    $0x4,%esp
    if ((p = fork()) == 0)
 619:	e8 bd 02 00 00       	call   8db <fork>
 61e:	85 c0                	test   %eax,%eax
 620:	74 16                	je     638 <fork_children3+0x28>
  for (i = 0; i < NUM_THREAD; i++)
 622:	83 c3 01             	add    $0x1,%ebx
 625:	83 fb 04             	cmp    $0x4,%ebx
 628:	75 ef                	jne    619 <fork_children3+0x9>
}
 62a:	a1 ac 10 00 00       	mov    0x10ac,%eax
 62f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 632:	c9                   	leave  
 633:	c3                   	ret    
 634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      sleep(10);
 638:	83 ec 0c             	sub    $0xc,%esp
 63b:	6a 0a                	push   $0xa
 63d:	e8 31 03 00 00       	call   973 <sleep>
      max_level = i;
 642:	89 1d a8 10 00 00    	mov    %ebx,0x10a8
      return getpid();
 648:	83 c4 10             	add    $0x10,%esp
}
 64b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 64e:	c9                   	leave  
      return getpid();
 64f:	e9 0f 03 00 00       	jmp    963 <getpid>
 654:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 65f:	90                   	nop

00000660 <exit_children>:
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	83 ec 08             	sub    $0x8,%esp
  if (getpid() != parent)
 666:	e8 f8 02 00 00       	call   963 <getpid>
 66b:	3b 05 ac 10 00 00    	cmp    0x10ac,%eax
 671:	75 11                	jne    684 <exit_children+0x24>
 673:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 677:	90                   	nop
  while (wait() != -1);
 678:	e8 6e 02 00 00       	call   8eb <wait>
 67d:	83 f8 ff             	cmp    $0xffffffff,%eax
 680:	75 f6                	jne    678 <exit_children+0x18>
}
 682:	c9                   	leave  
 683:	c3                   	ret    
    exit();
 684:	e8 5a 02 00 00       	call   8e3 <exit>
 689:	66 90                	xchg   %ax,%ax
 68b:	66 90                	xchg   %ax,%ax
 68d:	66 90                	xchg   %ax,%ax
 68f:	90                   	nop

00000690 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 690:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 691:	31 c0                	xor    %eax,%eax
{
 693:	89 e5                	mov    %esp,%ebp
 695:	53                   	push   %ebx
 696:	8b 4d 08             	mov    0x8(%ebp),%ecx
 699:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 6a0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 6a4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 6a7:	83 c0 01             	add    $0x1,%eax
 6aa:	84 d2                	test   %dl,%dl
 6ac:	75 f2                	jne    6a0 <strcpy+0x10>
    ;
  return os;
}
 6ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6b1:	89 c8                	mov    %ecx,%eax
 6b3:	c9                   	leave  
 6b4:	c3                   	ret    
 6b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	53                   	push   %ebx
 6c4:	8b 55 08             	mov    0x8(%ebp),%edx
 6c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 6ca:	0f b6 02             	movzbl (%edx),%eax
 6cd:	84 c0                	test   %al,%al
 6cf:	75 17                	jne    6e8 <strcmp+0x28>
 6d1:	eb 3a                	jmp    70d <strcmp+0x4d>
 6d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6d7:	90                   	nop
 6d8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 6dc:	83 c2 01             	add    $0x1,%edx
 6df:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 6e2:	84 c0                	test   %al,%al
 6e4:	74 1a                	je     700 <strcmp+0x40>
    p++, q++;
 6e6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 6e8:	0f b6 19             	movzbl (%ecx),%ebx
 6eb:	38 c3                	cmp    %al,%bl
 6ed:	74 e9                	je     6d8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 6ef:	29 d8                	sub    %ebx,%eax
}
 6f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6f4:	c9                   	leave  
 6f5:	c3                   	ret    
 6f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6fd:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 700:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 704:	31 c0                	xor    %eax,%eax
 706:	29 d8                	sub    %ebx,%eax
}
 708:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 70b:	c9                   	leave  
 70c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 70d:	0f b6 19             	movzbl (%ecx),%ebx
 710:	31 c0                	xor    %eax,%eax
 712:	eb db                	jmp    6ef <strcmp+0x2f>
 714:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 71b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 71f:	90                   	nop

00000720 <strlen>:

uint
strlen(const char *s)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 726:	80 3a 00             	cmpb   $0x0,(%edx)
 729:	74 15                	je     740 <strlen+0x20>
 72b:	31 c0                	xor    %eax,%eax
 72d:	8d 76 00             	lea    0x0(%esi),%esi
 730:	83 c0 01             	add    $0x1,%eax
 733:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 737:	89 c1                	mov    %eax,%ecx
 739:	75 f5                	jne    730 <strlen+0x10>
    ;
  return n;
}
 73b:	89 c8                	mov    %ecx,%eax
 73d:	5d                   	pop    %ebp
 73e:	c3                   	ret    
 73f:	90                   	nop
  for(n = 0; s[n]; n++)
 740:	31 c9                	xor    %ecx,%ecx
}
 742:	5d                   	pop    %ebp
 743:	89 c8                	mov    %ecx,%eax
 745:	c3                   	ret    
 746:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 74d:	8d 76 00             	lea    0x0(%esi),%esi

00000750 <memset>:

void*
memset(void *dst, int c, uint n)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 757:	8b 4d 10             	mov    0x10(%ebp),%ecx
 75a:	8b 45 0c             	mov    0xc(%ebp),%eax
 75d:	89 d7                	mov    %edx,%edi
 75f:	fc                   	cld    
 760:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 762:	8b 7d fc             	mov    -0x4(%ebp),%edi
 765:	89 d0                	mov    %edx,%eax
 767:	c9                   	leave  
 768:	c3                   	ret    
 769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000770 <strchr>:

char*
strchr(const char *s, char c)
{
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	8b 45 08             	mov    0x8(%ebp),%eax
 776:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 77a:	0f b6 10             	movzbl (%eax),%edx
 77d:	84 d2                	test   %dl,%dl
 77f:	75 12                	jne    793 <strchr+0x23>
 781:	eb 1d                	jmp    7a0 <strchr+0x30>
 783:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 787:	90                   	nop
 788:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 78c:	83 c0 01             	add    $0x1,%eax
 78f:	84 d2                	test   %dl,%dl
 791:	74 0d                	je     7a0 <strchr+0x30>
    if(*s == c)
 793:	38 d1                	cmp    %dl,%cl
 795:	75 f1                	jne    788 <strchr+0x18>
      return (char*)s;
  return 0;
}
 797:	5d                   	pop    %ebp
 798:	c3                   	ret    
 799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 7a0:	31 c0                	xor    %eax,%eax
}
 7a2:	5d                   	pop    %ebp
 7a3:	c3                   	ret    
 7a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7af:	90                   	nop

000007b0 <gets>:

char*
gets(char *buf, int max)
{
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	57                   	push   %edi
 7b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 7b5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 7b8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 7b9:	31 db                	xor    %ebx,%ebx
{
 7bb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 7be:	eb 27                	jmp    7e7 <gets+0x37>
    cc = read(0, &c, 1);
 7c0:	83 ec 04             	sub    $0x4,%esp
 7c3:	6a 01                	push   $0x1
 7c5:	57                   	push   %edi
 7c6:	6a 00                	push   $0x0
 7c8:	e8 2e 01 00 00       	call   8fb <read>
    if(cc < 1)
 7cd:	83 c4 10             	add    $0x10,%esp
 7d0:	85 c0                	test   %eax,%eax
 7d2:	7e 1d                	jle    7f1 <gets+0x41>
      break;
    buf[i++] = c;
 7d4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 7d8:	8b 55 08             	mov    0x8(%ebp),%edx
 7db:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 7df:	3c 0a                	cmp    $0xa,%al
 7e1:	74 1d                	je     800 <gets+0x50>
 7e3:	3c 0d                	cmp    $0xd,%al
 7e5:	74 19                	je     800 <gets+0x50>
  for(i=0; i+1 < max; ){
 7e7:	89 de                	mov    %ebx,%esi
 7e9:	83 c3 01             	add    $0x1,%ebx
 7ec:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 7ef:	7c cf                	jl     7c0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 7f1:	8b 45 08             	mov    0x8(%ebp),%eax
 7f4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 7f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7fb:	5b                   	pop    %ebx
 7fc:	5e                   	pop    %esi
 7fd:	5f                   	pop    %edi
 7fe:	5d                   	pop    %ebp
 7ff:	c3                   	ret    
  buf[i] = '\0';
 800:	8b 45 08             	mov    0x8(%ebp),%eax
 803:	89 de                	mov    %ebx,%esi
 805:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 809:	8d 65 f4             	lea    -0xc(%ebp),%esp
 80c:	5b                   	pop    %ebx
 80d:	5e                   	pop    %esi
 80e:	5f                   	pop    %edi
 80f:	5d                   	pop    %ebp
 810:	c3                   	ret    
 811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 818:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 81f:	90                   	nop

00000820 <stat>:

int
stat(const char *n, struct stat *st)
{
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	56                   	push   %esi
 824:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 825:	83 ec 08             	sub    $0x8,%esp
 828:	6a 00                	push   $0x0
 82a:	ff 75 08             	push   0x8(%ebp)
 82d:	e8 f1 00 00 00       	call   923 <open>
  if(fd < 0)
 832:	83 c4 10             	add    $0x10,%esp
 835:	85 c0                	test   %eax,%eax
 837:	78 27                	js     860 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 839:	83 ec 08             	sub    $0x8,%esp
 83c:	ff 75 0c             	push   0xc(%ebp)
 83f:	89 c3                	mov    %eax,%ebx
 841:	50                   	push   %eax
 842:	e8 f4 00 00 00       	call   93b <fstat>
  close(fd);
 847:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 84a:	89 c6                	mov    %eax,%esi
  close(fd);
 84c:	e8 ba 00 00 00       	call   90b <close>
  return r;
 851:	83 c4 10             	add    $0x10,%esp
}
 854:	8d 65 f8             	lea    -0x8(%ebp),%esp
 857:	89 f0                	mov    %esi,%eax
 859:	5b                   	pop    %ebx
 85a:	5e                   	pop    %esi
 85b:	5d                   	pop    %ebp
 85c:	c3                   	ret    
 85d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 860:	be ff ff ff ff       	mov    $0xffffffff,%esi
 865:	eb ed                	jmp    854 <stat+0x34>
 867:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 86e:	66 90                	xchg   %ax,%ax

00000870 <atoi>:

int
atoi(const char *s)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	53                   	push   %ebx
 874:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 877:	0f be 02             	movsbl (%edx),%eax
 87a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 87d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 880:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 885:	77 1e                	ja     8a5 <atoi+0x35>
 887:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 88e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 890:	83 c2 01             	add    $0x1,%edx
 893:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 896:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 89a:	0f be 02             	movsbl (%edx),%eax
 89d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 8a0:	80 fb 09             	cmp    $0x9,%bl
 8a3:	76 eb                	jbe    890 <atoi+0x20>
  return n;
}
 8a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8a8:	89 c8                	mov    %ecx,%eax
 8aa:	c9                   	leave  
 8ab:	c3                   	ret    
 8ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	57                   	push   %edi
 8b4:	8b 45 10             	mov    0x10(%ebp),%eax
 8b7:	8b 55 08             	mov    0x8(%ebp),%edx
 8ba:	56                   	push   %esi
 8bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 8be:	85 c0                	test   %eax,%eax
 8c0:	7e 13                	jle    8d5 <memmove+0x25>
 8c2:	01 d0                	add    %edx,%eax
  dst = vdst;
 8c4:	89 d7                	mov    %edx,%edi
 8c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8cd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 8d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 8d1:	39 f8                	cmp    %edi,%eax
 8d3:	75 fb                	jne    8d0 <memmove+0x20>
  return vdst;
}
 8d5:	5e                   	pop    %esi
 8d6:	89 d0                	mov    %edx,%eax
 8d8:	5f                   	pop    %edi
 8d9:	5d                   	pop    %ebp
 8da:	c3                   	ret    

000008db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 8db:	b8 01 00 00 00       	mov    $0x1,%eax
 8e0:	cd 40                	int    $0x40
 8e2:	c3                   	ret    

000008e3 <exit>:
SYSCALL(exit)
 8e3:	b8 02 00 00 00       	mov    $0x2,%eax
 8e8:	cd 40                	int    $0x40
 8ea:	c3                   	ret    

000008eb <wait>:
SYSCALL(wait)
 8eb:	b8 03 00 00 00       	mov    $0x3,%eax
 8f0:	cd 40                	int    $0x40
 8f2:	c3                   	ret    

000008f3 <pipe>:
SYSCALL(pipe)
 8f3:	b8 04 00 00 00       	mov    $0x4,%eax
 8f8:	cd 40                	int    $0x40
 8fa:	c3                   	ret    

000008fb <read>:
SYSCALL(read)
 8fb:	b8 05 00 00 00       	mov    $0x5,%eax
 900:	cd 40                	int    $0x40
 902:	c3                   	ret    

00000903 <write>:
SYSCALL(write)
 903:	b8 10 00 00 00       	mov    $0x10,%eax
 908:	cd 40                	int    $0x40
 90a:	c3                   	ret    

0000090b <close>:
SYSCALL(close)
 90b:	b8 15 00 00 00       	mov    $0x15,%eax
 910:	cd 40                	int    $0x40
 912:	c3                   	ret    

00000913 <kill>:
SYSCALL(kill)
 913:	b8 06 00 00 00       	mov    $0x6,%eax
 918:	cd 40                	int    $0x40
 91a:	c3                   	ret    

0000091b <exec>:
SYSCALL(exec)
 91b:	b8 07 00 00 00       	mov    $0x7,%eax
 920:	cd 40                	int    $0x40
 922:	c3                   	ret    

00000923 <open>:
SYSCALL(open)
 923:	b8 0f 00 00 00       	mov    $0xf,%eax
 928:	cd 40                	int    $0x40
 92a:	c3                   	ret    

0000092b <mknod>:
SYSCALL(mknod)
 92b:	b8 11 00 00 00       	mov    $0x11,%eax
 930:	cd 40                	int    $0x40
 932:	c3                   	ret    

00000933 <unlink>:
SYSCALL(unlink)
 933:	b8 12 00 00 00       	mov    $0x12,%eax
 938:	cd 40                	int    $0x40
 93a:	c3                   	ret    

0000093b <fstat>:
SYSCALL(fstat)
 93b:	b8 08 00 00 00       	mov    $0x8,%eax
 940:	cd 40                	int    $0x40
 942:	c3                   	ret    

00000943 <link>:
SYSCALL(link)
 943:	b8 13 00 00 00       	mov    $0x13,%eax
 948:	cd 40                	int    $0x40
 94a:	c3                   	ret    

0000094b <mkdir>:
SYSCALL(mkdir)
 94b:	b8 14 00 00 00       	mov    $0x14,%eax
 950:	cd 40                	int    $0x40
 952:	c3                   	ret    

00000953 <chdir>:
SYSCALL(chdir)
 953:	b8 09 00 00 00       	mov    $0x9,%eax
 958:	cd 40                	int    $0x40
 95a:	c3                   	ret    

0000095b <dup>:
SYSCALL(dup)
 95b:	b8 0a 00 00 00       	mov    $0xa,%eax
 960:	cd 40                	int    $0x40
 962:	c3                   	ret    

00000963 <getpid>:
SYSCALL(getpid)
 963:	b8 0b 00 00 00       	mov    $0xb,%eax
 968:	cd 40                	int    $0x40
 96a:	c3                   	ret    

0000096b <sbrk>:
SYSCALL(sbrk)
 96b:	b8 0c 00 00 00       	mov    $0xc,%eax
 970:	cd 40                	int    $0x40
 972:	c3                   	ret    

00000973 <sleep>:
SYSCALL(sleep)
 973:	b8 0d 00 00 00       	mov    $0xd,%eax
 978:	cd 40                	int    $0x40
 97a:	c3                   	ret    

0000097b <uptime>:
SYSCALL(uptime)
 97b:	b8 0e 00 00 00       	mov    $0xe,%eax
 980:	cd 40                	int    $0x40
 982:	c3                   	ret    

00000983 <yield>:
SYSCALL(yield)
 983:	b8 16 00 00 00       	mov    $0x16,%eax
 988:	cd 40                	int    $0x40
 98a:	c3                   	ret    

0000098b <getlev>:
SYSCALL(getlev)
 98b:	b8 17 00 00 00       	mov    $0x17,%eax
 990:	cd 40                	int    $0x40
 992:	c3                   	ret    

00000993 <setpriority>:
SYSCALL(setpriority)
 993:	b8 18 00 00 00       	mov    $0x18,%eax
 998:	cd 40                	int    $0x40
 99a:	c3                   	ret    
 99b:	66 90                	xchg   %ax,%ax
 99d:	66 90                	xchg   %ax,%ax
 99f:	90                   	nop

000009a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 9a0:	55                   	push   %ebp
 9a1:	89 e5                	mov    %esp,%ebp
 9a3:	57                   	push   %edi
 9a4:	56                   	push   %esi
 9a5:	53                   	push   %ebx
 9a6:	83 ec 3c             	sub    $0x3c,%esp
 9a9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 9ac:	89 d1                	mov    %edx,%ecx
{
 9ae:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 9b1:	85 d2                	test   %edx,%edx
 9b3:	0f 89 7f 00 00 00    	jns    a38 <printint+0x98>
 9b9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 9bd:	74 79                	je     a38 <printint+0x98>
    neg = 1;
 9bf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 9c6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 9c8:	31 db                	xor    %ebx,%ebx
 9ca:	8d 75 d7             	lea    -0x29(%ebp),%esi
 9cd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 9d0:	89 c8                	mov    %ecx,%eax
 9d2:	31 d2                	xor    %edx,%edx
 9d4:	89 cf                	mov    %ecx,%edi
 9d6:	f7 75 c4             	divl   -0x3c(%ebp)
 9d9:	0f b6 92 94 10 00 00 	movzbl 0x1094(%edx),%edx
 9e0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 9e3:	89 d8                	mov    %ebx,%eax
 9e5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 9e8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 9eb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 9ee:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 9f1:	76 dd                	jbe    9d0 <printint+0x30>
  if(neg)
 9f3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 9f6:	85 c9                	test   %ecx,%ecx
 9f8:	74 0c                	je     a06 <printint+0x66>
    buf[i++] = '-';
 9fa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 9ff:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 a01:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 a06:	8b 7d b8             	mov    -0x48(%ebp),%edi
 a09:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 a0d:	eb 07                	jmp    a16 <printint+0x76>
 a0f:	90                   	nop
    putc(fd, buf[i]);
 a10:	0f b6 13             	movzbl (%ebx),%edx
 a13:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 a16:	83 ec 04             	sub    $0x4,%esp
 a19:	88 55 d7             	mov    %dl,-0x29(%ebp)
 a1c:	6a 01                	push   $0x1
 a1e:	56                   	push   %esi
 a1f:	57                   	push   %edi
 a20:	e8 de fe ff ff       	call   903 <write>
  while(--i >= 0)
 a25:	83 c4 10             	add    $0x10,%esp
 a28:	39 de                	cmp    %ebx,%esi
 a2a:	75 e4                	jne    a10 <printint+0x70>
}
 a2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a2f:	5b                   	pop    %ebx
 a30:	5e                   	pop    %esi
 a31:	5f                   	pop    %edi
 a32:	5d                   	pop    %ebp
 a33:	c3                   	ret    
 a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 a38:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 a3f:	eb 87                	jmp    9c8 <printint+0x28>
 a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a4f:	90                   	nop

00000a50 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 a50:	55                   	push   %ebp
 a51:	89 e5                	mov    %esp,%ebp
 a53:	57                   	push   %edi
 a54:	56                   	push   %esi
 a55:	53                   	push   %ebx
 a56:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 a59:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 a5c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 a5f:	0f b6 13             	movzbl (%ebx),%edx
 a62:	84 d2                	test   %dl,%dl
 a64:	74 6a                	je     ad0 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 a66:	8d 45 10             	lea    0x10(%ebp),%eax
 a69:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 a6c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 a6f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 a71:	89 45 d0             	mov    %eax,-0x30(%ebp)
 a74:	eb 36                	jmp    aac <printf+0x5c>
 a76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a7d:	8d 76 00             	lea    0x0(%esi),%esi
 a80:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 a83:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 a88:	83 f8 25             	cmp    $0x25,%eax
 a8b:	74 15                	je     aa2 <printf+0x52>
  write(fd, &c, 1);
 a8d:	83 ec 04             	sub    $0x4,%esp
 a90:	88 55 e7             	mov    %dl,-0x19(%ebp)
 a93:	6a 01                	push   $0x1
 a95:	57                   	push   %edi
 a96:	56                   	push   %esi
 a97:	e8 67 fe ff ff       	call   903 <write>
 a9c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 a9f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 aa2:	0f b6 13             	movzbl (%ebx),%edx
 aa5:	83 c3 01             	add    $0x1,%ebx
 aa8:	84 d2                	test   %dl,%dl
 aaa:	74 24                	je     ad0 <printf+0x80>
    c = fmt[i] & 0xff;
 aac:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 aaf:	85 c9                	test   %ecx,%ecx
 ab1:	74 cd                	je     a80 <printf+0x30>
      }
    } else if(state == '%'){
 ab3:	83 f9 25             	cmp    $0x25,%ecx
 ab6:	75 ea                	jne    aa2 <printf+0x52>
      if(c == 'd'){
 ab8:	83 f8 25             	cmp    $0x25,%eax
 abb:	0f 84 07 01 00 00    	je     bc8 <printf+0x178>
 ac1:	83 e8 63             	sub    $0x63,%eax
 ac4:	83 f8 15             	cmp    $0x15,%eax
 ac7:	77 17                	ja     ae0 <printf+0x90>
 ac9:	ff 24 85 3c 10 00 00 	jmp    *0x103c(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 ad0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ad3:	5b                   	pop    %ebx
 ad4:	5e                   	pop    %esi
 ad5:	5f                   	pop    %edi
 ad6:	5d                   	pop    %ebp
 ad7:	c3                   	ret    
 ad8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 adf:	90                   	nop
  write(fd, &c, 1);
 ae0:	83 ec 04             	sub    $0x4,%esp
 ae3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 ae6:	6a 01                	push   $0x1
 ae8:	57                   	push   %edi
 ae9:	56                   	push   %esi
 aea:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 aee:	e8 10 fe ff ff       	call   903 <write>
        putc(fd, c);
 af3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 af7:	83 c4 0c             	add    $0xc,%esp
 afa:	88 55 e7             	mov    %dl,-0x19(%ebp)
 afd:	6a 01                	push   $0x1
 aff:	57                   	push   %edi
 b00:	56                   	push   %esi
 b01:	e8 fd fd ff ff       	call   903 <write>
        putc(fd, c);
 b06:	83 c4 10             	add    $0x10,%esp
      state = 0;
 b09:	31 c9                	xor    %ecx,%ecx
 b0b:	eb 95                	jmp    aa2 <printf+0x52>
 b0d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 b10:	83 ec 0c             	sub    $0xc,%esp
 b13:	b9 10 00 00 00       	mov    $0x10,%ecx
 b18:	6a 00                	push   $0x0
 b1a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 b1d:	8b 10                	mov    (%eax),%edx
 b1f:	89 f0                	mov    %esi,%eax
 b21:	e8 7a fe ff ff       	call   9a0 <printint>
        ap++;
 b26:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 b2a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 b2d:	31 c9                	xor    %ecx,%ecx
 b2f:	e9 6e ff ff ff       	jmp    aa2 <printf+0x52>
 b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 b38:	8b 45 d0             	mov    -0x30(%ebp),%eax
 b3b:	8b 10                	mov    (%eax),%edx
        ap++;
 b3d:	83 c0 04             	add    $0x4,%eax
 b40:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 b43:	85 d2                	test   %edx,%edx
 b45:	0f 84 8d 00 00 00    	je     bd8 <printf+0x188>
        while(*s != 0){
 b4b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 b4e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 b50:	84 c0                	test   %al,%al
 b52:	0f 84 4a ff ff ff    	je     aa2 <printf+0x52>
 b58:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 b5b:	89 d3                	mov    %edx,%ebx
 b5d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 b60:	83 ec 04             	sub    $0x4,%esp
          s++;
 b63:	83 c3 01             	add    $0x1,%ebx
 b66:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 b69:	6a 01                	push   $0x1
 b6b:	57                   	push   %edi
 b6c:	56                   	push   %esi
 b6d:	e8 91 fd ff ff       	call   903 <write>
        while(*s != 0){
 b72:	0f b6 03             	movzbl (%ebx),%eax
 b75:	83 c4 10             	add    $0x10,%esp
 b78:	84 c0                	test   %al,%al
 b7a:	75 e4                	jne    b60 <printf+0x110>
      state = 0;
 b7c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 b7f:	31 c9                	xor    %ecx,%ecx
 b81:	e9 1c ff ff ff       	jmp    aa2 <printf+0x52>
 b86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b8d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 b90:	83 ec 0c             	sub    $0xc,%esp
 b93:	b9 0a 00 00 00       	mov    $0xa,%ecx
 b98:	6a 01                	push   $0x1
 b9a:	e9 7b ff ff ff       	jmp    b1a <printf+0xca>
 b9f:	90                   	nop
        putc(fd, *ap);
 ba0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 ba3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 ba6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 ba8:	6a 01                	push   $0x1
 baa:	57                   	push   %edi
 bab:	56                   	push   %esi
        putc(fd, *ap);
 bac:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 baf:	e8 4f fd ff ff       	call   903 <write>
        ap++;
 bb4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 bb8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 bbb:	31 c9                	xor    %ecx,%ecx
 bbd:	e9 e0 fe ff ff       	jmp    aa2 <printf+0x52>
 bc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 bc8:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 bcb:	83 ec 04             	sub    $0x4,%esp
 bce:	e9 2a ff ff ff       	jmp    afd <printf+0xad>
 bd3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 bd7:	90                   	nop
          s = "(null)";
 bd8:	ba 35 10 00 00       	mov    $0x1035,%edx
        while(*s != 0){
 bdd:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 be0:	b8 28 00 00 00       	mov    $0x28,%eax
 be5:	89 d3                	mov    %edx,%ebx
 be7:	e9 74 ff ff ff       	jmp    b60 <printf+0x110>
 bec:	66 90                	xchg   %ax,%ax
 bee:	66 90                	xchg   %ax,%ax

00000bf0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 bf0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bf1:	a1 b0 10 00 00       	mov    0x10b0,%eax
{
 bf6:	89 e5                	mov    %esp,%ebp
 bf8:	57                   	push   %edi
 bf9:	56                   	push   %esi
 bfa:	53                   	push   %ebx
 bfb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 bfe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c08:	89 c2                	mov    %eax,%edx
 c0a:	8b 00                	mov    (%eax),%eax
 c0c:	39 ca                	cmp    %ecx,%edx
 c0e:	73 30                	jae    c40 <free+0x50>
 c10:	39 c1                	cmp    %eax,%ecx
 c12:	72 04                	jb     c18 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c14:	39 c2                	cmp    %eax,%edx
 c16:	72 f0                	jb     c08 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c18:	8b 73 fc             	mov    -0x4(%ebx),%esi
 c1b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 c1e:	39 f8                	cmp    %edi,%eax
 c20:	74 30                	je     c52 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 c22:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 c25:	8b 42 04             	mov    0x4(%edx),%eax
 c28:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 c2b:	39 f1                	cmp    %esi,%ecx
 c2d:	74 3a                	je     c69 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 c2f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 c31:	5b                   	pop    %ebx
  freep = p;
 c32:	89 15 b0 10 00 00    	mov    %edx,0x10b0
}
 c38:	5e                   	pop    %esi
 c39:	5f                   	pop    %edi
 c3a:	5d                   	pop    %ebp
 c3b:	c3                   	ret    
 c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c40:	39 c2                	cmp    %eax,%edx
 c42:	72 c4                	jb     c08 <free+0x18>
 c44:	39 c1                	cmp    %eax,%ecx
 c46:	73 c0                	jae    c08 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 c48:	8b 73 fc             	mov    -0x4(%ebx),%esi
 c4b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 c4e:	39 f8                	cmp    %edi,%eax
 c50:	75 d0                	jne    c22 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 c52:	03 70 04             	add    0x4(%eax),%esi
 c55:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 c58:	8b 02                	mov    (%edx),%eax
 c5a:	8b 00                	mov    (%eax),%eax
 c5c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 c5f:	8b 42 04             	mov    0x4(%edx),%eax
 c62:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 c65:	39 f1                	cmp    %esi,%ecx
 c67:	75 c6                	jne    c2f <free+0x3f>
    p->s.size += bp->s.size;
 c69:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 c6c:	89 15 b0 10 00 00    	mov    %edx,0x10b0
    p->s.size += bp->s.size;
 c72:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 c75:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 c78:	89 0a                	mov    %ecx,(%edx)
}
 c7a:	5b                   	pop    %ebx
 c7b:	5e                   	pop    %esi
 c7c:	5f                   	pop    %edi
 c7d:	5d                   	pop    %ebp
 c7e:	c3                   	ret    
 c7f:	90                   	nop

00000c80 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c80:	55                   	push   %ebp
 c81:	89 e5                	mov    %esp,%ebp
 c83:	57                   	push   %edi
 c84:	56                   	push   %esi
 c85:	53                   	push   %ebx
 c86:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c89:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 c8c:	8b 3d b0 10 00 00    	mov    0x10b0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c92:	8d 70 07             	lea    0x7(%eax),%esi
 c95:	c1 ee 03             	shr    $0x3,%esi
 c98:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 c9b:	85 ff                	test   %edi,%edi
 c9d:	0f 84 9d 00 00 00    	je     d40 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ca3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 ca5:	8b 4a 04             	mov    0x4(%edx),%ecx
 ca8:	39 f1                	cmp    %esi,%ecx
 caa:	73 6a                	jae    d16 <malloc+0x96>
 cac:	bb 00 10 00 00       	mov    $0x1000,%ebx
 cb1:	39 de                	cmp    %ebx,%esi
 cb3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 cb6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 cbd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 cc0:	eb 17                	jmp    cd9 <malloc+0x59>
 cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cc8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 cca:	8b 48 04             	mov    0x4(%eax),%ecx
 ccd:	39 f1                	cmp    %esi,%ecx
 ccf:	73 4f                	jae    d20 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 cd1:	8b 3d b0 10 00 00    	mov    0x10b0,%edi
 cd7:	89 c2                	mov    %eax,%edx
 cd9:	39 d7                	cmp    %edx,%edi
 cdb:	75 eb                	jne    cc8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 cdd:	83 ec 0c             	sub    $0xc,%esp
 ce0:	ff 75 e4             	push   -0x1c(%ebp)
 ce3:	e8 83 fc ff ff       	call   96b <sbrk>
  if(p == (char*)-1)
 ce8:	83 c4 10             	add    $0x10,%esp
 ceb:	83 f8 ff             	cmp    $0xffffffff,%eax
 cee:	74 1c                	je     d0c <malloc+0x8c>
  hp->s.size = nu;
 cf0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 cf3:	83 ec 0c             	sub    $0xc,%esp
 cf6:	83 c0 08             	add    $0x8,%eax
 cf9:	50                   	push   %eax
 cfa:	e8 f1 fe ff ff       	call   bf0 <free>
  return freep;
 cff:	8b 15 b0 10 00 00    	mov    0x10b0,%edx
      if((p = morecore(nunits)) == 0)
 d05:	83 c4 10             	add    $0x10,%esp
 d08:	85 d2                	test   %edx,%edx
 d0a:	75 bc                	jne    cc8 <malloc+0x48>
        return 0;
  }
}
 d0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 d0f:	31 c0                	xor    %eax,%eax
}
 d11:	5b                   	pop    %ebx
 d12:	5e                   	pop    %esi
 d13:	5f                   	pop    %edi
 d14:	5d                   	pop    %ebp
 d15:	c3                   	ret    
    if(p->s.size >= nunits){
 d16:	89 d0                	mov    %edx,%eax
 d18:	89 fa                	mov    %edi,%edx
 d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 d20:	39 ce                	cmp    %ecx,%esi
 d22:	74 4c                	je     d70 <malloc+0xf0>
        p->s.size -= nunits;
 d24:	29 f1                	sub    %esi,%ecx
 d26:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 d29:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 d2c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 d2f:	89 15 b0 10 00 00    	mov    %edx,0x10b0
}
 d35:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 d38:	83 c0 08             	add    $0x8,%eax
}
 d3b:	5b                   	pop    %ebx
 d3c:	5e                   	pop    %esi
 d3d:	5f                   	pop    %edi
 d3e:	5d                   	pop    %ebp
 d3f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 d40:	c7 05 b0 10 00 00 b4 	movl   $0x10b4,0x10b0
 d47:	10 00 00 
    base.s.size = 0;
 d4a:	bf b4 10 00 00       	mov    $0x10b4,%edi
    base.s.ptr = freep = prevp = &base;
 d4f:	c7 05 b4 10 00 00 b4 	movl   $0x10b4,0x10b4
 d56:	10 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d59:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 d5b:	c7 05 b8 10 00 00 00 	movl   $0x0,0x10b8
 d62:	00 00 00 
    if(p->s.size >= nunits){
 d65:	e9 42 ff ff ff       	jmp    cac <malloc+0x2c>
 d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 d70:	8b 08                	mov    (%eax),%ecx
 d72:	89 0a                	mov    %ecx,(%edx)
 d74:	eb b9                	jmp    d2f <malloc+0xaf>
