# Data Cleaning
# Configuro el directorio de trabajo
setwd("./mapasMentales/lenguajesProgramacion/codigoR/")

# Verifico  si existe el directorio "data
if(!file.exists("datos")){
  # Si no existe el directorio lo creo
  dir.create("datos")
}

# Asignacion de una variable con la URL de un archivo
archURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
archXlsxURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"

# Descarga del archivo, se usa el método curl porque la URL usa https
download.file(archURL, destfile = "./datos/camaras.csv", method = "curl")
download.file(archXlsxURL, destfile = "./datos/camaras.xlsx", method = "curl")

# Listamos los archivos del directorio data
list.files("./datos")

fechaDescarga <- date()  # obtenemos la fecha de descarga del archivo

# Carga el archivo descargado en un data frame
  # Archivo de texto
  datosCamara <- read.table("./datos/camaras.csv", sep = ",", header = T)

  # Archivo excel
  # Para leer archivos excel se necesita tener el paquete xlsx >> install.packages("xlsx")
  library(xlsx)             # Cargamos la librería xlsx
  datosCamaraExcel0 <- read.xlsx("./datos/camaras.xlsx", sheetIndex = 1, header = T)
  # Podemos leer filas y columnas específicas
  indiceCol <- 2:3
  indiceFila <- 1:5
  datosCamaraExcel1 <- read.xlsx("./datos/camaras.xlsx", sheetIndex = 1, colIndex = indiceCol, rowIndex = indiceFila)
  
  # Archivo XML
  # Para leer archivos XML se necesita instalar el paquete XML >> install.packages("XML")
  library(XML)              # Cargamos la librería XML
  # Asigna la URL del archivo a una variable
  archXmlURL <- "http://www.w3schools.com/xml/simple.xml"
  # Parsea el XML en una estructura R
  doc <- xmlTreeParse(archXmlURL, useInternalNodes = T)
  # Obtiene el nodo raíz
  nodoRaiz <- xmlRoot(doc)
  # Obtiene el nombre del nodo raíz
  xmlName(nodoRaiz)
  # Obtiene los nombres de los elementos del nodo raíz
  names(nodoRaiz)
  # Obtiene el primer elemento de la estructura
  nodoRaiz[[1]]
  # Acceso directo al primer valor del primer elemento de la estructura
  nodoRaiz[[1]][[1]]
  # Extracción de todos los valores del objeto XML
  xmlSApply(nodoRaiz, xmlValue)
  # Extracción del valor del atributo "name" de cada elemento del objeto XML
  xpathSApply(nodoRaiz, "//name", xmlValue)
  # Extracción del valor del atributo "price" de cada elemento del objeto XML
  xpathSApply(nodoRaiz, "//price", xmlValue)
  # Otro ejemplo de extracción de HTML (similar a XML)
  archXmlURL <- "http://www.espn.com/nfl/team/_/name/bal/baltimore_ravens"
  doc1 <- htmlTreeParse(archXmlURL, useInternalNodes = T)
  scores <- xpathSApply(doc1, "//li[@class='record']", xmlValue)
  teams <- xpathSApply(doc1, "//li[@class='team-name']", xmlValue)
  
  # Archivo JSON
  # Para trabajar con objetos JSON es necesario el paquete jsonlite >> install.packages("jsonlite")
  library(jsonlite)         # Cargamos la librería jsonlite
  # Asigna a una variable la URL de un archivo JSON
  archJSON <- "https://api.github.com/users/flacomenoide/repos"
  # Obtiene los datos desde el objeto JSON y lo asignamos a un data frame
  datosJSON <- fromJSON(archJSON)
  # Obtiene los nombres de las columnas del data frame generado
  names(datosJSON)
  # Obtiene los nombres del data frame de la columan owner
  names(datosJSON$owner)
  # Obtiene los valores de la  columna login del data frame de la columan login
  datosJSON$owner$login
  
  # Transforma un data frame a JSON
  myJson <- toJSON(iris, pretty = T)
  # Transforma de JSON a data frame
  iris2 <- fromJSON(myJson)

# Paquete data.table >> versión más eficiente de los data frames
# Instalar el paquete para poder usarlo >> install.packages("data.table")
library(data.table)
# Crear un data frame
df <- data.frame(x=rnorm(9), y=rep(c("a","b","c"),each=3), z=rnorm(9))
# Crear un data table similar al data frame anterior
dt <- data.table(x=rnorm(9), y=rep(c("a","b","c"),each=3), z=rnorm(9))
# Permite ver las tablas que están en memoria
tables()
# La extracción de filas es similar al data frame
dt[2,]
dt[dt$y=="a",]
# Para la extracción de columnas necesitamos usar expresiones
# Expresiones en R son sentencias delimitadas por {}
# R
# Trae el promedio de las columas x y z cuando pasamos como argumento una lista
dt[,list(mean(x), sum(z))]
# Trae una tabla de resumen de la columna y cuando pasamos una función como parámetro
dt[,table(y)]
# Agrega la nueva variable w al data table
dt[,w:=z^2]
# Creamos una nueva variable con múltiples operaciones
dt[,m:={tmp <- (x+z); log(tmp+5)}]
dt[,a:=x>0]
dt[,b:=mean(x+w), by=a]
# .N Sirve para contar el número de veces que un valor aparece
dt[,.N, by=y]

