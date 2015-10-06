# Escalas y esquemas de Colores

# Graficamos algo en la forma estándar
qplot(displ, hwy, data = mpg, color = cty)
# y modificamos su esquema de colores mediante la funcion:
# scale_color_gradient
qplot(displ, hwy, data = mpg, color = cty) + scale_color_gradient(low = "red", high = "yellow")
# scale_size_area
qplot(displ, hwy, data = mpg, color = cty) + scale_size_area()
# pch esquema gráfico de los shapes
?pch
# scale_shape_manual >> cambiamos los shapes por default
qplot(displ, cty, data = mpg, color = drv, shape = fl) + scale_shape_manual(values = c(0, 15, 1, 16, 3))

# Paletas de colores disponibles
library(RColorBrewer)
display.brewer.all()
qplot(displ, hwy, data = mpg, color = cty) + scale_fill_brewer(palette = "Set1")