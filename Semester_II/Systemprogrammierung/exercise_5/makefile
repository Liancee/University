CC = gcc
CFLAGS = -W -Wall -Wextra -Werror -pedantic -std=c11
SRC = lseven.c
OUT = lseven

all: $(OUT)

$(OUT): $(SRC)
	$(CC) $(CFLAGS) -o $(OUT) $(SRC)

clean:
	rm -f $(OUT)

.PHONY: all clean
