# #### Geographical Data with R ####
# #### PART 1: GEOGRAPHICAL DATA ####
# This section will use the powerpoint before we get to a more practical demonstration in Part 2
#Install Packages 
install.packages("tidyverse")
install.packages("rgdal")
install.packages("sp")
install.packages("sf")
install.packages("raster")
install.packages("gridExtra")
install.packages("latticeExtra")
# #### PART 2: VISUALISING GEOGRAPHICAL DATA ####
# Mount packages
library(tidyverse)
library(rgdal)
library(sp)
library(sf)
library(raster)
library(gridExtra)
library(latticeExtra)

# ==== Basic Plots ====
# Import Simple Shapefiles
Points_Shape <- readOGR(dsn=path.expand("Data/Shapefiles"), layer="Points") # note that when using readOGR, we do not include the file extension, as multiple different types of file are being used
Lines_Shape <- readOGR(dsn=path.expand("Data/Shapefiles"), layer="Lines")
Polygons_Shape <- readOGR(dsn=path.expand("Data/Shapefiles"), layer="Polygons")

read_sf("Data/Shapefiles/Points.shp")

# Plotting using basic plot()
plot(Points_Shape)

# Overlaying and different parameters in plot()
par(mfrow=c(1,3)) # mfrow has two parameters, the first number of rows, the second columns
plot(Points_Shape, pch=21, col='black', bg='red', cex=1.75, lwd=2) # pch dictates the shape, col the outline, bg the fill. Cex and lwd set the size and line width respectively
plot(Lines_Shape, col='yellow', lwd=2) 
plot(Polygons_Shape, col='green', lwd=1.9)

# for more detail on pch see:
browseURL("https://r-lang.com/pch-in-r/")

# We can also directly overlay plots using points(), lines() etc.
par(mfrow=c(1,1))
plot(Polygons_Shape, col='green', lwd=1.9)
points(Points_Shape, pch=21, col='black', bg='red', cex=1.75, lwd=2)
lines(Lines_Shape, col='yellow', lwd=2)
legend("topright", c("Lines", "Polygons", "Points"), col = c('yellow', 'green', 'red'),fill=c('yellow','green','red'))

# an easier method may be to simply add=TRUE 
plot(Polygons_Shape, col='green', lwd=1.9)
plot(Points_Shape, pch=21, col='black', bg='red', cex=1.75, lwd=2, add=TRUE)
plot(Lines_Shape, col='yellow', lwd=2, add=TRUE) 

# ==== Real World Geographic Data ====
# Lets add a more familiar geographic shapefile
Scot <- readOGR(dsn=path.expand("Data/Shapefiles"),layer="Scotland")

# Plotting our basic shapes, we can see that they did actually have real word coordinates associated with them
plot(Scot)
plot(Polygons_Shape, col='green', lwd=1, add=TRUE)
plot(Points_Shape, pch=21, col='black', bg='red', cex=0.75, lwd=1, add=TRUE)
plot(Lines_Shape, col='yellow', lwd=2, add=TRUE)

# CRS and Plot
st_crs(Scot)
extent(Scot)

# We can add the rest of the constituencies of the UK to this
Constits <- readOGR(dsn=path.expand("Data/Shapefiles"),layer="Constituencies")

plot(Scot)
plot(Constits, add=TRUE)


#MAke sure contry_na is a factor
Constits$country_na<- as.factor(Constits$country_na)
# Comparing the two extents, much of the UK is cut off when using Scotlands geographic extent
extent(Scot)
extent(Constits)
# This can be addressed simply by plotting the larger shapefile first, a better solution is to simply set the extent when plotting the first using xlim and ylim
plot(Scot, xlim=c(-8.25,2), ylim=c(50, 61))
plot(Constits, add=TRUE)
plot(Constits, col="brown", bg="grey")

# ==== Spplot ====
# spplot allows much more nuance and customisation of plots than the basic plot function
Constits_p <- spplot(Constits, zcol='country_na', col.regions=c("red","green","blue","orange"), scales=list(draw = TRUE), xlab='Longitude', ylab='Latitude', xlim=c(-8.25,2), ylim=c(50, 61)) # We can use the attribute data attached to the geographical data to plot in a more meaningful way. col.regions sets the fill colour of polygons, having scales draw= TRUE simply adds scales along the axes

