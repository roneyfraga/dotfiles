#!/usr/bin/env Rscript
# reference_manager.R - Unified Reference Manager
# Combines BibTeX extraction and RAG preparation in one script
# Usage: reference_manager.R [options]

suppressMessages(library(pdftools))
suppressMessages(library(bibr))
suppressMessages(library(bibtex))
suppressMessages(library(rcrossref))
suppressMessages(library(openalexR))
suppressMessages(library(optparse))
suppressMessages(library(stopwords))
suppressMessages(library(stringr))
suppressMessages(library(stringi))
suppressMessages(library(purrr))
suppressMessages(library(dplyr))
suppressMessages(library(tidyr))
suppressMessages(library(glue))
suppressMessages(library(readr))

# Helper function
`%||%` <- function(x, y) if (!is.null(x) && length(x) > 0) x else y

# Command Line Options ---------------------------------------------------------

option_list <- list(
  # Input options
  optparse::make_option(
    c("-p", "--pdf_file"),
    type = "character",
    help = "PDF file to process"
  ),
  optparse::make_option(
    c("-d", "--doi"),
    type = "character",
    help = "DOI code (e.g., 10.1016/j.respol.2025.105343)"
  ),

  # BibTeX options
  optparse::make_option(
    c("-b", "--bibtex_file"),
    type = "character",
    help = "BibTeX file to insert/append data (e.g., references.bib)"
  ),
  optparse::make_option(
    c("-k", "--key"),
    type = "character",
    help = "Custom citation key (e.g., Bueno2021)"
  ),
  optparse::make_option(
    c("-w", "--write"),
    action = "store_true",
    default = FALSE,
    help = "Write BibTeX code to file specified by -b/--bibtex_file"
  ),
  optparse::make_option(
    c("-r", "--rename"),
    action = "store_true",
    default = FALSE,
    help = "Rename PDF to 'Author - Year - Title.pdf'"
  ),
  optparse::make_option(
    c("-B", "--local_bibtex"),
    action = "store_true",
    default = FALSE,
    help = "Write BibTeX to local hidden file (.filename.bib)"
  ),
  optparse::make_option(
    c("-l", "--length_title"),
    type = "integer",
    default = 90,
    help = "Maximum title length for PDF filename (default: 90)"
  ),

  # RAG options
  optparse::make_option(
    c("-R", "--rag"),
    action = "store_true",
    default = FALSE,
    help = "Create RAG files (CSV and Markdown)"
  ),
  optparse::make_option(
    c("--no_rag_marker"),
    action = "store_true",
    default = FALSE,
    help = "Add 'no_rag' marker to Markdown to prevent RAG indexing"
  ),

  # Workflow control
  optparse::make_option(
    c("--full"),
    action = "store_true",
    default = FALSE,
    help = "Run full workflow: extract DOI, create BibTeX, rename PDF, create CSV/Markdown"
  ),
  optparse::make_option(
    c("--bibtex_only"),
    action = "store_true",
    default = FALSE,
    help = "Only run BibTeX extraction (skip RAG preparation)"
  ),

  # General options
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
  description = paste(
    "\nUnified reference manager: extract DOI, create BibTeX, prepare RAG files.",
    "\n",
    "\nWorkflow modes:",
    "\n  --full         : Complete workflow (extract → BibTeX → rename → CSV/Markdown)",
    "\n  --bibtex_only  : Only extract DOI and create BibTeX",
    "\n  -R, --rag      : Create RAG files (CSV and Markdown)",
    "\n  (default)      : Smart mode based on options",
    "\n",
    "\nExamples:",
    "\n  # Full workflow",
    "\n  ref.R -p paper.pdf --full",
    "\n",
    "\n  # Extract BibTeX and rename",
    "\n  ref.R -p paper.pdf -B -r",
    "\n",
    "\n  # Create BibTeX + RAG files",
    "\n  ref.R -p paper.pdf -B -r -R",
    "\n",
    "\n  # Just create RAG files (requires .bib)",
    "\n  ref.R -p 'Author - 2021 - Title.pdf' -R",
    sep = ""
  )
)

