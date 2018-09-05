#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
suppressWarnings(library(stringi))
suppressWarnings(library(ggplot2))
suppressWarnings(library(quanteda))
suppressWarnings(library(dplyr))
suppressWarnings(library(data.table))

uni_dt2 <- readRDS("uni_dt.rds")
bi_dt2<- readRDS("bi_dt.rds")
tri_dt2<- readRDS("tri_dt.rds")

alloc.col(uni_dt2)
alloc.col(bi_dt2)
alloc.col(tri_dt2)





# function to return highly probable previous word given two successive words
triWords <- function(w1, w2, n = 5) {
        pwords <- tri_dt2[.(w1, w2)][order(-Prob)]
        if (any(is.na(pwords)))
                return(biWords(w2, n))
        if (nrow(pwords) > n)
                return(pwords[1:n, word_3])
        count <- nrow(pwords)
        bwords <- biWords(w2, n)[1:(n - count)]
        return(c(pwords[, word_3], bwords))
}



# function to return highly probable previous word given a word
biWords <- function(w1, n = 5) {
        pwords <- bi_dt2[w1][order(-Prob)]
        if (any(is.na(pwords)))
                return(uniWords(n))
        if (nrow(pwords) > n)
                return(pwords[1:n, word_2])
        count <- nrow(pwords)
        unWords <- uniWords(n)[1:(n - count)]
        return(c(pwords[, word_2], unWords))
}

# function to return random words from unigrams
uniWords <- function(n = 5) {  
        return(sample(uni_dt2[, word_1], size = n))
}



# The prediction app
getWords <- function(str){
        require(quanteda)
        tokens <- tokens(x = char_tolower(str))
        tokens <- char_wordstem(rev(rev(tokens[[1]])[1:2]), language = "english")
        
        words <- triWords(tokens[1], tokens[2], 5)
        chain_1 <- paste(tokens[1], tokens[2], words[1], sep = " ")
        
        print(words[1])
}



#Prediction
shinyServer(function(input, output) {
        output$prediction <- renderPrint({ 
                result <- getWords(input$inputWords) 
                
        })
        
})   


