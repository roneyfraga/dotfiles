#!/usr/bin/env Rscript
# Reference to RAG - Fetch references from OpenAlex and create RAG-ready markdown
# Usage: reference_to_rag.R -p "Author - Year - Title.pdf"

suppressMessages(library(openalexR))
suppressMessages(library(dplyr))
suppressMessages(library(purrr))
suppressMessages(library(stringr))
suppressMessages(library(tidyr))
suppressMessages(library(glue))
suppressMessages(library(readr))
suppressMessages(library(optparse))
suppressMessages(library(bibr))
suppressMessages(library(bibtex))

# small helper (local %||%) ----------------------------------------------------
`%||%` <- function(x, y) if (!is.null(x) && length(x) > 0) x else y

# Command Line Options ---------------------------------------------------------

option_list <- list(
  optparse::make_option(
    c("-p", "--pdf_file"),
    type = "character",
    help = "PDF file (renamed format: Author - Year - Title.pdf)"
  ),
  optparse::make_option(
    c("-d", "--doi"),
    type = "character",
    help = "DOI code to search (e.g., 10.1016/j.respol.2025.105343)"
  ),
  optparse::make_option(
    c("-c", "--csv_file"),
    type = "character",
    help = "CSV file to save referenced works data"
  ),
  optparse::make_option(
    c("--no_csv"),
    action = "store_true",
    default = FALSE,
    help = "Skip saving CSV file (CSV is saved by default)"
  ),
  optparse::make_option(
    c("--no_markdown"),
    action = "store_true",
    default = FALSE,
    help = "Skip creating markdown file (Markdown is created by default)"
  ),
  optparse::make_option(
    c("--no_rag"),
    action = "store_true",
    default = FALSE,
    help = "Add 'no_rag' marker to prevent RAG indexing"
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
  description = "\nFetch referenced works from OpenAlex for a single paper and save as CSV/Markdown."
)

args <- optparse::parse_args(parser)

# Validation -------------------------------------------------------------------

if (is.null(args$pdf_file) && is.null(args$doi)) {
  stop("ERROR: PDF file or DOI is required.\n  Use -p/--pdf_file or -d/--doi")
}

# Helper: Extract metadata from local .bib file --------------------------------

extract_metadata_from_bib <- \(bib_file) {
  if (!file.exists(bib_file)) {
    return(NULL)
  }

  tryCatch({
    bib_data <- bibtex::read.bib(bib_file)
    if (length(bib_data) == 0) return(NULL)
    entry <- bib_data[[1]]

    list(
      author = entry$author[[1]]$family %||% NA_character_,
      year   = entry$year %||% NA_character_,
      title  = entry$title %||% NA_character_,
      doi    = entry$doi %||% NA_character_
    )
  }, error = \(e) NULL)
}

# Extract DOI / file_basename / bib_metadata -----------------------------------

doi <- args$doi %||% NA_character_
bib_metadata <- NULL
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
    cat("\n")
    cat("════════════════════════════════════════════════════════════════════\n")
    cat("⚠️  NO BIBTEX METADATA FOUND\n")
    cat("════════════════════════════════════════════════════════════════════\n")
    cat(glue::glue("File: {basename(pdf_file)}\n"))
    cat(glue::glue("Expected BibTeX file: {basename(local_bib_file)}\n\n"))
    cat("This script only processes files with BibTeX metadata.\n")
    cat("Please create a BibTeX file using the reference.R script:\n\n")
    cat(glue::glue("  ./reference.R -p \"{pdf_file}\" -B\n\n"))
    cat("════════════════════════════════════════════════════════════════════\n\n")
    quit(status = 1)
  }

  bib_metadata <- extract_metadata_from_bib(local_bib_file)

  if (is.null(bib_metadata)) {
    cat("\n")
    cat("════════════════════════════════════════════════════════════════════\n")
    cat("⚠️  INVALID BIBTEX METADATA\n")
    cat("════════════════════════════════════════════════════════════════════\n")
    cat(glue::glue("File: {basename(pdf_file)}\n"))
    cat(glue::glue("BibTeX file: {basename(local_bib_file)}\n\n"))
    cat("The BibTeX file exists but could not be parsed.\n")
    cat("Please regenerate it using the reference.R script:\n\n")
    cat(glue::glue("  ./reference.R -p \"{pdf_file}\" -B\n\n"))
    cat("════════════════════════════════════════════════════════════════════\n\n")
    quit(status = 1)
  }

  # If no DOI passed on CLI, try from .bib; otherwise keep CLI DOI
  if (is.na(doi) && !is.na(bib_metadata$doi)) {
    doi <- bib_metadata$doi
    if (args$verbose) cat(paste0("✅ Using DOI from local .bib file: ", doi, "\n"))
  } else if (is.na(doi)) {
    # NEW BEHAVIOR: allow running without DOI; force-skip CSV later
    cat("\n")
    cat("════════════════════════════════════════════════════════════════════\n")
    cat("ℹ️  Proceeding without DOI\n")
    cat("════════════════════════════════════════════════════════════════════\n")
    cat("No DOI in CLI or .bib; will SKIP OpenAlex fetch and CSV output,\n")
    cat("but will still build the Markdown from .bib metadata.\n\n")
    cat("════════════════════════════════════════════════════════════════════\n\n")
  }
}

