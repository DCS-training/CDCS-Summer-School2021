########################### Defining your own Dictionary ###########################

dict <- dictionary(list(
  immigration = c('immigr*',  'inmigr*', '*migrat*', '*migrant*', '*asyl*', 'refugee*'),
  climate = c('co2', 'emission', 'greta', 'temperature', 'climate*', 'environment', 'pollution')
))

topicdfm <- tokens_lookup(tokens_all, dict) %>%
  dfm()
topfeatures(topicdfm)
topicdfm_all_gp <- dfm_group(topicdfm, groups = snsname)
topfeatures(topicdfm_all_gp, groups = snsname)

topicdf <- cbind(docvars(corpus_all), convert(result, to = "data.frame"))

########################### Using Expert Defined Topic Dictionary ###########################
dict <- dictionary(file = "policy_agendas_english.lcd") # CAP Dictionary



########################### Getting Text from Guardian ###########################

install.packages("guardianapi")
library(guardianapi)

gu_api_key()

covid <- gu_content(query = "covid", from_date = "2021-06-01",
                    to_date = "2021-06-10")
head(covid)
