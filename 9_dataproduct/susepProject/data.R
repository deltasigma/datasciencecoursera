# Aux functions
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

# Load and tidy data
load_data <- function() {
    dir <- "data"
    
    # Loading market data
    # Carregando Companhias
    cias <- read.csv(paste(dir,"Ses_cias.csv.gz", sep = "/"), sep=";",
                     encoding="latin1")
    
    # Carregando Grupos Economicos
    grupos <- read.csv(paste(dir,"Ses_grupos_economicos.csv.gz", sep = "/"),
                       quote = "", sep=";", encoding="latin1")
    
    # Carregando Movimentação do Mercado...
    seguros.dt <- read.csv(paste(dir,"Ses_seguros2015.csv.gz", sep = "/"), sep=";", 
                        dec=",")
    
    # Trazer Grupos e Cias para o Dataframe seguros
    seguros.dt <- merge(seguros.dt, grupos, by=c('damesano','coenti'), all.x = TRUE)
    
    # Filtrando campos interessantes
    drops <- c('row.names', 'premio_direto', 'premio_de_seguros', 'premio_retido',
               'sinistro_direto', 'premio_emitido2', 'premio_emitido_cap',
               'despesa_resseguros', 'sinistro_ocorrido', 'receita_resseguro',
               'sinistros_ocorridos_cap', 'recuperacao_sinistros_ocorridos_cap',
               'rvne', 'conveniodpvat', 'consorciosefundos', 'cogrupo.y')
    seguros.dt <- seguros.dt[,!(names(seguros.dt) %in% drops)]
    
    return(seguros.dt)
}

prepare_data <- function(seguros) {
    # Pick only this year
    #data <- seguros[seguros$damesano >= "201501", ]
    
    # Process data
    library(data.table)
    dt.seguros <- data.table(seguros)
    seg <- dt.seguros[,list(premiums=sum(premio_ganho), claims=sum(sinistro_retido),
                            commissions=sum(desp_com),name=unique(nogrupo)), 
                      by='cogrupo.x'][order(-premiums)]
    
    # Classify Size
    average <- mean(seg[seg$cogrupo.x != 99999 & seg$cogrupo.x != 1225,]$premiums)
    
    s <- seg[seg$premiums <= average / 4, ]
    m <- seg[seg$premiums > average / 4 & seg$premiums <= 2 * average, ]
    b <- seg[seg$premiums > 2 * average, ]
    
    seg$size <- ifelse(seg$cogrupo.x %in% s$cogrupo.x, 'small','medium')
    seg$size <- ifelse(seg$cogrupo.x %in% b$cogrupo.x, 'big', seg$size)
    
    # Classify TOP
    ranking_size = 10
    top <- head(seg, ranking_size-1)
    seg$ranking <- ifelse(seg$cogrupo.x %in% top$cogrupo.x, 'Y','N')
    other <- data.frame(-1,
                        sum(seg[seg$ranking == 'N',]$premiums),
                        sum(seg[seg$ranking == 'N',]$claims),
                        sum(seg[seg$ranking == 'N',]$commissions),
                        'OTHERS',
                        NA,
                        'Y')
    names(other) <- names(seg)
    return(data.frame(rbind(seg[seg$ranking == 'Y', ],other)))
}

# Convert 3 columns to 1 column with classification
totidy <- function(df.seg) {
    tidy <- data.frame()
    
    for (i in 1:nrow(df.seg)) {
        row_name <- trim(df.seg[i, c("name")])
        row_prem <- df.seg[i, c("premiums")]
        row_clai <- df.seg[i, c("claims")]
        row_comm <- df.seg[i, c("commissions")]
        
        tidy <- rbind(tidy,data.frame(name = row_name, value = row_prem,
                                      type = "premiums"))
        tidy <- rbind(tidy,data.frame(name = row_name, value = row_clai,
                                      type = "claims"))
        tidy <- rbind(tidy,data.frame(name = row_name, value = row_comm,
                                      type = "commissions"))
        # do more things with the data frame...
    }
    
    return(tidy)
}