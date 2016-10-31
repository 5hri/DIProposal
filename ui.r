library(shiny)

# Define UI for application that takes in input
shinyUI(
  navbarPage("AirBnB Optimizer",
             tabPanel(p(icon("flash"), "Negotiator"),
                      
                      sidebarPanel(
                        numericInput('accommodates', 'Accomodate how many people?', 1, min=1,max=30,step=1),
                        numericInput('bedrooms','Number of bedrooms: ', 1, min=0, max=10,step=1),
                        numericInput('bathrooms','Number of bathrooms: ', 1, min=1, max=10,step=1),
                        numericInput('beds', 'Number of beds: ', 1, min=1, max=20,step=1),
                        submitButton('Click to negotiate')
                      ),
                      mainPanel(
                        p('This application intends to help users who live in San Francisco to find a good price point to put up in AirBnB.'),
                        p('User have to to is to input some basic information such as number of people the unit can accommodate, 
      number of bathrooms, number of bedrooms, and number of beds that is available.  And then a suggestion will
      be provided based on the San Francisco AirBnb listing data.'),
                        p('Usage: Adjust any of the option on the left hand side to fit the features of your unit and then hit submit'),
                        h3('Results of Suggestion'),
                        h4('You entered'),
                        verbatimTextOutput("inputValue"),
                        h4('The suggested per night price is '),
                        verbatimTextOutput("prediction")
                      )
             ),
             
             tabPanel(p(icon("leaf"), "Optimizer"),
                      fluidPage(
                        leafletOutput("MapPlot1")
                      )
             )
             
  ))