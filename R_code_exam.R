# Good morning everyone!
# Below you will find my R code regarding the melting of the Perito Moreno glaciers in the Calafate area (Patagonia, AR).
# To best show the possible variations regarding the surface distribution of the glacier I chose two different images, one from 04/11/2017 and one from 01/11/2023.
# The images were obtained through the Eo_browser_Sentinel website (https://apps.sentinel-hub.com).
# I think that in six years the glacier system will have retreated and reduced in volume, but now we'll find out!

# Project key points:
# To start it was necessary to have the two images referring to the two different dates.
# Insert them into the R system to then make the glacier distribution calculations.
# After the numerical and percentage calculation, again using R, report the data obtained with graphs.
# As we often saw during the lesson, it is useful to represent the same products obtained through different color scales in order to also help color blind people.
# I will show the same product with Viridis scales color.

# Now let's go!

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

# Install and load the needed packages that i will use in the R_files:
# install.packages("raster")
# install.packages("ggplot")
# install.packages("patchwork")
# install.packages("viridis")

library(raster)                           # Analysis and modeling of spatial data.

library (ggplot2)                         # For creating graphs.

library(patchwork)                        # Combine separate ggplots into the same graph.

setwd("C:/Telerilevamento_lab")           # Let's set the working directory.

setwd
#setwd --> function (dir) 
#.Internal(setwd(dir))
#<bytecode: 0x000001aacbeb2c80>
#<environment: namespace:base>

Perito17 <- brick ("perito17_.png")       # Brick is a fuction used for upload immage in R (import the create data).

Perito17
#Perito17 --> class      : RasterBrick 
#dimensions : 579, 1250, 723750, 4  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 1250, 0, 579  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : perito17_.png 
#names      : perito17__1, perito17__2, perito17__3, perito17__4 

# Let's see the results in natural colours with plotRGB (red-green-blue) for the image of 2017:
plotRGB(Perito17, 1, 2, 3, stretch="Lin")

# Too observe the number of cells..
ncell(Perito17)

# At the same time is possible see the results with another strecht to see the difference:
plotRGB(Perito17, 1, 2, 3, stretch="Hist")

# I want to classify the immage in two classes.
# First I get all sigle value in the immage.
# I have to (to use the classification function) transform the image values ​​into a series of continuous values ​​-> via getValues ​​(takes the values ​​from an image and puts them back on the printout).
singlenr1 <- getValues(Perito17)

singlenr1

# To see the single values divide in two columns:
View(singlenr1)            

# The function (kmeans) allows you to group pixels on classes based on the average of their values, the center of gravity is obtained and the distance between the unknown point and the center of gravity (of the individual classes) is measured.
kcluster1 <- kmeans(singlenr1, centers = 2)

kcluster1

#...to assign new values to a raster object
# setValues --> returns the values ​​obtained in image format by combining each individual color class (setvalues ​​passes continuous data in image format).
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

# Choosing a colorRampPalette for show off of the classes, the number 100 indicates the shade number.
cl <- colorRampPalette(c('white','yellow','red'))(100)

plot(Perito17class, col=cl)

# Now I need to estimate the frequencies of the different class. 
# I need the total number of the cell in The immage:
frequencies1 <- freq(Perito17class)

frequencies1

total1 = ncell (Perito17)

total1

# Total number of pixel of the immage (I need the total number to do the percentages of the two different classes).
percentages1= frequencies1 * 100 / total1

percentages1
# percent_substrate17: 42%
# percent_glacier17: 58%

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>t
# Now i'm going to do the same things but with the product of 2023:

library(raster)                           # Analysis and modeling of spatial data.

library (ggplot2)                         # For creating graphs.

library(patchwork)                        # Combine separate ggplots into the same graph.

setwd("C:/Telerilevamento_lab")           # Let's set the working directory.

setwd
#setwd --> function (dir) 
#.Internal(setwd(dir))
#<bytecode: 0x000001aacbeb2c80>
#<environment: namespace:base>

Perito23 <- brick ("perito23_.png")       # Brick is a fuction used for upload immage in R (import the create data).

Perito23
#class      : RasterBrick 
#dimensions : 579, 1250, 723750, 4  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 1250, 0, 579  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : perito23_.png 
#names      : perito23__1, perito23__2, perito23__3, perito23__4

# Let's see the results in natural colours with plotRGB (red-green-blue) for the image of 2023.
plotRGB(Perito23, 1, 2, 3, stretch="Lin")

# To observe the number of cells:
ncell(Perito23)

# At the same time is possible see the results with another strecht to see the difference.
plotRGB(Perito23, 1,2,3, stretch="Hist")

# I want to classify the immage in two classes.
# First I get all sigle value in the immage:
singlenr2 <- getValues(Perito23)

singlenr2

