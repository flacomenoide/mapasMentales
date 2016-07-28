#!/usr/bin/python
# -*- coding: utf-8 -*-
import os
import unicodedata
import re
import argparse
import sys

__author__ = 'Miguel Jínez'

def justAlphNumChars(inputLine):
    r1 = range(ord('a'),ord('z')+1)
    r2 = range(ord('A'),ord('Z')+1)
    r3 = range(ord('0'),ord('9')+1)
    r = r1 + r2 + r3
    outputLine = ""
    for x1 in inputLine:
        if ord(x1) not in r:
            x1 = " "
        outputLine += x1
    return outputLine

def justPrintableChars(inputLine):
    outputLine = ""
    for x1 in inputLine:
        if not(31 < ord(x1) < 127):
            x1 = " "
        outputLine += x1
    return outputLine

def __main__():
    if len(sys.argv) <> 4:
        print "El script necesita 3 argumentos, archivo de entrada, archivo de salida y método a aplicar"
        print "Métodos a aplicar disponibles:"
        print "\t0- Deja solo caracteres alpha numéricos (a-z, A-Z, 0-9)"
        print "\t1- Elimina caracteres no imprimibles"
        print "Ejemplo:"
        print "limpiaTexto.py archivoInput archivoOutput 0"
        sys.exit("Error de sintaxis")
    else:
        print "Bienvenidos"
        scriptName = sys.argv[0]
        inputFile = sys.argv[1]
        inputFile = inputFile.decode('utf-8')
        outputFile = sys.argv[2]
        outputFile = outputFile.decode('utf-8')
        depOption = int(sys.argv[3])
        if depOption == 0:
            functionExecution = justAlphNumChars
        elif depOption == 1:
            functionExecution = justPrintableChars
        print "Script : " + scriptName
        print "Archivo de Entrada : " + inputFile
        archI = open(inputFile, "rb")
        print "Archivo de Salida : " + outputFile
        archO = open(outputFile, "wb")
        print "Se inicia la escritura en el archivo de salida"
        for lin in archI:
            archO.write(functionExecution(lin)+"\n")
        archI.close()
        archO.close()

if __name__ == __main__():
    main()