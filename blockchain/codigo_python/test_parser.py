#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Apr 19 22:13:06 2017

@author: flacomenoide
"""

from herramientas_bc import *

with open('1M.dat', 'rb') as arch_bc:
    print("Número Mágico:\t %8x" % uint4(arch_bc))
    print("Tamaño del bloque:\t %u" % uint4(arch_bc))