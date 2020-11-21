all: README.md

README.md: make_readme
	./$< >$@

bib.pdf: bib.tex references.bib
	pdflatex $<
	bibtex bib
	pdflatex $<

clean:
	$(RM) README.md README.html
	$(RM) *.aux *.bbl *.blg *-blx.bib *.log *.pdf *.run.xml

.PHONY: all clean
