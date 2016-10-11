# Autor: Miguel Jínez

# Fundamentos de R
# ================

# El operador <- Sirve para asignar valores a variables
variable <- "valor" # Asignación de un valores a variables

# Los nombres de las variables:
#   - Diferencian entre mayúsculas y minúsculas
#   - No pueden ser solamente números
#   - No pueden contener caracteres especiales como: ! - * &
otra_Variable <- 10
x <- otra_Variable
g <- 5

# Tipos de Datos en R
# Tipos de datos Básicos
  # Datos Atómicos
  tc <- "tipo de dato caracter" # Tipo de dato caracter
  tn <- 2.3                     # Tipo de dato duoble
  ti <- 5                       # Tipo de dato entero
  tl <- TRUE                    # Tipo de dato lógico
  tc <- as.complex(ti)          # Tipo de dato complejo
  # Factores
  tf <- as.factor(c("a","b"))
  # Missing
  tm <- NA
  tm <- NaN
  # Names
  names(tf) <- (c("a","z","x"))
  
# Tipos de datos Estructurados
  # Mismo tipo de Datos
  tv <- c(1,2,3,4)                        # Tipo de dato vector
  tx <- matrix(tv, nrow = 2)              # Tipo de dato matríz
  ta <- array(c(tv,tv+4), dim = c(2,2,2)) # Tipo de dato Array
  # Diferente tipo de datos
  tt <- list(1,2,"a",T)
  td <- data.frame(c(1,2,3), c("a","b","c"), c(T,F,F))
  # Tipos de datos que aceptan nombres: Vector, List y Data Frames
  names(td) <- c("Numero", "Letra", "Logico")
# Operaciones Matemáticas
g+x           # Suma
g-x           # Resta
g*x           # Multiplicación
x/g           # División
sqrt(x)       # Raíz cuadrada
x^g           # x elevado a la potencia g
exp(g)        # Número e elevado a la potencia g
log(g, x)     # Logaritmo de g en base x
factorial(g)  # Factorial de g
cos(x)        # Coseno de x
sin(x)        # Seno de x
tan(x)        # Tangente de x
abs(-x)       # Valor absoluto de -x

z <- cbind(x1 = 3, x2 = c(4:1, 2:5)) # Se crea un data frame con 2 columnas y 8 filas

rowMeans(z)   # Cálculo de los promedios de todas las filas
colSums(z)    # Cálculo de la suma de todas las filas del data frame z
rowSums(z)    # Cálculo de la suma de todas las columnas del data frame z

# Funciones
dividir <- function(x,y){   # Creamos una función para dividir 2 números
    resultado <- x/y        # Asignamos a la variable "resultado" la división de los parámetrso de la función
    print(resultado)        # Impresión del contenido de la variable resultado
}

dividir(x, g)               # Uso de la función creada previamente
dividir(x+2, 2.4)           # R permite interpretar los cálculos dinámicamente

# Concatenación y Arrays
tv <- c(1,2,3,4,5,6,7,8)   # La función c permite combinar valores en un vector o en una lista
tv + 2                     # Se realiza la suma de 2 a cada elemento del vector
concatenado <- c(tv, 9)    # Se agrega al array original un elemento nuevo

# Listar Objetos
ls()                                # Lista los objetos creados en la presente sesión
ls(pattern = "concate")             # Lista los objetos que cumplen con un patrón en particular

# Borrar Objetos
rm(variable)                        # Borra un objeto del ambiente de trabajo
rm(list = ls(pattern = "concate"))  # Se puede usar el parámetro list para pasarle una lista de objetos a borrar

# ========== #
# Ejercicios #
# ========== #
thames.longitud = 346           # Distancia en Km
severn.longitud = 354           # Distancia en Km
severn.length - thames.length   # El río Severn es 8 Km más largo que el río Thames
severn.length / thames.length   # El río Severn es 1.023 veces más largo que el río Thames

multiplicar <- function(){      # Creación de una función que multiplica 12.8, 19.2 y el número pi
    print(12.8 * 19.2 * pi)
}

multiplicar()                  # Uso dela función multiplicar
rm(list=ls())                  # Borrado de todos los objetos de Workspace

