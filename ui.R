library(shiny)
library(DT)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  # Application title.
  titlePanel("Teste Legal Note"),
  
  sidebarLayout(
    sidebarPanel(
#       
#       dateRangeInput('dateRange',
#                      label = 'Data: ',
#                      start = Sys.Date() - 2, end = Sys.Date() + 2
#       ),
      
      selectInput("dataset", 
                  "CADERNO", 
                  c("TODOS", unique(as.character(Tabela.Diario$CADERNO)))),
      
      
      selectInput("obs", 
                  "DIARIO", 
                  c("TODOS", unique(as.character(Tabela.Diario$DIARIO)))),
      
      selectInput("adv",
                  "ADVOGADO",
                  c("TODOS", unique(as.character(Lista.Intimados$NOMEADV)))),
      
      
      helpText("Note: Para atualizar os dados da tabela",
               "clique em atualizar."
               ),
      
      submitButton("Atualizar Dados")
      
    ),
    
    # Show a summary of the dataset and an HTML table with the
    # requested number of observations. Note the use of the h4
    # function to provide an additional header above each output
    # section.
    
    fluidPage(
           
      wellPanel(
        
        span("Numero de Recortes: ",
           textOutput("n_data"))
      ),
           DT::dataTableOutput("table")
    
    )
)))