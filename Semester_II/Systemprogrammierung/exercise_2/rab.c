#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>


int main()
{
	int rndNum = open("/dev/urandom", 0);
	char myRndNums[4];
	read(rndNum, myRndNums, sizeof myRndNums);
	printf("%08x\n", myRndNums);
        	
}
