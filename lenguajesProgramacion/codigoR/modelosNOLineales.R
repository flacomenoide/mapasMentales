# Modelos no lineales
# transformación simple
mod <- lm(log(price) ~ log(carat), data = diamonds)
summary(mod)

# polinómios
qplot(age, earn, data = wages) + geom_smooth() + coord_cartesian(ylim = c(0, 75000))
mod <- lm(earn ~ poly(age, 3), data = wages)
summary(mod)
qplot(age, earn, data = wages) + geom_smooth(method = lm, formula = y ~ poly(x, 3)) + coord_cartesian(ylim = c(0, 75000))

mod1 <- lm(earn ~ age, data = wages)
mod2 <- lm(earn ~ poly(age,2), data = wages)
mod3 <- lm(earn ~ poly(age,3), data = wages)
anova(mod1, mod2, mod3)

# splines
library(splines)
mod <- lm(earn ~ ns(age, knots = c(40, 60)), data = wages) # con knots en 40 y 60
mod <- lm(earn ~ ns(age, df = 4), data = wages) # con 4 grados de libertad con natural spline
mod <- lm(earn ~ ns(age, df = 6), data = wages) # con 4 grados de libertad con natural spline
mod <- lm(earn ~ bs(age, df = 4), data = wages) # con 4 grados de libertad con linear spline
summary(mod)
qplot(age, earn, data = wages) +
  geom_smooth(method = lm, formula = y ~ bs(x, df = 4)) +
  coord_cartesian(ylim = c(0, 50000))

library(mgcv)
gmod <- gam(earn ~ s(height), data = wages) # modelo general aditivo + s() función smooth
summary(gmod)
qplot(age, earn, data = wages) +
  geom_smooth(method = gam, formula = y ~ s(x)) +
  coord_cartesian(ylim = c(0, 50000))