# Makefile for roadbikebib
# (fork of Makefile of latexframework)
#
# To avoid trouble on systems where the SHELL variable might bei inherited
# from the environment. This is never a problem with GNU make, but the GNU
# make Manual recommends this setting (p. 149).
SHELL = /bin/sh

# subfolders of the project
# SHELF: documentations, source material (articles)
# ISHELF: like SHELF, but material, that NOT WILL BE in the dist!
SHELF := shelf
ISHELF := shelfignore

# Different make programs have incompatible suffix lists and this sometimes
# creates confusion (GNU make Manual, p. 149). The suffix list is set
# explicitly using only the suffixes needet in this Makefile.
.SUFFIXES:
.SUFFIXES: .tex .bib .pdf .dvi

# Variables for the main file, includet tex files and the bib file
MAIN := main
BIBF := $(wildcard *.bib)

# grouping the subfolders.
DIRS :=  $(SHELF)
DIRSNB := $(ISHELF)

# Variables for auxilliary files
README := README.md
GITIG := .gitignore
MKFILE := Makefile
AUXFILES := $(GITIG) $(README) $(MKFILE)

# variables to represent external programs.
PDFLATEX := pdflatex
PDFLATEXFLAGS := -interaction=batchmode
BIBTEX := bibtex 
OPEN := open
ECHO := echo

# With this option (-p) specified, no error will be reported if a directory
# given as an operand already exists.
MKDIR := mkdir -p

# Option -f "forces" a delete, i.e. doesn't error out if the file didn't exist.
# Option -r deletes recursive (for removing directories).
RM := rm -f
RMDIR := rm -rf

all: $(MAIN).pdf

# Generate the pdf file. With a bibliograpy file (bib file), four steps are
# needet (Joachim Schlosser: Wissenschaftliche Arbeiten schreiben mit LaTeX,
# S. 170).
# 1. compile the tex file, extracting the bibliogrpahy references
# 2. solve the references with BibTeX
# 3. compilie the tex file and include the bibliography
# 4. compile the tex file and include the references 
#
# If no bib file exists, then the bibtex and consecutive pdflatex runs are not
# necessary. ToDo: not testet yet a situation when more than one bib files are
# present (e.g. in case the variable BIBF contains a list of files rather then
# one file). Maybe it will need the make function "firstword"?
$(MAIN).pdf: $(MAIN).tex $(BIBF)
	@$(PDFLATEX) $(PDFLATEXFLAGS) $(MAIN).tex
ifneq ("$(wildcard $(BIBF))","")
	-$(BIBTEX) $(MAIN)
	@$(PDFLATEX) $(PDFLATEXFLAGS) $(MAIN).tex
	@$(PDFLATEX) $(PDFLATEXFLAGS) $(MAIN).tex
endif
	@$(OPEN) $(MAIN).pdf

clean:
	$(RM) *.aux *.toc *.idx *.ind *.ilg *.log *.out *.lof *.lot *.lol *.bbl *.blg

distclean: clean
	$(RM) *.pdf *.dvi

# Make folders
init: $(DIRS) $(DIRSNB)

$(DIRS) $(DIRSNB):
	$(MKDIR) $@

help:
	@$(ECHO) Type "'make help'         to see this list"
	@$(ECHO) Type "'make init'         to make (initialize) the folders $(DIRS) $(DIRSNB)"
	@$(ECHO) Type "'make clean'        to remove generated auxilliary files"
	@$(ECHO) Type "'make distclean'    to remove ALL generated files"
	@$(ECHO) Type "'make -W $(MAIN).tex'  to force a compile run"

# Übliche Pseudoziele gemäss "make ge-packt", S. 159.
.PHONY: all clean distclean init dist help
