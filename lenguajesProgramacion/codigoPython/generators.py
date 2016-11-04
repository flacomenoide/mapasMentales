# Uso de Generators
# creacion de una funcion que obtenga los numeros pares

# Generator Function
# ==================
def generator_numeros_pares(n):
    for i in range(n):
        if i % 2 == 0:
            yield i

# La invocacion de una funcion generator da como resultado un generator object
print generator_numeros_pares(6)
print list(generator_numeros_pares(9))


# Generator Expression
# ====================
(i for i in range(1,9))
list(i for i in range(1,9))

pares = (n for n in range(10) if n%2==0)
print pares
print list(pares)