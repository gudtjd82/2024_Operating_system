#include "types.h"
// #include "defs.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    int pid;

    pid = fork();

    if(pid < 0)
    {
        printf(1, "Error\n");
        exit();
    }

    else if(pid == 0)
    {
        for(int i = 0; i< 10; i++)
        {
            printf(1, "Child\n");
            yield();
        }
    }
    else{
        for(int i = 0; i< 10; i++)
        {
            printf(1, "Parent\n");
            yield();
        }
        wait();
    }
    exit();
}