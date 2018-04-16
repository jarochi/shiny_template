library(PogromcyDanych)
library(ggplot2)
library(dplyr)

przykład <- data.frame(serialeIMDB$serial)

shinyServer(function(input, output){
  
  output$trend <- renderPlot({
    wybranySerial <- input$wybranySerial
    serial <- filter(serialeIMDB, serial == wybranySerial)
    pl <- ggplot(serial, aes(id, ocena, size=glosow, color=sezon)) +
      geom_point() + xlab("Numer odcinka")
    if(input$liniaTrendu)
      pl <- pl + geom_smooth(se=FALSE, method="lm", size=3)
    pl
    })
  
  output$model <- renderPrint({
    wybranySerial <- input$wybranySerial
    serial <- filter(serialeIMDB, serial == wybranySerial)
    summary(lm(ocena~id, serial))
    
  })
  
  output$Super_wykres <- renderPlot({
    wybranySerial <- input$wybranySerial
    serial <- filter(serialeIMDB, serial == wybranySerial)
    pl <- ggplot(serial, aes(id, ocena, size=glosow, color=sezon)) +
      geom_point() + xlab("Numer odcinka")
    if(input$liniaTrendu)
      pl <- pl + geom_smooth(se=FALSE, method="lm", size=3)
    pl
  })
  
  
  raw_input <- reactive({
    
    if (!is.null(input[["input_z_danymi"]]))
      input_curves <- serialeIMDB
    input[["use_example"]]
    isolate({
      if (!is.null(input[["use_example"]]))
        if(input[["use_example"]] > 0)
          input_curves <- serialeIMDB
    })
    
    if(exists("input_curves")) {
      input_curves
    } else {
      NULL
    }
  })
  
  output$przykład <-renderUI({
    
    if(is.null(raw_input())) {
      tabsetPanel(
        tabPanel(title = "Data input",
                 fluidRow(
                   column(width = 5, 
                          fileInput('input_z_danymi', "Submit amplification data (.rdml, .csv or .xls file):")
                   ),
                   column(width = 5,
                          p("Test application with the example amplification data"),
                          actionButton("use_example", "Load example")
                   ),
                   tags$style(type='text/css', "#use_example { width:100%; margin-top: -5px;}")
                 )
        )
      )
    } else {
      tabsetPanel(
        tabPanel(title = "Super_wynik",
                 plotOutput("Super_wykres"))
      )
    }
  })
})