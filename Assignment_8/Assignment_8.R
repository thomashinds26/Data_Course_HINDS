library(tidyverse)
library(ggplot2)
#1)
mushroom_growth_data <- read_csv("Assignment_8/mushroom_growth.csv")

#2)
plot(mushroom_growth_data$Nitrogen,mushroom_growth_data$GrowthRate, main = 'How are Nitrogen and Growth Rate Related?', xlab = 'Nitrogen',ylab = 'Growth Rate')
plot(mushroom_growth_data$Temperature,mushroom_growth_data$GrowthRate, main = 'How are Temperature and Growth Rate Related?', xlab = 'Temperature',ylab = 'Growth Rate')
plot(mushroom_growth_data$Light,mushroom_growth_data$GrowthRate, main = 'How are Light and Growth Rate Related?', xlab = 'Light',ylab = 'Growth Rate')
ggplot(mushroom_growth_data, aes(x=Humidity,y=GrowthRate)) + geom_boxplot() + ggtitle("How is Growth Rate Distributed Among humidities?")
ggplot(mushroom_growth_data, aes(x=Species,y=GrowthRate)) + geom_boxplot() + ggtitle("How is Growth Rate Distributed Among Species?")

#3 & 4)
model_1 <- lm(GrowthRate ~ Species, data = mushroom_growth_data)
summary(model_1)
msq_1 <- mean(model_1$residuals^2)
msq_1

model_2 <- lm(GrowthRate ~  Temperature, data = mushroom_growth_data)
summary(model_2)
msq_2 <- mean(model_2$residuals^2)
msq_2

model_3 <- lm(GrowthRate ~ Nitrogen, data = mushroom_growth_data)
summary(model_3)
msq_3 <- mean(model_3$residuals^2)
msq_3

model_4 <- lm(GrowthRate ~ Light + Nitrogen + Temperature, data = mushroom_growth_data)
summary(model_4)
msq_4 <- mean(model_4$residuals^2)
msq_4

#5) best model is model_4
#6)
model_4_predictions <- predict(model_4, data = mushroom_growth_data)
truths <- mushroom_growth_data$GrowthRate

#7)
plot(truths, model_4_predictions, main = 'How Close Are the Predictions to Truth?',xlab = 'Truth', ylab = 'Prediction')
abline(0,1)
# on the line, Truth equals Prediction
