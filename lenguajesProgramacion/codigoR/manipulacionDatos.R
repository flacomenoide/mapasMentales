# Manipulación de Datos
# =====================
setwd("./colabs/mapasMentales/lenguajesProgramacion/codigoR/")
td <- data.frame(c(1,2,3), c("a","b","c"), c(T,F,F))
names(td) <- c("Numero", "Letra", "Logico")
# Generación de Secuencias
5:15    # Ascendente
8:-2    # Descendente
# Uso de la función seq()
seq(from=1, to=12)            # Uso similar a la manera rápida :
seq(from=2, to=12, by=2)      # Creación de una secuencia del 2 al 12 con saltos de 2
seq(from=2, to=12, length=10) # Creación de una secuencia del 2 al 12 con longitud 8
seq(from=2, to=12, along=tv)  # Creación de una secuencia del 2 al 12 con longitud similar a la del objeto tv

# Subscripting o Subsetting
# Subscripting Vectores
tv <- c(1:10)
tv[5]         # Se extrae el elemento 5 del vector tv
tv[-5]        # Se extrae todos los elemento del vector tv excepto el elemento 5
tv[c(1,4)]    # Se extraen los elementos 1 y 4 del vector tv pasándo como índice un vector
tv[c(-1,-4)]  # Se extraen todos los elementos del vector tv pasándo como índice un vector que excluye a los elementos 1 y 4
tv[tv<5]      # Se extraen los elementos del vector tv que cumplan con la condición definida

# Subscripting Data Frames
td[,2]        # Se extrae toda la columna 2 del data frame td
td[2,]        # Se extrae toda la fila 2 del data frame td
td[2:3, 3]    # Se extrae de la columna 3 las filas de la 2 a la 3
td$Numero     # Se extrae toda la columna con nombre "Numero"
td$Numero[2]  # Se extrae el segundo elemento de la columna con nombre "Numero"
ncol(td)      # Obtener la cantidad de columnas de un data frame
nrow(td)      # Obtener la cantidad de filas de un data frame
dim(td)       # Obtener la cantidad de filas y columnas de un data frame
length(tv)    # Obtener la longitud de un Vector

# Consultas de datos
# ==================
sunspot.year            # Dataset default R que contiene las observaciones de manchas solares observadas desde 1700 a 1988
# Creación de una data frame a partir de una sequencia y el dataset sunspot.year
manchasSolares <- data.frame(Year=1700:1988,Obs=sunspot.year)
head(manchasSolares)    # Visualización de las 6 primeras filas
tail(manchasSolares)    # Visualización de las 6 últimas filas
manchasSolares_int <- round(manchasSolares)   # Redondeamos los valores con decimales y asignakos el resultado a un nuevo data frame
any(manchasSolares_int[,2]<0)                 # Busca valores menores a cero en la segunda columna, si los encuentra devuelve TRUE
# Busca valores menores a 1700 o mayores a 1988 en la primer columna, si los encuentra devuelve TRUE
any(manchasSolares_int[,1]<1700 | manchasSolares_int[,1]> 1988)
mean(manchasSolares_int[,2])                  # Calcula las observaciones promedio
round(mean(manchasSolares_int[,2]))           # Redondea el cálculo del promedio de visualizaciones
round(mean(manchasSolares_int[,2]), digits=2) # Redondea el cálculo del promedio de visualizaciones a 2 decimales
max(manchasSolares_int[,2])                   # Encuentra el mayor valor de la columna 2
# Busca el número de la o las filas que contienen el valor máximo de la columna 2
which(manchasSolares_int[,2] == max(manchasSolares_int[,2]))
# Extrae la fila completa donde se encuentra el elemento con el valor máximo de la columna 2
manchasSolares_int[which(manchasSolares_int[,2] == max(manchasSolares_int[,2])),]
length(which(manchasSolares_int[,2]<5))               # Obtiene la cantidad de elementos en donde el valor de la columna 2 sea menor a 5
manchasSolares_int[which(manchasSolares_int[,2]<5),]  # Extrae la fila completa en donde el valor de la columna 2 sea menor a 5
summary(manchasSolares_int)                           # Obtiene un resumen de las variables del data frame
colSums(manchasSolares_int[2])                        # Obtiene la suma de los valores de la columna 2

