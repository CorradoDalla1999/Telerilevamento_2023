# My fist code in Git Hub
#Let's install the raster package

install.packages("raster")

library(raster)

# import data, setting the working directory
# setwd("C:/lab/") # windows

l2011 <-brick("p224r63_2011_masked")    #tutte le volte che si esce da R si devono usare le virgolette
plot (l2011)
cl <- colorRamplette(c("red","orange","yelow")) (100)
clb <- colorRampPalette(c("blu scuro", "blu", "azzurro")) (100) #per cambiare i colori, 100 è il numero delle sfumature
