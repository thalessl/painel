library(readstata13) # opening data
library(plm) # panel models package

base <- read.dta13("C:/Users/Thalles/Downloads/rais_mg_20002014_estabpainelbalanceado.dta")
base <- as.data.frame(base)

# Showing R the time and individual index. The order counts!
base <- pdata.frame(base, index = c("cnpjcei", "ano"))

# Equivalent to Stata xtab 

library(gmodels)

CrossTable(base$ano, base$tamanhoestabelecimento)

# creating year dummies

## Transforming into factor levels
library(purrrlyr)
ano <- base[,c(23)]
ano <- as.data.frame(ano)
options(na.action='na.pass')
ano <- dmap(ano, as.factor)

## Dummies
options(na.action='na.pass')
ano <- model.matrix(~ ano
                       + 0, data = ano)

ano <- as.data.frame(ano)

base <- cbind(base, ano)
