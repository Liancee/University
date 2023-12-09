#include <stdio.h>
#include <stdlib.h>

#ifdef BIRNE_X
  #define INTEGER_TYPE long
#elif LOCKED_BSE
  #define INTEGER_TYPE int
#elif DOORS_10
  #define INTEGER_TYPE short
#else
  #error "Unsupported operating system: Banana Mac"
#endif

void usage(char *);

int main(int args, char *argv[])
{
  if (args != 4) usage(argv[0]);

  INTEGER_TYPE num1 = atoi(argv[1]);
  INTEGER_TYPE num2 = atoi(argv[2]);
  INTEGER_TYPE num3 = atoi(argv[3]);

  INTEGER_TYPE sum = num1 + num2 + num3;

  printf("Sum: %ld\n", (long)sum);

  return 0;
}

void usage(char * s)
{
  fprintf(stderr, "Usage: %s <num1> <num2> <num3>\n", s);
  exit(EXIT_FAILURE);
}