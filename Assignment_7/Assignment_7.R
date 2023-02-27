library(tidyverse)
library(dplyr)
library(ggplot2)
data_imported <- read_csv('Assignment_7/Utah_Religions_by_County.csv')
data_cleaned = data_imported[,1:2]
for(i in 3:ncol(data_imported)) {
  temp_colname = colnames(data_imported)[i]
  data_cleaned$temp_num <- (round(data_imported[,i]*data_imported$Pop_2010,digit=0))[,1]
  colnames(data_cleaned)[colnames(data_cleaned) == "temp_num"] = paste('Num',temp_colname,sep='_')
}
for(i in 3:ncol(data_imported)) {
  temp_colname = colnames(data_imported)[i]
  data_cleaned$temp_percent <- (round(data_imported[,i],digit=4)*100)[,1]
  colnames(data_cleaned)[colnames(data_cleaned) == "temp_percent"] = paste('Pct',temp_colname,sep='_')
}

pop_county <- ggplot(data_cleaned, aes(x=data_cleaned$County, y=data_cleaned$Pop_2010)) + 
  geom_bar(stat = "identity") + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) + 
  ggtitle('Population by Country') + xlab('County') + ylab('Population')
pop_county

byreligion <- ggplot(data=data_cleaned, aes(x=data_cleaned$County, y=data_cleaned$Pop_2010, fill=data_cleaned$Pct_Religious)) + 
  geom_bar(stat="identity") + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) + 
  ggtitle('Population with Number of Religious People by Color') + xlab('County') + ylab('Population') + 
  labs(fill = "Religious People")
byreligion

piechart <- ggplot(data_cleaned, aes(x="", y=data_cleaned$Pop_2010, fill=data_cleaned$County))+
  geom_bar(width = 1, stat = "identity") + coord_polar("y", start=0)
piechart

#1. 
# Does population of a county correlate with the proportion of 
# any specific religious group in that county?
religions = c()
pop_religion_correlations = c()
for (i in 20:32) {
  religions = cbind(religions, str_split(colnames(data_cleaned)[i],'_')[[1]][2])
  pop_religion_correlations = cbind(pop_religion_correlations, cor(data_cleaned$Pop_2010,data_cleaned[,i])[1])
}
religions = t(religions)
pop_religion_correlations = t(pop_religion_correlations)
data.frame(religions, pop_religion_correlations)
plot(data_cleaned$Pop_2010, data_cleaned$Pct_Muslim)
#There generally aren't any strong correlations between population and religious percentages.
# Muslim shows a strong mathematical correlation, but a visual inspection makes it appear to 
# be due to a few data points with high leverages.

#2.
# Does proportion of any specific religion in a given county correlate 
# with the proportion of non-religious people?
religions = c()
irreligiosity_religion_correlations = c()
for (i in 20:32) {
  religions = cbind(religions, str_split(colnames(data_cleaned)[i],'_')[[1]][2])
  irreligiosity_religion_correlations = cbind(irreligiosity_religion_correlations, cor(data_cleaned$`Pct_Non-Religious`,data_cleaned[,i])[1])
}
religions = t(religions)
irreligiosity_religion_correlations = t(irreligiosity_religion_correlations)
data.frame(religions, irreligiosity_religion_correlations)
plot(data_cleaned$`Pct_Non-Religious`, data_cleaned$`Pct_Episcopal Church`)
plot(data_cleaned$`Pct_Non-Religious`, data_cleaned$`Pct_LDS`)
#There are two strong correlations between the proportion of non-religious people and 
# the proportion of specific religions.
#The proportion of members of the Episcopal Church shows a moderately strong positive correlation 
# with the proportion of non-religious people.
#The proportion of members of the LDS Church shows a very strong negative correlation 
# with proportion of non-religious people




