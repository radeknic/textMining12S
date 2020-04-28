#wĹ‚Ä…czenie bibliotek
library(proxy)

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

#skalowanie wielowymiarowe
distCos <- dist(dtmTfidfBoundsMatrix) #wyznacza odleglosc przy uzyciu konkretnej miary. dokumenty to obserwacje, a slowa to cechy ktore opisuja 
#te obserwacje, skutkiem tego jest macierz odleglosci miedzy konkretnymi dokumentami
mds <- cmdscale(distCos,eig=TRUE, k=2) #wykonuje skalowanie wielowymiarowe- przestrzen 2000 wymiarową- a to redukujemy do 2 wymiarow
x <- mds$points[,1]
y <- mds$points[,2]

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
