library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
source("boxes.R")
source("flipBox.R")
shinyApp(
  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(),
    dashboardBody(
      setShadow("card"),
      fluidRow(
        column(
          width = 6,
          align = "center",
          selectInput('names', label= 'Pick a name to display the flipbox',
                      choices = c('mary', 'john', 'jane'), multiple = FALSE),
          uiOutput('flip_box')
        )
      )
      
    )
    
  ),
  server = function(input, output) {
    output$flip_box <- renderUI({
      
      req(input$names)
      
      # I need to use input values from various input widgets as parameter
      # values in flipBox, that is why I am using the renderUI
      # but the 'back side' button does not work on the second rendering
      # of the flipbox, only the first time it renders
      flipBox(
        id = 1,
        front_content = tagList(img('student_header.jpg')),

        back_content = tagList(img('filter_panel.jpg'))
        )
    })
    
    output$distPlot <- renderPlot({
      hist(rnorm(input$obs))
    })    
    
  }
)