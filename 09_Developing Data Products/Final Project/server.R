# This is the server logic for a Shiny web application.
###AIR QUALITY
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(rsconnect)
library(shiny)
library(ggplot2)
attach(airquality)
library(datasets)
library(dplyr)

fit.lm.so <- lm(Ozone ~ Solar.R)
fit.lm.wi <- lm(Ozone~ Wind)
fit.lm.te <- lm(Ozone~ Temp)
ggreg <- function (fit) {
        
        require(ggplot2)
        
        ggplot(fit$model, aes_string(x = names(fit$model)[2], y = names(fit$model)[1])) + 
                geom_point() +
                stat_smooth(method = "lm", col = "red") +
                labs(title = paste("Adj R2 = ",signif(summary(fit)$adj.r.squared, 5),
                                   "Intercept =",signif(fit$coef[[1]],5 ),
                                   " Slope =",signif(fit$coef[[2]], 5),
                                   " P =",signif(summary(fit)$coef[2,4], 5)))
}

shinyServer(function(input, output) {
        
        output$indpredso <- renderPrint({
                
                soInput <- input$sliderso
                
                # build data frame
                newdata <- data.frame(Solar.R = soInput)
                
                # Generate individual prediction
                g1 <- predict(fit.lm.so, newdata, interval="predict")
                
                # print individual prediction
                g1
        })
        
        
        output$pred1 <- renderPrint ({
                
                # build sequence
                rng <- seq(from=7, to=input$sliderso, by=c(17))
                
                # generate data frame to suply to predict function
                newdata <- data.frame(Solar.R=rng)
                
                # generate predictions
                g <- predict(fit.lm.so, newdata, interval="predict")
                
                # print predictions
                g
                
        })
        
        output$indpredwi <- renderPrint({
                
                wiInput <- input$sliderwi
                
                # build data frame
                newdata <- data.frame(Wind =wiInput )
                
                # Generate individual prediction
                g1 <- predict(fit.lm.wi, newdata, interval="predict")
                
                # print individual prediction
                g1
        })
        
        output$pred2 <- renderPrint ({
                
                # build sequence
                rng <- seq(from=1.7, to=input$sliderwi, by=c(1))
                
                # generate data frame to suply to predict function
                newdata <- data.frame(Wind=rng)
                
                # generate predictions
                g <- predict(fit.lm.wi, newdata, interval="predict")
                
                # print predictions
                g
                
        })
        
        output$indpredte <- renderPrint({
                
                teInput <- input$sliderte
                
                # build data frame
                newdata <- data.frame(Temp =teInput )
                
                # Generate individual prediction
                g1 <- predict(fit.lm.te, newdata, interval="predict")
                
                # print individual prediction
                g1
        })
        
        output$pred3 <- renderPrint ({
                
                # build sequence
                rng <- seq(from=56, to=input$sliderte, by=c(2))
                
                # generate data frame to suply to predict function
                newdata <- data.frame(Temp=rng)
                
                # generate predictions
                g <- predict(fit.lm.te, newdata, interval="predict")
                
                # print predictions
                g
                
        })
        
        vars <- reactive({
                var.vector <- as.vector(input$variables)
                lmFormula<-paste("Ozone~",
                                 ifelse(length(var.vector)>0,
                                        predictors<-paste(var.vector,
                                                          collapse="+"),
                                        "1"),
                                 sep="")
                
        }) 
        
        # fits model based on selected variables
        fit<-reactive({
                lm(as.formula(vars()), data=airquality)
        })
        
        #Plot 4 diagnostic plots for the generated regression model
        output$OzonePlot<-renderPlot({
                par(mfrow = c(2, 2), oma = c(0, 0, 0, 0))
                ggreg(fit())
             
        })
        #output summary data
        output$summaryFit <- renderPrint({
                summary(fit())
        })
        
})