# If only DOI was provided (no PDF), create a basename from DOI
if (!is.null(args$doi) && is.null(args$pdf_file)) {
  doi <- args$doi
  if (args$verbose) cat(paste0("Using DOI: ", doi, "\n"))
  file_basename <- stringr::str_replace_all(doi, "[^A-Za-z0-9]", "_")
}

# Decide if we will fetch & write CSV ------------------------------------------

has_doi <- !is.na(doi) && nchar(trimws(doi)) > 0
force_skip_csv <- !has_doi

if (force_skip_csv && !args$no_csv) {
  # override to respect your rule: no DOI => no CSV
  args$no_csv <- TRUE
  if (args$verbose) cat("🔒 No DOI provided → forcing --no_csv\n")
}

# Prepare holders for metadata used later --------------------------------------

citing_doi   <- if (has_doi) doi else NA_character_
citing_id    <- NA_character_
citing_title <- NA_character_
citing_year  <- NA_character_
citing_author <- NA_character_

work <- NULL
references <- NULL

# Fetch Referenced Works (only when DOI is present) ----------------------------

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

      citing_doi   <- work$doi
      citing_id    <- work$id
      citing_title <- work$display_name
      citing_year  <- work$publication_year
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
      stop(glue::glue("ERROR: {e$message}"))
    }
  )
} else if (args$verbose) {
  cat("⏭️  Skipping OpenAlex fetch because no DOI was provided.\n")
}

# Save CSV (only if not forced off) --------------------------------------------

if (!args$no_csv) {
  # Determine CSV filename (hidden by default)
  csv_filename <- if (!is.null(args$csv_file)) {
    args$csv_file
  } else {
    paste0(".", file_basename, ".csv")
  }

  # Convert numeric columns to character to preserve formatting
  references_formatted <- references |>
    dplyr::mutate(
      citing_year = as.character(citing_year),
      cited_year  = as.character(cited_year)
    )

  readr::write_csv(references_formatted, csv_filename, quote = "all")
  cat(glue::glue("\n✅ CSV saved to: {csv_filename}\n\n"))
}

# Save Markdown ----------------------------------------------------------------

if (!args$no_markdown) {
  md_filename <- paste0(file_basename, ".md")

  md_content <- character()

  if (args$no_rag) {
    md_content <- c(md_content, "no_rag", "")
  }

  # Prefer .bib metadata; otherwise fall back to OpenAlex (if fetched)
  if (!is.null(bib_metadata)) {
    first_author <- bib_metadata$author %||% "Unknown"
    md_year      <- bib_metadata$year %||% NA_character_
    md_title     <- bib_metadata$title %||% "Untitled"
  } else {
    # fallback when only DOI path used (or when no .bib)
    if (!is.null(work) && !is.null(work$authorships) && length(work$authorships[[1]]) > 0) {
      first_author <- stringr::str_extract(work$authorships[[1]]$display_name[[1]], "\\S+$") %||% "Unknown"
    } else {
      first_author <- citing_author %||% "Unknown"
    }
    md_year  <- citing_year %||% NA_character_
    md_title <- citing_title %||% "Untitled"
  }

  # Header
  md_content <- c(md_content, glue::glue("# {first_author} - {md_year} - {md_title}"), "")

  # Metadata list
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

  # User comments section
  md_content <- c(md_content, "## User Comments", "")

  writeLines(md_content, md_filename)

  if (args$no_rag) cat("🚫 Added 'no_rag' marker to markdown file\n")
}

# Summary ----------------------------------------------------------------------

cat("\n=== Files ===\n")
if (!args$no_csv) {
  cat(glue::glue("CSV: {csv_filename %||% paste0('.', file_basename, '.csv')}\n\n"))
} else if (force_skip_csv) {
  cat("CSV: (skipped — DOI not provided)\n\n")
}
if (!args$no_markdown) {
  cat(glue::glue("Markdown: {paste0(file_basename, '.md')}\n\n"))
}
cat("\n")

