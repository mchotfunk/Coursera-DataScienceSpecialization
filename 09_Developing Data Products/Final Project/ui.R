# AIR QUALITY
#
# http://shiny.rstudio.com
#
# library(rsconnect)
# deployApp()
# APP URL: https://voitel.shinyapps.io/shiny_app/
library(rsconnect)
library(datasets)
library(dplyr)

suppressWarnings(library(shiny))
suppressWarnings(attach(airquality))

shinyUI(fluidPage(
        
        # Application title
        titlePanel("Predict Emissions of Ozone within New York State"),
        h3("Author: Andrew Abisha Hu"),
        
        sidebarLayout(
                sidebarPanel(
                        
                        h3("Data description"),
                        helpText("The data were obtained from the New York State Department of Conservation (ozone data) and the National Weather Service (meteorological data). It is Daily readings of the following air quality values for May 1, 1973 (a Tuesday) to September 30, 1973."),
                        
                        selectInput("variables","Select one or more predictors:",
                                    names(select(airquality,-Ozone)),
                                    selected = "Solar.R",
                                    selectize = TRUE,
                                    multiple = TRUE),
                        submitButton("See the summary of model"),
                        
                        p("After trying different predictors, choose a specific predictor and assign a value, in order to predict a 95% interval of that predictor, and the outcome of Ozone"),
                        sliderInput("sliderso", "What is the Solar radiation of that day?", 7, 334, value = 185,step = 17),
                        submitButton("Predict Ozone given Solar.R"),
                        sliderInput("sliderwi", "What is the Average Wind Speed of that day?",1.7,20.7,value=9.7,step=1),
                        submitButton("Predict Ozone given Wind speed"),
                        sliderInput("sliderte", "What is the temperature of that day?",56,97,value=79, step=2),
                        submitButton("Predict Ozone given temperature")
                ),
                
                # print predictions
                mainPanel(
                        h2("Introduction:"),
                        p("The purpose of this Shiny app is to predict Ozone given different predictors
                          . Input differnt predictors and click tabs to see results:"),
                        tabsetPanel(type= "tabs",
                                    tabPanel("Regression Plot:",
                                            br(),
                                            plotOutput("OzonePlot")
                                            ),
                                    tabPanel("Model Summary",
                                            br(),
                                            verbatimTextOutput("summaryFit")
                                            ),
                                    tabPanel("Predictions for the Solar Radiation selected:",
                                             br(),
                                             verbatimTextOutput("indpredso"),
                                             br(),
                                             "Predictions for Ozone given levels of Solar Radiation:",
                                             br(),
                                             verbatimTextOutput("pred1")
                                             ),
                                    tabPanel("Predictions for the Wind Speed selected:",
                                             br(),
                                             verbatimTextOutput("indpredwi"),
                                             br(),
                                             "Predictions for Ozone given levels of Wind Speed:",
                                             br(),
                                             verbatimTextOutput("pred2")
                                             ),
                                    tabPanel("Predictions for the Temperature selected:",
                                             br(),
                                             verbatimTextOutput("indpredte"),
                                             br(),
                                             "Predictions for Ozone given levels of Temperature:",
                                             br(),
                                             verbatimTextOutput("pred3")
                                             )
                        
                        
                )
        )
))

)