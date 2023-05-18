#giorno 18/05/23
# Species Distribution Modelling (SDM) è una tecnica che viene utilizzata per modelizzare come vengono distribuite le specie a seconda di informazioni legate all'ambiente(risorse, clima ecc...)
#Dati di presenza (quando esiste una particolare specie) e dati di assenza (quando non esiste la specie)
#Si prendono i dati a terra e i dati ambientali con lo scopo di creare un mappa di distribuzione potenziale della specie (sulla base dei punti campionati)
#A COSA SERVE QUESTO METODO-> 1)Previsione (voglio sapere qaul'è la probabilità più alta di trovare una certa specie in un luogo)   2) capire quali sono i fattori principali che governano una certa specie (presenza di acqua, clima ecc..)
#Prevedere la distribuzione di una certa specie sulla base delle variaibili ambientali

# install.packages("sdm")
# install.packages("rgdal", dependencies=T)    

library(sdm)
library(raster) #gestisce i predittori delle variabili ambientali (sono dati raster in formato immagine)
library(rgdal) #per la gestione dei dati (formato vettoriale) sulle specie

file <- system.file("external/species.shp", package="sdm") #system.file serve a prendere dentro la cartella il file che si chiama species.shp
species <- shapefile(file)

# looking at the set
species

# plot
plot(species, pch=19)     #pch=19 per fare uscire i pallini al posto delle croci

# looking at the occurrences
species$Occurrence     #dove compare il numero 1 la specie è presente, se compare 0 la specie è assente
plot(presences, col="blue", pch=19) #plot75 #prendiamo solo i punti dove l'occorrenza della speie è uguale  a 1
#ora facciamo l'occorrena della specie = a 0 (assenze)
absences <- species[species$Occurrence ==0,]
plot(absences, col="blue", pch=19)   #plot76
# copy and then write:
plot(species[species$Occurrence == 1,],col='blue',pch=16)
points(species[species$Occurrence == 0,],col='red',pch=16)   #plot77

# predictors: look at the path
path <- system.file("external", package="sdm")  

# list the predictors
lst <- list.files(path=path,pattern='asc$',full.names = T) #fullnames per fare vedere tutto il nome
lst

# stack per prenderli tutti assieme
preds <- stack(lst)
plot(preds)  #plot78
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)   #plot79

# plot predictors and occurrences
plot(preds$elevation, col=cl)    #morfologia
points(species[species$Occurrence == 1,], pch=16)  #plot80

plot(preds$temperature, col=cl)    #temperatura
points(species[species$Occurrence == 1,], pch=16)   #plot81

plot(preds$precipitation, col=cl)    #precipitazioni
points(species[species$Occurrence == 1,], pch=16)   #plot82

plot(preds$vegetation, col=cl)   #vegetazione
points(species[species$Occurrence == 1,], pch=16)   #plot83

#modello per vedere di creare una mappa di distribuzione continua della specie nello spazio

# set the data for the sdm
datasdm <- sdmData(train=species, predictors=preds)
datasdm 
# modello, spiegare al sistema quali sono i dati che andremo a utilizzare
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")    #m1 è il modello
#sdm è la funzione per fare il modello e crea una mappa della distribuzione della specie nello spazio
# make the raster output layer
p1 <- predict(m1, newdata=preds)   #predict crea una mappa delle distribuzioni della specie

# plot the output
plot(p1, col=cl)   #ESCE TROPPO PICCOLO -> CHIEDI AL PROF
points(species[species$Occurrence == 1,], pch=16)   #plot84

# add to the stack
s1 <- stack(preds,p1)
plot(s1, col=cl)    #plot85

# Do you want to change names in the plot of the stack?
# Here your are!:
# choose a vector of names for the stack, looking at the previous graph, qhich are:
names(s1) <- c('elevation', 'precipitation', 'temperature', 'vegetation', 'model')
# and then replot!:
plot(s1, col=cl)
# you are done, with one line of code (as usual!)
