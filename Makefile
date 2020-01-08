all: README.md

README.md: make_readme
	./$< >$@

clean:
	$(RM) README.md

.PHONY: all clean
