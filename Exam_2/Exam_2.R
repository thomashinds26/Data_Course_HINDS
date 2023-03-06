#import libraries
library(tidyverse)
library(ggplot2)

#read in the data
u5mr_raw <- read.csv("Exam_2/unicef-u5mr.csv")

#clean up data
country_names_raw <- u5mr_raw$CountryName
region_names_raw <- u5mr_raw$Continent
u5mr_raw <- u5mr_raw %>% 
  select(-c('Region','CountryName','Continent')) %>%
  data.frame()

country_names <- c()
region_names <- c()
years <- c()
U5MRs <- c()

for (i in 1:nrow(u5mr_raw)) {
  for (j in 1:ncol(u5mr_raw)) {
    country_names <- append(country_names,country_names_raw[i])
    region_names <- append(region_names, region_names_raw[i])
    years <- append(years, 1949 + j)
    U5MRs <- append(U5MRs, as.numeric(u5mr_raw[i,j]))
  }
}
u5mr <- data.frame(country_names, region_names, years, U5MRs)
colnames(u5mr) <- c('Country','Continent','Year','U5MR')


png("Exam_2/HINDS_Plot_1.png")
HINDS_Plot_1 <- ggplot(u5mr, aes(u5mr$Year, u5mr$U5MR, color = u5mr$Country)) +                                    
  geom_line() +
  theme(legend.position = "none") +
  facet_grid(. ~ u5mr$Continent) + 
  xlab("Year") + 
  ylab("U5MR")
HINDS_Plot_1
dev.off()

u5mr_continental_means <- group_by(u5mr,Continent, Year) %>%
  summarise(U5MR = mean(U5MR, na.rm = TRUE))

png("Exam_2/HINDS_Plot_2.png")
HINDS_Plot_2 <- ggplot(u5mr_continental_means, aes(u5mr_continental_means$Year, u5mr_continental_means$U5MR, color = u5mr_continental_means$Continent)) +                                    
  geom_line(size = 2) + 
  xlab("Year") + 
  ylab("U5MR") 
HINDS_Plot_2
dev.off()

mod1 <- lm(U5MR ~ Year, u5mr)
summary(mod1)
mod2 <- lm(U5MR ~ Year + Continent, u5mr)
summary(mod2)
mod3 <- lm(U5MR ~ Year + Continent + Year*Continent, u5mr)
summary(mod3)

years <- c()
continents <- c()
for (i in 1950:2015) {
  years <- append(years,i)
  years <- append(years,i)
  years <- append(years,i)
  years <- append(years,i)
  years <- append(years,i)
  continents <- append(continents, "Africa")
  continents <- append(continents, "Americas")
  continents <- append(continents, "Asia")
  continents <- append(continents, "Europe")
  continents <- append(continents, "Oceania")
}
predict_table <- data.frame(Year=years, Continent = continents)
u5mr_predictions <- data.frame(predict(mod1,predict_table), predict(mod2,predict_table), predict(mod3,predict_table))
colnames(u5mr_predictions) <- c('mod1', 'mod2', 'mod3')
mods <- c('mod1','mod2','mod3')
Year <- c()
Continent <- c()
Mod <- c()
U5MR <- c()
for (i in 1:nrow(u5mr_predictions)) {
  for (k in 1:3){
    Year <- append(Year, predict_table[i,1])
    Continent <- append(Continent, predict_table[i,2])
    Mod <- append(Mod, mods[k])
    U5MR <- append(U5MR,u5mr_predictions[i,k])
  }
}
u5mr_predictions <- data.frame(Year, Continent, Mod, U5MR)

png("Exam_2/HINDS_Plot_3.png")
HINDS_Plot_3 <- ggplot(u5mr_predictions, aes(u5mr_predictions$Year, u5mr_predictions$U5MR, color = u5mr_predictions$Continent)) +                                    
  geom_line() +
  facet_grid(. ~ u5mr_predictions$Mod) + 
  xlab("Year") + 
  ylab("U5MR")
HINDS_Plot_3
dev.off()

# Model 3 is the best because the interaction coefficients are significant and 
# it has the highest adjusted R^Squared

Ecuador_2020_prediction <- predict(mod3, data.frame(Year = c(2020), Continent = 'Americas'))
Ecuador_2020_prediction
# Model Prediction Reality
#  mod3   -10.58      13