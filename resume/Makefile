# Makefile for building a LaTeX document, generating Markdown, and cleaning up

# Name of the LaTeX document without the file extension
DOC = rdnajac-resume

# Define the LaTeX engine to use
LATEXMK = latexmk

# Define the flags to pass to latexmk
FLAGS = -pdf -silent

# Default target to build the PDF and generate Markdown
all: $(DOC).pdf $(DOC).md

# Rule to build the PDF using latexmk
$(DOC).pdf: $(DOC).tex
	$(LATEXMK) $(FLAGS) $(DOC).tex

# Generate Markdown file with LaTeX code
$(DOC).md: $(DOC).tex
	@echo '<style>' > $@
	@echo 'code { font-size: 12px; }' >> $@
	@echo '</style>' >> $@
	@echo >> $@
	@echo '# LaTeX Source' >> $@
	@echo >> $@
	@echo '[Download PDF](../assets/$(DOC).pdf)' >> $@
	@echo >> $@
	@echo '```latex' >> $@
	@cat $(DOC).tex >> $@
	@echo '```' >> $@

# Install files to assets folder and Desktop
install: $(DOC).pdf $(DOC).md
	cp -fv $(DOC).pdf ../assets/
	cp -fv $(DOC).md ../assets/
	cp -fv $(DOC).pdf ~/Desktop/

# Clean up auxiliary files (alphabetized and using specific file names)
clean:
	rm -fv ./$(DOC).aux ./$(DOC).fdb_latexmk ./$(DOC).fls ./$(DOC).log \
		./$(DOC).out ./$(DOC).synctex.gz ./$(DOC).pdf ./$(DOC).md

.PHONY: all install clean
