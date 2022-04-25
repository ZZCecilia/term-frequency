# This file is a generated template, your changes will not be overwritten

termfrequencyClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
  "termfrequencyClass",
  inherit = termfrequencyBase,
  private = list(
    .run = function() {
      
      #Reading the text file and defining the data object
      text1 <- self$data
      
      #Connecting R and Jamovi(options)
      fretext <- self$option$fretext
      dep <- self$option$dep
      wcpa <- self$option$wcpa
      hmwtd <- self$option$hmwtd
      
      ### Defined Functions ###
      # Pre-processing data with defined function
      corpus_preprocessing = function(corpus){
        # Replace special symbols with space 
        toSpace <- content_transformer(function (x , pattern) gsub(pattern, " ", x))
        # Normalization
        corpus <- tm_map(corpus, toSpace, "/")
        corpus <- tm_map(corpus,toSpace,"@")
        corpus <- tm_map(corpus,toSpace,"\\ï½")
        corpus <- tm_map(corpus,toSpace,"#")
        corpus <- tm_map(corpus, toSpace, "Â®")
        # Casing (upper case & lower case), convert the text to lower case
        corpus <- tm_map(corpus, content_transformer(tolower))
        # Remove punctuation 
        corpus <- tm_map(corpus, removePunctuation)
        # Remove extra white space 
        corpus <- tm_map(corpus, stripWhitespace)
        # Remove Stop words
        corpus <- tm_map(corpus,removeWords,stopwords("english"))
        corpus <- tm_map(corpus,removeWords,c("the","and","The","And","A","An","a","an","e","d"))
        # Stemming (e.g. -ing vs original)
        corpus <- tm_map(corpus,stemDocument, language ="english")
        return(corpus)
      }
      
      #Initialize Data variables
      #Creating Data Object
      if (is.null(self$options$fretext)) 
        return()
      
      fre_df<- data.frame(
        d_fretext<- self$data[[self$options$fretext]])
      
      # Transfer the data into corpus 
      text_corpus = VCorpus(DataframeSource(fre_df))
      
      # Apply data pre-processing to corpus
      corpus_cleaned <- corpus_preprocessing(text_corpus)
      
      #Building a document-term matrix (DTM)
      text_dtm <- DocumentTermMatrix(corpus_cleaned)
      dtm_fre <- as.matrix(text_dtm)
      
      
      #Word Frequency
      words_frequency <- colSums(dtm_fre)
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

