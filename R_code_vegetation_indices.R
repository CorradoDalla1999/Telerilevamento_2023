#giorno 24/03/23
#esrecizio: import defor1_.png
library(raster)
setwd("C:/Telerilevamento_lab")   #La directory di lavoro (setwd) è la cartella nella quale verranno salvati / cercati di default i file.
getwd()                           #getwd per scoprire in che cartella stai salvando il programma, setwd per cambiarla
l1992 <- brick("defor1_.png")     #brick importa intero set di bande, diamo al file il nome l1992
l1992                             #nome dell'immagine
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")    #plotto la mappa tramite diffusione a 3 livelli NIR=1, Red=2 and Green=3
l1992 =l1992[[1]]-l1992[[2]]                 #Banda infrarosso meno la banda del rosso, DVI= different vegetation index
dvil1992
cl <- colorRampPalette(c('darkblue','yellow','red','black')) (100)
plot(dvil1992, col=cl)         #plot22 #colore determinante è il giallo che rappresenta il deforestamento


#stesso procedimento con l2006:
library(raster)
setwd("C:/Telerilevamento_lab")
getwd()
l2006 <- brick("defor2_.png")   #con brick carico i dati
l2006
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
dvil2006 =l2006[[1]]-l2006[[2]]
dvil2006
cl <- colorRampPalette(c('darkblue','yellow','red','black')) (100)
plot(dvil2006, col=cl)     #plot23



par(mfrow=c(2,1))     #tramite par carico le due immagini ottenute in precedenza (plot: 22 e 23) in una singola immagine a 2 righe e una colonna 
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin") #plot24
#per metterle invece una accanto all'altra:
par(mfrow=c(1,2))     
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin") #plot25

#giorno 30/03/23 
#nella parte iniziale della lezione vengono rifatte le stesse cose dela scorsa lezone(non le riscriverò)
library(raster)
setwd("C:/Telerilevamento_lab")
getwd()
#analisi multitemporale, differenza tra due DVI (1992 vs 2006), dove la differenza sarà alta vorrà dire maggiore distruzione in questo intervallo di tempo
difdvi = dvil1992 - dvil2006
cld <- colorRampPalette(c('blue','white','red')) (100)
plot(difdvi, col=cld)   #plot26
#Non si possono paragonare due immagini che hanno bit diversi, per sistemare il problema si normailzza il dvi -> NDVI (cioè normal dvi)
# NDVI 1992 normalizziamo sulla somma delle due bande (differenza diviso la somma), il numero di bit di una immagine è la risoluzione radiometrica,spettrale  e spaziale
ndvi1992 = dvil1992 / (l1992[[1]] + l1992[[2]])
plot(ndvi1992, col=cl)    #plot27
#calcoliamo il NDVI del 2006
ndvi2006 = dvil2006 / (l2006[[1]] + l2006[[2]])
plot(ndvi2006, col=cl)  #plot28

#differenza tra i due ndvi
difndvi = ndvi1992 - ndvi2006
plot(difndvi, col=cld)  #plot29
