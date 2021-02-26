library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    tags$style("body { background-color: ghostwhite}"),
    actionButton("update_box", "Update Box", class = "bg-info"), 
    actionButton("update_box2", "Update Box 2", class = "bg-info"),
    br(),
    br(),
    box(
      title = textOutput("box_state"),
      id = "mybox",
      status = "maroon",
      background = "maroon", solidHeader = TRUE,
      gradient = TRUE,
      collapsible = TRUE,
      closable = TRUE,
      height = "300px"
    )
  )
)

server <- function(input, output, session) {
  
  output$box_state <- renderText({
    state <- if (input$mybox$collapsed) "collapsed" else "uncollapsed"
    paste("My box is", state)
  })

  
  observeEvent(input$update_box, {
    updateBox(
      "mybox", 
      action = "update", 
      options = list(
        title = h2("hello", dashboardLabel(1, status = "primary")),
        status = "info", 
        solidHeader = FALSE, 
        width = 12, 
        background = "orange", 
        gradient = TRUE,
        height = "900px", 
        closable = FALSE
      )
    )
  })
  
  observeEvent(input$update_box2, {
    updateBox(
      "mybox", 
      action = "update", 
      options = list(
        status = "danger", 
        solidHeader = FALSE,
        width = 4, 
        background = NULL, 
        height = "500px", 
        closable = TRUE
      )
    )
  })
  
}

shinyApp(ui, server)