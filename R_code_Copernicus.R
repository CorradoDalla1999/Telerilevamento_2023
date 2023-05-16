#giorno 11/05/23
#come scaricare una immagine da copernicus e vederla in R
library(raster)

install.packages("ncdf4")   #installazione 
library(ncdf4)              #abbiamo la library appena installata, serve a importare il dataset
library(ggplot2)            
library(viridis)
setwd("C:/Telerilevamento_lab")

# register and download data from, dobbiamo scegliere la variabile a noi interessata 
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html  #sito dal quale scaricheremo i dati (valori a 8 bit)
#dataset che userò: c_gls_BA300_202105010000_GLOBE_S3_V3.0.1.nc   (è sulla distrubuzione spaziale degli incendi)
fd <- raster("c_gls_BA300_202105010000_GLOBE_S3_V3.0.1.nc")   #fd sta per fire distribution


fd
plot(fd)

ggplot() +
+ geom_raster(ssoil, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture))

# with viridis
ggplot() +
geom_raster(ssoil, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) +
scale_fill_viridis(option="magma")

#giorno 12/05/23
library(ncdf4)
library(raster)
library (ggplot2)
library (viridis)
setwd("C:/Telerilevamento_lab")
sc <- raster("c_gls_SSM1km_202305030000_CEURO_S1CSAR_V1.2.1.nc")
plot(sc)    #plot73

scd <- as.data.frame (sc, xy=T)

ggplot() + 
  geom_raster (scd, mapping=aes (x=x, y=y, fill=Surface.Soil.Moisture))
ggtitle("Soil Moisture from Copernicus")   #plot74

# Cropping an image
ext <- c (23,30,62,68)

sc_crop <- crop (sc, ext)
plot (sc_crop)

# Exercise: plot cropped image with ggplot
sc_cropd <- as.data.frame (sc_crop, xy=T)

ggplot() + 
  geom_raster (sc_cropd, mapping=aes (x=x, y=y, fill=Surface.Soil.Moisture))
ggtitle("Soil Moisture from Copernicus, cropped")

# with viridis
ggplot() +
  geom_raster(sc_cropd, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) +
  scale_fill_viridis(option="viridis")
