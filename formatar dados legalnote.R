library(shiny)


Tabela.Diario <- read.csv("Legal Note.csv", 
                          sep = ";", 
                          dec = ",", 
                          header = T)

#Criar uma nova coluna com os dados dos intimados, tirar espaços excedentes e desacentuar.
Tabela.Diario <- transform(Tabela.Diario, 
                           ADVOGADOS = gsub(") ", "), ", gsub("'|\\'", "",iconv(trimws(sub(".*?Intimados(.*?))*", "\\1", Tabela.Diario$RECORTE),"both"),
                                                                                to="ASCII//TRANSLIT"))))

Tabela.Diario$PUBDATA <- as.Date(Tabela.Diario$PUBDATA, "%m/%d/%y")
Tabela.Diario$CREATEDATA <- as.Date(Tabela.Diario$CREATEDATA, "%m/%d/%y")


#Capturar lista com dos advogados e separar Nome, número e estado da OAB
Lista.Intimados <- data.frame(unique(trimws(matrix(unlist(strsplit(as.character(Tabela.Diario$ADVOGADOS), ",")), 
                                                   ncol = 1, 
                                                   byrow = TRUE),
                                            'both')))
names(Lista.Intimados) <- c("NOMEADVOGADO")
Lista.Intimados <- transform(Lista.Intimados,
                             NOMEADV = trimws(gsub("\\(.*?\\)", "" , Lista.Intimados$NOMEADVOGADO), 'both'),
                             NUMOAB = trimws(gsub("[- .)/(+]|[a-zA-Z]*:?", "", Lista.Intimados$NOMEADVOGADO), 'both'),
                             ESTADOOAB = trimws(gsub(".*?OAB|[0-9])*?|/.)|/|)", "" , Lista.Intimados$NOMEADVOGADO), 'both'))

