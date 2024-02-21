#!/usr/bin/env Rscript

# run
# ./doi2bibtex.R DOIcode

suppressMessages(library(rcrossref))
suppressMessages(library(clipr))
suppressMessages(library(stringr))

# receber o comando do terminal
args <- commandArgs(TRUE)
args <- gsub('^.*.org\\/', '', args)

rcrossref::cr_cn(dois = args, format = "bibtex") -> bib 

gsub('[', '', 'Vargas_Carpintero_2022, title={')

clipr::write_clip(bib2, allow_non_interactive = TRUE)

# args <- '10.3390/land11101748'


