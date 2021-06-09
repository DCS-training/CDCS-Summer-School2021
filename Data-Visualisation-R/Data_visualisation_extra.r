# #### Extra Data Visualisation ####

# Add units directly to scale
Party_hist_lab + scale_x_continuous(labels = function(x) paste0(x, '%'))

# Adjust bins
ggplot(Elec, aes(x=turnout, fill=first_party)) + geom_histogram(colour='black', bins = 100) + scale_fill_manual(values=party_col) + theme(legend.position = "top", legend.title=element_text(colour = "white", size = 10, face="bold"), legend.text=element_text(colour = "white", size = 8), legend.background = element_rect(fill = "black"), legend.key = element_rect(fill = "black"))

ggplot(Elec, aes(x=turnout, fill=first_party)) + geom_histogram(colour='black', binwidth = 2, size=1.5) + scale_fill_manual(values=party_col) + theme(legend.position = "top", legend.title=element_text(colour = "white", size = 10, face="bold"), legend.text=element_text(colour = "white", size = 8), legend.background = element_rect(fill = "black"), legend.key = element_rect(fill = "black"))

# Faceting
Facet_plot <- ggplot(Elec_main, aes(x=turnout, y=con)) + geom_point(aes(colour=majority))+ scale_colour_viridis()
Facet_plot + facet_wrap(~first_party, nrow=2, dir='v')
Facet_plot + facet_wrap(~first_party, ncol=2)

# Facet grid Multidimensional faceting
Facet_grid <- ggplot(Elec_main, aes(x=valid_votes, fill=first_party)) + geom_histogram(colour='black') + scale_fill_manual(values=party_col) + theme(legend.position = "top", legend.title=element_text(colour = "white", size = 10, face="bold"), legend.text=element_text(colour = "white", size = 8), legend.background = element_rect(fill = "black"), legend.key = element_rect(fill = "black"))

Facet_grid + facet_grid(first_party ~ country_name)
Facet_grid + facet_grid(.~ country_name)
Facet_grid + facet_grid(country_name~.)

# Histograms and Bars
# Stacked Histograms
ggplot(Elec, aes(x=turnout, fill=first_party)) + geom_histogram(colour='black', position='stacked') + scale_fill_manual(values=party_col) + theme(legend.position = "top", legend.title=element_text(colour = "white", size = 10, face="bold"), legend.text=element_text(colour = "white", size = 8), legend.background = element_rect(fill = "black"), legend.key = element_rect(fill = "black"))

# Non-stacked
ggplot(Elec, aes(x=turnout, fill=first_party)) + geom_histogram(colour='black', position='identity', alpha=0.5) + scale_fill_manual(values=party_col) + theme(legend.position = "top", legend.title=element_text(colour = "white", size = 10, face="bold"), legend.text=element_text(colour = "white", size = 8), legend.background = element_rect(fill = "black"), legend.key = element_rect(fill = "black"))

# Bar
ggplot(Elec_main, aes(x=first_party, y=valid_votes, fill=first_party)) + geom_bar(colour=NA, stat='identity') + scale_fill_manual(values=party_col) + theme(legend.position = "top", legend.title=element_text(colour = "white", size = 10, face="bold"), legend.text=element_text(colour = "white", size = 8), legend.background = element_rect(fill = "black"), legend.key = element_rect(fill = "black"))


# Boxplot
ggplot(Eng_main, aes(x=first_party, y=IMDmean, fill=first_party)) + geom_boxplot(outlier.shape = NA) + geom_point(alpha=0.6, position = position_jitterdodge())