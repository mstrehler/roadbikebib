# Literatur-Referenz Rennrad roadbike.bib

## Allgemeine Angaben

Literatur-Referenz für Rennrad im BibTex-Format.

Dateien
* roadbike.bib: Das Literaturverzeichnis im BibTeX-Format
* bibtest.tex: LaTeX-File zum Erzeugen des gesamten, formatierten Inhaltes von `roadbike.bib`
* bibtest.pdf: Verzeichnis als PDF
* README.md: diese Datei

## Anwendung

### Das Verzeichnis als git-submodul anfügen:

```bash
git subomdule add https://github.com/mstrehler/roadbikebib.git
```
Damit wird im lokalen Projektordner ein Unterverzeichnis `roadbikebib` erzeugt.

### Änderungen der `roadbike.bib` in Datei übernehmen
Wenn in der `roadbike.bib` zentrale Änderungen gemacht wurden können so die Änderungen in das Projekt übernommen werden.

```bash
cd roadbikebib
git checkout master
git pull
cd ..
git add roadbikebib
git commit -m "Update des Submodules roadbikebib"
```

