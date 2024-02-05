library(raster)

library (ggplot2)

setwd("C:/Telerilevamento_lab")

setwd

Perito23 <- brick ("perito23_.png")

Perito23

plotRGB(Perito23, 1, 2, 3, stretch="Lin")

singlenr1 <- getValues(Perito23)

singlenr1

kcluster1 <- kmeans(singlenr1, centers = 2)

kcluster1

Perito23class <- setValues(Perito23[[1]], kcluster1$cluster)

Perito23class

cl <- colorRampPalette(c('white','yellow','red'))(100)

plot(Perito23class, col=cl)

frequencies1 <- freq(Perito23class)

frequencies1

total1 = ncell (Perito23)

total1

percentages1= frequencies1 * 100 / total1

percentages1

library(raster)

library (ggplot2)

setwd("C:/Telerilevamento_lab")

setwd

Perito17 <- brick ("perito17_.png")

Perito17

plotRGB(Perito17, 1, 2, 3, stretch="Lin")

singlenr2 <- getValues(Perito17)

singlenr2

View(singlenr2)

kcluster2 <- kmeans(singlenr2, centers = 2)

kcluster2

Perito17class <- setValues(Perito17[[1]], kcluster2$cluster) # to assign new values to a raster object

Perito17class

cl <- colorRampPalette(c('white','yellow','red'))(100)

plot(Perito17class, col=cl)

par(mfrow=c(1,2))

plot(Perito17)

plot(Perito23)

frequencies2 <- freq(Perito17class)

frequencies2

total2 = ncell (Perito17class)

total2

percentages2= frequencies2 * 100 / total2

percentages2

cover <- c("glacier", "substrate")

percent_2017 <- c(42, 58)

percent_2023 <- c(59, 42)

percentages <- data.frame (cover, percent_2017, percent_2023)

percentages

ggplot (percentages, aes (x=cover, y=percent_2017, color=cover)) + geom_bar (stat="identity", fill= "beige") + labs(title = "Perito_2017")

ggplot (percentages, aes (x=cover, y=percent_2023, color=cover)) + geom_bar (stat="identity", fill= "beige")+ labs(title= "Perito_2023")

p1 <- ggplot (percentages, aes (x=cover, y=percent_2017, color=cover)) + geom_bar (stat="identity", fill= "beige") + labs(title= "Perito_2017")

p2 <- ggplot (percentages, aes (x=cover, y=percent_2023, color=cover)) + geom_bar (stat="identity", fill= "beige") + labs(title= "Perito_2023")

