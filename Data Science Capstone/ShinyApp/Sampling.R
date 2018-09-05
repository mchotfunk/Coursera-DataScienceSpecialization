suppressWarnings(library(stringi))
suppressWarnings(library(ggplot2))
suppressWarnings(library(quanteda))
suppressWarnings(library(dplyr))
suppressWarnings(library(data.table))


#Set work directory
setwd("/users/andrewhu/desktop/final/en_US")
#Read text file
enblogrul <- file("en_US.blogs.txt", open="rb") 
entwurl <- file("en_US.twitter.txt", open="rb")
enneurl <- file("en_US.news.txt", open="rb")

#Read in the lines
en_blogs<- readLines(enblogrul, encoding = "UTF-8", skipNul=TRUE)

en_tw<- readLines(entwurl, encoding = "UTF-8", skipNul=TRUE)

en_news<- readLines(enneurl, encoding = "UTF-8", skipNul=TRUE)

close(enblogrul)
close(entwurl)
close(enneurl)


set.seed(525)
mini_tw <- sample(en_tw, size = 25000, replace = F)
mini_blogs <- sample(en_blogs, size = 25000, replace = F)
mini_news <- sample(en_news, size = 25000, replace = F)

sample <- c(mini_tw,mini_blogs,mini_news)


# filter weird symbols
sample <- gsub("[^[:alpha:][:space:]']", " ", sample)
sample <- gsub("ã", "'", sample)
sample <- gsub("ð", "'", sample)

sample <- gsub(" #\\S*","", sample) #delete hastag
sample <- gsub("(f|ht)(tp)(s?)(://)(\\S*)", "", sample) # delete http links
sample <- gsub("[^0-9A-Za-z///' ]", "", sample) #delete special chars

#####

#Set work directory
setwd("/users/andrewhu/Documents/GitHub/Coursera-DataScienceSpecialization/Data Science Capstone")
sampleurl <- file("sample.txt", open="rb") 
sample <- readLines(sampleurl, encoding = "UTF-8", skipNul=TRUE)
close(sampleurl)


#corpus for the whole sample
corp <- corpus(sample)

#tokenization for the corpus
toks <- tokens(corp)

#generate ngrams for 1~3
unigram <- tokens_ngrams(toks, n=1)
bigram <- tokens_ngrams(toks, n=2)
trigram <- tokens_ngrams(toks, n=3)

#document frequency matrix for ngram 1~4
unigram_dfm <- dfm(unigram, what="fasterword", ngrams=1)

bigram_dfm <- dfm(bigram, what="fasterword", ngrams=2)

trigram_dfm <- dfm(trigram, what="fasterword", ngrams=3)

#find the count of corpus

uni_sum <- colSums(unigram_dfm)
bi_sum <- colSums(bigram_dfm)
tri_sum <- colSums(trigram_dfm)


#Create data table for uni, bi and tri

uni_dt <- data.table(word_1 = names(uni_sum), count = uni_sum)

bi_dt <- data.table(
        word_1 = sapply(strsplit(names(bi_sum), "_", fixed = TRUE), '[[', 1),
        word_2 = sapply(strsplit(names(bi_sum), "_", fixed = TRUE), '[[', 2),
        count = bi_sum)

tri_dt <- data.table(
        word_1 = sapply(strsplit(names(tri_sum), "_", fixed = TRUE), '[[', 1),
        word_2 = sapply(strsplit(names(tri_sum), "_", fixed = TRUE), '[[', 2),
        word_3 = sapply(strsplit(names(tri_sum), "_", fixed = TRUE), '[[', 3),
        count = tri_sum)


#index 

setkey(uni_dt, word_1)
setkey(bi_dt, word_1, word_2)
setkey(tri_dt, word_1, word_2, word_3)


#Kneser-Kney Smoothing
discount_value <- 0.75

######## Bi-Gram Probability ###########

# number of words in Bi gram 
num_words_bigram <- nrow(bi_dt[by = .(word_1, word_2)])


# Calculating the probability: for a word "given the number of times it was the second word"
prob_bigram <- bi_dt[, .(Prob = ((.N) / num_words_bigram)), by = word_2]
setkey(prob_bigram, word_2)

# Assigning the previos probabilities (prob_bigram),  to unigrams
uni_dt[, Prob := prob_bigram[word_1, Prob]]
uni_dt <- uni_dt[!is.na(uni_dt$Prob)]


prob_ni <- bi_dt[, .(N = .N), by = word_1]
setkey(prob_ni, word_1)

# Assigning total times word 1 occured to bigram cn1
bi_dt[, Cn1 := uni_dt[word_1, count]]

# Kneser Kney Algorithm
bi_dt[, Prob := ((count - discount_value) / Cn1 + discount_value / Cn1 * prob_ni[word_1, N] * uni_dt[word_2, Prob])]


###################


##### Trigram probability ####


# Finding count of word1-word2 combination in bigram 
tri_dt[, Cn2 := bi_dt[.(word_1, word_2), count, allow.cartesian=T]]

# Finding count of word1-word2 combination in trigram
prob_trigram <- tri_dt[, .N, by = .(word_1, word_2)]
setkey(prob_trigram, word_1, word_2)

# Kneser Kney Algorithm
tri_dt[, Prob := (count - discount_value) / Cn2 + discount_value / Cn2 * prob_trigram[.(word_1, word_2), N] *
               bi_dt[.(word_1, word_2), Prob,allow.cartesian=T]]


# Finding the most frequently used 50 unigrmas
uni_dt <- uni_dt[order(-Prob)][1:50]


