# Histogramas 

Histogramas son las manera más popular de visualizar distribuciones contínuas.

[![Histogramas](https://i.vimeocdn.com/video/639920124.jpg?mw=400&mh=300&q=70)](https://vimeo.com/221607341 "Click para ver el video")

## Geometrías

### geom_histogram()
  * Eje X, el mapeo del eje de las X necesita una variable contínua.
  * Eje Y, no hace falta mapear el eje de las Y al igual que con geom_bar geom_histogram construye este eje contando el número de observaciones de cada segmento del eje X.

#### Parámetros
  
  * **binwidth** - ggplot usa por defecto 30 segmentos, esto puede ser modificado definiendo el valor del argumento `binwidth` que es interpretado como la unidad mínima del eje X.
  * **bins** - alternativamente se puede usar el argumento `bins` que define el número total de segmentos a usar en el eje X.
  * **boundary** - permite mover los segmentos hacia la izquierda o la derecha en el eje X, toma un valor de X como límite entre 2 segmentos.

## Estéticas Disponibles
Los histogramas comparten las mismas estéticas que los gráficos de barras.

* **color** - controla el color del contorno de las barras.
* **fill** - controla el color interno de la barras.
* **width** - permite controlar el ancho de cada barra, hay que resaltar que este es un *parámetro* y no una estática por lo que se debe configurar fuera de la funcion `aes`.

## Geometrías Similares

Existen geometrías que usan la misma información del histograma pero las muestran de diferentes maneras:
  * **geom_freqpoly** - dibuja un polígono de frecuencia que usa una línea para mostrar la misma información del histograma, se puede pensar como un polígono que une las cimas de las barras del histograma.
  * **geom_density** - permite comparar más fácilmente las formas de las distribuciones, dibuja una estimación de un kernel de densidad para cada distribución, es una representación suavizada de los datos, el eje Y no representa los conteos sino la densidad de las observaciones (n / total). Las áreas de densidad son más fáciles de comparar que los conteos.
  * **geom_dotplot** - representa cada observación con un punto en una columna de puntos dentro de los segmentos para crear una percepción de un histograma, su uso no es aconsejable para grandes cantidades de datos.
