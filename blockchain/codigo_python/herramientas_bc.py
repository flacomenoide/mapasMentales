#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 18 22:39:52 2017

@author: flacomenoide
"""
import struct

def uint1(stream):
    return ord(stream.read(1))