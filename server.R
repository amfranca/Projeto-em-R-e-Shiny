library(shiny)
library(dplyr)
library(ggvis)

#carregar tabela
load('tabela.diaria.Rda')
load('Lista.Intimados.Rda')


shinyServer(function(input, output) {

  output$table <- DT::renderDataTable(DT::datatable(({
        data <- Tabela.Diario

        if(input$dataset != "TODOS"){
          data <- data[data$CADERNO == input$dataset,]
        }
        if(input$obs != "TODOS"){
          data <- data[data$DIARIO == input$obs,]
        }
        if(input$adv != "TODOS"){
         data <- filter(data, grepl(input$adv, ADVOGADOS))
        }
        data
      })))
  
  
  output$n_data <- renderText({ nrow(table) })
  
  })
  