# R cocde per scaricare e visualizzare data-Copernicus
# install.packages("ncdf4")
library(ncdf4)
library(raster)
setwd("C:/Telerilevamento_lab")
sc <- raster("c_gls_SSM1km_202305030000_CEURO_S1CSAR_V1.2.1.nc")
plot(sc)   #plot73
