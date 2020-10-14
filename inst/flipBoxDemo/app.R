#' @examples
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
shinyApp(
  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(),
    dashboardBody(
      shiny::fluidRow(
        shiny::column(
          12,
          flipBox(
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
      br(),
      br(),
      hr(),
      shiny::fluidRow(
        shiny::column(
          12,
          tags$div(
            class = "text-center",
            shiny::textOutput("flipbox_value")
          )
        )
      )
    )
  ),
  
  server = function(input, output, session) {
    
    output$flipbox_value <- shiny::renderText({
      req(input$id_value)
      paste0("Flipbox Value: ", input$id_value)
    })
    
  }
)
