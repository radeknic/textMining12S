#wĹ‚Ä…czenie bibliotek
library(lsa)

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

#analiza wymiaróW ukrytych semantycznych (dekompozycja wg wartosci osobliwych )
lsa <- lsa(tdmTfidfBoundsMatrix)
lsa$tk #odpowiednik macierzy U, współrzędne wyrazów 
lsa$dk #odpowiednik macierzy V, współrzędne dokumentów
lsa$sk #odpowiednik macierzy D, znaczenie składowych


#przygotowanie współrzędnych do wykresu 
coordDocument <- lsa$dk%*%diag(lsa$sk)
coordTerms <- lsa$tk%*%diag(lsa$sk)
words <- c("harry", "czarodziej", "dumbledore", "hermiona", "ron", "komnata", "powiedzieć", "chcieć", "dowiadywać", "albus", "syriusz", "lupin", "umbridge", "edmund", "kaspian", "łucja", "czarownica", "piotr", "zuzanna", "aslana", "narnii", "baron", "dziecko", "wyspa", "bell", "edward", "wampir", "jacob")
termsImportance <- diag(coordTerms%*%t(diag(lsa$sk)%*%t(lsa%tk)))
importantWords <- names(tail(sort, termsImportance),25))
coordWords <- coordTerms[importantWords]
x1 <- coordDocument[,1]
y1 <- coordDocument[,2]
x2 <- coordWords[,1]
y2 <- coordWords[,2]

#przygotowanie legendy
legend <- paste(paste("d",1:length(rownames(coordDocument)), sep =""),
                rownames (dtmTfidfBoundsMatrix),
                sep = "<-")

#wykres dokumentu
plot(
  x1,
  y1, 
  xlab="Coordinate 1", 
  ylab="Coordinate 2",
  main="Multidimensional Scalling",
  col = "orange")
text(
  x1, 
  y1, 
  labels =paste("d",1:length(rownames(coordDocument)), sep =""),
  pos = 4,
  col = "orange"
)
legend("bottom", legend, cex = .65, text.col = "orange")

#export wykresu do pliku .png
plotFile <- paste(
  outputDir,
  "\\",
  "lsa.png",
  sep = ""
)
png(file = plotFile)
points(
  x2,
  y2, 
  xlab="Coordinate 1", 
  ylab="Coordinate 2",
  main="Multidimensional Scalling",
  pch =2,
  col = "brown")
text(
  x2, 
  y2, 
  labels =rownames(coordWords),
  pos = 4,
  col = "brown"
)
legend("bottom", legend, cex = .65, text.col = "orange")
dev.off()
