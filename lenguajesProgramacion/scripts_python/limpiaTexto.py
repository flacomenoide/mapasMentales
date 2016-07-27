#!/usr/bin/python
# -*- coding: utf-8 -*-
import os
import unicodedata
import re
import argparse
import sys

__author__ = 'Miguel Jínez'

def justPrintableChars(inputLine):
    outputLine = ""
    for x1 in inputLine:
        if not(31 < ord(x1) < 127):
            x1 = " "
        outputLine += x1
    return outputLine

def __main__():
    if len(sys.argv) <> 3:
        print "El script necesita 2 argumentos, archivo de entrada y archivo de salida"
        print "Ejemplo:"
        print "limpiaTexto.py archivoInput archivoOutput"
        sys.exit("Error de sintaxis")
    else:
        print "Bienvenidos"
        scriptName = sys.argv[0]
        inputFile = sys.argv[1]
        inputFile = inputFile.decode('utf-8')
        outputFile = sys.argv[2]
        outputFile = outputFile.decode('utf-8')
        print "Script : " + scriptName
        print "Archivo de Entrada : " + inputFile
        archI = open(inputFile, "rb")
        print "Archivo de Salida : " + outputFile
        archO = open(outputFile, "wb")
        print "Se inicia la escritura en el archivo de salida"
        for lin in archI:
            archO.write(justPrintableChars(lin)+"\n")
        archI.close()
        archO.close()

if __name__ == __main__():
    main()