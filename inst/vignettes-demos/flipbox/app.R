library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

shinyApp(
  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(),
    dashboardBody(
      fluidRow(
        column(
          width = 6,
          uiOutput("active_side"), 
          actionButton("toggle", "Toggle flip box"),
          flipBox(
            id = "myflipbox", 
            trigger = "hover",
            width = 12,
            front = div(
              class = "text-center",
              h1("Flip on hover"),
              img(
                src = "https://image.flaticon.com/icons/svg/149/149076.svg",
                height = "300px",
                width = "100%"
              )
            ),
            back = div(
              class = "text-center",
              height = "300px",
              width = "100%",
              h1("Flip on hover"),
              p("More information....")
            )
          )
        ),
        column(
          width = 6,
          uiOutput("active_side_2"),
          flipBox(
            id = "myflipbox2",
            width = 12,
            front = div(
              class = "text-center",
              h1("Flip on click"),
              img(
                src = "https://image.flaticon.com/icons/svg/149/149076.svg",
                height = "300px",
                width = "100%"
              )
            ),
            back = div(
              class = "text-center",
              height = "300px",
              width = "100%",
              h1("Flip on click"),
              p("More information....")
            )
          )
        )
      )
    ),
    title = "flipBox"
  ),
  
  server = function(input, output, session) {
    output$active_side <- renderUI({
      side <- if (input$myflipbox) "front" else "back"
      dashboardBadge(side, color = "blue")
    })
    
    output$active_side_2<- renderUI({
      side <- if (input$myflipbox2) "front" else "back"
      dashboardBadge(side, color = "blue")
    })
    
    observeEvent(input$toggle, {
      updateFlipBox("myflipbox")
    })
  }
)
