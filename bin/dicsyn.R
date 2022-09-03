#!/usr/bin/env Rscript

# run
# ./dicsyn.R idioma termo

suppressMessages(library(rvest))
suppressMessages(library(stringr))
suppressMessages(library(pipeR))

url <- 'https://sinonimos.woxikon.com.br'

# receber o comando do terminal
args <- commandArgs(TRUE)

# test if there is at least one argument: if not, return an error
if (length(args) < 2) {

    stop("Please specify valid language (pt, en, fr, it, ...) and a search term..\n", call. = FALSE)

} else if (!(args[1] %in% c('pt', 'en', 'be', 'cl', 'co', 'br', 'nz', 'uk', 'fr', 'it', 'sv'))) {

    stop("Specify a valid language.
            Portuguese: 'pt'
            English: 'en'
            French: 'fr',
            Italian: 'it'
            etc.\n", call = FALSE)

} else {

    page  <- read_html(paste(url, args[1], args[2], sep = '/'))
    
    # primeiro sinônimo
    html_nodes(page, xpath = '//*[@id="content"]/div[3]/div/div/div[2]/div/div[3]/ol/li/div') %>>% 
        html_text2() %>>% 
        (gsub('^.*:|\\n', ' ', .)) %>>% 
        (trimws(., which = 'both', whitespace = "[ \t\r\n]"))  %>>% 
        (strsplit(., split = " +")) %>>% 
        (. -> a)
    
    # todos, exceto o primeiro sinônimo
    html_nodes(page, xpath = '//*[@id="content"]/ol/li[*]') %>>% 
        html_text2() %>>% 
        (gsub('^.*:|\\n', ' ', .)) %>>% 
        (trimws(., which = 'both', whitespace = "[ \t\r\n]"))  %>>% 
        (strsplit(., split = " +")) %>>% 
        (. -> b)
    
    termos <- append(a, b)
    
    b <- lapply(termos, function(x) { 
                    paste(x[1], str_c(x[2:length(x)], collapse = ", "), sep = ': ')
    }) 
    
    names(b) <- NULL
    unlist(b)
}

# teste aqui
# args <- list('pt', 'amor')

# page <- read_html(paste(url, args[1], args[2], sep = '/'))

# html_nodes(page, xpath = '//*[@id="content"]/div[3]/div/div/div[2]/div/div[3]/ol/li/div') %>>% 
#     html_text2() %>>% 
#     (gsub('^.*:|\\n', ' ', .)) %>>% 
#     (trimws(., which = 'both', whitespace = "[ \t\r\n]"))  %>>% 
#     (strsplit(., split = " +")) %>>% 
#     (. -> a)

# # todos, exceto o primeiro sinônimo
# html_nodes(page, xpath = '//*[@id="content"]/ol/li[*]') %>>% 
#     html_text2() %>>% 
#     (gsub('^.*:|\\n', ' ', .)) %>>% 
#     (trimws(., which = 'both', whitespace = "[ \t\r\n]"))  %>>% 
#     (strsplit(., split = " +")) %>>% 
#     (. -> b)


