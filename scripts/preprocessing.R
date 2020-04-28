#wĹ‚Ä…czenie bibliotek
library(tm)
library(hunspell)
library(stringr)

#zmiana katalogu roboczego
<<<<<<< HEAD
workDir <- "E:\\RN\\TextMining12S"
=======
workDir <- "E:\RN\TextMining12S"
>>>>>>> 8f0d87906622041a8def0679d40930dae6db1579
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
<<<<<<< HEAD
  "Literatura - streszczenia - oryginał",
=======
  "Literatura - streszczenia - oryginaĹ‚",
>>>>>>> 8f0d87906622041a8def0679d40930dae6db1579
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


<<<<<<< HEAD
removeChar<-content_transformer(
=======
remove_char<-content_transformer(
>>>>>>> 8f0d87906622041a8def0679d40930dae6db1579
  function(x, pattern, replacement) 
    gsub(pattern, replacement, x)
)

#usuniecie em dash i 3/4 z tekstu
<<<<<<< HEAD
corpus <-tm_map(corpus, removeChar, intToUtf8(8722), "")
corpus <-tm_map(corpus, removeChar, intToUtf8(190), "")
=======
corpus <-tm_map(corpus, remove_char, intToUtf8(8722), "")
corpus <-tm_map(corpus, remove_char, intToUtf8(190), "")
>>>>>>> 8f0d87906622041a8def0679d40930dae6db1579

#lematyzacja - sprowadzenie do formy podstawowej 
polish <- dictionary(lang = "pl_PL")

lemmatize <- function(text){
  simple_text <- str_trim(as.character(text[1]))
  parsed_text <- strsplit(simple_text, split = " ")
<<<<<<< HEAD
  new_tex_vec <- hunspell_stem(parsed_text[[1]], dict = polish)
  for (i in 1:length(new_tex_vec)){
    if (length(new_tex_vec[[i]]) == 0) new_tex_vec[i] <- parsed_text[[1]][i]
    if(length(new_tex_vec[[i]]) > 1) new_tex_vec[i] <- new_tex_vec[[i]][1]
=======
  new_tex_vec <- hunpsell_stem(parsed_text[[1]], dict = polish)
  for (i in l:length(new_tex_vec)){
    if (length(new_tex_vec[[i]]) == 0) new_tex_vec[i] <- parsed_text[[1]][i]
    if(length(new_tex_vec[[1]]) > 1) new_tex_vec[i] < - new_tex_vec[[i]][1]
>>>>>>> 8f0d87906622041a8def0679d40930dae6db1579
    
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
<<<<<<< HEAD
  outputDir,
=======
  ourputDir,
>>>>>>> 8f0d87906622041a8def0679d40930dae6db1579
  "\\",
  "Literatura - strzeszczenia - przetworzone",
  sep = ""
  
)

dir.create(preprocessed_dir, showWarnings = FALSE)
writeCorpus(corpus, path = preprocessed_dir)

<<<<<<< HEAD

writeLines(as.character(corpus[[1]]))

=======
writeLines(as.character(corpus[[1]]))
writeLines(as.character(corpus[[1]]))
>>>>>>> 8f0d87906622041a8def0679d40930dae6db1579
