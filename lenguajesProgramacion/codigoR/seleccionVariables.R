# Selección de Variables

# Cargamos un dataframe de counties con información de crímenes en diferentes lugares
cts <- read.csv("D:/Importante/Intro/data/counties.csv", stringsAsFactors = FALSE)
head(cts)

# Selección del mejor subset de variables
library(ggplot2)
library(leaps) # Paquete de análisis de selección de variables
subs <- regsubsets(earn ~ ., data = wages) # Realiza un  estudio de selección de variables
summary(subs)
summary(subs)$adjr2 # Muestra el análisis de R^2 ajustado (el mejor modelo es el de menor R^2)
summary(subs)$cp # Muestra el análisis de Cp (el mejor modelo es el de mayor Cp)
summary(subs)$bic # Muestra el análisis de bic (el mejor modelo es el de mayor bic)

# Ponemos los resultados en un data frame para analizarlos mejor
df <- data.frame(
  est = c(summary(subs)$adjr2, summary(subs)$cp, summary(subs)$bic),
  x = rep(1:7, 3),
  type = rep(c("adjr2", "cp", "bic"), each = 7)
  )

# Graficamos los estimadores
qplot(x, est, data = df, geom = "line") + theme_bw() + facet_grid(type ~ ., scales = "free_y")

coef(subs, 3) # Vemos los coeficientes del tercer modelo

regsubsets(crime ~ ., data = cts) # No es práctico para grandes data frames


# Forward y Backward
start.mod <- lm(earn ~ height, data = wages) # Definimos un modelo inicial
empty.mod <- lm(earn ~ 1, data = wages) # Definimos un modelo vacío
full.mod <- lm(earn ~ ., data = wages) # Definimos un modelo completo

step(start.mod, scope = list(upper = full.mod, lower = empty.mod), direction = "forward")

# Usando cts2
library(dplyr)
cts2 <- select(cts, -state, -county)
head(cts2)
start.cts2 <- lm(crime ~ pop, data = cts2)
empty.cts2 <- lm(crime ~ 1, data = cts2)
full.cts2 <- lm(crime ~ ., data = cts2)
step(start.cts2, scope = list(upper=full.cts2, lower=empty.cts2), direction = "forward")
step(start.cts2, scope = list(upper=full.cts2, lower=empty.cts2), direction = "backward")
step(start.cts2, scope = list(upper=full.cts2, lower=empty.cts2), direction = "both")

cts3 <- cts2[2:110,]
start <- full <- lm(crime ~ pop, data = cts3)
full <- lm(crime ~ ., data = cts3)
empty <- lm(crime ~ 1, data = cts3)
bounds <- list(upper = full, lower = empty)

step(start, scope = bounds, direction = "forward")
step(start, scope = bounds, direction = "backward")
step(start, scope = bounds, direction = "both")