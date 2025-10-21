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

# Extract DOI ------------------------------------------------------------------

if (!is.null(args$pdf_file)) {
  pdf_file <- args$pdf_file

  if (!fs::file_exists(pdf_file)) {
    stop(paste0("ERROR: PDF file not found: ", pdf_file))
  }

  if (args$verbose) cat("Extracting DOI from PDF...\n")

  doi <- bibr::pdf_extract_doi(pdf_file)

  # If DOI not found in PDF but provided via -d flag, use the provided DOI
  if (is.na(doi) && !is.null(args$doi)) {
    doi <- args$doi
    if (args$verbose) cat(paste0("Using provided DOI: ", doi, "\n"))
  } else if (is.na(doi) && is.null(args$doi)) {
    stop(paste0(
      "\nERROR: No DOI found in PDF: ", args$pdf_file,
      "\nTry providing DOI manually with -d/--doi"
    ))
  }

  if (!is.na(doi) && is.null(args$doi)) {
    if (args$verbose) cat(paste0("Found DOI: ", doi, "\n"))
  }

  # Extract filename base for output files
  file_basename <- basename(pdf_file) |>
    stringr::str_remove("\\.pdf$")
}

if (!is.null(args$doi) && is.null(args$pdf_file)) {
  doi <- args$doi
  if (args$verbose) cat(paste0("Using DOI: ", doi, "\n"))

  # Generate filename base from DOI
  file_basename <- stringr::str_replace_all(doi, "[^A-Za-z0-9]", "_")
}

# Fetch Referenced Works -------------------------------------------------------

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

    if (nrow(work) == 0) {
      stop("No work found in OpenAlex")
    }

    # Extract main paper info
    citing_doi <- work$doi
    citing_id <- work$id
    citing_title <- work$display_name
    citing_year <- work$publication_year
    citing_author <- stringr::str_extract(work$authorships[[1]]$display_name[[1]], "\\S+$")

    cat(glue::glue("Author: {citing_author}"), "\n")
    cat(glue::glue("Year: {citing_year}"), "\n")
    cat(glue::glue("Title: {citing_title}"), "\n")

    # Extract referenced works
    work |>
      dplyr::select(
        citing_doi = doi,
        citing_id = id,
        citing_year = publication_year,
        citing_title = display_name,
        referenced_works
      ) |>
      tidyr::unnest(referenced_works, keep_empty = TRUE) ->
      refs_data

    if (nrow(refs_data) == 0 || all(is.na(refs_data$referenced_works))) {
      stop("No referenced works found")
    }

    cat(glue::glue("✅ Found {nrow(refs_data)} referenced works\n\n"))

    # Fetch details of referenced works
    if (args$verbose) cat("Fetching details of referenced works...\n")

    refs_data$referenced_works |>
      stringr::str_extract("W\\d+") |>
      na.omit() |>
      unique() ->
      ref_ids

    if (length(ref_ids) > 0) {
      openalexR::oa_fetch(
        entity = "works",
        identifier = ref_ids,
        options = list(select = c("id", "doi", "publication_year", "title")),
        verbose = FALSE
      ) |>
        dplyr::select(cited_doi = doi, referenced_works = id, cited_year = publication_year, cited_title = title) ->
        ref_works

      refs_data |>
        dplyr::left_join(ref_works, by = dplyr::join_by(referenced_works)) |>
        dplyr::rename(cited_id = referenced_works) |>
        dplyr::relocate(cited_id, .after = cited_doi) ->
        references

      cat(glue::glue("✅ Retrieved details for {nrow(ref_works)} works\n\n"))
    } else {
      ref_works <- tibble::tibble()
      references <- refs_data
    }
  },
  error = \(e) {
    stop(glue::glue("ERROR: {e$message}"))
  }
)

# Save CSV ---------------------------------------------------------------------

if (!args$no_csv) {
  # Determine CSV filename
  if (!is.null(args$csv_file)) {
    csv_filename <- args$csv_file
  } else {
    csv_filename <- paste0(file_basename, ".csv")
  }

  # Save CSV
  readr::write_csv(references, csv_filename)

  cat(glue::glue("\n✅ CSV saved to: {csv_filename}\n\n"))
}

# Save Markdown ----------------------------------------------------------------

if (!args$no_markdown) {
  # Determine markdown filename
  md_filename <- paste0(file_basename, ".md")

  # cat(glue::glue("\nCreating markdown file for RAG...\n"))

  # Build markdown content
  md_content <- character()

  # Add no_rag marker if requested
  if (args$no_rag) {
    md_content <- c(md_content, "no_rag")
    md_content <- c(md_content, "")
  }

  # Extract first author for title
  if (!is.null(work$authorships) && length(work$authorships[[1]]) > 0) {
    first_author <- stringr::str_extract(work$authorships[[1]]$display_name[[1]], "\\S+$") %||% "Unknown"
  }

  # Header with Author - Year - Title format
  md_content <- c(md_content, glue::glue("# {first_author} - {citing_year} - {citing_title}"))
  md_content <- c(md_content, "")

  # Metadata (without subheader)
  md_content <- c(md_content, glue::glue("- **Author:** {first_author}"))
  md_content <- c(md_content, glue::glue("- **Year:** {citing_year}"))
  md_content <- c(md_content, glue::glue("- **Title:** {citing_title}"))
  md_content <- c(md_content, glue::glue("- **DOI:** {citing_doi}"))
  md_content <- c(md_content, glue::glue("- **OpenAlex ID:** {citing_id}"))
  md_content <- c(md_content, glue::glue("- **Generated on:** {Sys.Date()}"))
  md_content <- c(md_content, "")

  # User comments section
  md_content <- c(md_content, "## User Comments")
  md_content <- c(md_content, "")

  # Write to file
  writeLines(md_content, md_filename)

  if (args$no_rag) {
    cat("🚫 Added 'no_rag' marker to markdown file\n")
  }
}

# Summary ----------------------------------------------------------------------

cat("\n=== Files ===\n")
if (!args$no_csv) {
  cat(glue::glue("CSV: {csv_filename %||% paste0(file_basename, '.csv')}\n\n"))
}
if (!args$no_markdown) {
  cat(glue::glue("Markdown: {md_filename}\n\n"))
}
cat("\n")
