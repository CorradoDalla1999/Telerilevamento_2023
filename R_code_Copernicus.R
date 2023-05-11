#come scaricare una immagine da copernicus e vederla in R
library(raster)

install.packages("ncdf4")   #installazione 
library(ncdf4)              #abbiamo la library appen ainstallata
library(ggplot2)            
library(viridis)
setwd("C:/Telerilevamento_lab")

# register and download data from, dobbiamo scegliere la variabile a noi interessata 
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html  #sito dal quale scaricheremo i dati (valori a 8 bit)
#dataset che userò: c_gls_BA300_202105010000_GLOBE_S3_V3.0.1.nc   (è sulla distrubuzione spaziale degli incendi)
ssoil <- raster("~/Downloads/c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc")

ssoil

plot(ssoil)

ggplot() +
+ geom_raster(ssoil, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture))

# with viridis
ggplot() +
geom_raster(ssoil, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) +
scale_fill_viridis(option="magma")
