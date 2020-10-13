library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

ui <- dashboardPage(
  title = "Box API",
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    tags$style("body { background-color: ghostwhite}"),
    fluidRow(
      actionButton("toggle_box", "Toggle Box"),
      actionButton("remove_box", "Remove Box", class = "bg-danger"),
      actionButton("restore_box", "Restore Box", class = "bg-success"),
      actionButton("update_box", "Update Box", class = "bg-primary")
    ),
    br(),
    box(
      title = textOutput("box_state"),
      "Box body",
      id = "mybox",
      collapsible = TRUE,
      closable = TRUE,
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    req(!input$mybox$collapsed)
    plot(rnorm(200))
  })
  
  output$box_state <- renderText({
    state <- if (input$mybox$collapsed) "collapsed" else "uncollapsed"
    paste("My box is", state)
  })
  
  observeEvent(input$toggle_box, {
    updateBox("mybox", action = "toggle")
  })
  
  observeEvent(input$remove_box, {
    updateBox("mybox", action = "remove")
  })
  
  observeEvent(input$restore_box, {
    updateBox("mybox", action = "restore")
  })
  
  observeEvent(input$update_box, {
    updateBox(
      "mybox", 
      action = "update", 
      options = list(
        title = tagList(h2("New title"), dashboardLabel(1, status = "primary")),
        status = "danger", 
        solidHeader = TRUE,
        width = 4
      )
    )
  })
  
  observeEvent(input$mybox$visible, {
    collapsed <- if (input$mybox$collapsed) "collapsed" else "uncollapsed"
    visible <- if (input$mybox$visible) "visible" else "hidden"
    message <- paste("My box is", collapsed, "and", visible)
    showNotification(message, type = "warning", duration = 1)
  })
}

shinyApp(ui, server)