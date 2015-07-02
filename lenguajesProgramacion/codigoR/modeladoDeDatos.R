# Modelado de datos

options(stringsAsFactors = FALSE)
wages <- read.csv("D:/Importante/Intro/data/wages.csv")
crime <- read.csv("D:/Importante/Intro/data/crime.csv")

library(dplyr)
tbl_df(wages)

# Crea un modelo  lm para predecir "tc2009" a partir de "low"
modLm1 <- lm(formula = tc2009 ~ low, data = crime)
# Otra manera definiéndo explícitamente el intercepto es
modLm1 <- lm(formula = tc2009 ~ 1 + low, data = crime)

# Para poder mirar los coeficientes calculados invocamos al objeto generado como modelo
modLm1

# Podemos crear un modelo lm sin intercepto, es decir, si x = 0 => y = 0
modLm0 <- lm(formula = tc2009 ~ low -1, data = crime)
# o es lo mismo
modLm0 <- lm(formula = tc2009 ~ 0 + low, data = crime)
modLm0

# Podemos ver más información del modelo obteniendo los nombre del objeto
names(modLm1)
# Extraemos un resumen del modelo
summary(modLm1)
# Podemos visualizar las predicciones del modelo con los valores originales
predict(modLm1)
# Podemos extraer los residuos de los puntos originales
resid(modLm1)
# Podemos extraer los coeficientes del modelo
coef(modLm1)
# o con
coefficients(modLm1)
# Visualizamos la predicción del modelo
library(ggplot2)
qplot(low, predict(modLm1), data = crime)
# Verificamos los intervalos de confianza del modelo
confint(modLm1, level = 0.95)
# Visualización de resumen del modelo
plot(modLm1)

# Visualizamos los datos reales del data frame y agregamos una geometría geom_smoot con el método lm 
qplot(low, tc2009, data = crime) + geom_smooth(method = lm)
# Podemos eliminar el área que muestra el error estándar
qplot(low, tc2009, data = crime) + geom_smooth(se = FALSE, method = lm)

# Predicción de salario basado en la altura de una persona
modelWages <- lm(formula = earn ~ height, data = wages)
coef(modelWages)
qplot(height, earn, data = wages, alpha = I(1/4)) + geom_smooth(se = FALSE, method = lm)

# Podemos calculas los intervalos de confianza del modelo
confint(modelWages, level = 0.95)

# Inferencia de un Modelo
# Cargamos una muestra de datos
w1 <- read.csv("D:/Importante/Intro/data/w1.csv")
qplot(height, earn, data = w1) + geom_smooth(se = F, method = lm)

# Modelamos en base a una variable categórica
modelWagesCat <- lm(formula = earn ~ race, data = wages)
coef(modelWagesCat)
anova(modelWagesCat)

wages$sex <- factor(wages$sex, levels = c("male", "female"))
modelWagesCatSex <- lm(formula = earn ~ sex, data = wages)
coef(modelWagesCatSex)
anova(modelWagesCatSex)
qplot(earn, data = wages, geom = "density", color = sex) +theme_bw()
qplot(earn, data = wages, geom = "density", color = race) +theme_bw()

modelMultiV <- lm(formula = earn ~ height + sex, data = wages)
coef(modelMultiV)
qplot(height, earn, data = wages, color = sex, alpha = I(1/4)) + geom_smooth(method = lm, se = F) + theme_bw()

d1 <- lm(formula = price ~ cut, data = diamonds)
coef(d1)
coef(d3)
d2 <- lm(formula = price ~ cut + carat, data = diamonds)
coef(d2)
qplot(carat, predict(d2), data = diamonds, color = cut, geom = "line")

d3 <- lm(formula = earn ~ height + sex + race + ed + age, data = wages)
coef(d3)
qplot(earn, predict(d3), data = wages, color = sex, alpha = I(1/4)) + geom_smooth(se = F, method = lm)

d3 <- lm(formula = earn ~ ., data = wages)
coef(d3)

d4 <- lm(formula = earn ~ . - age, data = wages)
coef(d4)
qplot(earn, predict(d4), data = wages, color = sex, alpha = I(1/4)) + geom_smooth(se = F, method = lm)

d5 <- lm(formula = earn ~ height + sex + height:sex, data = wages)
d5 <- lm(formula = earn ~ height * sex, data = wages)
coef(d5)
qplot(earn, predict(d5), data = wages, color = sex, alpha = I(1/4)) + geom_smooth(se = F, method = lm)

# Verificar la correlación entre 2 variables, valores absolutos cercanos a 1 indican alta correlación
cor(wages$height, wages$ed)

# Multiple testing bias
# Verifica si un coeficiente es estadísticamente significante, si el coeficiente == 0
# significa que las variable no tienen relación, esto se mide mediante el p-value
# A más variables las relaciones que se encuentren serán más débiles por lo tanto los p-values
# serán mayores
# Para validar el modelo es bueno chequear el p-value del modelo lo que nos indica si el modelo
# predice mejor que la aleatoriedad (p-value < 0.05)
# Otra alternativa es usar el test ANOVA con varios modelos, lo que nos mostrará la mejora de un
# modelo vs otro
anova(d3, d5, d4)
anova(d5)