# Secuencias y SubScripting
# =========================
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

# ========== #
# Ejercicios #
# ========== #
a <- 60:85          # Creamos una secuencia entre 60 y 85
a[12]               # Extraemos el elemento 12 de la secuencia
a[20]               # Extraemos el elemento 20 de la secuencia
a[c(5,25)]          # Extraemos los elementos 5 y 25 de la secuencia
a[4*1:6]            # Extraemos los elementos 4, 8, 12, 16, 20 y 24 de la secuencia
a[-18]              # Extraemos todos los elementos de la secuencia excepto el elemento 18
a[c(-2, -15, -17)]  # Extraemos todos los elementos de la secuencia excepto los elementos 2, 15 y 17

n<-3
# Diferencia entre 1:n-1 y 1:(n-1)
1:n-1               # Crea una secuencia entre 0 y 2
1:(n-1)             # Crea una secuencia entre 1 y 2
# Crea un datra frame con:
  # columna 1 (c1) con una secuencia entre 33 y 47
  # columna 2 (c2) con una secuencia entre 115 y 157 con incrementos de 3
  # columna 3 (c3) con una secuencia que inicie en 10 y 157 con decrementos de 8.7 y con una longitud de 15
ndf <- data.frame(c1=c(33:47), c2=seq(from=115, to=157, by=3), c3=seq(from=10, length=15 ,by=-8.5))
ndf[c(2,6),2]       # Extrae los elementos 2 y 6 de la columna 2
ndf[11,]            # Extrae la fila 11 completa
ndf[c(4,8),c(1,3)]  # Extrae los elementos 4 y 8 de las columnas 1 y 3
nrow(ndf)           # Indica la cantidad de filas del data frame
# 4 formas diferentes de extraer la columna 1
ndf$c1
ndf[,1]
ndf[1:15,1]
ndf[seq(from=1, to=15),1]

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

# Algunas pruebas estadísticas
t.test(airquality[1:31,1], airquality[124:153,1])   # Prueba t-test (T-students)
# p-value > 0.05, lo que sostiene la hoipótesis Nula
head(ToothGrowth,12)                        # Dataset  con información de la longitud de los dientes de conejillos de indias en mm
cor.test(ToothGrowth[,1], ToothGrowth[,3])  # Se calcula la correlación entre la longitud de los dientes y las dosis de calcio
summary(airquality$Solar.R)                 # Estadísticos básicos de un dataset

# Funciones Estadísticas
mean(td$Numero)     # Calculo del promedio
median(tv)          # Calculo de la mediana
max(tv)             # Encuentra el valor máximo del objeto
min(tv)             # Encuentra el valor mínimo del objeto
range(tv)           # Encuentra el rango de valores del objeto (mínimo, máximo)
sum(tv)             # Suma los valores del objeto
var(tv)             # Varianza (Sample Variance)
quantile(tv)        # Extrae los quantiles 0, 25, 50, 75 y 100 del objeto
cumsum(tv)          # Suma acumulada de los valores del objeto
cumprod(tv)         # Producto acumulado de los valores del objeto
colMeans(ta)        # Calcula la media de cada columna del objeto
rowMeans(ta)        # Calcula la media de cada fila del objeto
colSums(ta)         # Suma los valores de las columnas del objeto
rowSums(ta)         # Suma los valores de las filas del objeto

