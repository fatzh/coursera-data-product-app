library(UsingR)
data(GaltonFamilies)
library(shiny)

# load galton data and convert to centimeters
df <- GaltonFamilies
df$father <- df$father * 2.54
df$mother <- df$mother * 2.54
df$childHeight <- df$childHeight * 2.54

# build the model
mdl <- lm(data=df, childHeight ~ father + mother + gender)

# Define the server logic to predict the height
shinyServer(function(input, output) {
    
    
    
    output$heightPlot <- renderPlot({
        
        # build data set for prediction
        input_data <- data.frame(father=input$father,
                                 mother=input$mother,
                                 gender=input$gender)

        child_height <- round(predict(mdl, input_data), digits=0)
        
        df <- data.frame(labels=c('Mother', 'Father', 'Child'),
                         heights=c(input$mother, input$father, child_height))
        
        ggplot(data=df, aes(x=labels, y=heights, fill=labels)) +
            geom_bar(stat="identity") +
            theme_minimal() +
            theme(legend.position="none") +
            geom_text(aes(label=heights), vjust=4, color="white", size=5) +
            xlab("") +
            ylab("Heights (in centimeters)") +
            ggtitle("Family heights")
            
    })
})