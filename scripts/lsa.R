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
x <- mds$x[,1]
y <- mds$x[,2]

#przygotowanie legendy
legend <- paste(paste("d",1:length(rownames(dtmTfidfBoundsMatrix)), sep =""),
                rownames (dtmTfidfBoundsMatrix),
                sep = "<-")

#wykres dokumentu
plot(
  x,
  y, 
  xlab="Coordinate 1", 
  ylab="Coordinate 2",
  main="Multidimensional Scalling",
  col = "orange")
text(
  x, 
  y, 
  labels =paste("d",1:length(rownames(dtmTfidfBoundsMatrix)), sep =""),
  pos = 3,
  col = "orange"
)
legend("bottom", legend, cex = .65, text.col = "orange")

#export wykresu do pliku .png
plotFile <- paste(
  outputDir,
  "\\",
  "mds.png",
  sep = ""
)
png(file = plotFile)
plot(
  x,
  y, 
  xlab="Coordinate 1", 
  ylab="Coordinate 2",
  main="Multidimensional Scalling",
  col = "orange")
text(
  x, 
  y, 
  labels =paste("d",1:length(rownames(dtmTfidfBoundsMatrix)), sep =""),
  pos = 3,
  col = "orange"
)
legend("bottom", legend, cex = .65, text.col = "orange")
dev.off()
