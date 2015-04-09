# Makefile to make beamer slides or handouts.
# Based on ideas from Norbert Preining
# see http://www.preining.info/blog/2015/04/managing-slides-and-handouts-in-latex/

LATEX=xelatex
%.pdf: %.tex
	$(LATEX) $<

%-handout.pdf: %.tex
	$(LATEX) -jobname $*-handout '\newif\ifhandout\handouttrue\PassOptionsToClass{handout}{beamer}\input{$<}'

clean:
	rm -rf *.aux
	rm -rf *.log
	rm -rf *.nav
	rm -rf *.out
	rm -rf *.snm
	rm -rf *.toc 

distclean: clean
	rm -rf *.pdf 
	