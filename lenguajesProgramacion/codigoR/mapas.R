# Graficar datos geoespaciales

# Instalamos y cargamos en memoria el paquete maps
install.packages("maps")
library(maps)

# Instalamos mapproj para poder hacer uso de coord_map
install.packages("mapproj")

# Crea un data frame llamado counties
counties <- map_data("county")

# Grafica el mapa de Estados Unidos
qplot(long, lat, data = counties, group = group, fill = group, geom = "polygon")

# Leer archivo texas.csv y cargarlo en el data frame texas
texas <- read.csv("D:/Importante/Intro/data/texas.csv")

# Realiza un gráfico de puntos con la latitud y longitud registrados en el dataset
qplot(long, lat, data = texas)

# Revisar el help sobre maps
help(package = "maps")
# Muestra el gráfico del mapa de Texas en el plano
qplot(long, lat, data = texas)
# Mostramos el mapa de Texas coloreado por la variable "bin"
tx <- qplot(long, lat, data = texas, geom = "polygon", group = group, fill = bin)
# Agregamos el título a un gráfico
tx2 <- tx + ggtitle("Poblaci�n de Counties de Texas")
tx + scale_fill_brewer(palette = "Greys") + coord_map() + theme_bw() + ylab("") + xlab("") + ggtitle("Texas")