head(airquality)              # Dataset con las mediciones de la calidad del aire entre Mayo y Sept de 1973 en NY
mean(airquality[,2])          # Cálculo de la media de los valores de la columna 2 (No se puede realizar por valores NA)
mean(airquality[,2], na.rm=T) # Cálculo de la media de los valores de la columna 2 excluyendo los valores NA
any(is.na(airquality))        # Valida si existe algún valor NA en el dataset

aire_compl <- na.omit(airquality)   # Eliminar las filas que contienen valores NA
any(is.na(aire_compl))              # Validamos si existen valores NA

if(!file.exists("./datos")){dir.create("./datos")}
archCSV <- "https://recursos-data.buenosaires.gob.ar/ckan2/bicicleterias/bicicleterias.csv"
download.file(archCSV, destfile = "./datos/bicicleterias.csv", method = "curl")
biciData <- read.csv("./datos/bicicleterias.csv", header = T, sep = ";")
# Generación de una tabla que relaciona 2 variables de un data frame
table(biciData$BARRIO, biciData$MECANICA_S)
# Generación de una tabla que busca valores en una columna
table(biciData$BARRIO %in% c("NUÑEZ", "PALERMO"))
table(biciData$BARRIO %in% c("NUÑEZ"))
# Creación de una nueva columna en base a una tercera
biciData$CERCANO <- biciData$BARRIO %in% c("NUÑEZ", "PALERMO")
table(biciData$CERCANO)
# Creación de Variables categóricas a partir de variables continuas
biciData$GRUPOS_ALTURA <- cut(biciData$ALTURA, breaks = quantile(biciData$ALTURA))
table(biciData$GRUPOS_ALTURA)
#
data("UCBAdmissions")
DF <- as.data.frame(UCBAdmissions)
# Creación de una tabla con la relación entre 3 variables
xt <- xtabs(Freq ~ Gender + Admit, data = DF)
# Creación de una tabla plana a partir de la relación encontrada previamente
ftable(xt)
# Chequear el espacio que usa un objeto
object.size(DF)

# Manipulación de datos con Hmisc
library(Hmisc)
# Creación de una variable categórica a partir de una variable continua
biciData$GRUPOS_ALTURA2 <- cut2(biciData$ALTURA, g = 4)

# Manipulación de Datos con plyr >> install.packages("plyr")
library(plyr)
# Ordenamiento de un data frame por una variable
arrange(td,td$Logico)         # Ascendente
arrange(td,desc(td$Logico))   # Descendiente
# Creación de una variable categórica a partir de una variable continua con mutate
biciData <- mutate(biciData,GRUPOS_ALTURA3=cut2(biciData$ALTURA, g=4))

# Organizar los dartos
# Uso de librería reshape2
library(reshape2)
# Reformateamos el data frame 
carMelt <- melt(mtcars, id=c("gear", "cyl"), measure.vars = c("mpg", "hp"))
# Creamos un data frame que contenga el resumen por cilindraje
cylData <- dcast(carMelt, cyl ~ variable)         # por default se suman los valores
cylData <- dcast(carMelt, cyl ~ variable, mean)   # se puede elegir la función a aplicar


# Realizamos la sumarización de valores por categoría con tapply
tapply(InsectSprays$count, InsectSprays$spray, sum)
# Realizamos la sumarización de valores por categoría con lapply a partir de listas generadas
listas <- split(InsectSprays$count, InsectSprays$spray)   # Particionamos el vector original por categoría
sumaListas <- lapply(listas, sum)                         # Sumamos los valores de cada categoría
vctr <- unlist(sumaListas)                                # Simplifica la lista y la transforma a un vector
sapply(sumaListas, sum)                                   # Aplica directamente la función sobre el conjunto de vectores 
# Repetimos el ejemplo usando plyr
ddply(InsectSprays, .(spray), summarize, resumen=sum(count))

# Manipulación de datos con dplyr
library(dplyr)
