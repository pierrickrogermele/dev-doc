all: README.md

README.md: make_readme
	./$< >$@

clean:
	$(RM) README.md README.html

.PHONY: all clean
