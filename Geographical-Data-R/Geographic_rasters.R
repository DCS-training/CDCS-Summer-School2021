# #### The data and source for this script can be found at ####
browseURL("https://www.neonscience.org/resources/learning-hub/tutorials/raster-data-r")


## ----load-libraries----------------------------------------------------

# work with raster data
library(raster)
# export GeoTIFFs and other core GIS functions
library(rgdal)

## ----demonstrate-RGB-Image, fig.cap="Red, green, and blue bands of NEON's site Harvard Forest", echo=FALSE----
# Use stack function to read in all bands
RGB_stack_HARV <- 
  stack("Data/RasterData/HARV/RGB_Imagery/HARV_RGB_Ortho.tif")

names(RGB_stack_HARV) <- c("Red Band","Green Band","Blue Band")

grayscale_colors <- gray.colors(100, 
                                start = 0.0, 
                                end = 1.0, 
                                gamma = 2.2, 
                                alpha = NULL)

# Create an RGB image from the raster stack
plot(RGB_stack_HARV, 
     col=grayscale_colors,
     axes=F)



## ----plot-RGB-now, fig.cap="Composite image of NEON's site Harvard Forest", echo=FALSE, message=FALSE----
# Create an RGB image from the raster stack

original_par <-par() # create original par for easy reversal at end
par(col.axis="white",col.lab="white",tck=0)
plotRGB(RGB_stack_HARV, r = 1, g = 2, b = 3,
        axes=TRUE, 
        main="3 Band Color Composite Image\n NEON Harvard Forest Field Site")
box(col="white")



## ----reset-par, echo=FALSE, results="hide", warning=FALSE--------------
par(original_par) # go back to original par



## ----read-single-band, fig.cap="Red band of NEON's site Harvard Forest"----
 
# Read in multi-band raster with raster function. 
# Default is the first band only.
RGB_band1_HARV <- 
  raster("Data/RasterData/HARV/RGB_Imagery/HARV_RGB_Ortho.tif")

# create a grayscale color palette to use for the image.
grayscale_colors <- gray.colors(100,            # number of different color levels 
                                start = 0.0,    # how black (0) to go
                                end = 1.0,      # how white (1) to go
                                gamma = 2.2,    # correction between how a digital 
                                # camera sees the world and how human eyes see it
                                alpha = NULL)   #Null=colors are not transparent

# Plot band 1
plot(RGB_band1_HARV, 
     col=grayscale_colors, 
     axes=FALSE,
     main="RGB Imagery - Band 1-Red\nNEON Harvard Forest Field Site") 

# view attributes: Check out dimension, CRS, resolution, values attributes, and 
# band.
RGB_band1_HARV


## ----min-max-image-----------------------------------------------------
# view min value
minValue(RGB_band1_HARV)

# view max value
maxValue(RGB_band1_HARV)


## ----read-specific-band, fig.cap="Green band of NEON's site Harvard Forest"----
# Can specify which band we want to read in
RGB_band2_HARV <- 
  raster("Data/RasterData/HARV/RGB_Imagery/HARV_RGB_Ortho.tif", 
           band = 2)

# plot band 2
plot(RGB_band2_HARV,
     col=grayscale_colors, # we already created this palette & can use it again
     axes=FALSE,
     main="RGB Imagery - Band 2- Green\nNEON Harvard Forest Field Site")

# view attributes of band 2 
RGB_band2_HARV


## ----intro-to-raster-stacks--------------------------------------------

# Use stack function to read in all bands
RGB_stack_HARV <- 
  stack("Data/RasterData/HARV/RGB_Imagery/HARV_RGB_Ortho.tif")

# view attributes of stack object
RGB_stack_HARV



## ----plot-raster-layers, fig.cap=c("Histograms of each RGB band showing the distribution of values for NEON's site Harvard Forest","Raster of each RGB band for NEON's site Harvard Forest","Band 2 of NEON's site Harvard Forest")----
# view raster attributes
RGB_stack_HARV@layers

# view attributes for one band
RGB_stack_HARV[[1]]

# view histogram of all 3 bands
hist(RGB_stack_HARV,
     maxpixels=ncell(RGB_stack_HARV))

# plot all three bands separately
plot(RGB_stack_HARV, 
     col=grayscale_colors)

# revert to a single plot layout 
par(mfrow=c(1,1)) 

# plot band 2 
plot(RGB_stack_HARV[[2]], 
     main="Band 2\n NEON Harvard Forest Field Site",
     col=grayscale_colors)



## ----plot-rgb-image, fig.cap="Composite RGB image of NEON's site Harvard Forest"----

# Create an RGB image from the raster stack
plotRGB(RGB_stack_HARV, 
        r = 1, g = 2, b = 3)



## ----image-stretch, fig.cap=c("Composite RGB image of NEON's site Harvard Forest", "Composite RGB image of NEON's site Harvard Forest with slightly more contrast")----

# what does stretch do?
plotRGB(RGB_stack_HARV,
        r = 1, g = 2, b = 3, 
        scale=800,
        stretch = "lin")

plotRGB(RGB_stack_HARV,
        r = 1, g = 2, b = 3, 
        scale=800,
        stretch = "hist")


## ----raster-bricks, fig.cap="Composite RGB image of NEON's site Harvard Forest"----

# view size of the RGB_stack object that contains our 3 band image
object.size(RGB_stack_HARV)

# convert stack to a brick
RGB_brick_HARV <- brick(RGB_stack_HARV)

# view size of the brick
object.size(RGB_brick_HARV)



## ----plot-brick--------------------------------------------------------
# plot brick
plotRGB(RGB_brick_HARV)
