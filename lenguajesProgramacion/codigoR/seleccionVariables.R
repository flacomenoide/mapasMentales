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


# Regresión penalizada (LASSO)
