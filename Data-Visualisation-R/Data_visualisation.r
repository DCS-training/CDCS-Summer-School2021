# #### Data Visualisation with R ####
# #### PART 1: BASIC PLOTS ####

# ==== Basic ggplot2 Syntax ====
library("tidyverse")
library("viridis")

# The main package we will be using for data visualisation is ggplot2, included in the tidyverse package
# R does have base functionality for visualising data though ggplot2 is the standard package used
# Lets import and tidy some data and visualise it with a basic ggplot plot

Elec <- read_csv("https://raw.githubusercontent.com/DCS-training/CDCS-Summer-School2021/main/Data-Visualisation-R/Data/Election_Results.csv")
Elec$first_party <- as_factor(Elec$first_party)
Elec$first_party <- factor(Elec$first_party, levels= c('Con', 'Lab', 'SNP', 'LD', 'DUP', 'PC', 'Green', 'SF', 'SDLP', 'UUP', 'Ind', 'UKIP', 'Spk'))

Elec_main <- Elec[(Elec$first_party=='Con'|Elec$first_party=='Lab'|Elec$first_party=='LD'|Elec$first_party=='SNP'|Elec$first_party=='DUP'),]
Elec_main$first_party <- factor(Elec_main$first_party, levels= c('Con', 'Lab', 'SNP', 'LD', 'DUP'))

# And plot using ggplot
ggplot(Elec, aes(x=turnout, y=majority, colour=first_party)) + geom_point()
ggplot(Elec_main, aes(x=turnout, y=majority, colour=first_party)) + geom_point()

# The first parameter in ggplot() is the Dataframe to plot, Elec/Elec_main in this case
# This is followed by the aes() argument. This dictates the specific attributes to be plotted on the x and y axes as well as any colours
# The final argument + geom_point specifies the type of plot to be used in the visualisation

# Lets try with bar plots and histograms
ggplot(Elec, aes(x=first_party, fill=country_name)) + geom_bar(colour='black')
ggplot(Elec, aes(x=turnout, fill=first_party)) + geom_histogram(colour='black')

# Note that for these, only an x variable is needed for basic plots, though this should be continuous (ie.ideally numeric)
# Additionally, fill is used to colour the bins themselves, while colour (in the geom_ argument) dictates the outline of the bins

# ==== Greater Customisation with ggplot2 ====
# These are fairly basic plots, but a great level of customisation is possible with ggplot2

# The theme() argument allows for deep customisation of non-data components of plots 
ggplot(Elec, aes(x=turnout, fill=first_party)) + geom_histogram(colour='black') + theme_bw() 
ggplot(Elec, aes(x=turnout, fill=first_party)) + geom_histogram(colour='black') + theme_dark()
ggplot(Elec, aes(x=turnout, fill=first_party)) + geom_histogram(colour='black') + theme_void()

# This site contains a list of possible ready made themes, but standard themes can be much more minutely adjusted
browseURL("https://ggplot2.tidyverse.org/reference/ggtheme.html")

# ---- Legends ----
# Legends can be customised using theme() in multiple ways, including setting position or removing it altogether
ggplot(Elec, aes(x=turnout, fill=first_party)) + geom_histogram(colour='black') + theme(legend.position = "none") # Remove legend
ggplot(Elec, aes(x=turnout, fill=first_party)) + geom_histogram(colour='black') + theme(legend.position = "top") # Move legend above plot
ggplot(Elec, aes(x=turnout, fill=first_party)) + geom_histogram(colour='black') + theme(legend.position = "top", legend.title=element_blank()) # Remove legend title
ggplot(Elec, aes(x=turnout, fill=first_party)) + geom_histogram(colour='black') + theme(legend.position = "top", legend.title=element_blank())

# The formatting of the legend can also be adjusted
ggplot(Elec, aes(x=turnout, fill=first_party)) + geom_histogram(colour='black') + theme_bw() + theme(legend.position = "top", legend.title=element_text(colour = "white", size = 10, face="bold"), legend.text=element_text(colour = "white", size = 8), legend.background = element_rect(fill = "black"), legend.key = element_rect(fill = "black"))
# element_ allows specific non-data components of plots to be adjusted. eg. element_text for text and elecment_rect for borders and backgrounds

# ---- Colours ----
# The default colours in R aren't necessarily always the best options, but this too can be customised
party_col <- c("#0087DC", "#E4003B", "#FDF38E", "#FAA61A", "#D46A4C", "#005B54", "#528D6B", "#326760", "#2AA82C", "#48A5EE", "#DDDDDD", "#70147A", "white")

ggplot(Elec, aes(x=turnout, fill=first_party)) + geom_histogram(colour='black')+scale_fill_manual(values = party_col)

