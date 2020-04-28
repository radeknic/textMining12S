#wĹ‚Ä…czenie bibliotek
library(tm)
library(stringr)

#zmiana katalogu roboczego
workDir <- "E:\\RN\\TextMining12S"
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
  "Literatura - strzeszczenia - przetworzone",
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

#usuniecie rozszerzen z nazw dokumentow
cutExtension <- function(document) {
  meta(document, "id") <- gsub(pattern = "\\.txt$", "", meta(document, "id"))
  return(document)
}

corpus <- tm_map (corpus, cutExtension)

#utworzenie macierzy czestosci
tdmTfAll <- TermDocumentMatrix(corpus) #wszystkie slowa
dtmTfAll <- DocumentTermMatrix(corpus)
tdmTfidfAll <- TermDocumentMatrix( #zmieniamy wage
  corpus,
  control = list(
    weighting = weightTfIdf
  )
)
tdmBinAll <- TermDocumentMatrix(
  corpus,
  control = list(
    weighting = weightBin
  )
)

tdmTfBounds <- TermDocumentMatrix( #bierzemy slowa ktore wystepuja w conajmniej 2 a nie wiecej niz 16 dokumentach
  corpus,
  control = list(
   bounds = list (
     global = c(2,16) #to zmienic w projekcie, przetestowac rozne wartosci tego bounds 
   )
  )
)
tdmTfidfBounds <-TermDocumentMatrix( #zmieniam wage i wprowadzam granice
  corpus,
  control = list(
    weighting = weightTfIdf,
    bounds = list(
      global = c(2,16)
    )
  )
)
dtmTfidfBounds <- DocumentTermMatrix( #zmieniam wage i wprowadzam granice
  corpus,
  control = list(
    weighting = weightTfIdf,
    bounds = list(
      global = c(2,16)
    )
  )
)


#konwersja macierzy rzadkich do macierzy klasycznych
tdmTfAllMatrix <- as.matrix(tdmTfAll)
dtmTfAllMatrix <- as.matrix(dtmTfAll)
tdmTfidfAllMatrix <- as.matrix(tdmTfidfAll)
tdmBinAllMatrix <- as.matrix(tdmBinAll)
tdmTfBoundsMatrix <- as.matrix(tdmTfBounds)
tdmTfidfBoundsMatrix <- as.matrix(tdmTfidfBounds)
dtmTfidfBoundsMatrix <- as.matrix(dtmTfidfBounds)

#eksport macierzy do pliku .csv
#matrixFile <- paste(
 # outputDir,
#  "\\",
 # "tdmTfidfBounds.csv",
#  sep = ""
#)
##write.table(tdmTfidfBoundsMatrix, file = matrixFile, sep = ";", dec = ",", col.names = NA)

