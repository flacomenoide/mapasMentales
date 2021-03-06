# Uso de Generators
# creacion de una funcion que obtenga los numeros pares

# Generator Function
# ==================
# Genera un listado de numeros pares 
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

# Uso de los GENERATORS objects
# =============================
par = generator_numeros_pares(10)
print par.next()
print par.next()

for i in par:
    print i

# Generator Function: Fibonacci sin limite
def fibonacci():
    ant, post = 0, 1
    while True:
        yield post
        ant, post = post, post + ant

f = fibonacci()
print "Fibonacci: ", f.next()
print "Fibonacci: ", f.next()
print "Fibonacci: ", f.next()

for i in range(8):
    print "Fibonacci: ", f.next()

# Uso de pipes
# Encontrar el nombre mas largo
nombres = (nom.strip() for nom in open("names.txt"))
longitud = ((nombre, len(nombre)) for nombre in nombres)
mayor = max(longitud, key=lambda x:x[1])
print mayor

# Coroutine que imprime un numero enviado en el send
def ejemplo_coroutine():
    while True:
        x = yield
        print x

c = ejemplo_coroutine()
c.next()
c.send(12)
c.close()

# Coroutine 
def contador(string):
    count = 0
    try:
        while True:
            item = yield
            if isinstance(item,str):
                if item in string:
                    count += 1
                    print item
                else:
                    print "No Match"
            else:
                print "No string"
    except GeneratorExit:
        print count

c1 = contador("Buenos Aires")
c1.next()
c1.send("Aire")
c1.send("Buen")
c1.send("Quito")
c1.send(100.2)
c1.close()