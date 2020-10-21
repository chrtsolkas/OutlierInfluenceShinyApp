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
shinyUI(fluidPage(
    # Application title
    titlePanel("Outlier influence on a simple linear model"),
    
    fluidRow(
        column(
            width = 8, 
            plotOutput('scatterPlot', height = 400)
        ),
        column(
            width = 4,
            plotOutput('residPlot', height = 400),
        )
    ),
    
    hr(),
    
    wellPanel(fluidRow(
        column(
            width = 12,
            align = "center",
            h3("Control the position of the outlier point"),
            column(width = 5, 
                   sliderInput("outlier.x",
                               "x value:",
                               min = -3,
                               max = 10,
                               value = 0)),
            column(width = 5, 
                   offset = 2, 
                   sliderInput("outlier.y",
                               "y value:",
                               min = -3,
                               max = 10,
                               value = 0)
                   )
            
        )
    )),

    fluidRow(
        column(12,
               h3("Influence measures for the outlier point:")
        )
    ),
    fluidRow(
        column(12,
               tableOutput("OutlierMeasures")
        )
    ),
    
    fluidRow(
        column(12,
               h3("Does it have influence based on that measure?")
        )
    ),
    fluidRow(
        column(12,
               tableOutput("is.infl")
        )
    ),
    
    fluidRow(
        column(12,
               h3("Influence measures for some normal points (do you spot any differences from the outlier measures?):")
        )
    ),
    fluidRow(
        column(12,
               tableOutput("InfluenceMeasures")
        )
    )
    
    
))
