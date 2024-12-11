#!/usr/bin/env Rscript

library(styler)

# Read stdin (code to format)
code <- readLines("stdin")

# Custom function to preserve the first empty line
style_preserve_empty_line <- function(code) {
  # Apply styler
  styled_code <- style_text(code)

  # If the first line was empty and was removed, add it back
  if (length(code) > 0 && code[1] == "" && (length(styled_code) == 0 || styled_code[1] != "")) {
    styled_code <- c("", styled_code)
  }

  styled_code
}

# Apply custom styling
styled_code <- style_preserve_empty_line(code)

# Output the styled code
cat(styled_code, sep = "\n")
