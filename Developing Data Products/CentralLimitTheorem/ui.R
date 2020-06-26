#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(
    navbarPage("Central Limit Theorem",
               tabPanel("Explanation",
                        # Definition
                        h3("Definition"),
                        p("Central Limit Theorem (CLT) states that the distribution of
                          sample mean approximates to normal distribution as the 
                          sample size gets larger, regardless of the population distribution."),
                        br(),
                        p("In other words, given a sufficiently large sample size 
                          from a population, the mean of all the samples from the 
                          same population will be approximately equal to the mean of 
                          the population. These samples, if plotted on a histogram 
                          will follow an approximate normal distribution pattern. 
                          This trend is usually noticeable when the sample size 
                          is equal to or greater than 30."),
                        br(),
                        p("For the random samples we take from the population, 
                          we can compute the mean of the sample means:"),
                        br(),
                        withMathJax(),
                        p("\\( \\bar{x} \\) = \\( \\mu \\)"),
                        tags$ul(
                             tags$li("\\( \\bar{x} \\): Mean of the sample distribution"), 
                             tags$li("\\( \\mu \\): Population mean"), 
                        ),
                        p("and the standard deviation of the sample means:"),
                        p("s = \\( \\frac{\\sigma}{\\sqrt{n}} \\)"),
                        tags$ul(
                             tags$li("s: Standard deviation of the sample distribution"), 
                             tags$li("\\( \\sigma \\): Population standard deviation"),
                             tags$li("n: Sample size"),
                        ),
                        br(),
                        h3("Proof"),
                        p("This app creates a sample using the user input to prove 
                              Central Limit Theorem experimentally. To do so, we perform following 
                              steps in the next tab: "),
                        br(),
                        tags$ol(
                            tags$li("Define sample range using the first slider.
                                    As the probability of getting any number within the range is 
                                    equal, we can conclude that the population follows 
                                    a uniform distribution."),
                            tags$li("Select sample size using the second slider."),
                            tags$li("Select number of samples to create the data set of averages
                                         of each sample. This sample will be used to plot the histogram 
                                        and the density chart. This can be done using the radio buttons."),
                            tags$li("Click 'Submit' to get the output using above mentioned 
                                        parameters.")
                        )
               ),
               tabPanel("Simulation",
                        fluidPage(
                            sidebarLayout(
                                sidebarPanel(
                                    sliderInput("range", "Population: ", min = 1, max = 100, 
                                                value = c(25,50)),
                                    sliderInput("sample_size", "Sample Size: ", min = 2, max = 100,
                                                value = 5, step = 2),
                                    radioButtons("num_sample",
                                                 "Number of Samples:",
                                                 c("50" = 50, "100" = 100, "200" = 200, "400" = 400,
                                                   "800" = 800, "1,600" = 1600, "3200" = 3200),
                                                 selected = "50"),
                                    submitButton("Submit")
                                ),
                                mainPanel(
                                    h4("Adjusting the parameters, we can confirm CLT using the
                                            histogram."),
                                    br(),
                                    htmlOutput("Clt_Hist"),
                                    br(),
                                    p(strong("Mean of Population: "), textOutput("range_mean", inline = TRUE)),
                                    p(strong("Mean of Sample: "), textOutput("sample_mean", inline = TRUE)),
                                    p(strong("Standard Deviation of Population: "), textOutput("population_sd", inline = TRUE)),
                                    p(strong("Standard Deviation of Sample: "), textOutput("sample_sd", inline = TRUE))
                                )
                            )
                        )
               )
    )
)