# ========== #
# Ejercicios #
# ========== #
mean(airquality$Ozone, na.rm=TRUE)          # Cálculo de la media de la columna Ozono del dataset airquality
round(mean(airquality$Ozone, na.rm=TRUE),2) # Cálculo de la media de la columna Ozono del dataset airquality redondeado a 2 decimaless
any(is.na(airquality$Temp))                 # Verificar si existen NA en la columna Temp del dataset airquality
centigrados <- function(tf){                # Función para convertir grados F a C
  return ((tf-32)*(5/9))
}
centigrados(airquality[,4])                 # Probar la función con un array o con un escalar
range(centigrados(airquality[,4]))          # Encontrar el mínimo y el máximo valor de la temp en C
# Encontramos el mínimo y el máximo del dataset
airquality[which(airquality[,4] == max(airquality[,4]) | airquality[,4] == min(airquality[,4])),]
length(which(airquality[,3] <= 4))          # Cantidad de días con vientos menores o igual a 4mph
airquality[which(airquality[,2] > 300),]    # Días con radiación superior a 300 Langleys
median(airquality$Ozone, na.rm = TRUE)      # 2 maneras de encontrar la mediana
quantile(airquality$Ozone, na.rm = TRUE)[3]
# Verificar que variable tiene mayor correlación con la presencia de Ozono
cor.test(airquality$Ozone, airquality$Solar.R)
cor.test(airquality$Ozone, airquality$Wind)
cor.test(airquality$Ozone, airquality$Temp) # Mayor correlación
# Qué método (supp) cuya ingesta de calcio es de 2mg tiene el mayor promedio de la longitud de los dientes de los conejillos de indias
table(ToothGrowth$supp)
mean(ToothGrowth[which(ToothGrowth$supp=='OJ' & ToothGrowth$dose == 2.0),1])
mean(ToothGrowth[which(ToothGrowth$supp=='VC' & ToothGrowth$dose == 2.0),1])

# Condicionales
# =============
a <- 10
b <- 11
# La sentencia "else" tiene que estar en la misma línea donde termina el if
if(a<b){print("b es mayor que a")} # Este ejemplo da error
else {print("a es mayor que b")}

if(a<b){print("b es mayor que a") # Este ejemplo funciona bien
  } else {print("a es mayor que b")}

ifelse(a<b,"Si","No")             # ifelse permite evaluar una condición y tener una respuesta positiva y una negativa en la misma llamada

# Loops
for(i in 1:5){                # Iteración restringida con una secuencia
  print((i+1)*3)
}

for(i in c("a","m","z")){     # Iteración restringida con un vector
  print(i)
}

x <- 0
while(x<10){                  # Iteración NO restringida
  print(x)
  x<-x+1                      # Si comentamos esta línea el ciclo será infinito (ESC para terminar)
}

# ========== #
# Ejercicios #
# ========== #
x <- 10
y <- 25

if(x<y){
  print("La operación es correcta")
}

ifelse(x<=y, "La operación es correcta", "La operación NO es correcta")

if(x<=y){
  print("La operación es correcta")
} else {
  print("La operación NO es correcta")
}

z <- 50
ifelse(x>y, "Verdadero", ifelse(x>z, "Doble Falso", "Un Verdadero, un Falso"))

for(i in 1:20){
  print(i)
}
for(i in 5:10){
  print((i^2)-i)
}

letras <- c("P","I","R","A","T","E")
for(i in letras){
  print(i)
}

i <- -10
while(i >= -20){
  print(i)
  i <- i-1
}

h <- 10
j <- -5
if(h<j){
  print("Sentencia Verdadera")
} else {
  for(i in h:j){
    print(i)
  }
}

if(h<j){
  print("Sentencia Verdadera")
} else {
  i=h
  while(i >= j){
    print(i)
    i <- i-1
  }
}

# Gráficos
# ========

head(VADeaths)        # Dataset de tasa de muertes por grupo etario por miles en Virginia en 1940
barplot(VADeaths)     # Gráfico de Barras
boxplot(ToothGrowth$len)                                # Boxplots
boxplot(len ~ dose, ToothGrowth, subset = supp=="VC")   # eje X Dosis, eje Y Longitud
hist(islands)         # Histogramas
pie(15:1, col = rainbow(15))    # Gráficos de Pastel
pie(15:1, col = "red")
plot(cars$dist, cars$speed)
plot(cars)

