# Ejecutar código con conexión a Internet
install.packages("devtools") # Paquete de desarrollo para R

# Iniciando búsquedas de texto rOpenSci
# URL: https://ropensci.org/
# Instalar la librería full text
devtools::install_github(c("ropensci/rplos", "ropensci/bmc", "ropensci/aRxiv", "emhart/biorxiv"))
devtools::install_github("ropensci/fulltext")

library("fulltext")
library(rplos)

DOI <- ft_search(query="ebola")
DOI

str(DOI)

article <- DOI$plos[[2]][[1]][4]    #Fetch the DOI from the 4th PLOS article
# "10.1371/journal.pntd.0003706"

URL <- full_text_urls(doi=article)  #Fetch the full URL
URL

text <- plos_fulltext(doi=article)  #Fetch the XML text
text[[1]]