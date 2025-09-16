# cores no terminal
if (interactive()) {
  if (!requireNamespace("colorout", quietly = TRUE)) {
    warning(
      "Pacote 'colorout' não encontrado. Instale com: 
      install.packages('colorout', repos = 'https://community.r-multiverse.org')"
    )
  } else {
    suppressPackageStartupMessages(library(colorout))

    # Variável global para controlar o estado atual
    .tema_atual <- "claro"

    cores_claras <- function() {
      colorout::setOutputColors(
        index    = "\x1b[38;2;38;139;210m", # Blue
        normal   = "\x1b[38;2;101;123;131m", # Base00
        number   = "\x1b[38;2;211;54;130m", # Magenta
        negnum   = "\x1b[38;2;220;50;47m", # Red
        zero     = "\x1b[38;2;42;161;152m", # Cyan
        infinite = "\x1b[38;2;181;137;0m", # Yellow
        string   = "\x1b[38;2;133;153;0m", # Green
        date     = "\x1b[38;2;203;75;22m", # Orange
        const    = "\x1b[38;2;181;137;0m", # Yellow
        true     = "\x1b[38;2;133;153;0m", # Green
        false    = "\x1b[38;2;220;50;47m", # Red
        warn     = "\x1b[38;2;181;137;0m", # Yellow
        stderror = "\x1b[38;2;203;75;22m", # Orange
        error    = "\x1b[38;2;220;50;47m", # Red
        verbose  = FALSE
      )
      # message("Tema: Solarized Light (claro)")
      .tema_atual <<- "claro"
    }

    cores_escuras <- function() {
      colorout::setOutputColors256(
        normal   = 250, # cinza claro (#bcbcbc)
        number   = 39, # azul intenso (#00afff)
        negnum   = 196, # vermelho forte (#ff0000)
        zero     = 81, # ciano claro (#5fd7ff)
        infinite = 220, # amarelo vivo (#ffd700)
        string   = 114, # verde (#87d75f)
        date     = 178, # oliva (#d7af00)
        const    = 141, # lilás (#af87d7)
        true     = 34, # verde (#00af00)
        false    = 160, # vermelho escuro (#d70000)
        warn     = 208, # laranja (#ff8700)
        stderror = 202, # vermelho alaranjado (#ff5f00)
        error    = 196, # vermelho puro (#ff0000)
        verbose  = FALSE
      )
      # message("Tema: Gruvbox Dark (escuro)")
      .tema_atual <<- "escuro"
    }

    # Função principal que alterna ou define tema específico
    cores_terminal <- function(tema = NULL) {
      if (is.null(tema)) {
        # Alterna entre temas
        if (.tema_atual == "claro") {
          cores_escuras()
        } else {
          cores_claras()
        }
      } else {
        # Define tema específico
        tema <- tolower(tema)
        if (tema %in% c("claro", "light", "solarized")) {
          cores_claras()
        } else if (tema %in% c("escuro", "dark", "gruvbox")) {
          cores_escuras()
        } else {
          stop("Tema não reconhecido. Use: 'claro', 'escuro', 'light', 'dark', 'solarized' ou 'gruvbox'")
        }
      }
    }

    # Função para ver o tema atual
    cores_atuais <- function() {
      return(.tema_atual)
    }

    # Aplicando tema claro por padrão
    cores_claras()

    # Mensagem de ajuda
    # message("Funções disponíveis:")
    # message("• tema() - Alterna entre temas claro/escuro")
    # message("• tema('claro') ou tema('escuro') - Define tema específico")
    # message("• tema_atual() - Mostra tema atual")
  }
}

# Função utilitária para ajustar a largura do output
largura <- function() {
  cols <- suppressWarnings(as.numeric(system("tput cols", intern = TRUE)))
  if (is.na(cols) || cols <= 0) cols <- 80
  options(width = cols)
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
    `Authors@R` = 'person("Roney", "Souza", email = "roneyfraga@gmail.com", role = c("aut", "cre"), comment = c(ORCID = "orcid.org/0000-0001-5750-489X"))'
  ),
  usethis.protocol = "ssh"
)

options(editor = "nvim")

# Disable autocompletion from the language server, needed by Nvim-R
options(languageserver.server_capabilities = list(completionProvider = FALSE, completionItemResolve = FALSE))

# openalexR
options(openalexR.mailto = "roneyfraga@gmail.com")
