#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[])
{
    int my_pid, my_gpid;
    printf(1, "My student id is 2021042842\n");

    my_pid = getpid();
    my_gpid = getgpid();
    printf(1, "My pid is %d\n", my_pid);
    printf(1, "My gpid is %d\n", my_gpid);

    exit();
}