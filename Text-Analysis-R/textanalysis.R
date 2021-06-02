# ---
# title: "Basic Text Analysis Using R (workshop material)"
# author: "Justin Ho"
# last updated: "02/06/2021"
# ---


# =================================== Setting Up =======================================

# Installing the packages
install.packages("quanteda")
install.packages("quanteda.textplots")
install.packages("quanteda.textstats")
install.packages("dplyr")
install.packages("wordcloud")
install.packages("ggplot2")

# Loading the necessary packages
library(quanteda)
library(quanteda.textplots)
library(quanteda.textstats)
library(ggplot2)
library(dplyr)

# =================================== Basic Text Analysis =======================================

# Loading the documents
df_snp <-  read.csv("snp.csv", stringsAsFactors = FALSE)
corpus_snp <- corpus(df_snp, text_field = "text")

# The followings are not necessary steps, but it is always a good idea to view a portion of your data
corpus_snp[1:10] # print the first 10 documents
ndoc(corpus_snp) # Number of Documents
nchar(corpus_snp[1:10]) # Number of character for the first 10 documents
ntoken(corpus_snp[1:10]) # Number of tokens for the first 10 documents
ntoken(corpus_snp[1:10], remove_punct = TRUE) # Number of tokens for the first 10 documents after removing punctuation

# Meta-data
docvars(corpus_snp) %>% head()

# Defining custom stopwords
customstopwords <- c("s", "http", "stopword")

# Creating DFM
tokens_snp <- tokens(corpus_snp, remove_punct = TRUE, remove_numbers = TRUE, verbose = TRUE, remove_url = TRUE)
dfm_snp <- dfm(tokens_snp)

# Inspecting the results
topfeatures(dfm_snp, 30) 

# What is it with "make"?
kwic(tokens_snp, "make", 3)

# Plotting a histogram
library(ggplot2)
scotfeatures <- topfeatures(dfm_snp, 100)  # Putting the top 100 words into a new object
data.frame(list(term = names(scotfeatures), frequency = unname(scotfeatures))) %>% # Create a data.frame for ggplot
  ggplot(aes(x = reorder(term,-frequency), y = frequency)) + # Plotting with ggplot2
  geom_point() +
  theme_bw() +
  labs(x = "Term", y = "Frequency") +
  theme(axis.text.x=element_text(angle=90, hjust=1))

# Doing it again, removing stop words this time!
dfm_snp <- dfm_remove(dfm_snp, c(stopwords('english'), customstopwords))

# Inspecting the results again
topfeatures(dfm_snp, 30) 

# Top words again
scotfeatures <- topfeatures(dfm_snp, 100)  # Putting the top 100 words into a new object
data.frame(list(term = names(scotfeatures), frequency = unname(scotfeatures))) %>% # Create a data.frame for ggplot
  ggplot(aes(x = reorder(term,-frequency), y = frequency)) + # Plotting with ggplot2
  geom_point() +
  theme_bw() +
  labs(x = "Term", y = "Frequency") +
  theme(axis.text.x=element_text(angle=90, hjust=1))

# Wordcloud
textplot_wordcloud(dfm_snp)

# TFIDF
dfm_snp_tfidf <- dfm_tfidf(dfm_snp)
topfeatures(dfm_snp_tfidf, 30)
textplot_wordcloud(dfm_snp_tfidf)

# =================================== Comparison Across Groups =======================================

# Loading the documents
df_all <-  read.csv("scotelection2021.csv", stringsAsFactors = FALSE)
corpus_all <- corpus(df_all, text_field = "text")
tokens_all <- tokens(corpus_all, remove_punct = TRUE, remove_numbers = TRUE, verbose = TRUE, remove_url = TRUE)
dfm_all <- dfm(tokens_all)
dfm_all <- dfm_remove(dfm_all, c(stopwords('english'), customstopwords))

# Grouping by party
dfm_all_gp <- dfm_group(dfm_all, groups = snsname)
topfeatures(dfm_all_gp, 30, groups = snsname)

# Subsetting by docvars
corpus_con <- corpus_subset(corpus_all, snsname == "Scottish Conservatives")
tokens_con <- tokens(corpus_con)
kwic(tokens_con, "indyref2", 3)


png("wordcloud.png", 1000, 1000)
textplot_wordcloud(dfm_all_gp, max_size = 1.5, comparison = TRUE, labelsize = 2, labeloffset = -0.001)
dev.off()

# Calculating TFIDF by group
topterm_gp <- dfm_all_gp %>% dfm_tfidf() %>% textstat_frequency(groups = snsname, force = TRUE)
topterm_gp %>% group_by(group) %>%  slice_max(frequency, n = 20) %>% 
  ggplot(aes(reorder(feature, frequency), frequency)) +
  geom_col() +
  coord_flip() +
  facet_grid(vars(group), scales = "free")


# =================================== Sentiment Analysis =======================================

# We will use the Lexicoder Sentiment Dictionary (2015)
data_dictionary_LSD2015

# Passing the dictionary to the dictionary function, you can also define your own dictionary
sentiment <- tokens_lookup(tokens_all, data_dictionary_LSD2015) %>% dfm()
sentiment <- convert(sentiment, to = "data.frame")
sentiment["sentiment"] <- sentiment$positive + sentiment$neg_negative - sentiment$negative - sentiment$neg_positive

# Merging the result with the original dataset
df_wsentiment <- cbind(df_all, sentiment)

# Basic Exploration: mean sentiment score
df_wsentiment %>% group_by(snsname) %>% summarise(sentiment = mean(sentiment))

# Sentiment trend over time
df_wsentiment$date <- as.Date(df_wsentiment$datetime)

plot_df <- df_wsentiment %>% group_by(snsname, date) %>% 
  summarise(sentiment = mean(sentiment))
ggplot(plot_df, aes(date, sentiment, color = snsname)) +
  geom_line()

# Here we are going to use a function from this package to aggregate by week/month
install.packages("lubridate")
library(lubridate)

plot_df <- df_wsentiment %>% mutate(date = floor_date(date, "week")) %>% 
  group_by(snsname, date) %>% 
  summarise(sentiment = mean(sentiment))
ggplot(plot_df, aes(date, sentiment, color = snsname)) +
  geom_line()