args <- optparse::parse_args(parser)

# Validation -------------------------------------------------------------------

if (is.null(args$pdf_file) && is.null(args$doi)) {
  stop("ERROR: PDF file or DOI is required.\n  Use -p/--pdf_file or -d/--doi")
}

# Determine workflow -----------------------------------------------------------

run_bibtex <- FALSE
run_rag <- FALSE

if (args$bibtex_only) {
  run_bibtex <- TRUE
  run_rag <- FALSE
} else if (args$full) {
  run_bibtex <- TRUE
  run_rag <- TRUE
} else {
  # Determine based on flags
  bibtex_options_set <- !is.null(args$bibtex_file) || args$write ||
    args$rename || args$local_bibtex || !is.null(args$key)

  # If -R is set, always run RAG
  if (args$rag) {
    run_rag <- TRUE
  }

  # If BibTeX options are set, run BibTeX
  if (bibtex_options_set) {
    run_bibtex <- TRUE
  }

  # If nothing is set, default behavior
  if (!run_bibtex && !run_rag) {
    run_bibtex <- TRUE
    run_rag <- FALSE
  }
}

if (args$verbose) {
  cat("\n=== Workflow Plan ===\n")
  cat(sprintf("BibTeX Extraction: %s\n", if (run_bibtex) "✅ Yes" else "⏭️  Skip"))
  cat(sprintf("RAG Preparation:   %s\n\n", if (run_rag) "✅ Yes" else "⏭️  Skip"))
}

# Initialize variables
doi <- args$doi %||% NA_character_
bib2 <- NULL
key2 <- NULL
filename <- NULL
bib_metadata <- NULL

# ============================================================================
# PART 1: BIBTEX EXTRACTION
# ============================================================================

