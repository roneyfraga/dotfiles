#!/usr/bin/env Rscript

suppressMessages(library(pdftools)) # dependencia para bibr
suppressMessages(library(bibr)) # https://github.com/edonnachie/bibr
suppressMessages(library(bibtex))
suppressMessages(library(rcrossref))
suppressMessages(library(optparse))
suppressMessages(library(stopwords))
suppressMessages(library(stringr))
suppressMessages(library(stringi))
suppressMessages(library(purrr))

option_list <- list(
  optparse::make_option(c("-b", "--bibtex_file"), type = "character", help = "bibtex file to insert the data, example [references.bib]"),
  optparse::make_option(c("-p", "--pdf_file"), type = "character", help = "search doi code through pdf file"),
  optparse::make_option(c("-d", "--doi"), type = "character", help = "search inserted doi code"),
  optparse::make_option(c("-k", "--key"), type = "character", help = "key, example [Bueno2021]"),
  optparse::make_option(c("-w", "--write"), action = "store_false", help = "write the bibtex code in the bib file"),
  optparse::make_option(c("-r", "--rename"), action = "store_false", help = "rename the pdf file"),
  optparse::make_option(c("-l", "--length_title"), type = "integer", default = 90, help = "title length")
)

parser <- optparse::OptionParser(option_list = option_list)
args <- optparse::parse_args(parser)

# Verificar se o DOI foi fornecido
if (is.null(args$pdf_file) && is.null(args$doi)) {
  stop("ERROR: doi code or pdf file is required. Use [-d or --doi] to specify the DOI or [-p or --pdf] to specity the pdf.")
}

# via pdf?
# pdf_file <- '/home/roney/Biblioteca/techonological-trajectories/Xu - 2024 - A novel developmental trajectory discovery approach by integrating main path analysis and intermediacy.pdf'
if (!is.null(args$pdf_file)) {
  pdf_file <- args$pdf_file

  if (!fs::file_exists(pdf_file)) stop("There is no PDF file with that name")

  doi <- bibr::pdf_extract_doi(pdf_file)

  if (is.na(doi) && is.null(args$doi)) {
    cat(stop(paste0("\nError: No DOI found in pdf_file ", args$pdf_file, "\nWould you like to insert DOI code manually via '-d' tag?\n")))
  }

  if (!is.na(doi)) {
    bib <- rcrossref::cr_cn(dois = doi, format = "bibtex")
    bib_ris <- rcrossref::cr_cn(dois = doi, format = "ris")
  }
}

# via doi?
# doi <- '10.1016/j.envdev.2024.101074'
# doi <- '10.3390/su15020967'
# doi <- '10.1007/s13593-021-00729-5'
# doi <- '10.51861/ded.dmdt.2.023'
# doi <- '10.1177/01655515221101835'
if (!is.null(args$doi)) {
  doi <- args$doi
  bib <- rcrossref::cr_cn(dois = doi, format = "bibtex")
  bib_ris <- rcrossref::cr_cn(dois = doi, format = "ris")
}

# tratar o arquivo bib
bib <- trimws(bib, which = "left")

gsub(", title", ", \n  title", bib) |>
  {
    \(x) gsub(", volume=", ", \n  volume = ", x, ignore.case = TRUE)
  }() |>
  {
    \(x) gsub(", ISSN=", ", \n  ISSN = ", x, ignore.case = TRUE)
  }() |>
  {
    \(x) gsub(", ISBN=", ", \n  ISBN = ", x, ignore.case = TRUE)
  }() |>
  {
    \(x) gsub(", BOOKTITLE=", ", \n  BOOKTITLE = ", x, ignore.case = TRUE)
  }() |>
  {
    \(x) gsub(", url=", ", \n  url = ", x, ignore.case = TRUE)
  }() |>
  {
    \(x) gsub(", number=", ", \n  number = ", x, ignore.case = TRUE)
  }() |>
  {
    \(x) gsub(", journal=", ", \n  journal = ", x, ignore.case = TRUE)
  }() |>
  {
    \(x) gsub(", publisher=", ", \n  publisher = ", x, ignore.case = TRUE)
  }() |>
  {
    \(x) gsub(", author=", ", \n  author = ", x, ignore.case = TRUE)
  }() |>
  {
    \(x) gsub(", year=", ", \n  year = ", x, ignore.case = TRUE)
  }() |>
  {
    \(x) gsub(", month=", ", \n  month = ", x, ignore.case = TRUE)
  }() |>
  {
    \(x) gsub(", pages=", ", \n  pages = ", x, ignore.case = TRUE)
  }() |>
  {
    \(x) gsub(", DOI=", ", \n  DOI = ", x, ignore.case = TRUE)
  }() |>
  {
    \(x) gsub("}\n$", "\n}\n", x, ignore.case = TRUE)
  }() |>
  {
    \(x) sub("_", "", x)
  }() ->
  bib2

# cat(bib2)

gsub("\\,.*$", "", bib2) |>
  {
    \(x) gsub("^.*\\{", "", x)
  }() ->
  key

# remove title's special characters
key2 <- stringr::str_trim(stringi::stri_trans_general(key, "Latin-ASCII"))
key2 <- gsub("[[:punct:]]", "", key2)

if (!is.null(args$key)) {
  key2 <- args$key
}

if (key != key2) {
  bib2 <- gsub(paste0("\\{", key, ","), paste0("\\{", key2, ","), bib2)
}

