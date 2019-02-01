library(shiny)

function(input, output, session) {
  
  output$regije <- renderPlot({
    graf.regije(input$regija)
  })
  output$zemljevid <- renderPlot({
    graf.zemljevid(input$st)
  })
}