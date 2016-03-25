latexfile ?= paper_cix
bibfile = paper_cix
figures = figs/*
latex = pdflatex -interaction=nonstopmode
SHELL=/bin/bash

all: $(latexfile).pdf test.pdf

$(latexfile).pdf: $(latexfile).aux $(latexfile).bbl $(figures) whix.sty *.tex
	while ($(latex) $(latexfile).tex; \
	grep -q "Rerun to get cross" $(latexfile).log ) do true ; \
	done

$(latexfile).bbl: $(bibfile).bib $(latexfile).aux
	$(latex) $(latexfile)
	bibtex $(latexfile)

$(latexfile).aux: $(latexfile).tex
	$(latex) $(latexfile).tex

test.pdf: test.tex whix.sty
	pdflatex test.tex

clean:
	rm -f $(latexfile).{pdf,bbl,blg,log,out,aux,lof,lot,toc}

checkrefs:
	pdflatex $(latexfile).tex | grep --color -i undefined

paper:
	pdflatex $(latexfile)
