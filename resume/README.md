# My Resume

## LaTex

The resume is written in LaTex. You can find the source code in the `resume.tex` file.

## Pandoc

Use lua filters to insert text from external files.

```bash
pandoc resume.tex -o resume.pdf --lua-filter=insert_text.lua

