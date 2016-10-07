# data cleaning
# Configuro el directorio de trabajo
setwd("./mapasMentales/lenguajesProgramacion/codigoR/")

# Verifico  si existe el directorio "data
if(!file.exists("datos")){
  # Si no existe el directorio lo creo
  dir.create("datos")
}

# Asignacion de una variable con la URL de un archivo
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

# Descarga del archivo, se usa el método curl porque la URL usa https
download.file(fileUrl, destfile = "./datos/camaras.csv", method = "curl")
# Listamos los archivos del directorio data
list.files("./datos")

fechaDescarga <- date()

datosCamara <- read.table("./datos/camaras.csv", sep = ",", header = T)
head(datosCamara)
