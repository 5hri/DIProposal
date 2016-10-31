library(shiny)
library(rCharts); library(leaflet)

mydata <- read.csv('./data/SFlistings.csv')
mydata$price <- as.numeric(gsub('\\$','',mydata$price))

model <- glm(price ~ accommodates + bathrooms + bedrooms + beds, data=mydata)

tmp <- sample_n(mydata,100) %>% 
  select(id, price, latitude, longitude) %>% 
  mutate_each(funs(as.numeric), id, price, latitude, longitude) %>% na.omit

shinyServer(
  function(input, output,session) {
    # Tab 1
    output$inputValue <- renderPrint({paste('Accommodates: ', input$accommodates, 
                                            '# of Bathrooms:', input$bathrooms, 
                                            '# of bedrooms:', input$bedrooms,
                                            '# of beds:', input$beds
    )})
    
    output$prediction <- renderPrint({predict(model, data.frame(accommodates=input$accommodates,
                                                                bathrooms=input$bedrooms,
                                                                bedrooms=input$bedrooms,
                                                                beds=input$beds))})
    
    #Tab 2
    output$MapPlot1 <- renderLeaflet({
      leaflet() %>% 
        addProviderTiles("Stamen.TonerLite",options = providerTileOptions(noWrap = TRUE))%>%
        addMarkers(lng = tmp$longitude,
                   lat = tmp$latitude,popup = paste("$",as.character(tmp$price))
        ) %>% 
        setView(lng = -122.431297,
                lat = 37.773972,
                zoom = 12)
    })
    
  }
)