library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

shinyApp(
  ui = dashboardPage(
    header = dashboardHeader(),
    sidebar = dashboardSidebar(collapsed = FALSE),
    body = dashboardBody(),
    controlbar = dashboardControlbar(collapsed = FALSE, skinSelector()),
    title = "Skin Selector"
  ),
  server = function(input, output) { }
)
