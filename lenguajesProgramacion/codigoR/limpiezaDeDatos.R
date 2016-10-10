# data cleaning
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
  datosCamaraExcel1
  
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
  