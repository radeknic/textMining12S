#wĹ‚Ä…czenie bibliotek
library(tm)
library(hunspell)
library(stringr)

#zmiana katalogu roboczego
workDir <- "E:\RN\TextMining12S"
setwd(workDir)

#definicja katalogĂłw projektu
inputDir <- ".\\data"
outputDir <- ".\\results"
scriptsDir <- ".\\scripts"
workspaceDir <- ".\\workspaces"

#utworzenie katalogu wyjĹ›ciowego
dir.create(outputDir, showWarnings = FALSE)
dir.create(workspaceDir, showWarnings = FALSE)

#utworzenie korpusu dokumentĂłw
corpusDir <- paste(
  inputDir,
  "\\",
  "Literatura - streszczenia - oryginaĹ‚",
  sep = ""
)
corpus <- VCorpus(
  DirSource(
    corpusDir,
    pattern = "*.txt",
    encoding = "UTF-8"
  ),
  readerControl = list(
    language = "pl_PL"
  )
)

#wstÄ™pne przetwarzanie
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, content_transformer(tolower))
stoplistFile <- paste(
  inputDir,
  "\\",
  "stopwords_pl.txt",
  sep = ""
)
stoplist <- readLines(
  stoplistFile,
  encoding = "UTF-8"
)
corpus <- tm_map(corpus, removeWords, stoplist)
corpus <- tm_map(corpus, stripWhitespace)


remove_char<-content_transformer(
  function(x, pattern, replacement) 
    gsub(pattern, replacement, x)
)

#usuniecie em dash i 3/4 z tekstu
corpus <-tm_map(corpus, remove_char, intToUtf8(8722), "")
corpus <-tm_map(corpus, remove_char, intToUtf8(190), "")

#lematyzacja - sprowadzenie do formy podstawowej 
polish <- dictionary(lang = "pl_PL")

lemmatize <- function(text){
  simple_text <- str_trim(as.character(text[1]))
  parsed_text <- strsplit(simple_text, split = " ")
  new_tex_vec <- hunpsell_stem(parsed_text[[1]], dict = polish)
  for (i in l:length(new_tex_vec)){
    if (length(new_tex_vec[[i]]) == 0) new_tex_vec[i] <- parsed_text[[1]][i]
    if(length(new_tex_vec[[1]]) > 1) new_tex_vec[i] < - new_tex_vec[[i]][1]
    
  }
  new_text <- paste(new_tex_vec, collapse = " ")
  return(new_text)
}


corpus <- tm_map(corpus, content_transformer(lemmatize))

#usuniecie rozszerzen z nazw dokumentow
cut_extension <- function(document) {
  meta(document, "id") <- gsub(pattern = "\\.txt$", "", meta(document, "id"))
  return(document)
}

corpus <- tm_map (corpus, cut_extension)

#eksport korpusu przetworzonego do plikow tekstowych
preprocessed_dir <- paste(
  ourputDir,
  "\\",
  "Literatura - strzeszczenia - przetworzone",
  sep = ""
  
)

dir.create(preprocessed_dir, showWarnings = FALSE)
writeCorpus(corpus, path = preprocessed_dir)

writeLines(as.character(corpus[[1]]))
writeLines(as.character(corpus[[1]]))