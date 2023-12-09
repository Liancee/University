CC = gcc
CFLAGS = -Wall -Wfatal-errors

birne: CFLAGS += -DBirne_X
bsd: CFLAGS += -DLocked_BSE
doors: CFLAGS += -DDoors_10
banana: CFLAGS += -DBanana_Mac

birne bsd doors banana: sum.c
	$(CC) $(CFLAGS) $< -o sum_$@

clean:
	rm -f sum_birne sum_bsd sum_doors
