library(shiny)

shinyUI(fluidPage(
  
  tabsetPanel(
    tabPanel("Združitev regij v skupine",
             sidebarPanel(
               sliderInput(inputId="st", label="Izberi število skupin:",
                           value=3, min=1, max=5)
             ),
             mainPanel(plotOutput("zemljevid"))),
    
    tabPanel("Deleži ločenih odpadkov po regijah",
             sidebarPanel(
               checkboxGroupInput(inputId="regija", label="Izberi regije:", 
                           choiceNames=c("Gorenjska", "Goriška", "Jugovzhodna Slovenija", "Koroška", "Obalno-kraška", "Osrednjeslovenska", "Podravska", "Pomurska", "Posavska", "Primorsko-notranjska", "Savinjska", "Zasavska"),
                           choiceValues=c("Gorenjska", "Goriska", "Jugovzhodna_Slovenija", "Koroska", "Obalno-kraska", "Osrednjeslovenska", "Podravska", "Pomurska", "Posavska", "Primorsko-notranjska", "Savinjska", "Zasavska"),
                           selected="Osrednjeslovenska")
             ),
             mainPanel(plotOutput("regije")))
    
    
  )
))