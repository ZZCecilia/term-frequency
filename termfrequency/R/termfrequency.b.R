# This file is a generated template, your changes will not be overwrittentermfrequencyClass <- if (requireNamespace('jmvcore', quietly=TRUE)) R6::R6Class(
  "termfrequencyClass",
  inherit = termfrequencyBase,
  private = list(
    .run = function() {
      
      data <- self$data
      fretext <- self$options$fretext
      
      if (is.null(self$options$fretext)) 
        return()
      
      #set the data frame
      fre_df <- data.frame(doc_id=fretext,
                           text=data[[fretext]],
                           stringsAsFactors = FALSE)
      
      # Transfer the data into corpus 
      text_corpus = tm::VCorpus(tm::DataframeSource(fre_df))
      
      # Apply data pre-processing to corpus
      corpus_cleaned <- private$.corpus_preproc(text_corpus)
      
      # Building a document-term matrix (DTM)
      text_dtm <- tm::DocumentTermMatrix(corpus_cleaned)
      dtm_fre <- as.matrix(text_dtm)
      
      # Word Frequency
      words_frequency <- colSums(dtm_fre)
      words_frequency <- sort(words_frequency, decreasing = TRUE)
      
      #Results
      results <- self$results$text$setContent(words_frequency)
    },
    # Pre-processing data with defined function
    .corpus_preproc = function(corpus) {
      # Replace special symbols with space 
      toSpace <- tm::content_transformer(function (x , pattern) gsub(pattern, " ", x))
      # Normalization
      corpus <- tm::tm_map(corpus, toSpace, "/")
      corpus <- tm::tm_map(corpus, toSpace,"@")
      corpus <- tm::tm_map(corpus, toSpace,"\\ï½")
      corpus <- tm::tm_map(corpus, toSpace,"#")
      corpus <- tm::tm_map(corpus, toSpace, "ÃÂ")
      # Casing (upper case & lower case), convert the text to lower case
      corpus <- tm::tm_map(corpus, tm::content_transformer(tolower))
      # Remove punctuation 
      corpus <- tm::tm_map(corpus, tm::removePunctuation)
      # Remove extra white space 
      corpus <- tm::tm_map(corpus, tm::stripWhitespace)
      # Remove Stop words
      corpus <- tm::tm_map(corpus, tm::removeWords, tm::stopwords("english"))
      corpus <- tm::tm_map(corpus, tm::removeWords, c("the","and","The","And","A","An","a","an","e","d"))
      # Stemming (e.g. -ing vs original)
      corpus <- tm::tm_map(corpus, tm::stemDocument, language="english")
      return(corpus)
    }
  )
)
