library(raster)

library (ggplot2)

library(patchwork) # combine separate ggplots into the same graph

setwd("C:/Telerilevamento_lab")  #Let's set the working directory

setwd
#setwd --> function (dir) 
#.Internal(setwd(dir))
#<bytecode: 0x000001aacbeb2c80>
#<environment: namespace:base>

Perito17 <- brick ("perito17_.png") #Brick is a fuction used for upload immage in R (import the create data)

Perito17
#Perito17 --> class      : RasterBrick 
#dimensions : 579, 1250, 723750, 4  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 1250, 0, 579  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : perito17_.png 
#names      : perito17__1, perito17__2, perito17__3, perito17__4 

# Let's see the results in natural colours with plotRGB (red-greem-blue) for the image of 2017
plotRGB(Perito17, 1, 2, 3, stretch="Lin")

#At the same time is possible see the results with another strecht to see the difference
plotRGB(Perito17, 1,2,3, stretch="Hist")

# I want to classify the immage in two classes
# First I get all sigle value in the immage
#I have to (to use the classification function) transform the image values ​​into a series of continuous values ​​-> via getValues ​​(takes the values ​​from an image and puts them back on the printout)
so #in so sono 3 bande da 2 milioni di pixel
singlenr1 <- getValues(Perito17)

singlenr1

View(singlenr1) # to see the single values divide in two columns

#...and then classify. The function used to divide the pixel in different class based on the mean of the value, in two class
kcluster1 <- kmeans(singlenr1, centers = 2)

kcluster1

#...to assign new values to a raster object
Perito17class <- setValues(Perito17[[1]], kcluster1$cluster)

Perito17class
#class      : RasterLayer 
#band       : 1  (of  4  bands)
#dimensions : 579, 1250, 723750  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 1250, 0, 579  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : memory
#names      : perito17__1 
#values     : 1, 2  (min, max)

# Choosing a colorRampPalette for show off of the classes
cl <- colorRampPalette(c('white','yellow','red'))(100)

plot(Perito17class, col=cl)

# Now I need to estimate the frequencies of the different class. 
# I need the total number of the cell in The immage
frequencies1 <- freq(Perito17class)

frequencies1

total1 = ncell (Perito17)

total1

# total number of pixel of the immage (I need the total number to do the percentages of the two different classes)
percentages1= frequencies1 * 100 / total1

percentages1
# percent_substrate17: 42%
# percent_glacier23: 58%

# Now i'm going to do the same things but with the product of 2023

library(raster)

library (ggplot2)

setwd("C:/Telerilevamento_lab")  #Let's set the working directory

setwd
#setwd --> function (dir) 
#.Internal(setwd(dir))
#<bytecode: 0x000001aacbeb2c80>
#<environment: namespace:base>

Perito23 <- brick ("perito23_.png") #Brick is a fuction used for upload immage in R (import the create data)

Perito23
#class      : RasterBrick 
#dimensions : 579, 1250, 723750, 4  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 1250, 0, 579  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : perito23_.png 
#names      : perito23__1, perito23__2, perito23__3, perito23__4

# Let's see the results in natural colours with plotRGB (red-greem-blue) for the image of 2023
plotRGB(Perito23, 1, 2, 3, stretch="Lin")

# I want to classify the immage in two classes
# First I get all sigle value in the immage
singlenr2 <- getValues(Perito23)

singlenr2

View(singlenr2)   # to see the single values divide in two columns

#...and then classify. The function used to divide the pixel in different class based on the mean of the value, in two class
kcluster2 <- kmeans(singlenr2, centers = 2)

kcluster2

#...to assign new values to a raster object
Perito23class <- setValues(Perito23[[1]], kcluster2$cluster) 

Perito23class
#class      : RasterLayer 
#band       : 1  (of  4  bands)
#dimensions : 579, 1250, 723750  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 1250, 0, 579  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : memory
#names      : perito23__1 
#values     : 1, 2  (min, max)

# Choosing a colorRampPalette for show off of the classes
cl <- colorRampPalette(c('white','yellow','red'))(100)

plot(Perito23class, col=cl)

# Multiframe 
par(mfrow=c(1,2))
plot(Perito17class, col=cl, main="Year 2017")
plot(Perito23class, col=cl, main="Year 2023")


# Now I need to estimate the frequencies of the different class. 
# I need the total number of the cell in The immage
frequencies2 <- freq(Perito23class)

frequencies2

total2 = ncell (Perito23class)

total2

# total number of pixel of the immage (I need the total number to do the percentages of the two different classes)
percentages2= frequencies2 * 100 / total2

percentages2
# percent_substrate17: 41%
# percent_glacier23: 59%

# Build graphs for comparison between 2017 and 2023
cover <- c("glacier", "substrate")

percent_2017 <- c(58, 42)

percent_2023 <- c(59, 41)

percentages <- data.frame (cover, percent_2017, percent_2023)

percentages

ggplot (percentages, aes (x=cover, y=percent_2017, color=cover)) + geom_bar (stat="identity", fill= "beige") + labs(title = "Perito_2017")

ggplot (percentages, aes (x=cover, y=percent_2023, color=cover)) + geom_bar (stat="identity", fill= "beige")+ labs(title= "Perito_2023")

p1 <- ggplot (percentages, aes (x=cover, y=percent, color=cover)) + geom_bar (stat="identity", fill= "beige") + labs(title= "Perito_2017")

p2 <- ggplot (percentages, aes (x=cover, y=percent, color=cover)) + geom_bar (stat="identity", fill= "beige") + labs(title= "Perito_2023")

