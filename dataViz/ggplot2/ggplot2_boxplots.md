# Boxplots y Count Plots

## Boxplots

Muestran relaciones entre una variable contínua y una categórica, aunque tiene funciones que ayudan a comparar dos (2) variables contínuas.

Boxplots permiten analizar la distribución de una variable contínua y compararla de una manera simple entre múltiples categorías.

[![Boxplots](https://i.vimeocdn.com/video/640873839.jpg?mw=400&mh=300)](https://vimeo.com/222358034, "Click para ver el video")

### geom_boxplot()
  * Eje X, el mapeo del eje de las X necesita una variable categórica.
  * Eje Y, el mapeo del eje de las Y necesita una variable contínua.

### Parámetros y Estéticas Disponibles
Los boxplots permiten cambiar la manera de presentar los outliers con los parámetros: 
* **outlier.color**
* **outlier.fill**
* **outlier.shape**
* **outlier.shape** - admite valores entre 1 y 25.
* **outlier.size**
* **outlier.stroke**
* **outlier.alpha**

Estéticas disponibles:
* **alpha** - controla el nivel de transparencia de las cajas.
* **color** - controla el color del contorno de las cajas.
* **fill** - controla el color interno de la cajas.
* **group** - permite comparar dos (2) variables continuas en un boxplot.
* **linetype** - controla el tipo de línea de las cajas.
* **shape**
* **size**
* **weight**

### Cómo Categorizar una Variable Contínua

ggplot2 permite usar tres (3) funciones que ayudan en este propósito:

* **cut_interval()** - divide un vector en **n** partes de rangos iguales.
* **cut_number()** - divide un vector en **n** grupos con (aproximadamente) la misma cantidad de observaciones en cada categoría.
* **cut_width()** - divide un vector en grupos de ancho `width`.

### Geometrías Similares 
* **geom_dotplot()** - si al argumento `binaxis` se asigna "y" este se comparta como un boxplot y muestra distribuciones para cada categoría, el resultado es similar a histogramas verticales, el argumento `stackdir = "center"` permitirá que el histograma se muestre con un estilo de gráfico violín.

* **geom_violin** - es una alternativa a los boxplots, usa densidades para graficar una versión suavizada de dotplots centrados. Argumentos útiles:
  * `draw_quantiles = c(0.25, 0.5, 0.75)` dibujará líneas horizontales  en los violines en los quantiles definidos.

## Count Plots 

Count plots muestran realaciones entre dos (2) variables categóricas, prácticamente dibuja un punto por cada intersección de las categorías de las dos (2) variables el tamaño del punto representa la cantidad de observaciones de la combinación.

Los mapas de calor proveen otra manera de visualizar la relación de dos (2) variables categóricas pero en lugar de mostrar puntos de diferentes tamaños usa colores.

### Geometrías

* **geom_count()**
* **geom_tile()**
