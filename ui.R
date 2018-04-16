library(shiny)
library(PogromcyDanych)

nazwySeriali <- sort(levels(serialeIMDB$serial))


shinyUI(fluidPage(
  titlePanel("Tytuł"),
  headerPanel("Nagłówek"),
  sidebarLayout(
    sidebarPanel(
      p("Lewy panel boczny"),
      selectInput(inputId = "wybranySerial",
                  label = "Wybierz serial do analizy",
                  choices = nazwySeriali,
                  selected = "Friends"),
      checkboxInput(inputId = "liniaTrendu",
                    label = "Czy zaznaczyć linię trendu",
                    value = TRUE)
    ),
    mainPanel(
      br(),                 # równa poziom napisu
      p("Panel główny"),
      uiOutput("przykład"),
      plotOutput("trend"),
      verbatimTextOutput("model")
    )
  )
))