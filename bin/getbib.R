#!/usr/bin/env Rscript

# run
# ./getbib.R DOICode

suppressMessages(library(rcrossref))
suppressMessages(library(clipr))

# args <- 'https://doi.org/10.3389/fddsv.2023.1201419'
# args <- 'https://doi.org/10.3390/land11101748'

# receber o comando do terminal
args <- commandArgs(TRUE)

args <- gsub('^.*\\.org/', '', args)

bib <- rcrossref::cr_cn(dois = args, format = "bibtex")
bib <- trimws(bib, which = 'left')

gsub(', title', ', \n  title', bib) |>
  {\(x) gsub(', volume=', ', \n  volume = ', x)}() |>
  {\(x) gsub(', ISSN=', ', \n  ISSN = ', x)}() |>
  {\(x) gsub(', url=', ', \n  url = ', x)}() |>
  {\(x) gsub(', number=', ', \n  number = ', x)}() |>
  {\(x) gsub(', journal=', ', \n  journal = ', x)}() |>
  {\(x) gsub(', publisher=', ', \n  publisher = ', x)}() |>
  {\(x) gsub(', author=', ', \n  author = ', x)}() |>
  {\(x) gsub(', year=', ', \n  year = ', x)}() |>
  {\(x) gsub(', month=', ', \n  month = ', x)}() |>
  {\(x) gsub(', pages=', ', \n  pages = ', x)}() |>
  {\(x) gsub(', DOI=', ', \n  DOI = ', x)}() |>
  {\(x) gsub('}\n$', '\n}\n', x)}() |>
  {\(x) sub('_', '', x)}() ->
  bib2

cat(bib2)

clipr::write_clip(bib2, allow_non_interactive = TRUE)

