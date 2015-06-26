# Modificacion de temas

# Gráfico original
qplot(displ, hwy, data = mpg, color = cty)

# Agregando borde
qplot(displ, hwy, data = mpg, color = cty) + theme(panel.border = element_rect(color = "black", fill = NA))

#instalando nuevos temas
install.packages("ggthemes")
library(ggthemes)

# Un gráfico con varios temas
qplot(displ, hwy, data = mpg, color = cty) + theme_grey()
qplot(displ, hwy, data = mpg, color = cty) + theme_bw()
qplot(displ, hwy, data = mpg, color = cty) + scale_fill_excel() + theme_excel()

# Cambiando la leyenda
q <- qplot(displ, hwy, data = mpg, color = cty) 
q + theme(legend.position = "bottom")
q + guides(color = "legend")
q + guides(color = "none")
q + guides(color = "colorbar")
q + scale_fill_discrete(name = "LegenDa")
