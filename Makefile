REPORT=main

LATEX=pdflatex
LATEX2=latex
BIBTEX=bibtex

SRCS=$(wildcard *.tex) $(wildcard tex/*.tex) $(wildcard *.sty) $(wildcard *.tikzstyles)
REFS=$(wildcard *.bib)
# FIGS=$(wildcard figs/*)

all: $(REPORT).pdf

$(REPORT).pdf: $(SRCS) $(REFS) $(FIGS)
	$(LATEX) $(REPORT)
	$(BIBTEX) $(REPORT)
	$(LATEX) $(REPORT)
	$(LATEX) $(REPORT)

.PHONY: abstract abstract.md
abstract: macros.tex abstract.tex
	pandoc $^ -t plain --wrap none
abstract.md: macros.tex abstract.tex
	pandoc $^ -t markdown

clean:
	rm -f *~ *.dvi *.aux *.log *.blg *.bbl *.toc $(REPORT).out $(REPORT).ps $(REPORT).pdf *.bak *.sav *.vtc

submission.tar.gz: figures $(SRCS) $(REFS) main.bbl
	tar czf $@ $^
