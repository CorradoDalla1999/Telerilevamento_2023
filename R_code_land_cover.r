#giorno 21/04/23   Faremo le mappe di land cover per vedere il cambiamneto delle classi nel tempo
library(raster)
library(ggplot2)  #per i grafici di ggplot
library(patchwork)

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
#lavoriamo sulle frequenze per poi fare dei plot con gli istogrami che mostrino le differenze
#quanta aea occupano le due classi in percentuale?
frequencies1 <- freq(defor1class)
frequencies1
tot1 <- ncell(defor1class)  #per vedere da quanti pixel è composto
tot1
percentages1 = frequencies1 * 100 / tot1
percentages1  #foresta circa 90% 
#stessa cosa con defor2class
frequencies2 <- freq(defor2class)
frequencies2
tot2 <- ncell(defor2class)  #per vedere da quanti pixel è composto
tot2
percentages2 = frequencies2 * 100 / tot2
percentages2    #52.07 la foresta 

#Faccio una tabella con i valori ottenuti
cover <- c("Forest","Bare soil")  #prima colonna che avrà due valori
percent_1992 <- c(89.746, 10.253)
percent_2006 <- c(52.069, 47.931)

percentages <- data.frame(cover, percent_1992, percent_2006)  #per creare la tabella
percentages

#Facciamo il plot per ottenere tabella ed istogrammi
ggplot(percentages, aes(x=cover, y=percent1992, color=cover)) + geom_bar(stat="identity", fill="white")  #geom_bar crea istogrammi, fill è il colore di riempimento delle barre #plot55

ggplot(percentages, aes(x=cover, y=percent2006, color=cover)) + geom_bar(stat="identity", fill="white")  #plot56

p1 <- ggplot(percentages, aes(x=cover, y=percent1992, color=cover)) + geom_bar(stat="identity", fill="white")

p2 <- ggplot(percentages, aes(x=cover, y=percent2006, color=cover)) + geom_bar(stat="identity", fill="white")

p1+p2   #plot57

#per ottenere lo stesso risultato con però un range da 0 a 100 in termini quantitativi
p1 <- ggplot(percentages, aes(x=cover, y=percent1992, color=cover)) + geom_bar(stat="identity", fill="white") +
ylim(c(0,100))

p2 <- ggplot(percentages, aes(x=cover, y=percent2006, color=cover)) + geom_bar(stat="identity",
fill="white") +
ylim(c(0,100))

p1+p2   #plot58


