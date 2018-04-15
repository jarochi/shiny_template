library(shiny)

shinyUI(fluidPage(
  titlePanel("Tytuł"),
  headerPanel("Nagłówek"),
  sidebarLayout(
    sidebarPanel(
      p("Lewy panel boczny")    
    ),
    mainPanel(
      br(),                 # równa poziom napisu
      p("Panel główny"),
      uiOutput(zdefiniowana_zmienna)
    )
  )
))