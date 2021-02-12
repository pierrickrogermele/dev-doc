CFLAGS=-g

all: binary_search

binary_search: binary_search.o
	$(CC) -o $@ $^

run: all
	./binary_search

clean:
	$(RM) binary_search *.o

.PHONY: all clean run
