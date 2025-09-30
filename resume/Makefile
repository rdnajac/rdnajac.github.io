DOC = rdnajac-resume

LATEXMK = latexmk

FLAGS = -pdf -silent

all: $(DOC).pdf 

$(DOC).pdf: $(DOC).tex
	$(LATEXMK) $(FLAGS) $(DOC).tex
	cp $(DOC).pdf ~/Documents/job/

install: $(DOC).pdf
	cp -fv $(DOC).pdf ../assets/
	cp -fv $(DOC).pdf ~/Desktop/

clean:
	rm -fv ./*.{aux,log,out,synctex.gz,fdb_latexmk,fls,pdf}

.PHONY: all install clean
