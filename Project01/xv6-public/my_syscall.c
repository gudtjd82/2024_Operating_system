#include "types.h"
#include "defs.h"

int
myfunction(char* str)
{
    cprintf("%s\n", str);
    return 0xABCABC;
}

int
sys_myfunction(void)
{
    char *str;

    if(argint(0, &str) < 0)
        return -1;
    
    return myfunction(str);
}