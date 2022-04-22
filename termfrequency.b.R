
# This file is a generated template, your changes will not be overwritten

termfrequencyClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
    "termfrequencyClass",
    inherit = termfrequencyBase,
    private = list(
        .run = function() {
          #Reading the text file and defining the data object
          text1 <- self$data
          
          #Connecting R and Jamovi(options)
          dep <- self$option$dep
          wcpa <- self$option$wcpa
          hmwtd <- self$option$hmwt
          
          review_text <- paste(reviews$Reviews, collapse=" ")
          
          #Setting up and loading the data as a corpus
          #text_corpus <- Corpus(VectorSource(text1))
          review_source <- VectorSource(review_text) # need source for the text
          corpus <- Corpus(review_source) # corpus is the name for a collection of documents that want to compare
          
          
          #Cleaning up the text data
          text_corpus <- tm_map(text_corpus, stripWhitespace)
          text_corpus1 <- tm_map(text_corpus, content_transformer(tolower))
          text_corpus2 <- tm_map(text_corpus1, removePunctuation)
          text_corpus3 <- tm_map(text_corpus2, removeNumbers)
          text_corpus4 <- tm_map(text_corpus3, removeWords, stopwords("english"))
          
          
          #Building a document-term matrix (DTM)
          text_corpus_dtm <- DocumentTermMatrix(text_corpus4)
          dtm_m <- as.matrix(text_corpus_dtm)
          
          #Word Frequency
          words_frequency <- colSums(as.matrix(dtm_m))
          words_frequency <- sort(words_frequency, decreasing = TRUE)
          
          #Display the result
          result <- print(words_frequency)
          textResults <- self$result$result
          textResults$content <- result
          

            # `self$data` contains the data
            # `self$options` contains the options
            # `self$results` contains the results object (to populate)

        })
)
