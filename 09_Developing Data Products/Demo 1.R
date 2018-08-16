#Similar data products


# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
# library(rsconnect)
# deployApp()
# APP URL: https://voitel.shinyapps.io/shiny_app/

suppressWarnings(library(shiny))
suppressWarnings(attach(mtcars))

shinyUI(fluidPage(
        
        # Application title
        titlePanel("Predict Horsepower from MPG"),
        
        sidebarLayout(
                sidebarPanel(
                        sliderInput("sliderMPG", "What is the MPG of the car?", 10, 35, value = 20),
                        submitButton("Click to Predict the Horsepower")
                ),
                
                # print predictions
                mainPanel(
                        p("The purpose of this Shiny app is to predict HorsePower of the car given the MPG
                          ."),
                        p("The slider represents the MPG of the car (from 10 to 35). By moving the slider
                          the lower and upper bounds of MPG are adjusted."),
                        p("The algorithm employs Simple Linear Regression Model of HorsePower vs. MPG",
                           "data set is available in the dataset package in R."),
                        p("The linear model has a 95% confidence interval level"),
                        p("Prediction for the MPG selected:"),
                        verbatimTextOutput("indpred"),
                        p("Predictions:"),
                        verbatimTextOutput("pred")
                        )
        )
        ))

#---------


# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
attach(mtcars)

fit.lm <- lm(hp ~ mpg)

shinyServer(function(input, output) {
        
        output$indpred <- renderPrint({
                
                mpgInput <- input$sliderMPG
                
                # build data frame
                newdata <- data.frame(mpg = mpgInput)
                
                # Generate individual prediction
                g1 <- predict(fit.lm, newdata, interval="predict")
                
                # print individual prediction
                g1
        })
        
        output$pred <- renderPrint ({
                
                # build sequence
                rng <- seq(from=60, to=input$sliderMPG, by=c(5))
                
                # generate data frame to suply to predict function
                newdata <- data.frame(mpg=rng)
                
                # generate predictions
                g <- predict(fit.lm, newdata, interval="predict")
                
                # print predictions
                g
                
        })
        
})





