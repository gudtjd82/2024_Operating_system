#include "types.h"
#include "user.h"

int 
main(void)
{
    int cnt, numPG;
    cnt = countfp();
    numPG = countvp();
    printf(1, "The num of total free page in the system: %d\n", cnt);
    printf(1, "The num of page in the current process: %d\n", numPG);
    exit();
}