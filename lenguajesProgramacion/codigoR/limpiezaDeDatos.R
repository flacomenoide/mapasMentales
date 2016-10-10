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
archXmlURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"

# Descarga del archivo, se usa el método curl porque la URL usa https
download.file(archURL, destfile = "./datos/camaras.csv", method = "curl")
download.file(archXmlURL, destfile = "./datos/camaras.xlsx", method = "curl")

# Listamos los archivos del directorio data
list.files("./datos")

fechaDescarga <- date()  # obtenemos la fecha de descarga del archivo

# Carga el archivo descargado en un data frame
  # Archivo de texto
  datosCamara <- read.table("./datos/camaras.csv", sep = ",", header = T)

  # Archivo excel
  # Para leer archivos excel se necesita tener el paquete xlsx install.packages("xlsx")
  library(xlsx)             # Cargamos la librería xlsx
  datosCamaraExcel0 <- read.xlsx("./datos/camaras.xlsx", sheetIndex = 1, header = T)
  # Podemos leer filas y columnas específicas
  indiceCol <- 2:3
  indiceFila <- 1:4
  datosCamaraExcel1 <- read.xlsx("./datos/camaras.xlsx", sheetIndex = 1, colIndex = indiceCol, rowIndex = indiceFila)
  