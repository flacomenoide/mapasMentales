# Fundamentos de R
# ================
# Autor: Miguel Jínez

# El operador <- Sirve para asignar valores a variables
variable <- "valor" # Asignación de un valores a variables

# Los nombres de las variables:
#   - Diferencian entre mayúsculas y minúsculas
#   - No pueden ser solamente números
#   - No pueden contener caracteres especiales como: ! - * &
otra_Variable <- 10
x <- otra_Variable
g <- 5

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
abs(-x)        # Valor absoluto de -x

z <- cbind(x1 = 3, x2 = c(4:1, 2:5)) # Se crea un data frame con 2 columnas y 8 filas

rowMeans(z)   # Cálculo de los promedios de todas las filas
colSums(z)    # Cálculo de la suma de todas las filas del data frame z
rowSums(z)    # Cálculo de la suma de todas las columnas del data frame z

# Funciones
# =========
dividir <- function(x,y){   # Creamos una función para dividir 2 números
    resultado <- x/y        # Asignamos a la variable "resultado" la división de los parámetrso de la función
    print(resultado)        # Impresión del contenido de la variable resultado
}

dividir(x, g)               # Uso de la función creada previamente
dividir(x+2, 2.4)           # R permite interpretar los cálculos dinámicamente

# Concatenación y Arrays
# ======================
concatenado <- c(1,2,3,4,5,6,7,8)   # La función c permite combinar valores en un vector o en una lista
concatenado + 2                     # Se realiza la suma de 2 a cada elemento del vector

# Listar y Borrar objetos
# =======================
ls()                                # Lista los objetos creados en la presente sesión
ls(pattern = "concate")             # Lista los objetos que cumplen con un patrón en particular

rm(variable)                        # Borra un objeto del ambiente de trabajo
rm(list = ls(pattern = "concate"))  # Se puede usar el parámetro list para pasarle una lista de objetos a borrar

# Ejercicios
thames.length = 346
severn.length = 354