# show the bibtex code
cat("BibTeX code:\n", bib2, "\n")

# filename
bib_ris |>
  {
    \(x) gsub("\\n", "\n\n", x)
  }() |>
  {
    \(x) gsub("^.*\\nTI ", "", x)
  }() |>
  {
    \(x) gsub("\\n.*$", "", x)
  }() |>
  {
    \(x) gsub(" - ", "", x)
  }() |>
  {
    \(x) stringr::str_trim(stringi::stri_trans_general(x, "Latin-ASCII"))
  }() |>
  {
    \(x) gsub("?", "", x)
  }() |>
  {
    \(x) gsub("[[:punct:]]", "", x)
  }() |>
  {
    \(x) gsub("\\s+", " ", x)
  }() |>
  {
    \(x) gsub("\\s+$", "", x)
  }() |>
  stringr::str_to_sentence() ->
  title

title_lenght <- as.numeric(args$length_title)
# title_lenght <- 90

if (nchar(title) > title_lenght) {
  words_to_keep <- cumsum(nchar(stringr::str_split(title, " ")[[1]])) <= title_lenght
  title <- paste(stringr::str_split(title, " ")[[1]][words_to_keep], collapse = " ")
}

bib_ris |>
  {
    \(x) gsub("\\n", "\n\n", x)
  }() |>
  {
    \(x) gsub("^.*\\nPY ", "", x)
  }() |>
  {
    \(x) gsub("\\n.*$", "", x)
  }() |>
  {
    \(x) gsub(" - ", "", x)
  }() ->
  year

key |>
  {
    \(x) gsub("[[:digit:]]", "", x)
  }() |>
  {
    \(x) stringr::str_trim(stringi::stri_trans_general(x, "Latin-ASCII"))
  }() |>
  {
    \(x) gsub("[[:punct:]]", "", x)
  }() ->
  last_author

if (!is.null(args$key)) {
  # chave <- Bueno2021
  chave <- args$key
  last_author <- gsub("[[:digit:]]", "", chave)
  year <- gsub("[[:alpha:]]", "", chave)
}

paste(last_author, " - ", year, " - ", title, sep = "") |>
  {
    \(x) gsub("\\s+", " ", x)
  }() |>
  {
    \(x) gsub("\\s+$", "", x)
  }() |>
  {
    \(x) paste0(x, ".pdf")
  }() ->
  filename

# show pdf file name
cat("PDF file name:\n", filename, "\n")

if (!is.null(args$bibtex_file)) {
  if (!fs::file_exists(args$bibtex_file)) stop(paste0("\n", "ERROR: There is no BibTeX file named ", args$bibtex))

  bib_db <- bibtex::do_read_bib(args$bibtex_file)
  # bib_db <- bibtex::do_read_bib('teste.bib')

  bib_db |>
    purrr::map(\(x) x[grepl("doi", names(x), ignore.case = TRUE)]) |>
    purrr::map(\(x) gsub("^.*10\\.", "10.", x)) |>
    unlist() ->
    dois_db

  # duplicated key?
  lapply(bib_db, attributes) |>
    purrr::map(\(x) x$key) |>
    unlist() ->
    keys_db

  if (any(key %in% keys_db)) {
    words_to_remove <- c(stopwords("pt"), stopwords("en"))
    title_list <- unlist(strsplit(title, " "))
    title_without_stopwords <- title_list[!title_list %in% words_to_remove]
    key2 <- paste0(key, stringr::str_to_title(title_without_stopwords[[1]]))
    bib2 <- gsub(key, key2, bib2)

    if (any(key2 %in% keys_db)) {
      key2 <- paste0(key, stringr::str_to_title(title_without_stopwords[[2]]))
      bib2 <- gsub(key, key2, bib2)
    }

    if (any(key2 %in% keys_db)) {
      key2 <- paste0(key, stringr::str_to_title(title_without_stopwords[[3]]))
      bib2 <- gsub(key, key2, bib2)
    }
  }

  # does this doi already exist?
  # bib_db <- bibtex::do_read_bib('teste.bib')
  bib_db <- bibtex::do_read_bib(args$bibtex_file)

  bib_db |>
    purrr::map(\(x) x[grep("doi", names(x), ignore.case = TRUE)]) |>
    purrr::map(\(x) gsub("^.*10\\.", "10.", x)) |>
    unlist() ->
    dois_db

  if (any(doi %in% dois_db)) {
    cat("\nWARNING: ", "DOI already in the BibTeX file.", "\n")
  }
}

# write bibtex code in bibtex file
if (!is.null(args$write)) {
  if (is.null(args$bibtex_file)) {
    stop("There is no BibTeX file.")
  }

  if (any(doi %in% dois_db)) {
    stop("DANGER: ", "DOI already in the BibTeX file.")
  }

  cat(bib2, file = args$bibtex_file, append = TRUE)
  cat("\nDONE:", "BibTeX added to the file", args$bibtex_file, "\n")
}

# write bibtex code in bibtex file
if (!is.null(args$rename)) {
  name_with_path <- stringr::str_split(args$pdf_file, "/")[[1]]
  name_with_path[length(name_with_path)] <- filename
  name_with_path_v2 <- paste(name_with_path, collapse = "/")

  file.rename(args$pdf_file, name_with_path_v2)

  cat("\nDONE:", "PDF renamed.", "\n")
}
