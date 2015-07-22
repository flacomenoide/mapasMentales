# Regresion Logística
options(na.action = "na.exclude")
titanic3 <- read.csv("D:/Importante/Intro/data/titanic3.csv", stringsAsFactors = FALSE)
head(titanic3)
# la variable que interesa de este df es "survived"
# Graficamos la relación entre sobrevivientes y edad
qplot(age, survived, data = titanic3) + geom_smooth(se = F)
library(mgcv)

# Generamos un modelo en base a una regresión logística
mod <- gam(survived ~ s(age), data = titanic3, family = binomial) # "family = binomial" indica la distribución del target
summary(mod)

# Estas funciones muestran los valores predichos para la variable transformada por la función "link"
# Usualmente no es útil
predict(mod)
predict(mod, type = "link")

# Estas funciones muestran los valores predichos de probabilidad de uno u otro valor del target
fitted(mod)
predict(mod, type = "response")

# Graficamos los valores predichos
qplot(age, survived, data = titanic3) +
  geom_smooth(se = F) +
  geom_line(aes(y = fitted(mod)), color = I("red"))

# Extraemos los residuos
resid(mod)
resid(mod, ttype = "deviance")
resid(mod, ttype = "pearson")
