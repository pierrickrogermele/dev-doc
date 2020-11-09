all: README.md

README.md: make_readme
	./$< >$@

bib.pdf: bib.tex
	pdflatex bib.tex
	bibtex bib
	pdflatex bib.tex

clean:
	$(RM) README.md README.html
	$(RM) *.aux *.bbl *.blg *-blx.bib *.log *.pdf *.run.xml

.PHONY: all clean
