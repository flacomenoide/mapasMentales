# -*- coding: utf-8 -*-
"""
Recorrer elementos de un directorio

"""

"""
Recorre un todos los archivos de un directorio e imprime sus archivos
"""
def imprime_archivos(directorio):
    for directorio, subDirectorios, archivos in os.walk(directorio):
        for archivo in archivos:
            print(archivo)


"""
Recorre un todos los archivos de un directorio e imprime sus archivos con el
patrón *.vym
"""
def imprime_archivos_con_patron(directorio):    
    for directorio, subDirectorios, archivos in os.walk(directorio):
        for archivo in archivos:
            if re.search("(.+)\.(vym)$", archivo):
                print(archivo)


import os, re

aFolder = "/un/directorio"
imprime_archivos(aFolder)
imprime_archivos_con_patron(aFolder)