# Trabajando con scatter plots y gráficos de líneas
head(trees)
plot(trees$Girth, trees$Height, type="p")
plot(trees$Girth, trees$Height, type="l")
plot(trees$Girth, trees$Height, type="b")
# Formateo de las etiquetas (xlab, ylab)
plot(trees$Girth, trees$Height, type="p", xlab="Circunferencia (pulgadas)", ylab="Altura (Pies)")
plot(trees$Girth, trees$Height, type="p", xlab="Circunferencia (pulgadas)", ylab="Altura (Pies)", xlim = c(8,18), ylim = c(60,90))
plot(trees$Girth, trees$Height, type="p", xlab="Circunferencia (pulgadas)", ylab="Altura (Pies)", las=1)
# Caracteres de Impresión - forma (pch entre 1 y 25)
plot(trees$Girth, trees$Height, type="p", xlab="Circunferencia (pulgadas)", ylab="Altura (Pies)", pch="1")
plot(trees$Girth, trees$Height, type="p", xlab="Circunferencia (pulgadas)", ylab="Altura (Pies)", pch=1)
plot(trees$Girth, trees$Height, type="p", xlab="Circunferencia (pulgadas)", ylab="Altura (Pies)", pch=16)
# Caracteres de Impresión - tamaño (cex)
plot(trees$Girth, trees$Height, type="p", xlab="Circunferencia (pulgadas)", ylab="Altura (Pies)", pch=16, cex=2)
plot(trees$Girth, trees$Height, type="p", xlab="Circunferencia (pulgadas)", ylab="Altura (Pies)", pch=16, cex=0.5)
# Caracteres de Impresión - Color (col)
colours()
plot(trees$Girth, trees$Height, type="p", xlab="Circunferencia (pulgadas)", ylab="Altura (Pies)", pch=16, cex=0.5, col="seagreen1")
# Caracteres de Impresión - Tipo de línea (lty y lwd)
plot(trees$Girth, trees$Height, type="l", xlab="Circunferencia (pulgadas)", ylab="Altura (Pies)", col="red", lty=2)
plot(trees$Girth, trees$Height, type="l", xlab="Circunferencia (pulgadas)", ylab="Altura (Pies)", col="red", lty=4, lwd=2)
# Agregando línea de Best Fit
abline(lm(trees$Height~trees$Girth))
# Agregando un segundo eje Y
par(mar=c(5,4,4,4))
plot(trees$Girth, trees$Height, xlab="Circunferencia (pulgadas)", ylab="Altura (Pies)", las=1, pch=16, col="springgreen")
par(new=T) 
plot(trees$Girth, trees$Volume, axes = F, xlab="", ylab="", pch=4, col="blue") # Graficamos el nuevo eje
axis(side=4, las=1)
mtext(side = 4, line = 2.5, "Volumen")
# Agregando la leyenda
legend("topleft", c("Altura (Pies)", "Volumen"), pch = c(16,4), col = c("springgreen", "blue"), bty = "n")
# Agregando un Título
title("Título del Gráfico", cex.main=1, font.main=2)
# Exportar Gráficos
#savePlot("archivo.jpg", type="jpeg") # Solo windows
quartz.save("archivo.jpg", type="jpg", dpi=300)
# Otros Gráficos
coplot(lat ~ long|depth, data = quakes)
plot(lat ~ long, data = quakes)

# ========== #
# Ejercicios #
# ========== #
summary(sunspot.year)
plot(1700:1988, sunspot.year, xlab = "Año", ylab = "Cantidad de Manchas Solares por Año", xlim = c(1700,2000),
  ylim = c(0,200), las=1, type="l", col="darkorange", lwd=2)
title("Observaciones de manchas solares entre 1700 y 1988", cex.main=1.2)

par(mar=c(5,4,4,4))
plot(airquality$Ozone, airquality$Temp, xlab="Concentración de Ozono", ylab="Temperatura F", xlim=c(0,180), ylim = c(50,100), las=1, pch=18, col="red", cex=1.2)
abline(lm(airquality$Temp ~ airquality$Ozone), col = "red", lty=3, lwd=1.5)
par(new=TRUE)
plot(airquality$Ozone, airquality$Wind, axes = F, xlab = "", ylab = "", xlim = c(0,180), ylim = c(0,21), col="slateblue", pch=4, cex=0.75)
axis(side = 4, las = 1)
mtext(side = 4, "Velocidad del Viento (mph)")
abline(lm(airquality$Temp ~ airquality$Wind), col = "slateblue", lty=3, lwd=1.5)
title("Medidas diarias de la calidad del aire medidas en NY entre Mayo y Sept 1973", cex=0.95)
legend("bottomleft",c("Temperatura F", "Velocidad del viento (mph"), pch=c(18,4), col=c("red", "slateblue"),  bty="n")
dev.copy(png, "ny_air_quality.jpg")
