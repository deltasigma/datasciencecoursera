
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Brazilian Insurance Market Performance"),

  # Show tabs with aplication data
  tabsetPanel(
      tabPanel("Performance", plotOutput("distPlot")),
      #tabPanel("Analysis", verbatimTextOutput("summary")),
      #tabPanel("Data", tableOutput("table")),
      tabPanel("DEBUG", 
               verbatimTextOutput("timeframe"),
               verbatimTextOutput("businessline"),
               verbatimTextOutput("size")
               )
  ),
  
  hr(),
  
  # Configuration
  fluidRow(
      column(4,
             checkboxGroupInput("businessline", 
                                label = h4("Business Line"), 
                                choices = list("P&C" = 1, 
                                               "Life & Pension" = 2, 
                                               "Health" = 3),
                                selected = c(1,2,3))
             ),
      column(4,
             dateRangeInput("timeframe", 
                            label = h4("Timeframe"),
                            start = Sys.Date() - 365, end = Sys.Date(),
                            min = Sys.Date() - (5*365), max = Sys.Date(),
                            separator = " - ", format = "dd/mm/yyyy",
                            startview = 'year', language = 'pt-BR', weekstart = 1
                            )
             ),
      column(4,
             checkboxGroupInput("size", 
                                label = h4("Company Size"), 
                                choices = list("Big" = 1, 
                                               "Average" = 2,
                                               "Small" = 3),
                                selected = c(1,2,3))
             )
      )
  
#   hr(),
#   
#   # Configuration
#   fluidRow(
#       column(4,
#              h4("Business Line")
#       ),
#       column(4,
#              h4("Timeframe")
#       ),
#       column(4,
#              h4("Companies")
#       )
#   )
  
  
))
