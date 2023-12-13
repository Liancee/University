#include <stdio.h>
#include <stdlib.h>

#ifdef Birne_X
  #define DATATYPE long
#elif Locked_BSE
  #define DATATYPE int
#elif Doors_10
  #define DATATYPE short
#elif Banana_Mac
  #error "Unsupported operating system: Banana Mac"
#else
  #error "Unknown unsupported operating system"
#endif

void usage(char *);

int main(int args, char *argv[])
{
  if (args != 4) usage(argv[0]);

  DATATYPE num1 = atoi(argv[1]);
  DATATYPE num2 = atoi(argv[2]);
  DATATYPE num3 = atoi(argv[3]);

  DATATYPE sum = num1 + num2 + num3;

  printf("Sum: %ld\n\nMind that integer overflows are not recognized and\nthe value range may vary dependent on your architecture.\n", (long)sum);

  return EXIT_SUCCESS;
}

void usage(char * s)
{
  fprintf(stderr, "Usage: %s <num1> <num2> <num3>\n", s);
  exit(EXIT_FAILURE);
}