# Leer un archivo csv
raw <- read.csv("D:/Importante/Intro/data/pew.csv", check.names = F)

# imprimimos las primeras líneas
head(raw)

### Uso de Reshape ###
library(reshape2)

# # Melt # #
# Transforma el dataset manteniendo la columna religión y el resto de columnas son traspuestas
tidy <- melt(raw, id = "religion")
head(tidy,10)

# Cambiamos los nombres de las columnas
names(tidy) <- c("religion", "income", "n")

# Cargamos datos de clima
raw <- read.delim("D:/Importante/Intro/data/weather.txt", check.names = F, na.strings = ".")
head(raw)
tidy <- melt(raw, id = c("year", "month", "element"), na.rm = TRUE, variable.name = "day")

# Reordenamos las columnas del dataset
tidy <- tidy[,c("year", "month", "day", "element", "value")]
head(tidy)

# # Uso de dcast # #
# Es lo opuesto a milt, convierte las filas en columnas
tidy1 <- dcast(tidy, year + month + day ~ element, value.var = "value")
head(tidy1)

titanic2 <- read.csv("D:/Importante/Intro/data/titanic2.csv", stringsAsFactors = FALSE)
head(titanic2)

tidy <- melt(titanic2, id = c("class", "age", "fate"), variable.name = "gender")
head(tidy)
tidy <- dcast(tidy, class + age + gender ~ fate, value.var = "value")
# Agregamos una nueva columna al data frame
tidy$rate <- round(tidy$survived / (tidy$survived + tidy$perished), 2)

### Grabar datos ###
# Formato CSV
write.csv(tidy, file = "D:/Importante/Intro/data/tidy.csv", row.names = FALSE)
# Formato CSV comprimido
write.csv(tidy, file = bzfile("D:/Importante/Intro/data/tidy.csv.bz2"), row.names = FALSE)

# Formato R -RDS- este formato es comprimido automáticamente
saveRDS(tidy, "D:/Importante/Intro/data/tidy.RDS")
readRDS("D:/Importante/Intro/data/tidy.RDS")