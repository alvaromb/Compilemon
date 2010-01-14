P = pdflatex -halt-on-error

all: informe

informe:
	$P informe

bib:
	bibtex informe

complet:
	$P informe > /dev/null
	bibtex informe > /dev/null
	$P informe > /dev/null
	$P informe > /dev/null

clean:
	rm *.aux *.bak *.idx *.ilg *.ind *.lof *.lot *.log *.out *.toc *~ *.bbl *.blg 2> /dev/null