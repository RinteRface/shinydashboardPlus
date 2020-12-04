library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

shinyApp(
  ui = dashboardPage(
    title = "Box Sidebar",
    header = dashboardHeader(),
    body = dashboardBody(
      box(
        title = "Update box sidebar", 
        closable = TRUE, 
        width = 12,
        solidHeader = FALSE, 
        collapsible = TRUE,
        actionButton("update", "Toggle card sidebar"),
        sidebar = boxSidebar(
          id = "mycardsidebar",
          width = 25,
          sliderInput(
            "obs", 
            "Number of observations:",
            min = 0, 
            max = 1000, 
            value = 500
          )
        ),
        plotOutput("distPlot")
      )
    ),
    sidebar = dashboardSidebar()
  ),
  server = function(input, output, session) {
    observe(print(input$mycardsidebar))
    
    output$distPlot <- renderPlot({
      hist(rnorm(input$obs))
    })
    
    observeEvent(input$update, {
      updateBoxSidebar("mycardsidebar")
    })
    
  }
)