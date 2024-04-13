#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]){
	char *buf = "Hello xv6!";
	int ret_val;
	ret_val = myfunction(buf);
	printf(1, "Return value : 0x%x\n", ret_val);

	//practice of making getppid()
	printf(1, "\nMy pid is %d\n, My ppid is %d\n", getpid(), getppid());

	exit();
}
