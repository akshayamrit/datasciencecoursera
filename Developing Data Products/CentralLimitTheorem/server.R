#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(googleVis)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    mean_pop <- reactive({
        range_min <- input$range[1]
        range_max <- input$range[2]
        averages <- range_min:range_max
        set.seed(666)
        for (i in 1:input$num_sample) {
            averages[i] <- mean(sample(range_min:range_max, input$sample_size, replace = TRUE))
        }
        averages <- data.frame(averages)
        return(averages)
    })

    output$range_mean <- reactive({round(mean(input$range[1]:input$range[2]), 2)})
    output$sample_mean <- reactive({round(mean(mean_pop()[,1]), 2)})
    output$population_sd <- reactive({round(sd(input$range[1]:input$range[2]), 2)})
    output$sample_sd <- reactive({round(sd(mean_pop()[,1]), 2)})
    
    output$Clt_Hist <- renderGvis({
        Clt_Hist <- gvisHistogram(mean_pop(), options = list(
            legend = "{position: 'none'}", title = "Distribution of Means",
            subtitle = "Samples are randomly drawn according to the parameters",
            histogram = "{ hideBucketItems: true, bucketSize: 1 }",
            hAxis = "{ title: 'Mean of Sample', maxAlternation: 1, showTextEvery: 1}",
            vAxis = "{ title: 'Frequency'}"
        ))
        return(Clt_Hist)
    })
})
