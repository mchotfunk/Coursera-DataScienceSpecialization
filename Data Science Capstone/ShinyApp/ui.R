#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(markdown)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
        titlePanel("Data Science Capstone- Natural Language Processing App"),
        HTML("<strong>Course: Data Science Specialization by Johns Hopkins University</strong>"),
        br(),
        HTML("<strong>Author: Andrew Abisha Hu</strong>"),
        br(),
  
  # Sidebar 
  sidebarLayout(
    sidebarPanel(
            h3("Introduction:"),
            
            p("The purpose of this Shiny app is to predict the next word given the previous words"),
           
            p("Use one or two word would be the most accurate"),
           
            textInput("inputWords", "Enter words here!", value=""),
            br(),
            br(),
            br()
       
    ),
    
    # Main
    mainPanel(
            h2("Here is the prediction"),
            verbatimTextOutput("prediction")
            
            
         
    )
  )
))