# Pre-set colour palettes can also be used
ggplot(Elec_main, aes(x=country_name, fill=first_party)) + geom_histogram(colour='black', stat='count') + scale_fill_viridis(discrete = TRUE)

Turnout_con <- ggplot(Elec, aes(x=turnout, y=con)) + geom_point(aes(colour=majority))+ scale_colour_viridis()
Turnout_con

# For information on available colour palettes see
browseURL("https://www.datanovia.com/en/blog/top-r-color-palettes-to-know-for-great-data-visualization/")

# ---- Labels ----
# Labels can also be easily customised in ggplot2
Party_hist <- ggplot(Elec, aes(x=turnout, fill=first_party)) + geom_histogram(colour='black') + scale_fill_manual(values=party_col) + theme(legend.position = "top", legend.title=element_text(colour = "white", size = 10, face="bold"), legend.text=element_text(colour = "white", size = 8), legend.background = element_rect(fill = "black"), legend.key = element_rect(fill = "black"))
Party_hist

Party_hist_lab <- Party_hist + labs(title="2015 UK General Election", x="Turnout (%)", y="Number of Constituencies", fill="Winning Party")
Party_hist_lab

# labs() allows labels to be customised. For more detail see:
browseURL("https://ggplot2.tidyverse.org/reference/labs.html")

# Labels can also be added onto the plot itself
Party_hist_lab + annotate(geom="label", x = c(70,63,71.5), y = c(40,22,10), label = c("Con","Lab", "SNP"), fill="black", colour=c("#0087DC", "#E4003B", "#FDF38E"))
                 
# annotate() allows labels to be added with the x and y position on the plot and the lebel itself required
# rect can also be used to highlight a specific area
ggplot(Elec, aes(x=turnout, y=con)) + geom_point(aes(colour=majority))+ scale_colour_viridis() + annotate("rect", xmin=59, xmax=66, ymin=150, ymax=9000, alpha=0.5) # note that alpha allows the transparency of an object to be set

# segment can add a custom line
ggplot(Elec, aes(x=turnout, y=con)) + geom_point(aes(colour=majority))+ scale_colour_viridis() + annotate("segment", x=53, xend=76, y=150, yend=28000, colour="red", lwd=1.5, alpha=0.5) # lwd sets the line width

# element_ allows specific non-data components of plots to be adjusted. eg. element_text for text and elecment_rect for borders and backgrounds


# #### PART 2: COMBINING PLOTS, PLOT TYPES AND STATISTICAL ANALYSIS ####

# ==== Facet Wrapping ====
# Facet wrapping can allow for more obvious comparison between specified attributes
ggplot(Elec_main, aes(x=con, fill=first_party)) + geom_histogram(colour='black') + scale_fill_manual(values=party_col) + theme(legend.position = "top", legend.title=element_text(colour = "white", size = 10, face="bold"), legend.text=element_text(colour = "white", size = 8), legend.background = element_rect(fill = "black"), legend.key = element_rect(fill = "black")) + facet_wrap(~first_party)

ggplot(Elec_main, aes(x=turnout, y=con)) + geom_point(aes(colour=majority))+ scale_colour_viridis() + facet_wrap(~first_party)

# ==== Different Types of Plots ====

# So far we have looked mainly at scatter plots and histograms. There are many more than this, we can look at some of the main other options now, but for greater detail for many available plots see:
browseURL("http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html")

# Scatter plot
Turnout_con # This plot is very commonly used and particularly useful for identifying correlations. 

# Histogram
Party_hist_lab # Histograms are particularly useful for plotting distributions and detecting whether or not the plot is normally distributed. With sensible use of fill, different attributes can also be easily compared 

# Density Plot
ggplot(Elec_main, aes(x=majority)) + geom_density(aes(fill=first_party), alpha=0.5) # This is similar to a histogram, in that it can show peaks and troughs in the distribution, but with a density plot, the precise shape of each factors (in this case first_party) distribution can be more easily visualised

# Import England Deprivation Index Data
Eng <- read_csv("Data/England_results.csv")
Eng_main <- Eng[(Eng$first_party=='Con'|Eng$first_party=='Lab'|Eng$first_party=='LD'),]

# Boxplots

ggplot(Eng_main, aes(x=first_party, y=IMDmean, fill=first_party)) + geom_boxplot() # This plot allows for distributions, means, range and outliers to be very easily identified. The mean is the horizontal line across each box and the top section of each box the 75%ile, with the bottom section 25%ile. The colour or shape of outliers can be altered with outlier. Or even removed eg.
ggplot(Eng_main, aes(x=first_party, y=IMDmean, fill=first_party)) + geom_boxplot(outlier.shape = NA)

# ==== A Short Note on Visualisation Pitfalls ====

