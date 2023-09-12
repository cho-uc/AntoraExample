# Antora document generation


This repository contains a basic example for generating PDF and HTML docs including the pdf-template

Run `./runAntora` to generate the PDF and HTML docs

A bug where using reference link `xref` is spotted.
The explicit text for the link `[]` is replaced by `Section x.y.z`

If the text of the xref matches the title of the target page, then Assembler will drop the text when rewriting it. 
This allows Asciidoctor to rewrite the text as "Section x.y.z" if xrefstyle is configured. 
However, when the text is different, it preserves the text.

