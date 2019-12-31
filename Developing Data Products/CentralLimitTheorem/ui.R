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
                        p("In probability theory, the central limit theorem establishes that, 
                              in some situations, when independent random variables are added, their
                              properly normalized sum tends toward a normal distribution even if the
                              original variables themselves are not normally distributed."),
                        br(), 
                        h3("Proof"),
                        p("This app creates a sample using the user input to prove 
                              Central Limit Theorem experimentally. To do so, we perform following 
                              steps: "),
                        br(),
                        tags$ol(
                            tags$li("Define sample range using the first slider."),
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
                                    sliderInput("range", "Range: ", min = 1, max = 100, 
                                                value = c(25,50)),
                                    sliderInput("sample_size", "Sample Size: ", min = 5, max = 100,
                                                value = 5, step = 5),
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
                                    p(strong("Mean of Range: "), textOutput("range_mean", inline = TRUE)),
                                    p(strong("Mean of Sample: "), textOutput("sample_mean", inline = TRUE)),
                                    p(strong("Median of Sample: "), textOutput("sample_median", inline = TRUE)),
                                    p(strong("Standard Deviation: "), textOutput("sample_sd", inline = TRUE))
                                )
                            )
                        )
               )
    )
)
