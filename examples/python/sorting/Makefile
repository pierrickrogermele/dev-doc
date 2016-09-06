progs = $(wildcard *_sort.py)

all:

run:
	@for p in $(progs) ; do \
		echo ; \
		echo $$p ; \
		./$$p ; \
	done
clean:
	$(RM) -r __pycache__ *.pyc *~

.PHONY: clean all run
