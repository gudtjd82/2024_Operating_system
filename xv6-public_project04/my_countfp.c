#include "types.h"
#include "user.h"

int 
main(void)
{
    int cnt;
    cnt = countfp();
    printf(1, "The num of total free page in the system: %d\n", cnt);
    exit();
}