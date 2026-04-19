DOC = rdnajac-resume

LATEXMK = latexmk

FLAGS = -pdf -silent

all: $(DOC).pdf 

BULLETSDIR = original
BULLETS = $(wildcard bullets/$(BULLETSDIR)/*.tex)

$(DOC).pdf: $(DOC).tex $(BULLETS)
	$(LATEXMK) $(FLAGS) -g $(DOC).tex
	cp $(DOC).pdf ~/Documents/job/

install: $(DOC).pdf
	cp -fv $(DOC).pdf ../assets/
	cp -fv $(DOC).pdf ~/Desktop/

clean:
	rm -fv ./*.{aux,log,out,synctex.gz,fdb_latexmk,fls,pdf}

.PHONY: all install clean
