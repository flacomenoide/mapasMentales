# Generalidades de ggplot2 

## Facetas
Las facetas nos permiten generar sub-gráficoss que nos facilitan la comparación de los datos.

* **facet_grid** - divide el gráfico en una cuadrícula de sub-gráficos basado en los valores de una o dos variables que sirven de facetas, las cuales son presentadas como una fórmula por lo cual se utiliza el caracter "~", las variables se pueden omitir colocando un "." en su lugar.

  `facet_grid(variable_filas ~ variable_columnas)`

  `facet_grid(. ~ variable_columnas)`

  `facet_grid(variable_filas ~ .)`


* **facet_wrap** - permite dividir el gráfico de una manera más sencilla basándose en una sola variable, permite reorganizar los sub-gráficos en múltiples filas. La variable es invocada anteponiéndo el signo "~", estos sub-gráficos tienen una apariencia casi cuadrada.

  `facet_wrap( ~ variable)`

* **scales** - cada faceta en el gráfico comparte los ejes, los cuales pueden ser cambiados usando el argumento `scales` tanto en `facet_grid` como en `facet_wrap`.
  - **`scales = free`** - permite que los rangos de los ejes X e Y varíen en cada sub-gráfico.
  - **`scales = free_y`** - permite que el eje Y de cada sub-gráfico varíe pero no el eje X.
  - **`scales = free_x`** - permite que el eje X de cada sub-gráfico varíe pero no el eje Y.

## Girar Coordenadas
* **coord_flip()** - esta función permite intercambiar los ejes X y Y.
