#giorno14/04/23

library(raster)                    #raster porta dentro R solo singoli strati, brick invece tira dentro dati con diversi livelli
setwd("C:/Telerilevamento_lab")    #settaggio della working directory
getwd()
so <- brick("Solar_Orbiter.jpg")  #importiamo l'immagine della solar_orbiter(so)
plotRGB(so, 1,2,3, stretch="Lin")   #plot46  #3 livelli energetici dal colore piu scuro a quello più chiaro
#nasa earth observatory -> per ricavare immagini per l'esame
#Quanta energia ce in questa immagine?
plotRGB(so, 1,2,3, stretch="Hist")   #plottaggio con stretch a istogramma   #plot47

#Dobbiamo (per utilizzare la funzione di classificazione) trasformare i valori dell'immagine in una serie di valori continui -> tramite getValues (prende i vslori da un aimmagine e li rimette sul tabulato)
so #in so sono 3 bande da 2 milioni di pixel
singlenr <- getValues(so)   #prende ogni singolo pixel dell'immagine 
kcluster <- kmeans(singlenr, centers = 3)  #raggruppa i pixel su delle classi basnadosi sulla media dei loro valori, si ottiene il centroide e si misura la distanza tra il punto incognito e il centroide (delle singoli classi)
kcluster   #kmeans lavora su una serie di numeri (trasforma ai valori di riflettanza in una serie di numeri tramite getValues), l'unica cosa che si deve decidere è il numero di classi che vogliamo tirare fuori -> in questo caso 3 (centers = 3)
#a noi piacciono i colori -> abbiniamo ai valori un colore
soclass <- setValues(so[[1]], kcluster$cluster)  #restituisce i valori ottenuti in formato immagine abbinando a ogni singola classe dei colori (setvalues passa dei dati continui in formato immagine)
#per unire due pezzi dentro R si usa il $ 
cl <- colorRampPalette(c('yellow','black','red'))(100)   #giallo è la classe numero 1 -> valore energetico più alto  (sono il 21%), rosso invece classe energetica intermedia (41%), nero valore più basso  (37%)
plot(soclass, col=cl)   #plot48
#quant'è la percentuale di pixel a bassa o alta energia? 
frequencies <- freq(soclass)
frequencies   #frequenze delle 3 classi
tot = 2221440
percentages = frequencies * 100 /  tot    
percentages #per vedere il risultato


#giorno 20/04/23
#concetti di classificiazione sul Gran Canyon
library(raster)
setwd("C:/Telerilevamento_lab")
#caricamento dell'immagine
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
gc
plotRGB(gc, 1,2,3, stretch="Lin")  #plot49
#Ora ritaglieremo l'immagine (peserà meno), disegneremo un rettangolo nell'immagine per ritagliarlo (utilizzeremo crop)
gcc <- crop(gc, drawExtent())
plotRGB(gcc, 1,2,3, stretch="Lin")  #plot50  #Immagine ritagliata
ncell(gcc) #numero di pixel dell'immagine ritagliata

#tirare fuori i valori dei pixel (catturare i valori dei pixel dell'immagine ritagliata):
singlenr <- getValues(gcc)
singlenr
#classificazione -> associa ad ogni pixel incognito una classe (scegliamo 3 classi)
kcluster <- kmeans(singlenr, centers=3)  
kcluster
gcclass <- setValues(gcc[[1]], kcluster$cluster) # i valori vengono associati ad una immagine. il simblo del dollaro unise due funzioni
plot(gcclass)   #plot51
#classe 1: rocce vulcaniche
#classe 2: arenarie
#classe 3: conglomerati
#calcolo frequenze di queste classi: numero di pixel per ogni classe
frequencies <- freq(gcclass)
frequencies
#estraiamo il totale
total=ncell (gcclass)
total
percentages = frequencies * 100 /  total    
percentages #per vedere il risultato
install.packages("ggplot2")   #installazione





