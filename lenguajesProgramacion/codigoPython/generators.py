# Uso de Generators
# creacion de una funcion que obtenga los numeros pares

def generator_numeros_pares(n):
    for i in range(n):
        if i % 2 == 0:
            yield i

# La invocacion de una funcion generator da como resultado un generator object
print generator_numeros_pares(6)
print list(generator_numeros_pares(6))
