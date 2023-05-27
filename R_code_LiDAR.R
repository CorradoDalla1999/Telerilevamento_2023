#calcolo del CHM
# CHM = DSM - DTM (surface model - terrain model)
# Load needed packages
library(raster) #"Geographic Data Analysis and Modeling"
library(rgdal) #"Geospatial Data Abstraction Library"
library(viridis)
library(ggplot2)

setwd("C:/lab/dati/")

dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")

dsm_2013d <- as.data.frame (dsm_2013, xy=T)
names (dsm_2013d) <- c("x", "y", "z")
head (dsm_2013d)

ggplot() +
geom_raster (dsm_2013d, mapping = aes (x=x, y=y, fill=z)) +
scale_fill_viridis ()+
ggtitle ("dsm 2013")    #plot86

dtm_2013 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")

dtm_2013d <- as.data.frame (dtm_2013, xy=T)
names (dtm_2013d) <- c("x", "y", "z")
head (dtm_2013d)

ggplot() +
geom_raster (dtm_2013d, mapping = aes (x=x, y=y, fill=z)) +
scale_fill_viridis ()+
ggtitle ("dtm 2013")   #plot87

chm_2013 <- dsm_2013 - dtm_2013
chm_2013d <- as.data.frame(chm_2013, xy=T)
names (chm_2013d) <- c("x", "y", "z")
head (chm_2013d)

ggplot() +
geom_raster (chm_2013d, mapping = aes (x=x, y=y, fill=z)) +
scale_fill_viridis ()+
ggtitle ("chm 2013")  #plot88

p1 <- ggplot() +
geom_raster (dsm_2013d, mapping = aes (x=x, y=y, fill=z)) +
scale_fill_viridis ()+
ggtitle ("dsm 2013")

p2 <- ggplot() +
geom_raster (dtm_2013d, mapping = aes (x=x, y=y, fill=z)) +
scale_fill_viridis ()+
ggtitle ("dtm 2013")

p3 <- ggplot() +
geom_raster (chm_2013d, mapping = aes (x=x, y=y, fill=z)) +
scale_fill_viridis ()+
ggtitle ("chm 2013")

p1 + p2 + p3    #plot89







## point cloud

library(lidR)

#load point cloud
point_cloud<-readLAS("C:/Users/MiTorresani/OneDrive - Alma Mater Studiorum Universit� di Bologna/lezioni/UniBo/esercizi/dati/DownloadService/LIDAR-PointCloudCoverage-2013SolarTirol.laz")

#plot r3 point cloud
plot(point_cloud)
