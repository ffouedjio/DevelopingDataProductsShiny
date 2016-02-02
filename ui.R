###########################################################################
##### Simulation of Truncated Standard Gaussian Distribution - ui.R  #####
##########################################################################

library(shiny) 

shinyUI(fluidPage( 
 
 headerPanel("Simulation of Truncated Standard Gaussian Distribution"), 
 sidebarPanel( 
  
  
  selectInput(inputId = "TruncationParameter",
              label = "1. Truncation Parameter:",
              choices = list("a=1" = "TP1", "a=1.5" = "TP2", "a=2" = "TP3","a=2.5" = "TP4","a=3" = "TP5","a=3.5" = "TP6")),
  
  radioButtons(inputId = "Algorithm",
              label = "2. Algorithms:",
              choices = list("Algorithm 1 (Slow)" = "V1", "Algorithm 2 (Fast)" = "V2")),
  
  
  
  sliderInput(inputId = "NumberSimulations",
              label = "3. Number of Simulations:",
              min = 1000, max = 10000, value = 1000, step = 100)
  
 ),
 
 mainPanel(
  plotOutput("distPlot")
 )
))


