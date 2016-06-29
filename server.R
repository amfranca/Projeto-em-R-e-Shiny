library(shiny)
load(file = 'tabela.diaria.Rda')

# Define server logic required to summarize and view the 
# selected dataset
shinyServer(function(input, output) {
  
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  
  # Generate a summary of the dataset
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  
      
    
  })
  
  # Show the first "n" observations
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
  })


#https://github.com/rstudio/shiny-examples/blob/master/051-movie-explorer/ui.R
#https://github.com/rstudio/shiny-examples/blob/master/051-movie-explorer/server.R
#http://shiny.rstudio.com/gallery/widgets.html
#http://shiny.rstudio.com/gallery/basic-datatable.html


