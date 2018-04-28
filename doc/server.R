library(shiny)
library(ggplot2)
library(openxlsx)

function(input, output) {
  #options(shiny.sanitize.errors = TRUE)
  terrorism <- read.xlsx("../data/raw data/globalterrorismdb_0617dist.xlsx")
  terrorism <- terrorism[,c("iyear", "country_txt", "region_txt", "city", "latitude", "longitude", "attacktype1_txt", "targtype1_txt", "weaptype1_txt")]
  terrorism1<-terrorism[terrorism$iyear<=1974|terrorism$iyear>=2012,]
 
  
  dataset <- reactive({
    terrorism1[sample(nrow(terrorism1), input$sampleSize),]
  })
  
  output$plot <- renderPlot({
    
    p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()
    
    if (input$color != 'None')
      p <- p + aes_string(color=input$color)
    
    if (input$jitter)
      p <- p + geom_jitter()
    if (input$smooth)
      p <- p + geom_smooth()
    
    print(p)
    
  }, height=700)
  
}