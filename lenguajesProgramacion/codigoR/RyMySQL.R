# Trabajar con R y MySQL
# install.packages("igraph") # Se instala si no se lo tiene en el sistema local
library(DBI) # Necesitamos DBI
library(RMySQL) # Necesitamos RMySQL
library(igraph) # Necesitamos igraph para análisis de redes sociales
library(dplyr) # Librería útil para trabajar con DBs
library(ggplot2) # Librería útil para graficar

# Creamos la conexión a la Base de Datos
cat("Por favor ingrese el Password: ");passwd <- scan("", what = " ", nlines = 1)
conM <- dbConnect(MySQL(), user = 'dblocal', password = passwd, host = 'localhost', dbname = 'uso_local')

# Podemos crear un df desde el resultado de un query
# Partimos de un data frame extraido desde una tabla relacional previamente preparada con los links entre nodos
transf <- dbGetQuery(conn = conM, statement = "select * from grafo_ordenado;") # traigo el grafo desde la DB
transf <- transf[,c(1,4,2,3,5,6,7,8,9,10,11,12)] # reordeno las columnas

importes <- dbGetQuery(conn = conM, statement = "select * from uso_local.importes;") # del grafo extraje los montos de cada conexión

names(importes) <- c("nodo", "cuenta", "banco", "importe_in", "importe_out")

g <- graph_from_data_frame(transf, directed = FALSE, vertices = NULL) # Creamos un objeto graph no dirigido
d <- degree(g) # Calculamos el degree de cada nodo
summary(d)
boxplot(d) # miro la distribución del degree de los nodos del grafo
boxplot(d, ylim = c(0,3))
# Existe una concentración de nodos con degree 1
# Para fines demostrativos se opta por elegir como líder a un nodo con degree superior a 3
quantile(d, c(.25, .50, .95)) # Miro los valores de los percentiles importantes en el degree de los nodos del grafo'


#coms <- multilevel.community(g) # Detección de comunidades con método multinivel
coms1 <- cluster_louvain(g) # Detección de comunidades con método louvain
modularity(coms1) # modularitad total

# La siguiente linea tarda mucho
plot(coms1, g) # imprime un gráfico de las comunidades

cent <- eigen_centrality(g) # Calculamos la centralidad de cada nodo en el grafo
close <- closeness(g) # Calculamos el closeness de cada nodo en el grafo
bet <- betweenness(g) # Calculamos el betweenness de cada nodo en el grafo
df_degree <- data.frame(names(d), d[names(d)], stringsAsFactors = F) # creamos un df con los degrees de cada nodo
# Definimos a los líderes en el grafo
df_degree$lider <- 0
df_degree[df_degree[,2] > 3,]$lider <- 1

df_community <- data.frame(coms1$names, coms1$membership, stringsAsFactors = F) # creamos df con nodo - comunidad
df_centrality <- data.frame(names(cent$vector), cent$vector[names(cent$vector)], stringsAsFactors = F) # creamos df con nodo -centralidad
df_closeness <- data.frame(names(close), close[names(close)], stringsAsFactors = F) # creamos df con nodo - closeness
df_betweeness <- data.frame(names(bet), bet[names(bet)], stringsAsFactors = F) # creamos df con nodo - betweeness
names(df_degree) <- c("nodo", "degree", "lider")
names(df_community) <- c("nodo", "comunidad")
names(df_centrality) <- c("nodo", "centralidad")
names(df_closeness) <- c("nodo", "closeness") ##
names(df_betweeness) <- c("nodo", "betweeness") ##

# Joinear todos los resultados
df_fin <- left_join(importes, df_degree, by = "nodo")
df_fin <- left_join(df_fin, df_community, by = "nodo")
df_fin <- left_join(df_fin, df_centrality, by = "nodo")
df_fin <- left_join(df_fin, df_closeness, by = "nodo")
df_fin <- left_join(df_fin, df_betweeness, by = "nodo") # Este dataset tiene a cada nodo con sus métricas generales

dbWriteTable(conM, "metricas", df_fin, overwrite = T, row.names = F) # Escribimos los resultados en la DB

# Con estos pasos verificamos las cuentas que generan mayor flujo de salida de dinero
df_cuentas_out <- df_fin[df_fin$banco == "BANCO ORIGEN", ]
head(df_cuentas_out[order(-df_cuentas_out$importe_out),])

comRes <- tapply(df_fin$degree, df_fin$comunidad, length)
plot(comRes, ylim = c(0,20))

bancos_out <- dbGetQuery(conn = conM, statement = "select * from bancos_reciben_trf;") # Bancos que reciben dinero del circuito
bancos_in <- dbGetQuery(conn = conM, statement = "select * from bancos_ingresan_trf;") # Bancos que ingresan dinero al circuito

grafo_bancos <- dbGetQuery(conn = conM, statement = "select * from grafo_entidades;") # Bancos que ingresan dinero al circuito
gb <- graph_from_data_frame(grafo_bancos, directed = TRUE, vertices = NULL) # Creamos un objeto graph dirigido de las entidades

V(gb)$color <- seq(1,62) +1

set.edge.attribute(gb, "weight", index=E(gb), get.edge.attribute(gb, "importe_e1_e2", index=E(gb)))

tkplot(gb, layout=layout.kamada.kawai) # Grafo de las relaciones de los Bancos

subGrafo <- function(nCom = 1) {
  # Trabajo por comunidades
  x <- "select g.* from uso_local.grafo_ordenado g join uso_local.metricas m0 on g.id_cuenta_1 = m0.nodo join uso_local.metricas m1 on g.id_cuenta_2 = m1.nodo where m0.comunidad = m1.comunidad and m0.comunidad = "
  x <- paste0(x, toString(nCom), ";", sep = "")
  tc <- dbGetQuery(conn = conM, statement = x)
  tc <- tc[,c(1,4,2,3,5,6,7,8,9,10,11,12)] # reordeno las columnas
  gc <- graph_from_data_frame(tc, directed = TRUE, vertices = NULL)
  return(gc)
}

plot(gc)
tkplot(subGrafo(25))
