#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(ggfortify)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$scatterPlot <- renderPlot({
        npoints <- 100
        set.seed(100)
        x <- runif(npoints, min = -2, max = 2)
        y <- x + rnorm(npoints, mean = 0, sd = 0.3)
        df <- data.frame( x = c(x, input$outlier.x),
                          y = c(y, input$outlier.y),
                          Point = c(rep("Normal point", npoints), "Outlier point")
        )
        g1 <- ggplot(df, aes(x, y, col = Point)) +
            geom_point(size = 4, alpha = .4) +
            expand_limits(x = c(-4, 11), y = c(-4, 11)) +
            geom_smooth(method = "lm", se = FALSE, col = "deeppink") +
            theme_light() +
            theme(legend.position="bottom", legend.title = element_blank())
       g1
    })
    
    output$residPlot <- renderPlot({
        npoints <- 100
        set.seed(100)
        x <- runif(npoints, min = -2, max = 2)
        y <- x + rnorm(npoints, mean = 0, sd = 0.3)
        df <- data.frame( x = c(x, input$outlier.x),
                          y = c(y, input$outlier.y),
                          Point = c(rep("Normal point", npoints), "Outlier point")
        )
        fit <- lm(y ~ x, df)
        ggplot(fortify(fit), aes(x = .fitted, y = .resid)) + 
            geom_point() +
            labs(x = "Fitted values", y = "Residuals", title = "Residual vs Fitted Plot") +
            geom_hline(aes(yintercept=0), colour="#990000", linetype="dashed") +
            theme_light()
    })
    
    output$InfluenceMeasures <- renderTable({
        npoints <- 100
        set.seed(100)
        x <- runif(npoints, min = -2, max = 2)
        y <- x + rnorm(npoints, mean = 0, sd = 0.3)
        df <- data.frame( x = c(x, input$outlier.x),
                          y = c(y, input$outlier.y),
                          Point = c(rep("Normal point", npoints), "Outlier point")
        )
        IM <- influence.measures(lm(y ~ x, df))
       
        colnames(IM$infmat) <- c("dfbetas intercept", "dfbetas coefficient", "dffit", "Covariance ratio", "Cook's distance", "Hat values")
        head(round(IM$infmat, 3), 4)
    })
    
    output$OutlierMeasures <- renderTable({
        npoints <- 100
        set.seed(100)
        x <- runif(npoints, min = -2, max = 2)
        y <- x + rnorm(npoints, mean = 0, sd = 0.3)
        df <- data.frame( x = c(x, input$outlier.x),
                          y = c(y, input$outlier.y),
                          Point = c(rep("Normal point", npoints), "Outlier point")
        )
        IM <- influence.measures(lm(y ~ x, df))
        
        colnames(IM$infmat) <- c("dfbetas intercept", "dfbetas coefficient", "dffit", "Covariance ratio", "Cook's distance", "Hat values")
        tail(round(IM$infmat, 3), 1)
    })
    
    output$is.infl <- renderTable({
        npoints <- 100
        set.seed(100)
        x <- runif(npoints, min = -2, max = 2)
        y <- x + rnorm(npoints, mean = 0, sd = 0.3)
        df <- data.frame( x = c(x, input$outlier.x),
                          y = c(y, input$outlier.y),
                          Point = c(rep("Normal point", npoints), "Outlier point")
        )
        IM <- influence.measures(lm(y ~ x, df))
        colnames(IM$is.inf) <- c("dfbetas intercept", "dfbetas coefficient", "dffit", "Covariance ratio", "Cook's distance", "Hat values")
        tail(IM$is.inf, 1)
    })

})
