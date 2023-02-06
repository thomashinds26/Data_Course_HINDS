install.packages('ggplot')
install.packages('tidyverse')

library(ggplot)
library(tidyverse)

Fake_COVID_data <- read_csv(Fake_COVID_data)

covid_state_means <- data.frame(
  state = colnames(Fake_COVID_data)[2:6],
  deaths = as.numeric(colMeans(Fake_COVID_data[,2:6]))
)

ggplot(covid_state_means, aes(x=state, y=deaths)) + 
  geom_bar(stat = "identity") +
  labs(y = 'Average Deaths per Day', x = 'State', title = 'Expected Covid Death Results')
      