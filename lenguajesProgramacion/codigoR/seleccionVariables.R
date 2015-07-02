# Selección de Variables

# Cargamos un dataframe de counties con información de crímenes en diferentes lugares
cts <- read.csv("D:/Importante/Intro/data/counties.csv", stringsAsFactors = FALSE)
head(cts)

library(leaps)
# Basados en los datos (stepwise)
# Regresión penalizada (LASSO)