Constits_p

# We can also overlay point shapefiles over our constituency polygons
Cities <- readOGR(dsn=path.expand("Data/Shapefiles"), layer="Cities")

Constits_p + layer(panel.points(x=Cities$lng, y=Cities$lat, col='yellow', pch=20, cex=0.75)) # layer(panel.points()) takes x and y coordinates (in this case the longitude and latitude of Cities)

# Lets add some additional data to our geographic data for deeper analysis
Elec <- read_csv("Data/csv/Election_results.csv")
Elec$constituency_name <- as_factor(Elec$constituency_name)

Constits <-  merge(Constits, Elec, by.x="pconname", by.y="constituency_name")

Turnout <- spplot(Constits, zcol='turnout', col.regions=rev(terrain.colors(50)), scales=list(draw = TRUE), xlab='Longitude', ylab='Latitude', xlim=c(-8.25,2), ylim=c(50, 61))

Turnout # We can also adjust the labels to show the numbers in turnout are as a percentage of the electorate using colorkey

Turnout <- spplot(Constits, zcol='turnout', main="UK General Election Turnout 2015", col.regions=rev(terrain.colors(50)), scales=list(draw = TRUE), xlab='Longitude', ylab='Latitude', xlim=c(-8.25,2), ylim=c(50, 61), colorkey = list(labels = list( labels = c("50%", "55%","60%","65%","70%","75%","80%"))))

Turnout

# Lets check the winning parties in each constituency from 2015
Constits$first_party <- factor(Constits$first_party, levels= c('Con', 'Lab', 'SNP', 'LD', 'DUP', 'PC', 'Green', 'SF', 'SDLP', 'UUP', 'Ind', 'UKIP', 'Spk'))

Result <- spplot(Constits, "first_party", main='UK General Election 2015', col.regions=terrain.colors(50), scales=list(draw=TRUE),xlab='Longitude',ylab='Latitude')

Result # These default colours are not particularly helpful for visualising the parties, lets create a colour map using the hex codes for the parties official colours and add the colours manually

party_col <- c("#0087DC", "#E4003B", "#FDF38E", "#FAA61A", "#D46A4C", "#005B54", "#528D6B", "#326760", "#2AA82C", "#48A5EE", "#DDDDDD", "#70147A", "white")
Result <- spplot(Constits, "first_party", main='UK General Election 2015', col.regions=party_col, scales=list(draw=TRUE),xlab='Longitude',ylab='Latitude')
Result

# ==== Combining Plots ====
# Using grid.arrange we can set plots next to one another for easy comparison
grid.arrange(spplot(Constits, "first_party", col.regions=party_col, main='UK General Election 2015', scales=list(draw=TRUE),xlab='Longitude',ylab='Latitude'), spplot(Constits, "turnout", col.regions=rev(terrain.colors(50)), main='UK General Election 2015 Turnout', scales=list(draw=TRUE),xlab='Longitude',ylab='Latitude', colorkey = list(labels = list( labels = c("50%", "55%","60%","65%","70%","75%","80%")))),ncol=2)

# Or
grid.arrange(Result, Turnout, ncol=2) # Without ncol=2, these plots would be stacked horizontally, Any number of rows or columns can be specified with enough plots

# This can all easily be combined with point data, eg. the Cities shapefile
Cities_points <- layer(panel.points(x=Cities$lng,y=Cities$lat, col="black",fill="red", pch=21, cex=0.5), data=Cities)

grid.arrange(Result, Turnout + Cities_points, ncol=2) 


# ==== Exporting Plots ====
# Plots can be exported in a number of formats, very easily by simply clicking Export in the Plot window. This can also be done through the COnsole, and allows somewhat more control
jpeg(file= 'Output/Result.jpeg')
Result
dev.off()

png(file= 'Output/Full_plot.png')
grid.arrange(Result, Turnout + Cities_points, ncol=2)
dev.off()

# jpeg() starts the device and requires the destination and file name to be specified. The plot can then be run as normal, before dev.off() turns off the jpeg device and the plot should be exported to the destination you specified

# There is much more to Geographical Data with R, but hopefully with these basics, you will be able to find suitable methods and outputs for your own research