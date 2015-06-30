# Modelado de datos

options(stringsAsFactors = FALSE)
wages <- read.csv("D:/Importante/Intro/data/wages.csv")
crime <- read.csv("D:/Importante/Intro/data/crime.csv")

library(dplyr)
tbl_df(wages)

# Crea un modelo  lm para predecir "tc2009" a partir de "low"
model <- lm(formula = tc2009 ~ low, data = crime)
# crea un modelo lm sin intercept
model <- lm(formula = tc2009 ~ low -1, data = crime)
# o
model <- lm(formula = tc2009 ~ 0 + low, data = crime)
model
names(model)
summary(model)
predict(model)
resid(model)
qplot(low, tc2009, data = crime) + geom_smooth(method = lm)
qplot(low, tc2009, data = crime) + geom_smooth(se = FALSE, method = lm)

modelWages <- lm(formula = earn ~ height, data = wages)
qplot(height, earn, data = wages) + geom_smooth(method = lm)
