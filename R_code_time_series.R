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
#per caricare tutti i file più velocemente: "lapply" permette 
list.files(pattern) #pattern è un e+pezzo di nome comune a tutte le immagini che vogliamo caricare, list.files serve a cariare la lista
rlist <- list.files(pattern="lst")
rlist
#lapply(nome della lista, funzione che vogliamo applicare)
import <- laaply(rlist, raster)
import