# The main pitfall you will come across is using an unsuitable type of visualisation. The temptation after learning new visulaisation methods might be to try and make them fit with your data/research, but this is the wrong way round. If you have a specific research question, go looking for an approiate visualisation method rather than the other way round

# Additionally, focussing too much on nice visualisations can oversimplify the output and result in misleading data (even if it is nicely coloured)

# ==== Basic Statistical Analysis and Visualisation ====

# Here we can look back at some of the plots we have produced, as well as some new ones, and try to analyse them in more detail

# ---- Scatter Plots ----

# Lets check the English Deprivation index against valid_votes

Eng$first_party <- factor(Eng$first_party, levels= c('Con', 'Lab', 'LD', 'Green', 'UKIP', 'Spk'))
Eng_col <- c("#0087DC", "#E4003B", "#FAA61A", "#528D6B", "#70147A", "white")

ggplot(Eng, aes(x=IMDmean, y=valid_votes, colour=first_party)) + geom_point(fill="black") + scale_colour_manual(values=Eng_col)

# This plot appears to show a correlation between valid votes and levels of deprivation, as well as Labour constituencies generally being in more deprived areas with lower turnouts when compared to the Conservative seats

# Adding a line of best fit can help to highlight this further
ggplot(Eng, aes(x=IMDmean, y=valid_votes, colour=first_party)) + geom_point(fill="black") + scale_colour_manual(values=Eng_col) + geom_smooth(method=lm, se=FALSE)

# Additionally we can check how turnout and the size of each constituencies majority are correlated 
ggplot(Elec, aes(x=turnout, y=majority, colour=first_party)) + geom_point() + scale_colour_manual(values=party_col) + geom_smooth(method=lm, se=FALSE) + theme_dark()
# Interestingly, most parties majorities reduce as turnout increase, except the Conservatives, where higher turnouts area heavily correlated to larger majorities

# ---- Histogram ----

Party_hist_lab + theme_dark()
# This plot seems to suggest that Conservative constituencies generally have a high turnout, while Labour constituencies have a low turnout. We can make this easier to analyse by adding a y intercept along the mean turnout value

Party_hist_lab + theme_dark() + geom_vline(xintercept=(mean(Elec$turnout)), colour="white", lwd=2)

# By adding a vline along the xintercept at the value for mean turnout, it is very clear that most Consevative constituencies are above the mean turnout, while the majoirty of Labour seats are below. Additionally, the SNP constituencies are almost all above this mean.

# ---- Density Plot ----

# Plotting deprivation densities, it is very clear that Conservative constituencies have a large peak in areas of low deprivation, while Labour constituencies are more evenly distributed, but with a smaller peak in areas of greater deprivation
ggplot(Eng_main, aes(x=IMDmean, fill=first_party)) + geom_density(colour='black', alpha=0.5) + scale_fill_manual(values=Eng_col) + theme(legend.position = "top", legend.title=element_text(colour = "white", size = 10, face="bold"), legend.text=element_text(colour = "white", size = 8), legend.background = element_rect(fill = "black"), legend.key = element_rect(fill = "black"))

# Plotting the size of majorities also has interesting results
ggplot(Eng_main, aes(x=majority, fill=first_party)) + geom_density(colour='black', alpha=0.5) + scale_fill_manual(values=Eng_col) + theme(legend.position = "top", legend.title=element_text(colour = "white", size = 10, face="bold"), legend.text=element_text(colour = "white", size = 8), legend.background = element_rect(fill = "black"), legend.key = element_rect(fill = "black"))
# Liberal Democrat constituencies have two peaks, both with relatively low majorities. Likewise, COnservative seats are marginally more secure than labour based on the size of majorities
       
# ---- Boxplots ----

ggplot(Elec_main, aes(x=first_party, y=turnout, fill=first_party)) + geom_boxplot() + scale_fill_manual(values=party_col)
# With this we can very clearly see that the SNP constituencies have the highest mean turnout of any of the main parties, but also a fairly large deviation from this mean

# ==== Exporting Plots ====
# Plots can be exported in a number of formats, very easily by simply clicking Export in the Plot window. This can also be done through the COnsole, and allows somewhat more control
jpeg(file= 'Output/Histogram.jpeg')
Party_hist_lab
dev.off()

png(file= 'Output/Box.png')
ggplot(Elec_main, aes(x=first_party, y=turnout, fill=first_party)) + geom_boxplot() + scale_fill_manual(values=party_col)
dev.off()

# jpeg() starts the device and requires the destination and file name to be specified. The plot can then be run as normal, before dev.off() turns off the jpeg device and the plot should be exported to the destination you specified


# There is much more to Data Visualisation with R, but hopefully with these basics, you will be able to find suitable methods and visualisations for your own research 
