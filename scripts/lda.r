#wĹ‚Ä…czenie bibliotek
library(topicmodels)

#zmiana katalogu roboczego

workDir <- "E:\\RN\\TextMining12S"
setwd(workDir)

#lokalizacja katalogu ze skryptami 
scriptDir <- ".\\scripts"


#ladowanie skryptu
sourceFile <- paste(
  scriptDir,
  "\\",
  "frequencyMatrix.R",
  sep = ""
)
 source(sourceFile)

#analiza ukrytej alokacji Dirichlet'a
nWords <- ncol(dtmTfAll)
nTopics <- 5
lda <- LDA(
  dtmTfAll,
  k = nTopics,
  method = "Gibbs",
  control = list(
    burnin = 2000,
    thin = 100,
    iter = 3000
  )
)
perplexity <- perplexity(lda, dtmTfAll)
results <- posterior(lda)

#prezentacja tematow
par(mai = c(1,2,1,1))
topic1 <- head(sort(results$terms[1,], decreasing = TRUE), 20)
barplot (
  rev(topic1), 
  horiz = TRUE,
  las = 1,
  main = "Temat 1", #tematyka ktora widziemy na podstawie wynikow
  xlab = "prawdopodobienstwo",
 col = "orange"
)
topic2 <- head(sort(results$terms[1,], decreasing = TRUE), 20)
barplot (
  rev(topic2), 
  horiz = TRUE,
  las = 1,
  main = "Temat 1", #tematyka ktora widziemy na podstawie wynikow
  xlab = "prawdopodobienstwo",
  col = "red"
)
topic3 <- head(sort(results$terms[1,], decreasing = TRUE), 20)
barplot (
  rev(topic3), 
  horiz = TRUE,
  las = 1,
  main = "Temat 1", #tematyka ktora widziemy na podstawie wynikow
  xlab = "prawdopodobienstwo",
  col = "violet"
)
topic4 <- head(sort(results$terms[1,], decreasing = TRUE), 20)
barplot (
  rev(topic4), 
  horiz = TRUE,
  las = 1,
  main = "Temat 1", #tematyka ktora widziemy na podstawie wynikow
  xlab = "prawdopodobienstwo",
  col = "green"
)
topic5 <- head(sort(results$terms[1,], decreasing = TRUE), 20)
barplot (
  rev(topic5), 
  horiz = TRUE,
  las = 1,
  main = "Temat 5", #tematyka ktora widziemy na podstawie wynikow
  xlab = "prawdopodobienstwo",
  col = "green"
)

#prezentacja dokumentów
document1 <- results$topics[1,]
barplot (
  rev(document1), 
  horiz = TRUE,
  las = 1,
  main = rownames(results$topics)[1], #tematyka ktora widziemy na podstawie wynikow, zmieniac nr jak cos 1 1 1 1 las zostaje ten sam
  xlab = "prawdopodobienstwo",
  col = "orange"
)


#udział tematow w slowach
words1<- c("czarodziej", "czarownica", "wampir")
round(results$terms[,words1],2)

words2<- c("harry", "łucja", "bell")
round(results$terms[,words1],2)