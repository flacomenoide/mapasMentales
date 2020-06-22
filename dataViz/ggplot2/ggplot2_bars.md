# Barcharts

Son una excelente forma de visualizar la distribución de variables categóricas.

## Geometrías

### geom_bar()
  * Eje X, el mapeo del eje de las x necesita una variable categórica.
  * Eje Y, no hace falta mapear el eje de las y, por defecto ggplot asignará el conteo de las veces que la categoría aparece en el dataset.

### goem_col()
Permite elegir la altura del eje de las Y con la asignaci{on de una variable.
La relación entre las variables debe ser 1:1, esto quiere decir que ggplot no calculará sumarizaciones de los valores de Y.

  * Eje X, necesita ser mapeado o a una variable categorica o continua.
  * Eje Y, necesita ser mapeado a una variable continua.

## Estéticas Disponibles
Estas son algunas de las estéticas y parámetros disponibles más comunes para los gráficos de barras.

* **color** - controla el color del contorno de las barras.
* **fill** - controla el color interno de la barras.
* **width** - permite controlar el ancho de cada barra, hay que resaltar que este es un *parámetro* y no una estática por lo que se debe configurar fuera de la funcion `aes`.

## Posiciones
Las posiciones nos permiten definir como queremos que las barras estén organizadas, principalmente cuando representan varias categorías. Por default las barras se muestran apiladas (*stacked*), este comportamiento se puede cambiar ajustando el parámetro de posición.

* **dodge** - si la barra tiene varias categorías esta posición sirve para dividirla en varias barras ubicadas una a lada de otra.
* **stack** - es la posición por defecto, permite que si hay varias categorías se apilen una encima de otra en una sola barra multicolor.
* **fill** - esta posición expande las barras hasta llenar el eje de las Y al 100% y distribuye los valores de las categorías en porcentajes, lo que facilita la comparación de las proporciones.
* **identity** - es una posición que permite que los objetos se sobrepongan unos con otros, suele ser una mala elección para gráficos de barras ya que podría dar la sensación de barras apiladas cuando en realidas están sobrepuestas, todas inician en 0.
