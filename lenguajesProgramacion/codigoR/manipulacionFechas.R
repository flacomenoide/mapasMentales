# Manipulación de Fechas
# ======================

# Obtiene la fecha actual en formato texto
f1 = date()
# Obtiene la fecha actual en formato date
f2 = Sys.Date()
# Formatea una fecha
format(f2, "%a %A %b %m %B %d %y %Y")

# Crear fechas a partir de string
fs <- c("1ene1960","2ene1960","31mar1960","30jul1960")
# Transforma strings en dates
fz <- as.Date(fs, "%d%b%Y")
# Calcula la diferencia entre fechas
fz[2] - fz[1]
# Obtiene la diferencia entre fechas en valores numéricos
as.numeric(fz[2] - fz[1])
# Obtiene el día de la semana de una fecha
weekdays(f2)
# Obtiene el mes del año de una fecha
months(f2)
# Obtiene la fecha en días a partir del origen juliano (1-1-1970)
julian(f2)

# Manipulación de fechas con lubridate
library(lubridate)
# Transforma un string a date de acuerdo al orden de los elementos
ymd("19780805")
mdy("08/05/78")
dmy("05-08-1978")
ymd_hms("1992-02-04 07:42:00")
Sys.timezone()              # Obtiene el timezone local
ymd_hms("1992-02-04 07:42:00", tz=Sys.timezone())
# Obtiene el día de la semana
wday(fz[1])
wday(fz[1], label = T)
