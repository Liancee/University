#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <sys/stat.h>

#define PATH_MAX 260

void usage(const char *);
void checkParameter(const char *, const char *);
void searchEvenFiles(const char *);

int main(int argc, char *argv[])
{
  if (argc != 2) usage(argv[0]);

  const char *dirPath = argv[1];
  const char *executablePath = argv[0];

  checkParameter(executablePath, dirPath);

  return EXIT_SUCCESS;
}

void checkParameter(const char *executablePath, const char *dirPath)
{
  // get file stats
  struct stat st;
  if (stat(dirPath, &st) == -1)
  {
    fprintf(stderr, "Error getting folder status\n");
    usage(executablePath);
  }

  // since the task requires the program parameter user input to be a path, we check for that with a POSIX macro
  if (!S_ISDIR(st.st_mode))
  {
    fprintf(stderr, "%s is not a directory\n", dirPath);
    usage(executablePath);
  }

  // folder was verified, and we start searching recursively for files with an even inode
  printf("Files with even inodes in %s:\n", dirPath);
  searchEvenFiles(dirPath);
}

void searchEvenFiles(const char *dirPath)
{
  DIR *dir = opendir(dirPath);
  if (!dir)
  {
    fprintf(stderr, "Error opening directory\n");
    exit(EXIT_FAILURE);
  }

  struct dirent *entry;
  while ((entry = readdir(dir)))
  {
    if (!strcmp(entry->d_name, ".") || !strcmp(entry->d_name, "..")) continue; // skip two default folder inodes

    // prepare full path for further usage
    char filePath[PATH_MAX];
    snprintf(filePath, sizeof(filePath), "%s/%s", dirPath, entry->d_name);

    // getting stats for the full path
    struct stat st;
    if (stat(filePath, &st) == -1)
    {
      fprintf(stderr, "Error getting file status\n");
      continue; // skip this one and go to next iteration
    }

    // check the filetype with POSIX macros
    if (S_ISDIR(st.st_mode)) searchEvenFiles(filePath); // recursively progress through subdirectories
    else if (S_ISREG(st.st_mode)) // is it a regular file?
      if (st.st_ino % 2 == 0) printf("[%lu] %s\n", (unsigned long)st.st_ino, filePath); // print file if inode is even
	  // st_ino is of type unsigned integer and if it should hold a large inode value we use unsigned long here as a precaution
  }
  closedir(dir);
}

void usage(const char * msg)
{
  fprintf(stderr, "Usage: %s <folderpath>\n", msg);
  exit(EXIT_FAILURE);
}
