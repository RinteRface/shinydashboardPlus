library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

shinyApp(
  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(),
    dashboardBody(
      box(
        solidHeader = FALSE,
        title = "Description Block",
        background = NULL,
        width = 12,
        status = "danger",
        footer = fluidRow(
          column(
            width = 6,
            descriptionBlock(
              number = "17%", 
              numberColor = "green", 
              numberIcon = icon("caret-up"),
              header = "$35,210.43", 
              text = "TOTAL REVENUE", 
              rightBorder = TRUE,
              marginBottom = FALSE
            )
          ),
          column(
            width = 6,
            descriptionBlock(
              number = "18%", 
              numberColor = "red", 
              numberIcon = icon("caret-down"),
              header = "1200", 
              text = "GOAL COMPLETION", 
              rightBorder = FALSE,
              marginBottom = FALSE
            )
          )
        )
      )
    ),
    title = "Description Block"
  ),
  server = function(input, output) { }
)