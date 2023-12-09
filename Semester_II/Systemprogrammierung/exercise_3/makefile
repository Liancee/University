CC = gcc
CFLAGS = -Wall

birne: CFLAGS += -DBIRNE_X
bsd: CFLAGS += -DLOCKED_BSE
doors: CFLAGS += -DDOORS_10

birne bsd doors: sum.c
	$(CC) $(CFLAGS) $< -o sum_$@

clean:
	rm -f sum_birne sum_bsd sum_doors
