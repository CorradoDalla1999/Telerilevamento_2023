# My fist code in Git Hub
#Let's install the raster package

install.packages("raster")

library(raster)

# import data, setting the working directory
# setwd("C:/lab/") # windows

library(raster)
setwd("C:/Telerilevamento_lab")
getwd()
l2011<-brick("p224r63_2011_masked.grd")      #associazione (brick -> l2011)
plot(l2011)                                  #l2011 "plottaggio" delle carte
cl <- colorRampPalette(c("red","orange","yellow")) (100)    #per cambiare i colori, abbiamo 3 colori di base e le diverse sfumature
plot(l2011,col=cl)                       #abbinare il cambio di colori alle carte, assieme alle 100 sfumature diverse

#plotting one element
plot(l2011[[4]], col=cl)
plot(l2011$B4_sre, col=cl)     #il dollarro lega dei pezzi fra loro
nir <- l2011 [[4]]  #or: nir <- l2011$B4_sre
plot(nir, col=cl)
