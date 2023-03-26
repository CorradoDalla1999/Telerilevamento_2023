#giorno 24/03/23
#esrecizio: import defor1_.png
library(raster)
setwd("C:/Telerilevamento_lab")   #La directory di lavoro (setwd) è la cartella nella quale verranno salvati / cercati di default i file.
getwd()                           #getwd per soprire in che cartella stai salvando il programma, setwd per cambiarla
l1992 <- brick("defor1_.png")     #brick importa intero set di bande, diamo al file il nome l1992
l1992
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")    #plotto la mappa tramite diffusione a 3 livelli NIR=1, Red=2 and Green=3
l1992 =l1992[[1]]-l1992[[2]]                 #Banda infrarosso meno la banda del rosso DVI= different vegetation index
dvil1992
cl <- colorRampPalette(c('darkblue','yellow','red','black')) (100)
plot(dvil1992, col=cl)         #plot22


#stesso procedimento con l2006:
library(raster)
setwd("C:/Telerilevamento_lab")
getwd()
l2006 <- brick("defor2_.png")
l2006
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
dvil2006 =l2006[[1]]-l2006[[2]]
dvil2006
cl <- colorRampPalette(c('darkblue','yellow','red','black')) (100)
plot(dvil2006, col=cl)     #plot23



par(mfrow=c(2,1))     #tramite par carico le ue immagini ottenute in precedenza (plot: 22 e 23) in una singola immagine a 2 righe e una colonna 
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")  #plot24

