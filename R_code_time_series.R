#R code for importin and analysing several images


library(raster)
setwd("C:/Telerilevamento_lab/greenland")
getwd()
lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)                     #plot30
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)                     #plot31
lst_2010 <- raster("lst_2010.tif")
plot(lst_2010)                     #plot32
lst_2015 <- raster("lst_2015.tif")
plot(lst_2015)                     #plot33

ls() #serve a vedere la lista di tutti gli oggetti per vedere se sono stati caricati
#per caricare tutti i file più velocemente: "lapply" permette di applicare una funzone qualsiasi a una intera lista di dati 
list.files(pattern) #pattern è un pezzo di nome comune a tutte le immagini che vogliamo caricare, list.files serve a caricare la lista
rlist <- list.files(pattern="lst")
rlist
#lapply(nome della lista, funzione che vogliamo applicare)
import <- laaply(rlist, raster)   #lapply applica alla lista di file la funzione raster
import

#giorno 31/03/23
library(raster)
setwd("C:/Telerilevamento_lab/greenland")
getwd()
par(mfrow=c(2,2))    #plot34
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)


ls()  #lista oggetti
rlist <- list.files(pattern="lst")  
rlist
import <- lapply(rlist, raster)
import

#utilizza la funzione che si chiamma stack per creare una immagine con tutte e quattro gli oggetti
stack(import)    #invece di importare i singoli file, faccio una lista di file dentro la cartella, importo tutto insieme e faccio lo stack
TGr <- stack(import)
TGr
plot(TGr)  #plot35

plotRGB(TGr, r=1, g=2, b=3, strecht="Lin") #plot36 #in rosso le temperture del 2000, in verde del 2005 e in blu del 2010
#Per vedere dove di preciso è aumentata la temperatura dal 2000 al 2005:
dift = TGr[[2]] - TGr[[1]]
plot(dift)   #plot37

cl <- colorRampPalette(c("blue","light blue","pink","red"))(100) #cambio la scala di colore alle quattro immagini degli anni diversi per notare meglio lo scioglimento dei ghiacciai
plot(TGr, col=cl) #plot38

#analisi multitemporale della variazione dei dati (di ossidi di azoto) en nel tempo (variazione degli ossidi di azoto in Europa
