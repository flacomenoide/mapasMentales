# Usando ORE (Oracle R Enterprise)
library(ORE)

if (!ore.is.connected()) # Verifica que no exista una conección ORE abierta
	ore.connect("ruser", "orcl", "host", "password", all = TRUE) # Crea una conexión a la DB con SID orcl
	# El argumento all hace que se cargue la metadata de todas las tablas del esquema en objetos ore.frame
ore.ls() # Lista las tablas y vistas disponibles
ore.disconnect()

ore.connect("ruser", "orcl", "host", "password") Crea una conexión sin el parámetro all
ore.sync(table = "TABLA") # carga la metadata de una tabla del esquema de la DB
ore.attach() # Hace válidos los objetos en el search path

# Selección de Colummas
df <- TABLA[, c("col1", "col2", "col3")] # Selección de columnas de TABLA por nombre
class(df)
head(df)
head(TABLA[, c(1, 4, 23)]) # Selección de columnas de TABLA por índice
head(TABLA[, -(1:22)]) # Selección de columnas de TABLA, elimina las columnas de la 1 a la 22 con la especificación del signo menos

# Selección de Filas
df1 <- df[df$col1 == "valor", ] # Selección de filas por cumplimiento de la expresión lógica
class(df1)
df2 <- df[df$col1 == "valor", c(1, 3)]
df3 <- df[df$col1 == "valor" | df$col1 == "valor0", 1:3]
head(df1)
head(df2)
head(df3)

# Uniendo Tablas
df1 <- data.frame(x1 = 1:5, y1 = letters[1:5])
df2 <- data.frame(x2 = 5:1, y2 = letters[11:15])
merge(df1, df2, by.x = "x1", by.y = "x2") # Usamso merge con objetos data.frame

ore.drop(table = "TABLA1")
ore.drop(table = "TABLA2")

ore.create(df1, table = "TABLA1")
ore.create(df2, table = "TABLA2")
merge(TABLA1, TABLA2, by.x = "x1", by.y = "x2") # Usamso merge con objetos ore.frame

# Crear un data frame temporal
DAT1 <- ore.push(dfx) # Crea el ore.frame DAT1 a partir del data frame dfx
ore.lm.mod <- ore.lm(variableApredecir ~ ., DAT1)
lm.mod <- lm(mpg ~ cyl + disp + hp + wt + gear, mtcars)
ore.save(ore.lm.mod, lm.mod, name = "dataStore0", overwrite = TRUE) # Almacena los objetos en la BD en el datastore0
ore.datastoreSummary("dataStore0")

# Usando la capa de transparencia
res <- ore.doEval(function(num = 10, escala = 100) {
				ID <- seq(num)
				data.frame(ID = ID, RES = ID/escala)
				})
class(res)
res
local_res <- ore.pull(res)
class(local_res)
local_res