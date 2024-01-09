CC = gcc
CFLAGS = -W -Wall -Wextra -Werror -pedantic -std=c11
SRC = append.c
OUT = append

all: $(OUT)

$(OUT): $(SRC)
	$(CC) $(CFLAGS) -o $(OUT) $(SRC)

clean:
	rm -f $(OUT)

.PHONY: all clean