if (run_bibtex) {
  if (args$verbose) cat("\n=== BibTeX Extraction ===\n\n")

  # Extract DOI from PDF
  if (!is.null(args$pdf_file)) {
    pdf_file <- args$pdf_file

    if (!fs::file_exists(pdf_file)) {
      stop(paste0("ERROR: PDF file not found: ", pdf_file))
    }

    if (args$verbose) cat("Extracting DOI from PDF...\n")

    doi_extracted <- bibr::pdf_extract_doi(pdf_file)

    if (is.na(doi_extracted) && is.null(args$doi)) {
      stop(paste0(
        "\nERROR: No DOI found in PDF: ", args$pdf_file,
        "\nTry providing DOI manually with -d/--doi"
      ))
    }

    if (!is.na(doi_extracted)) {
      doi <- doi_extracted
      if (args$verbose) cat(paste0("Found DOI: ", doi, "\n"))
    }
  }

  if (!is.null(args$doi)) {
    doi <- args$doi
    if (args$verbose) cat(paste0("Using DOI: ", doi, "\n"))
  }

  # Fetch BibTeX

  # ============================================================================
  # FIX BIBTEX ENTRY TYPE ISSUES
  # ============================================================================

  fix_bibtex_entry_type <- function(bib_text) {
    # Case 1: @book with institution but no publisher → @techreport
    if (grepl("@book", bib_text, ignore.case = TRUE) &&
      grepl("institution\\s*=", bib_text, ignore.case = TRUE) &&
      !grepl("publisher\\s*=", bib_text, ignore.case = TRUE)) {
      bib_text <- sub("@book", "@techreport", bib_text, ignore.case = TRUE)
      message("ℹ️  Converted @book to @techreport (has institution field)")
      return(bib_text)
    }

    # Case 2: @book without publisher → @misc
    if (grepl("@book", bib_text, ignore.case = TRUE) &&
      !grepl("publisher\\s*=", bib_text, ignore.case = TRUE)) {
      bib_text <- sub("@book", "@misc", bib_text, ignore.case = TRUE)
      message("ℹ️  Converted @book to @misc (missing publisher)")
      return(bib_text)
    }

    return(bib_text)
  }

  bib <- rcrossref::cr_cn(dois = doi, format = "bibtex")
  bib_ris <- rcrossref::cr_cn(dois = doi, format = "ris")

  # Format BibTeX
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

  # Fix BibTeX entry type issues
  bib2 <- fix_bibtex_entry_type(bib2)

  # Fix BibTeX entry type issues
  bib2 <- fix_bibtex_entry_type(bib2)

  # Extract and clean key
  gsub("\\,.*$", "", bib2) |>
    {
      \(x) gsub("^.*\\{", "", x)
    }() ->
    key

  key2 <- stringr::str_trim(stringi::stri_trans_general(key, "Latin-ASCII"))

  # ============================================================================
  # FIX BIBTEX ENTRY TYPE ISSUES
  # ============================================================================

  #' Fix BibTeX entry type issues from CrossRef
  #'
  #' CrossRef sometimes returns incorrect entry types (e.g., @book for technical reports)
  #' This function detects and fixes common issues:
  #' - @book with institution but no publisher → @techreport
  #' - @book without publisher → @misc
  #' - @incollection without booktitle → @misc
  #'
  #' @param bib_text Character string with BibTeX entry
  #' @return Fixed BibTeX entry
  fix_bibtex_entry_type <- function(bib_text) {
    # Case 1: @book with institution but no publisher → @techreport
    if (grepl("@book", bib_text, ignore.case = TRUE) &&
      grepl("institution\\s*=", bib_text, ignore.case = TRUE) &&
      !grepl("publisher\\s*=", bib_text, ignore.case = TRUE)) {
      bib_text <- sub("@book", "@techreport", bib_text, ignore.case = TRUE)
      message("ℹ️  Converted @book to @techreport (has institution field)")
      return(bib_text)
    }

    # Case 2: @book without publisher → @misc
    if (grepl("@book", bib_text, ignore.case = TRUE) &&
      !grepl("publisher\\s*=", bib_text, ignore.case = TRUE)) {
      bib_text <- sub("@book", "@misc", bib_text, ignore.case = TRUE)
      message("ℹ️  Converted @book to @misc (missing publisher)")
      return(bib_text)
    }

    # Case 3: @incollection without booktitle → @misc
    if (grepl("@incollection", bib_text, ignore.case = TRUE) &&
      !grepl("booktitle\\s*=", bib_text, ignore.case = TRUE)) {
      bib_text <- sub("@incollection", "@misc", bib_text, ignore.case = TRUE)
      message("ℹ️  Converted @incollection to @misc (missing booktitle)")
      return(bib_text)
    }

    return(bib_text)
  }

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

  # Generate Filename
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

  title_length <- as.numeric(args$length_title)
  if (nchar(title) > title_length) {
    words_to_keep <- cumsum(nchar(stringr::str_split(title, " ")[[1]])) <= title_length
    title <- paste(stringr::str_split(title, " ")[[1]][words_to_keep], collapse = " ")
  }

  # Extract year
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

  # Extract author
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
    chave <- args$key
    last_author <- gsub("[[:digit:]]", "", chave)
    year <- gsub("[[:alpha:]]", "", chave)
  }

  # Build filename
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

  cat("\n=== PDF Filename ===\n")
  cat(filename, "\n")

  # Check BibTeX File for duplicates
  if (!is.null(args$bibtex_file)) {
    if (!fs::file_exists(args$bibtex_file)) {
      stop(paste0("\nERROR: BibTeX file not found: ", args$bibtex_file))
    }

    bib_db <- bibtex::do_read_bib(args$bibtex_file)

    bib_db |>
      purrr::map(\(x) x[grepl("doi", names(x), ignore.case = TRUE)]) |>
      purrr::map(\(x) gsub("^.*10\\.", "10.", x)) |>
      unlist() ->
      dois_db

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

  # Write BibTeX to central file
  if (args$write) {
    if (is.null(args$bibtex_file)) {
      cat("\n════════════════════════════════════════════════════════════════════\n")
      cat("❌ ERROR: -w requires -b option\n")
      cat("════════════════════════════════════════════════════════════════════\n")
      cat("The -w flag writes BibTeX to a central file, but you must specify\n")
      cat("which file to write to using -b/--bibtex_file\n\n")
      cat("Examples:\n")
      cat("  # Write to central BibTeX file\n")
      cat("  ref.R -p paper.pdf -b references.bib -w\n\n")
      cat("  # Or just create local .bib file (no -w needed)\n")
      cat("  ref.R -p paper.pdf -B\n\n")
      cat("════════════════════════════════════════════════════════════════════\n\n")
      quit(status = 1)
    }

    if (exists("dois_db") && any(doi %in% dois_db)) {
      stop("ERROR: DOI already exists in BibTeX file. Aborting.")
    }

    cat(bib2, file = args$bibtex_file, append = TRUE)
    cat("\n✅ BibTeX added to:", args$bibtex_file, "\n")
  }

  # Rename PDF
  if (args$rename) {
    if (is.null(args$pdf_file)) {
      stop("ERROR: PDF file required for renaming. Use -p/--pdf_file")
    }

    name_with_path <- stringr::str_split(args$pdf_file, "/")[[1]]
    name_with_path[length(name_with_path)] <- filename
    name_with_path_v2 <- paste(name_with_path, collapse = "/")

    file.rename(args$pdf_file, name_with_path_v2)

    cat("\n✅ PDF renamed to:", filename, "\n")

    # Update pdf_file path for later use
    args$pdf_file <- name_with_path_v2
  }

  # Write Local BibTeX
  if (args$local_bibtex) {
    if (is.null(args$pdf_file)) {
      stop("ERROR: PDF file required for local BibTeX. Use -p/--pdf_file")
    }

    pdf_dir <- dirname(args$pdf_file)
    pdf_basename <- basename(args$pdf_file) |> stringr::str_remove("\\.pdf$")
    local_bib_file <- file.path(pdf_dir, paste0(".", pdf_basename, ".bib"))

    cat(bib2, file = local_bib_file)
    cat("\n✅ Local BibTeX written to:", local_bib_file, "\n")
  }
}

