library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

shinyApp(
  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(),
    dashboardBody(
      box(
        width = 12,
        style = paste0("background-color: #000; color: #FFF;"),
        fluidRow(
          column(
            width = 12,
        flip_box(
          id = "id",
          front_content = img(
              src = "https://image.flaticon.com/icons/svg/149/149076.svg",
              width = "100%",
              height = "300px",
              style = "border: 1px solid black"
          ),
          back_content = div(
            style = "border: 1px solid black; height: 300px; background-color: #FFFFFF; color: #000000;",
            h1(
              class = "text-center",
              "Details...."
            ),
            p("More information....")
          )
        )
          )
        ),
        
        fluidRow(
          column(
            width = 12,
            br(),
            div(
              id = "go_to_back",
              class = "pull_right",
              style = "display: inline-block; margin-right: 5px;",
              flip_button_front("id", "More Info")
            ),
            div(
              id = "go_to_front",
              class = "pull-right",
              style = "display: none; margin-right: 5px;",
              flip_button_back("id", "Back to Front")
            )
          )
        )
      )
    )
    ),
  
  server = function(input, output, session) {
    
  }
)
