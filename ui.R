library(shiny)

shinyUI(fluidPage(
    
    # application title
    titlePanel("Child Height predictor"),
    
    p('This application uses the Galton historical data to predict the height 
      of a child given its gender and the heights of its parents.'),
    p('All heights are in centimeters.'),
   
    # sidebar with gender selection and height sliders
    sidebarLayout(
        sidebarPanel(
            radioButtons("gender", "Child gender:",
                         c("Female" = "female",
                           "Male" = "male")),
            
            sliderInput("mother",
                        "Mother height",
                        min = 120,
                        max = 210,
                        value = 150),
            
            sliderInput("father",
                        "Father height",
                        min = 120,
                        max = 210,
                        value = 150),
            
            helpText("Note: Select the child gender, and use the sliders to set the mother and father heights (in centimeters)")
            
        ),
        
        #show the predicted height
        mainPanel(
            plotOutput("heightPlot")
        )
    )
    
))