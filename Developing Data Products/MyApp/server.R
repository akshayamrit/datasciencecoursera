#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
require(googleVis)
# begin shiny server
shinyServer(function(input, output) {
      # define reactive parameters
      pop<- reactive({sample(1:20, input$population, replace = TRUE)})
      bootstrapSample<-reactive({sample(pop(),input$sampleSize*input$numSample,
                                        replace = TRUE)})
      output$popVar<- reactive({round(var(pop()),2)})
      # print text through reactive funtion
      output$biaVar <- renderText({
            sample<- as.data.frame(matrix(bootstrapSample(), nrow = input$numSample,
                                          ncol =input$sampleSize))
            return(round(mean(rowSums((sample-rowMeans(sample))^2)/input$sampleSize), 2))
      })
      # google visualization histogram
      output$popHist <- renderGvis({
            popHist <- gvisHistogram(data.frame(pop()), options = list(
                  height = "300px",
                  legend = "{position: 'none'}", title = "Population Distribution",
                  subtitle = "samples randomly drawn (with replacement) from values 1 to 20",
                  histogram = "{ hideBucketItems: true, bucketSize: 2 }",
                  hAxis = "{ title: 'Values', maxAlternation: 1, showTextEvery: 1}",
                  vAxis = "{ title: 'Frequency'}"
            ))
            return(popHist)
      })
})