# Creando keys en data tables
dt1 <- data.table(x=rep(c("a","b","c"),each=100),y=rnorm(300))
setkey(dt1,x)
# Filtrando un data table por la clave
dt1['a']

# Conectarse a MySQL | mariadb
library(RMySQL)     # Cargamos la librería RMySQL
# Se establece una conexión con un servidor
conexion <- dbConnect(MySQL(),user="genome", host="genome-mysql.cse.ucsc.edu")
# Ejecuta una sentencia y almacena su resultado en una variable
result <- dbGetQuery(conexion, "show databases;")
# Desconexión de la Base
dbDisconnect(conexion)

# Conexión a una base en particular
conexion <- dbConnect(MySQL(),user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
# Obtener el listado de las tablas de la base de datos
tablas <- dbListTables(conexion)
length(tablas)
# Obtener los campos de una tabla
dbListFields(conexion, "affyU133Plus2")
# Obtener los resultados de un query
dbGetQuery(conexion, "SELECT COUNT(*) FROM affyU133Plus2")
# Leer datos de una tabla en un data frame
datos <- dbReadTable(conexion, "affyU133Plus2")
head(datos)
# Ejecuta un query en la Base de Datos, solo permite sentencias SELECT
query <- dbSendQuery(conexion, "SELECT * FROM affyU133Plus2 WHERE misMatches between 1 and 3")
datosMisMatches <- fetch(query)
quantile(datosMisMatches$misMatches)
datosMisMatches10 <- fetch(query, n=10)
# Libera los recursos locales y remotos relacionados con el result set
dbClearResult(query)
dim(datosMisMatches10)
dbDisconnect(conexion)

# Fuentes de Datos HDF5
# Se necesita instalar el paquete hdf5
  # Definimos el origen como BioConductor
  source("http://bioconductor.org/biocLite.R")
  biocLite("rhdf5")
library(rhdf5)
# Creación de un archivo hdf5
archH5 <- h5createFile("./datos/ejemplo.h5")
# Creación de Grupos
h5createGroup("./datos/ejemplo.h5", "foo")
h5createGroup("./datos/ejemplo.h5", "baa")
h5createGroup("./datos/ejemplo.h5", "foo/foobaa")
# Listado del contenido del archivo hdf5
h5ls("./datos/ejemplo.h5")
# Escritura en los grupos
a <- matrix(1:10,nr=5, nc=2)
# Escritura de contenido dentro de un grupo específico
h5write(a, "./datos/ejemplo.h5", "foo/A")
b <- array(seq(0.1,2.0, by=0.1), dim=c(5,2,2))
attr(b, "scale") <- "liter"
h5write(b, "./datos/ejemplo.h5", "foo/foobaa/b")
# Escritura por bloques
h5write(c(11,12,13), "./datos/ejemplo.h5", "foo/A", index=list(1:3,1))
# Lectura de un archivo hdf5
la <- h5read("./datos/ejemplo.h5", "/foo")
h5read("./datos/ejemplo.h5", "/foo/A")
h5ls("./datos/ejemplo.h5")
# Cierra todos los archivos HDF5 abiertos
H5close()

# Lectura de datos desde páginas web
# Crea la conexión con una página web
conexionW <- url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=es")
# Obtiene el contenido de la página web
codHtml <- readLines(conexionW)
# Cierra la conexión
close(conexionW)
codHtml
# Parseando la página con XML
library(XML)
# Asignamos la URL a una variable
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=es"
codHtml1 <- htmlTreeParse(url, useInternalNodes = T)
# Se extrae el Título
xpathSApply(codHtml1, "//title", xmlValue)
# Se extrae la columna "citado por"
xpathSApply(codHtml1, "//td[@class='gsc_a_c']", xmlValue)
# Uso de la librería httr
library(httr)
# Obtiene la URL y la asigna a una variable
codHtml2 <- GET(url)
# Obtiene el contenido de la paǵina
contenido <- content(codHtml2, as="text")
# Parsea el contenido
contenidoOrdenado <- htmlParse(contenido, asText = T)
# Extráe el título
xpathSApply(contenidoOrdenado, "//title", xmlValue)

# Uso de Get en páginas con password
pg1 <- GET("http://httpbin.org/basic-auth/user/passwd") # La respuesta es vacía
pg2 <- GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user", "passwd"))
names(pg2)
# Se define un handle para google.com
goog <- handle("http://google.com")
# Se obtienen múltiples páginas del dominio google.com manteniendo el handle
pg1 <- GET(handle = goog, path="/")
pg2 <- GET(handle = goog, path="search")
sign_oauth1.0()
sign_oauth2.0()