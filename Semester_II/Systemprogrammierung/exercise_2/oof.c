#include <pwd.h>
#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>

int main()
{
	int pid = getpid();
	char* user = getlogin();
	char* cwd = getcwd(NULL, 0);
	alarm(2);
	printf("Programm ID: %d\n", pid);
	printf("User: %s\n", user);
	printf("Working Directory: %s\n", cwd);
	free(cwd);
	sleep(10);

	return 0;
}
