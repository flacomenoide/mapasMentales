# Fundamentos de R

# El operador <- Sirve para asignar valores a variables
variable <- "valor" # Asignación de un valores a variables
otra_Variable <- 10
x <- otra_Variable

# Los nombres de las variables:
#   - Diferencian entre mayúsculas y minúsculas
#   - No pueden ser solamente números
#   - No pueden contener caracteres especiales como ! - * &
g <- 5

# Operaciones Matemáticas
g+x           # Suma
g-x           # Resta
g*x           # Multiplicación
x/g           # División
sqrt(x)       # Raíz cuadrada
x^g           # x elevado a la potencia g
exp(g)        # e elevado a la potencia g
log(g, x)     # Logaritmo de g en base x
factorial(g)  # Factorial de g
cos(x)        # Coseno de x
sin(x)        # Seno de x
tan(x)        # Tangente de x
abs(x)        # Valor absoluto de x

z <- cbind(x1 = 3, x2 = c(4:1, 2:5)) # Se crae un data frame con 2 columnas y 8 filas
rowMeans(z)   # Cálculo de los promedios de todas las filas
colSums(z)    # Cálculo de la suma de todas las filas del data frame z
rowSums(z)    # Cálculo de la suma de todas las columnas del data frame z
