
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)

shinyUI(fluidPage(
    
    # Application title
    titlePanel("Mercado Segurador Brasileiro"),
    
    # Sidebar with a slider input for number of bins
    plotOutput("distPlot"),
          
    hr(),
          
    fluidRow(
        column(4,
            sliderInput("bins",
            "Number of bins:",
            min = 1,
            max = 50,
            value = 30)
        ),
        column(4,
               checkboxInput('VIDA', 'Vida e Previdencia'),
               checkboxInput('AUTO', 'Automóvel')
        ),
        column(4,
               radioButtons(
                   "title",
                   "Titulo do Gráfico",
                   c("Vida e Previdência", "Saúde", "Ramos Elementares")
               )
        )
        
    )
))