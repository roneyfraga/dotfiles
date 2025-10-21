#!/usr/bin/env Rscript
# Reference Manager - Extract DOI, generate BibTeX, rename PDFs
# Usage: reference.R -p file.pdf -b refs.bib -w -r

suppressMessages(library(pdftools)) # dependencia para bibr
suppressMessages(library(bibr)) # https://github.com/edonnachie/bibr
suppressMessages(library(bibtex))
suppressMessages(library(rcrossref))
suppressMessages(library(optparse))
suppressMessages(library(stopwords))
suppressMessages(library(stringr))
suppressMessages(library(stringi))
suppressMessages(library(purrr))

# Command Line Options ---------------------------------------------------------

option_list <- list(
  optparse::make_option(
    c("-p", "--pdf_file"),
    type = "character",
    help = "PDF file to extract DOI from"
  ),
  optparse::make_option(
    c("-d", "--doi"),
    type = "character",
    help = "DOI code to search (e.g., 10.1016/j.respol.2025.105343)"
  ),
  optparse::make_option(
    c("-b", "--bibtex_file"),
    type = "character",
    help = "BibTeX file to insert the data (e.g., references.bib)"
  ),
  optparse::make_option(
    c("-k", "--key"),
    type = "character",
    help = "Custom citation key (e.g., Bueno2021)"
  ),
  optparse::make_option(
    c("-w", "--write"),
    action = "store_false",
    help = "Write BibTeX code to file"
  ),
  optparse::make_option(
    c("-r", "--rename"),
    action = "store_false",
    help = "Rename PDF to 'Author - Year - Title.pdf'"
  ),
  optparse::make_option(
    c("-l", "--length_title"),
    type = "integer",
    default = 90,
    help = "Maximum title length (default: 90)"
  ),
  optparse::make_option(
    c("-v", "--verbose"),
    action = "store_true",
    default = FALSE,
    help = "Show verbose output"
  )
)

parser <- optparse::OptionParser(
  usage = "usage: %prog [options]",
  option_list = option_list,
  description = "\nExtract DOI from PDF or use provided DOI to generate BibTeX entry and rename files."
)

args <- optparse::parse_args(parser)

# Validation -------------------------------------------------------------------

if (is.null(args$pdf_file) && is.null(args$doi)) {
  stop("ERROR: PDF file or DOI is required.\n  Use -p/--pdf_file or -d/--doi")
}

# Extract DOI ------------------------------------------------------------------

if (!is.null(args$pdf_file)) {
  pdf_file <- args$pdf_file
  
  if (!fs::file_exists(pdf_file)) {
    stop(paste0("ERROR: PDF file not found: ", pdf_file))
  }
  
  if (args$verbose) cat("Extracting DOI from PDF...\n")
  
  doi <- bibr::pdf_extract_doi(pdf_file)
  
  if (is.na(doi) && is.null(args$doi)) {
    stop(paste0(
      "\nERROR: No DOI found in PDF: ", args$pdf_file,
      "\nTry providing DOI manually with -d/--doi"
    ))
  }
  
  if (!is.na(doi)) {
    if (args$verbose) cat(paste0("Found DOI: ", doi, "\n"))
    bib <- rcrossref::cr_cn(dois = doi, format = "bibtex")
    bib_ris <- rcrossref::cr_cn(dois = doi, format = "ris")
  }
}

if (!is.null(args$doi)) {
  doi <- args$doi
  if (args$verbose) cat(paste0("Using DOI: ", doi, "\n"))
  bib <- rcrossref::cr_cn(dois = doi, format = "bibtex")
  bib_ris <- rcrossref::cr_cn(dois = doi, format = "ris")
}

# Format BibTeX ----------------------------------------------------------------

bib <- trimws(bib, which = "left")

gsub(", title", ", \n  title", bib) |>
  {\(x) gsub(", volume=", ", \n  volume = ", x, ignore.case = TRUE)}() |>
  {\(x) gsub(", ISSN=", ", \n  ISSN = ", x, ignore.case = TRUE)}() |>
  {\(x) gsub(", ISBN=", ", \n  ISBN = ", x, ignore.case = TRUE)}() |>
  {\(x) gsub(", BOOKTITLE=", ", \n  BOOKTITLE = ", x, ignore.case = TRUE)}() |>
  {\(x) gsub(", url=", ", \n  url = ", x, ignore.case = TRUE)}() |>
  {\(x) gsub(", number=", ", \n  number = ", x, ignore.case = TRUE)}() |>
  {\(x) gsub(", journal=", ", \n  journal = ", x, ignore.case = TRUE)}() |>
  {\(x) gsub(", publisher=", ", \n  publisher = ", x, ignore.case = TRUE)}() |>
  {\(x) gsub(", author=", ", \n  author = ", x, ignore.case = TRUE)}() |>
  {\(x) gsub(", year=", ", \n  year = ", x, ignore.case = TRUE)}() |>
  {\(x) gsub(", month=", ", \n  month = ", x, ignore.case = TRUE)}() |>
  {\(x) gsub(", pages=", ", \n  pages = ", x, ignore.case = TRUE)}() |>
  {\(x) gsub(", DOI=", ", \n  DOI = ", x, ignore.case = TRUE)}() |>
  {\(x) gsub("}\n$", "\n}\n", x, ignore.case = TRUE)}() |>
  {\(x) sub("_", "", x)}() ->
  bib2

# Extract and clean key
gsub("\\,.*$", "", bib2) |>
  {\(x) gsub("^.*\\{", "", x)}() ->
  key

