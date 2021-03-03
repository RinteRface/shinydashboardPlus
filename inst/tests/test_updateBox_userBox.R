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
    userBox(
      id = "mybox",
      title = userDescription(
        title = "Elizabeth Pierce",
        subtitle = "Web Designer",
        type = 2,
        image = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
      ),
      status = "teal",
      closable = TRUE,
      maximizable = TRUE,
      "Some text here!",
      footer = "The footer here!"
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
        status = "info", 
        title = userDescription(
          title = "Nadia Carmichael",
          subtitle = "lead Developer",
          image = "https://adminlte.io/themes/AdminLTE/dist/img/user7-128x128.jpg",
        ),
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