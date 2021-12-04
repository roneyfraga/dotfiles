#!/usr/bin/env Rscript

# run
# ./doi2bibtex.R doiCode

suppressMessages(library(rcrossref))

# receber o comando do terminal
args <- commandArgs(TRUE)

cat(rcrossref::cr_cn(dois = args, format = "bibtex"))

