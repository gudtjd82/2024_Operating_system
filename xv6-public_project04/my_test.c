#include "types.h"
#include "user.h"

int 
main(void)
{
    int cnt, numPG, numPG2;
    cnt = countfp();
    numPG = countvp();
    numPG2 = countpp();
    printf(1, "The num of total free page in the system: %d\n", cnt);
    printf(1, "The num of page in the current process (countvp): %d\n", numPG);
    printf(1, "The num of page in the current process (countpp): %d\n", numPG2);
    exit();
}