library(shiny)
library(ggplot2)
library(openxlsx)

terrorism <- read.xlsx("../data/raw data/globalterrorismdb_0617dist.xlsx")
terrorism <- terrorism[,c("iyear", "country_txt", "region_txt", "city", "latitude", "longitude", "attacktype1_txt", "targtype1_txt", "weaptype1_txt")]
dataset<-terrorism[terrorism$iyear<=1974|terrorism$iyear>=2012,]


fluidPage(
  
  titlePanel("Terrorism attacks"),
  
  sidebarPanel(
    
    sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                value=min(1000, nrow(dataset)), step=500, round=0),
    
    selectInput('x', 'X', names(dataset)),
    selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
    selectInput('color', 'Color', c('None', names(dataset))),
    
    checkboxInput('jitter', 'Jitter'),
    checkboxInput('smooth', 'Smooth')
    
  ),
  
  
  mainPanel(
    plotOutput('plot')
  )
)