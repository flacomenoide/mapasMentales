# Manipulación de Texto
setwd("./colabs/mapasMentales/lenguajesProgramacion/codigoR/")
biciData <- read.csv("./datos/bicicleterias.csv", header = T, sep = ";")
names(biciData)
# Pasar todas las letras a minúsculas
tolower(names(biciData))
# Dividir una cadena de texto basado en un caracter
x <- "cadena.con.texto"
xDividido <- strsplit(x,"\\.")  # divide la cadena de texto en cada caracter "."
xDividido[[1]][3]
sub("\\.", "", x)               # reemplaza el primer "." con nada
gsub("\\.", "", x)              # reemplaza todos los "." con nada
# Encontrar texto
grep("CABALLITO",biciData$BARRIO)   # devuelve los números de filas que contienen la palabra CABALLITO en la columna BARRIO
grepl("CABALLITO",biciData$BARRIO)  # devuelve un vector con TRUE en filas que contienen la palabra CABALLITO en la columna BARRIO

# Uso de la librería stringR
library(stringr)
nchar(x)                # trae el número de caracteres de un string
substr(x,5,7)           # extrae un substring entre la posición 5 y la posición 7
paste(x, "agregado")    # concatena 2 strings y los separa con un espacio
paste0(x, "agregado")   # concatena 2 strings
str_trim("hola   ")     # elimina espacios tanto del inicio como del final de un string