# ============================================================================
# PART 2: RAG PREPARATION
# ============================================================================

if (run_rag) {
  if (args$verbose) cat("\n=== RAG Preparation ===\n\n")

  # Helper: Extract metadata from local .bib file
  extract_metadata_from_bib <- \(bib_file) {
    if (!file.exists(bib_file)) {
      return(NULL)
    }

    tryCatch(
      {
        bib_data <- bibtex::read.bib(bib_file)
        if (length(bib_data) == 0) {
          return(NULL)
        }
        entry <- bib_data[[1]]

        list(
          author = entry$author[[1]]$family %||% NA_character_,
          year   = entry$year %||% NA_character_,
          title  = entry$title %||% NA_character_,
          doi    = entry$doi %||% NA_character_
        )
      },
      error = \(e) NULL
    )
  }

  # Get file basename and metadata
  file_basename <- NULL

  if (!is.null(args$pdf_file)) {
    pdf_file <- args$pdf_file
    if (!fs::file_exists(pdf_file)) {
      stop(paste0("ERROR: PDF file not found: ", pdf_file))
    }

    file_basename <- basename(pdf_file) |> stringr::str_remove("\\.pdf$")
    pdf_dir <- dirname(pdf_file)
    local_bib_file <- file.path(pdf_dir, paste0(".", file_basename, ".bib"))

    if (!file.exists(local_bib_file)) {
      cat("\n════════════════════════════════════════════════════════════════════\n")
      cat("⚠️  NO BIBTEX METADATA FOUND\n")
      cat("════════════════════════════════════════════════════════════════════\n")
      cat(glue::glue("File: {basename(pdf_file)}\n"))
      cat(glue::glue("Expected BibTeX file: {basename(local_bib_file)}\n\n"))
      cat("Run with -B flag to create BibTeX metadata first.\n")
      cat("════════════════════════════════════════════════════════════════════\n\n")
      quit(status = 1)
    }

    bib_metadata <- extract_metadata_from_bib(local_bib_file)

    if (is.null(bib_metadata)) {
      cat("\n⚠️  Invalid BibTeX metadata. Run with -B to regenerate.\n\n")
      quit(status = 1)
    }

    # Get DOI from metadata if not already set
    if (is.na(doi) && !is.na(bib_metadata$doi)) {
      doi <- bib_metadata$doi
      if (args$verbose) cat(paste0("✅ Using DOI from .bib file: ", doi, "\n"))
    } else if (is.na(doi)) {
      cat("\nℹ️  No DOI available. Skipping OpenAlex fetch.\n")
      cat("   Will create Markdown from .bib metadata only.\n\n")
    }
  }

  if (!is.null(args$doi) && is.null(args$pdf_file)) {
    doi <- args$doi
    file_basename <- stringr::str_replace_all(doi, "[^A-Za-z0-9]", "_")
  }

  # Decide if we fetch from OpenAlex
  has_doi <- !is.na(doi) && nchar(trimws(doi)) > 0

  if (!has_doi && args$verbose) {
    cat("ℹ️  No DOI available. Will create Markdown from .bib metadata only.\n")
  }

  # Prepare metadata holders
  citing_doi <- if (has_doi) doi else NA_character_
  citing_id <- NA_character_
  citing_title <- NA_character_
  citing_year <- NA_character_
  citing_author <- NA_character_
  work <- NULL
  references <- NULL

  # Fetch Referenced Works from OpenAlex
  if (has_doi) {
    doi_clean <- stringr::str_remove(doi, "^https?://doi\\.org/")

    cat("\n=== Fetching Referenced Works ===\n")
    cat(glue::glue("DOI: {doi}\n\n"))

    tryCatch(
      {
        openalexR::oa_fetch(
          entity = "works",
          doi = doi_clean,
          verbose = FALSE
        ) |>
          dplyr::slice_head(n = 1) ->
          work

        if (nrow(work) == 0) stop("No work found in OpenAlex")

        citing_doi <- work$doi
        citing_id <- work$id
        citing_title <- work$display_name
        citing_year <- work$publication_year
        citing_author <- stringr::str_extract(work$authorships[[1]]$display_name[[1]], "\\S+$")

        cat(glue::glue("Author: {citing_author}"), "\n")
        cat(glue::glue("Year: {citing_year}"), "\n")
        cat(glue::glue("Title: {citing_title}"), "\n")

        work |>
          dplyr::select(
            citing_doi = doi,
            citing_id = id,
            citing_year = publication_year,
            citing_title = display_name,
            citing_author = authorships,
            referenced_works
          ) |>
          tidyr::unnest(referenced_works, keep_empty = TRUE) ->
          refs_data

        refs_data <- refs_data |>
          dplyr::mutate(
            citing_author = purrr::map_chr(citing_author, \(auth) {
              if (length(auth) > 0 && !is.null(auth$display_name[[1]])) {
                stringr::str_extract(auth$display_name[[1]], "\\S+$")
              } else {
                NA_character_
              }
            })
          )

        if (nrow(refs_data) == 0 || all(is.na(refs_data$referenced_works))) {
          stop("No referenced works found")
        }

        cat(glue::glue("✅ Found {nrow(refs_data)} referenced works\n\n"))

        refs_data$referenced_works |>
          stringr::str_extract("W\\d+") |>
          na.omit() |>
          unique() ->
          ref_ids

        if (length(ref_ids) > 0) {
          openalexR::oa_fetch(
            entity = "works",
            identifier = ref_ids,
            options = list(select = c("id", "doi", "publication_year", "title", "authorships")),
            verbose = FALSE
          ) |>
            dplyr::select(
              cited_doi = doi,
              referenced_works = id,
              cited_year = publication_year,
              cited_title = title,
              cited_authorships = authorships
            ) ->
            ref_works

          ref_works <- ref_works |>
            dplyr::mutate(
              cited_author = purrr::map_chr(cited_authorships, \(auth) {
                if (length(auth) > 0 && !is.null(auth$display_name[[1]])) {
                  stringr::str_extract(auth$display_name[[1]], "\\S+$")
                } else {
                  NA_character_
                }
              })
            ) |>
            dplyr::select(-cited_authorships)

          refs_data |>
            dplyr::left_join(ref_works, by = dplyr::join_by(referenced_works)) |>
            dplyr::rename(cited_id = referenced_works) |>
            dplyr::relocate(citing_author, .after = citing_title) |>
            dplyr::relocate(cited_author, .after = cited_title) ->
            references

          cat(glue::glue("✅ Retrieved details for {nrow(ref_works)} works\n\n"))
        } else {
          references <- refs_data
        }
      },
      error = \(e) {
        cat(glue::glue("⚠️  OpenAlex error: {e$message}\n"))
        cat("    Continuing with Markdown creation only.\n\n")
      }
    )
  }

  # Save CSV (always create if we have references)
  if (!is.null(references) && nrow(references) > 0) {
    csv_filename <- paste0(".", file_basename, ".csv")

    references_formatted <- references |>
      dplyr::mutate(
        citing_year = as.character(citing_year),
        cited_year = as.character(cited_year)
      )

    readr::write_csv(references_formatted, csv_filename, quote = "all")
    cat(glue::glue("\n✅ CSV saved to: {csv_filename}\n\n"))
  }

  # Save Markdown (always create)
  md_filename <- paste0(file_basename, ".md")
  md_content <- character()

  if (args$no_rag_marker) {
    md_content <- c(md_content, "no_rag", "")
  }

  # Prefer .bib metadata
  if (!is.null(bib_metadata)) {
    first_author <- bib_metadata$author %||% "Unknown"
    md_year <- bib_metadata$year %||% NA_character_
    md_title <- bib_metadata$title %||% "Untitled"
  } else if (!is.null(work)) {
    if (!is.null(work$authorships) && length(work$authorships[[1]]) > 0) {
      first_author <- stringr::str_extract(work$authorships[[1]]$display_name[[1]], "\\S+$") %||% "Unknown"
    } else {
      first_author <- citing_author %||% "Unknown"
    }
    md_year <- citing_year %||% NA_character_
    md_title <- citing_title %||% "Untitled"
  } else {
    first_author <- "Unknown"
    md_year <- NA_character_
    md_title <- "Untitled"
  }

  md_content <- c(md_content, glue::glue("# {first_author} - {md_year} - {md_title}"), "")
  md_content <- c(
    md_content,
    glue::glue("- **Author:** {first_author}"),
    glue::glue("- **Year:** {md_year}"),
    glue::glue("- **Title:** {md_title}"),
    glue::glue("- **DOI:** {citing_doi %||% NA_character_}"),
    glue::glue("- **OpenAlex ID:** {citing_id %||% NA_character_}"),
    glue::glue("- **Generated on:** {Sys.Date()}"),
    ""
  )

  md_content <- c(md_content, "## User Comments", "")

  writeLines(md_content, md_filename)

  cat(glue::glue("✅ Markdown saved to: {md_filename}\n"))
  if (args$no_rag_marker) cat("🚫 Added 'no_rag' marker\n")
}

cat("\n✅ Workflow completed successfully\n\n")
