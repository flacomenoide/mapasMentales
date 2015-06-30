# Transformación de Datos
# Evitamos que los strings sean transformados automáticamente a FACTORS
options(stringsAsFactors = FALSE)

# creamos dataframes desde archivos CSV y CSV comprimidos (BZ2)
bnames <- read.csv("D:/Importante/Intro/data/bnames.csv.bz2")
births <- read.csv("D:/Importante/Intro/data/births.csv")

# Importamos ggplot2 para graficar
library(ggplot2)
head(bnames)
head(births)
tail(bnames)

# Filtramos el data frame por un nombre en particular y graficamos la distribución en el tiempo
bnamesMario <- bnames[bnames$name == "Mario",]
qplot(year, prop, data = bnamesMario, geom = "line")

# Filtramos el data frame por dos nombres en particular
bnames2 <- bnames[bnames$name == "Michael" | bnames$name == "Michelle",]
# Graficamos la distribución de los nombres distinguiéndolos por sexo usando la función interaction
qplot(year, prop, data = bnames2, geom = "line", color = interaction(name, sex))
qplot(year, prop, data = bnames, geom = "line", color = sex)

# # Manipulación de Datos # #
# paquete dplyr ayuda a ma nipular los dátos rápido y fácilmente
install.packages("dplyr")
library(dplyr)

# Filtramos las chicas de los años que terminan en 00
filter(bnames, sex == "girl" & year%%100 == 0)
# Reordenando un data frame por year y prop
b1 <- arrange(bnames, year, desc(prop))
head(b1)
# Agregamos una nueva columna al data frame
b2 <- mutate(bnamesMario, percentage = prop*100)
head(b2)
# Sumarizamos un dataset
b3 <- summarise(bnamesMario, minProp = min(prop), propAverage = mean(prop), maxProp = max(prop))
head(b3)

# JOIN data frames por year y sex
b4 <- left_join(bnames, births, by = c("year", "sex"))
head(b4)

# Calculamos una nueva columna y la agregamos al data frame
b4 <- mutate(b4, n = round(prop * births))

# Agrupación de Datos

# Sumarizamos desde un subset de un data frame
summarise(b4[b4$name == "Mario",], total = sum(n))
# o
# Generamos agrupadores por la columna name, los cuales podrán ser usados por las funciones
# summarise, mutate y arrange
# El data frame resultante está en formato tbl_df el cual es un data frame más fácil de manuipular
g <- group_by(b4, name)
tail(g)
# Y sumarizamos el total por name
totals <- summarise(g, total = sum(n))
head(totals)

# Ejemplo completo
gSoundex <- group_by(b4, soundex)
babiesBySoundex <- summarise(gSoundex, total = sum(n))
arrange(babiesBySoundex, desc(total))
j500 <- filter(bnames, soundex == "J500")
unique(j500$name)
sexByYear <- group_by(b4, year, sex)
ytotals <- summarise(sexByYear, births = sum(n))
qplot(year, births, data = ytotals, geom = "line", color = sex)
yearBySex <- group_by(b4, year, sex)
nameRankByYear <- mutate(yearBySex, ranking = rank(desc(prop)))
ones <- filter(nameRankByYear, ranking == 1)
ones <- select(ones, year, name, sex)
head(ones)
library(reshape2)
ones1 <- dcast(ones, year ~ sex, value.var = "name")

## Aprender más sobre dplyr
browseVignettes(package = "dplyr")
