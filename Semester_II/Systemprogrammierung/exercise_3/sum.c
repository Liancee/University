#include <stdio.h>
#include <stdlib.h>

#ifdef Birne_X
  #define INTEGER_TYPE long
#elif Locked_BSE
  #define INTEGER_TYPE int
#elif Doors_10
  #define INTEGER_TYPE short
#elif Banana_Mac
  #error "Unsupported operating system: Banana Mac"
#else
  #error "Unknown unsupported operating system"
#endif

#ifndef Banana_Mac // only that when the compile #error triggers we do not get to see all the resulting syntax errors
  void usage(char *);

  int main(int args, char *argv[])
  {
    if (args != 4) usage(argv[0]);

    // in theory here would be checked if the parameter is valid for its supposed OS, but since it is no requirement for this exercise it is not done.

    INTEGER_TYPE num1 = atoi(argv[1]);
    INTEGER_TYPE num2 = atoi(argv[2]);
    INTEGER_TYPE num3 = atoi(argv[3]);

    INTEGER_TYPE sum = num1 + num2 + num3;

    printf("Sum: %ld\n", (long)sum);

    return EXIT_SUCCESS;
  }

  void usage(char * s)
  {
    fprintf(stderr, "Usage: %s <num1> <num2> <num3>\n", s);
    exit(EXIT_FAILURE);
  }
#endif