View(singlenr2)                    # To see the single values divide in two columns.

#...and then classify. The function used to divide the pixel in different class based on the mean of the value, in two class.
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

# Choosing a colorRampPalette for show off of the classes:
cl <- colorRampPalette(c('white','yellow','red'))(100)

plot(Perito23class, col=cl)

# Multiframe:
par(mfrow=c(1,2))
plot(Perito17class, col=cl, main="Year 2017")
plot(Perito23class, col=cl, main="Year 2023")

# Now I need to estimate the frequencies of the different class. 
# I need the total number of the cell in The immage.
frequencies2 <- freq(Perito23class)

frequencies2

total2 = ncell (Perito23class)

total2

# Total number of pixel of the immage (I need the total number to do the percentages of the two different classes).
percentages2= frequencies2 * 100 / total2

percentages2
# percent_substrate23: 41%
# percent_glacier23: 59%

# Build graphs for comparison between 2017 and 2023:
cover <- c("glacier", "substrate")

percent_2017 <- c(58, 42)

percent_2023 <- c(59, 41)

percentages <- data.frame (cover, percent_2017, percent_2023)

percentages

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

# Now the goal is to be able to represent the results obtained in a graphic way:
ggplot (percentages, aes (x=cover, y=percent_2017, color=cover)) + geom_bar (stat="identity", fill= "beige") + labs(title = "Perito_2017")

ggplot (percentages, aes (x=cover, y=percent_2023, color=cover)) + geom_bar (stat="identity", fill= "beige")+ labs(title= "Perito_2023")

p1 <- ggplot (percentages, aes (x=cover, y=percent, color=cover)) + geom_bar (stat="identity", fill= "beige") + labs(title= "Perito_2017")

p2 <- ggplot (percentages, aes (x=cover, y=percent, color=cover)) + geom_bar (stat="identity", fill= "beige") + labs(title= "Perito_2023")

# To better observe the variations recorded in six years it is useful to compare the two graphs obtained.
p1 + p2

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

# TO HELP COLOR BLIND PEOPLE.... I chose to represent the same images about the variation in distribution of the glacier on the surface through the Viridis color scale.

library(raster)                           # Analysis and modeling of spatial data.

library (ggplot2)                         # For creating graphs.

library(patchwork)                        # Combine separate ggplots into the same graph.

library(viridis)                          # Color maps designed to improve graph readability for readers with common forms of color blindness and/or color vision deficiency.

setwd("C:/Telerilevamento_lab")           # Let's set the working directory.

Perito17 <- brick ("Perito17_.png")       # Brick is a fuction used for upload immage in R (import the create data).

Perito17

plot(Perito17)                            # Show the image of Perito17 

# Stacking vectors concatenates multiple vectors into a single vector along with a factor indicating where each observation originated.
Perito1 <- stack(Perito17[[1]], Perito17[[2]], Perito17[[3]])   

plot(Perito1)

# The sample() function draws randomly from a specified set of (scalar) objects allowing you to sample from arbitrary distributions of numbers. 
sample <- sampleRandom(Perito1, 10000)

# prcomp --> Performs a principal components analysis on the given data matrix and returns the results as an object of class.
pca1 <- prcomp(sample)

pca1

# predict is a generic function for predictions from the results of various model fitting functions.
pci1 <- predict(Perito1, pca1, index=c(1:2))

plot(pci1[[1]])

# as.data.frame --> Functions to check if an object is a data frame, or coerce it if possible.
pcid <- as.data.frame(pci1[[1]], xy=T)
ggplot() + geom_raster(pcid, mapping = aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis() + ggtitle("Perito17_viridis")

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

Perito23 <- brick ("Perito23_.png")           # Brick is a fuction used for upload immage in R (import the create data).

Perito23

plot(Perito23)                                # Show the image of Perito23

# Stacking vectors concatenates multiple vectors into a single vector along with a factor indicating where each observation originated.
Perito2 <- stack(Perito23[[1]], Perito23[[2]], Perito23[[3]])

plot(Perito2)

# The sample() function draws randomly from a specified set of (scalar) objects allowing you to sample from arbitrary distributions of numbers.
sample <- sampleRandom(Perito2, 10000)

# prcomp --> Performs a principal components analysis on the given data matrix and returns the results as an object of class.
pca2 <- prcomp(sample)

pca2

# predict is a generic function for predictions from the results of various model fitting functions.
pci2 <- predict(Perito2, pca2, index=c(1:2))

plot(pci2[[1]])

# as.data.frame --> Functions to check if an object is a data frame, or coerce it if possible.
pcid <- as.data.frame(pci2[[1]], xy=T)
ggplot() + geom_raster(pcid, mapping = aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis() + ggtitle("Perito23_viridis")

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

# My work is done!
