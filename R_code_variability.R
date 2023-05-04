#giorno 04/05/23
library(raster)
library(ggplot2)
install.packages("viridis")    #virgolette per richiamare qualcosa di esterno a R
library(viridis)   #applica delle scale di colore per il pacchetto ggplot2
library(patchwork)
setwd("C:/Telerilevamento_lab")
#utilizziamo la fnzione brick per importare l'immagine
sen <- brick("sentinel.png")

#band1 =NIR
#band2= red
#band3= green

plotRGB(sen, 1, 2, 3, sretch="Lin")   #plot60
nir <- sen[[1]]
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)   #funzione generale che fa calcoli(media,dev.std, varianza ecc..)   #nir è la banda 1; matrix(matrice 3x3), 1/9 è un totale di nove pixel distribuite 3x3
plot(sd3)  #per vedere la dev.std  #plot61

#ggplot apre la finestra per poi inserire il vero plot; geom_raster serve per la geometria del raster e dire chi è il raster cioè sd3
sd3d <- as.data.frame(sd3, xy=TRUE)  #dobbiamo trasformare i nostri valori da raster a as.datat.frame, sd3 è il nome della matrice
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation by viridis package")   #plot63  #ggtitle è per dare un titolo al plot
#magma è una nuova scala di colori

ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation by viridis package")    #plot64

#per caricare le due immagini assieme:
p1 <- ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +      
scale_fill_viridis() +                             #per scegliere la scala cromatica
ggtitle("Standard deviation by viridis package")   #ggtitle da il titolo

p2 <- ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "inferno") +
ggtitle("Standard deviation by viridis package")

p1 + p2   #plot65



#plot dell'immagine originale (nir) e la std.dev

nird <- as.data.frame(nir, xy=T)  #prendiamo il nir, lo trasformiamo in data frame nir(T)
p3 <- ggplot()+
geom_raster(nird, mapping =aes(x=x, y=y, fill=sentinel_1)) +
scale_fill_viridis(option = "cividis") +
ggtitle("NIR via the cividis colour scale")
p3   #plot66

p3+p1   #plot67
