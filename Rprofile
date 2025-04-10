
if (interactive()) {
  # cores do terminal
  suppressMessages(require(colorout))
  setOutputColors256(normal = 39, number = 51, negnum = 183, date = 43, string = 79, const = 75, verbose = FALSE)

  # função para enviar para o R qual a largura do terminal de saída dos dados
  largura <- function() {
    options(width = system("tput cols", intern = TRUE))
  }
}

options(repos = structure(c(CRAN = "https://cran.rstudio.com/")))

# browser: linux or mac?
if (as.character(Sys.info()["sysname"]) == "Linux") {
  options(browser = "/usr/bin/firefox")
} else {
  options(browser = "/applications/firefox.app/contents/macos/firefox-bin")
}

# cran
options(
  usethis.full_name = "Roney Fraga Souza",
  usethis.description = list(
    `Authors@R` = 'person("Roney", "Souza", email = "roneyfraga@gmail.com", role = c("aut", "cre"), comment = c(ORCID = "orcid.org/0000-0001-5750-489X"))'),
  usethis.protocol = "ssh"
)

# Disable autocompletion from the language server, needed by Nvim-R
options(languageserver.server_capabilities = list(completionProvider = FALSE, completionItemResolve = FALSE))

# openalexR
options(openalexR.mailto = "roneyfraga@gmail.com")
