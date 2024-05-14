#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  printf(1, "Attempting to access bad memory...\n");
  // 잘못된 메모리 접근 시도
  int *bad_ptr = (int *)0xFFFFFFFF; // 잘못된 주소
  printf(1, "Read from bad memory: %d\n", *bad_ptr); // 여기에서 프로세스는 강제 종료되어야 함
  exit();
}
