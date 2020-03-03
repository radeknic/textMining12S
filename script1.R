#wlaczanie biblioteki
library(tm)

#zmiana katalogu roboczego
workDir <- "D:\\RN\\PJN\\TextMining12S"
setwd(workDir)

#definicja katalogÃ³w projektu
inputDir <- ".\\data"
outputDir <- ".\\results"
scriptDir <- ".\\scripts"
workspaceDir <-".\\workspaces"

#tworzeniee katalogu wyjœciowego"
dir.create(workspaceDir,showWarnings = FALSE)

#utworzenie korpusu dokumentów"
corpusDir <-paste(inputDir,"\\","Literatura - streszczenia - orygina³",sep="")
corpus <-VCorpus(
  DirSource(corpusDir,
  pattern="*.txt",
  encoding="UTF-8"
  ),
  readerControl = list(
    language = "pl_PL"
  )
)


corpus <-tm_map(corpus, removeNumbers)
corpus <-tm_map(corpus, removePunctuation)
corpus <-tm_map(corpus, content_transformer(tolower))
stoplistFile <- corpusDir <-paste(inputDir,"\\","stopwords_pl.txt",sep="")
stoplist <-readLines(
  stoplistFile,
  encoding="UTF-8"
  
)
corpus <-tm_map(corpus, removeWords, stoplist)
corpus <-tm_map(corpus, stripWhitespace)
