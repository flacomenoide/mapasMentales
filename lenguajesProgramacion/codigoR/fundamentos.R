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
# Generación de secuencias
5:15    # Ascendente
8:-2    # Descendente
# Uso de la función seq()
seq(from=1, to=12, by= 2)
