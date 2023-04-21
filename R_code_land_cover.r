#giorno 21/04/23   Faremo le mappe di land cover per vedere il cambiamneto delle classi nel tempo
library(raster)
library(ggplot2)  #per i grafici di ggplot
setwd("C:/Telerilevamento_lab")
#caricare le due immagini: defor1 e defor2
defor1 <- brick("defor1_.png")    #brick per importare un pacchetto di bande
defor2 <- brick("defor2_.png")
par(mfrow=c(2,1))    #proiettiamo le immagini in due righe e una colonna   #plot52
plotRGB(defor1, 1,2,3, stretch="Lin")
plotRGB(defor2, 1,2,3, stretch="Lin")

#kmeans è il classificatore e misuriamo le distanze del pixel dalla media delle classi
#getvalues 
#setValues associa le classi a una nuova matrice di colori

singlenr1 <- getValues(defor1)
singlenr1                #ora abbiamo una serie di dati da far studiare a kmeans
kcluster1 <- kmeans(singlenr1, centers = 2)  #lavoriamo con la classificazione kmeans e il numero di centri che usciamo sono due
kcluster1
#prendiamo tutti i valori che abbiamo generato delle classi e otteniamo una immagine, da soli pixel e valori ricaviamo una immagine
defor1class <- setValues(defor1[[1]], kcluster1$cluster)   #otteniamo una immagine
plot(defor1class)    #plot 53  #immagine dove si dstinguono suolo nudo (classe due) e foresta(classe 1); nel suolo nudo è compreso anche il fiume

#stesso processo per la seconda immagine
singlenr2 <- getValues(defor2)
singlenr2
kcluster2 <- kmeans(singlenr2, centers = 2)
kcluster
defor2class <- setValues(defor2[[2]], kcluster2$cluster)
plot(defor2class)    #plot54 #in verde suolo nudo
par(mfrow=c(2,1))
plot(defor1class)
plot(defor2class)


#INSTALLIAMO: install.packages("patchwork")
install.packages("patchwork")


