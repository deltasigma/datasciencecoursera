# Load and tidy data
```{r, echo=FALSE}
# WD
dir <- "data"

# Loading market data
# Carregando Companhias
cias <- read.csv(paste(dir,"Ses_cias.csv", sep = "/"), sep=";")

# Carregando Grupos Economicos
grupos <- read.csv(paste(dir,"Ses_grupos_economicos.csv", sep = "/"),
                   quote = "", sep=";", encoding="UTF-8")

# Carregando Movimentação do Mercado...
seguros <- read.csv(paste(dir,"Ses_seguros.csv", sep = "/"), sep=";", dec=",")
