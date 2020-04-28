#wĹ‚Ä…czenie bibliotek          analiza glownych składowych


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

#analiza glownych skladowych
pca <- prcomp(dtmTfidfBounds)
x <- pca$X[,1]
y <- pca$x[,2]

#przygotowanie legendy
legend <- paste(paste("d",1:length(rownames(dtmTfidfBoundsMatrix)), sep =""),
                rownames (dtmTfidfBoundsMatrix),
                sep = "<-")

#wykres dokumentu w przestrzenii
plot(
  x,
  y, 
  xlab="współrzędna syntetyczna 1", 
  ylab="współrzędna syntetyczna 2",
  main="analiza glownych skladowych",
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
  "pca.png",
  sep = ""
)
png(file = plotFile)
plot(
  x,
  y, 
  xlab="współrzędna syntetyczna 1", 
  ylab="współrzędna syntetyczna 2",
  main="analiza glownych skladowych",
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
