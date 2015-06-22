
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(data.table)

source('data.R')
seg <- load_data()

shinyServer(function(input, output) {
    output$distPlot <- renderPlot({
        # Set inicial data range
        dt_begin <- reactive({format(input$timeframe[1],"%Y%m")})
        dt_end   <- reactive({format(input$timeframe[2],"%Y%m")})
        
        #data <- seguros[seguros$damesano >= dt_begin & seguros$damesano <= dt_end, ]
        
        # Grouped Bar Plot
        #counts <- table(mtcars$vs, mtcars$gear)
        #barplot(counts, xlab="Companies", col=c("darkblue","red"),
        #        legend = rownames(counts), beside=TRUE)
        
        # Recalculate
        seg <- prepare_data(seg)
        tidy <- totidy(seg)
        
        # Graph
        ggplot(aes(x = name,  y = value, group = type, fill = type), data = tidy) +
            geom_bar(stat = 'identity', position = 'dodge') +
            theme(axis.text.x = element_text(angle = 90, vjust = 0.5)) +
            scale_fill_manual('Index', values = c('claims'='red',
                                                  'premiums' = 'blue',
                                                  'commissions' = 'green' )) +
            labs(list(x = ('Companies'), y = 'R$'))
        
        #     # Simple Pie Chart
        #     slices <- c(10, 12,4, 16, 8)
        #     lbls <- c("US", "UK", "Australia", "Germany", "France")
        #     pie(slices, labels = lbls, main="Pie Chart of Countries")
        
    })
    
    output$timeframe <- renderPrint({ input$timeframe })
    output$businessline <- renderPrint({ input$businessline })
    output$size <- renderPrint({ input$size })
    
})
