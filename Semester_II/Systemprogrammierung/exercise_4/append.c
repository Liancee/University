#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <limits.h>

#define BUF_SIZE 4096

void usage();
void check_file(const char *);
void append(const char *, const char *);
void error(const char *);

int main(int args, char * argv[])
{
  if (args != 3) usage();

  // check here if the two given files are the same and if so call usage(); e.g. canonicalize_file_name or realpath

  check_file(argv[1]);
  check_file(argv[2]);

  append(argv[1], argv[2]);
}

void check_file(const char * file)
{
  int result;
  if (access(file, F_OK) != -1)
  {
    // The file exists, check if it is empty
    if (access(file, R_OK) != -1)
    {
      // The file is readable, check its size
      if (access(file, F_OK | R_OK | W_OK) != -1)
      {
        // The file is not empty
        result = 0;
      }
      else
      {
        // The file is empty or cannot be accessed for reading
        result = 1;
      }
    }
    else
    {
      // The file is not readable
      result = 2;
    }
  }
  else
  {
    // The file does not exist
    result = 3;
  }
  if (result) error(file);
}

void append(const char * src_file, const char * dst_file)
{
  int rfd = open(src_file, O_RDONLY);
  if (rfd < 0) error(src_file);

  int afd = open(dst_file, O_WRONLY | O_APPEND);
  if (afd < 0) error(dst_file);

  char * buf = malloc(BUF_SIZE);

  while(1)
  {
    ssize_t c = read(rfd, buf, BUF_SIZE);
    if (c < 0) error(src_file);
    if (c == 0) break;
    if (write(afd, buf, c) < 0) error(dst_file);
  }
  free(buf);
  buf = NULL;
  close(rfd);
  close(afd);
}

void usage()
{
  char msg [] = "Usage: ./append <src_file> <dst_file>\n";
  unsigned int msg_len = strlen(msg);
  write(STDOUT_FILENO, msg, msg_len);
  exit(EXIT_FAILURE);
}

void error(const char * msg)
{
  write(STDERR_FILENO, msg, strlen(msg));
  exit(errno);
}