key2 <- stringr::str_trim(stringi::stri_trans_general(key, "Latin-ASCII"))
key2 <- gsub("[[:punct:]]", "", key2)

if (!is.null(args$key)) {
  key2 <- args$key
}

if (key != key2) {
  bib2 <- gsub(paste0("\\{", key, ","), paste0("\\{", key2, ","), bib2)
}

# Display BibTeX
cat("\n=== BibTeX Code ===\n")
cat(bib2, "\n")

# Generate Filename ------------------------------------------------------------

# Extract title
bib_ris |>
  {\(x) gsub("\\n", "\n\n", x)}() |>
  {\(x) gsub("^.*\\nTI ", "", x)}() |>
  {\(x) gsub("\\n.*$", "", x)}() |>
  {\(x) gsub(" - ", "", x)}() |>
  {\(x) stringr::str_trim(stringi::stri_trans_general(x, "Latin-ASCII"))}() |>
  {\(x) gsub("?", "", x)}() |>
  {\(x) gsub("[[:punct:]]", "", x)}() |>
  {\(x) gsub("\\s+", " ", x)}() |>
  {\(x) gsub("\\s+$", "", x)}() |>
  stringr::str_to_sentence() ->
  title

# Truncate title if needed
title_length <- as.numeric(args$length_title)

if (nchar(title) > title_length) {
  words_to_keep <- cumsum(nchar(stringr::str_split(title, " ")[[1]])) <= title_length
  title <- paste(stringr::str_split(title, " ")[[1]][words_to_keep], collapse = " ")
}

# Extract year
bib_ris |>
  {\(x) gsub("\\n", "\n\n", x)}() |>
  {\(x) gsub("^.*\\nPY ", "", x)}() |>
  {\(x) gsub("\\n.*$", "", x)}() |>
  {\(x) gsub(" - ", "", x)}() ->
  year

# Extract author
key |>
  {\(x) gsub("[[:digit:]]", "", x)}() |>
  {\(x) stringr::str_trim(stringi::stri_trans_general(x, "Latin-ASCII"))}() |>
  {\(x) gsub("[[:punct:]]", "", x)}() ->
  last_author

if (!is.null(args$key)) {
  chave <- args$key
  last_author <- gsub("[[:digit:]]", "", chave)
  year <- gsub("[[:alpha:]]", "", chave)
}

# Build filename
paste(last_author, " - ", year, " - ", title, sep = "") |>
  {\(x) gsub("\\s+", " ", x)}() |>
  {\(x) gsub("\\s+$", "", x)}() |>
  {\(x) paste0(x, ".pdf")}() ->
  filename

cat("\n=== PDF Filename ===\n")
cat(filename, "\n")

# Check BibTeX File ------------------------------------------------------------

if (!is.null(args$bibtex_file)) {
  if (!fs::file_exists(args$bibtex_file)) {
    stop(paste0("\nERROR: BibTeX file not found: ", args$bibtex_file))
  }
  
  bib_db <- bibtex::do_read_bib(args$bibtex_file)
  
  # Check for duplicate DOI
  bib_db |>
    purrr::map(\(x) x[grepl("doi", names(x), ignore.case = TRUE)]) |>
    purrr::map(\(x) gsub("^.*10\\.", "10.", x)) |>
    unlist() ->
    dois_db
  
  # Check for duplicate key
  lapply(bib_db, attributes) |>
    purrr::map(\(x) x$key) |>
    unlist() ->
    keys_db
  
  if (any(key2 %in% keys_db)) {
    words_to_remove <- c(stopwords("pt"), stopwords("en"))
    title_list <- unlist(strsplit(title, " "))
    title_without_stopwords <- title_list[!title_list %in% words_to_remove]
    
    key2 <- paste0(key2, stringr::str_to_title(title_without_stopwords[[1]]))
    bib2 <- gsub(key, key2, bib2)
    
    if (any(key2 %in% keys_db)) {
      key2 <- paste0(key2, stringr::str_to_title(title_without_stopwords[[2]]))
      bib2 <- gsub(key, key2, bib2)
    }
    
    if (any(key2 %in% keys_db)) {
      key2 <- paste0(key2, stringr::str_to_title(title_without_stopwords[[3]]))
      bib2 <- gsub(key, key2, bib2)
    }
  }
  
  if (any(doi %in% dois_db)) {
    cat("\n⚠️  WARNING: DOI already exists in BibTeX file\n")
  }
}

# Write BibTeX -----------------------------------------------------------------

if (!is.null(args$write)) {
  if (is.null(args$bibtex_file)) {
    stop("ERROR: BibTeX file required. Use -b/--bibtex_file")
  }
  
  if (exists("dois_db") && any(doi %in% dois_db)) {
    stop("ERROR: DOI already exists in BibTeX file. Aborting.")
  }
  
  cat(bib2, file = args$bibtex_file, append = TRUE)
  cat("\n✅ BibTeX added to:", args$bibtex_file, "\n")
}

# Rename PDF -------------------------------------------------------------------

if (!is.null(args$rename)) {
  if (is.null(args$pdf_file)) {
    stop("ERROR: PDF file required for renaming. Use -p/--pdf_file")
  }
  
  name_with_path <- stringr::str_split(args$pdf_file, "/")[[1]]
  name_with_path[length(name_with_path)] <- filename
  name_with_path_v2 <- paste(name_with_path, collapse = "/")
  
  file.rename(args$pdf_file, name_with_path_v2)
  
  cat("\n✅ PDF renamed to:", filename, "\n")
}

cat("\n")
