#' @examples
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
shinyApp(
  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(),
    dashboardBody(
      flip_box(
        id = "id",
        front_content = div(
          class = "text-center",
          img(
            src = "https://image.flaticon.com/icons/svg/149/149076.svg",
            height = "300px",
            width = "100%"
          )
        ),
        back_content = div(
          class = "text-center",
          height = "300px",
          width = "100%",
          h1("Details...."),
          p("More information....")
        )
      )
    )
  ),
  
  server = function(input, output, session) {
    
    # observe({
    #   
    #   browser()
    #   
    #   print(list("flipBox Status: " = input$id))
    # })
    
  }
)
