#giorno 05/05/23
library(raster)
library(ggplot2)
library(viridis)  #necessario aggiungerlo perchè vengono usate le scale di colore

setwd("C:/Telerilevamento_lab") #Poichè uso windows
sen <- brick("sentinel.png")
sen
plot(sen)   #plot68
sen2 <- stack(sen[[1]], sen[[2]], sen[[3]])
plot(sen2)   #plot69
pairs(sen2)  #plot70

# PCA (Principal Component Analysis)
sample <- sampleRandom(sen2, 10000)
pca <- prcomp(sample)

# variance explained
summary(pca)

# correlation with original bands
pca

# pc map
pci <- predict(sen2, pca, index=c(1:2))
plot(pci[[1]])    #plot71
pcid <- as.data.frame(pci[[1]], xy=T)
ggplot() +
geom_raster(pcid, mapping = aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis()    #plot72



# aggregate cells: resampling (ricampionamento)
senres <- aggregate(sen, fact=10)

# Ripetere lo stesso processo PCA
