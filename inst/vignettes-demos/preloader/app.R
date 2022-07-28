library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(waiter)

shinyApp(
  ui = dashboardPage(
    preloader = list(
      waiter = list(html = tagList(spin_1(), "Loading ..."), color = "#3c8dbc"),
      duration = 5
    ),
    header = dashboardHeader(),
    sidebar = dashboardSidebar(),
    body = dashboardBody(
      actionButton("reload", "Reload")
    ),
    title = "Preloader"
  ),
  server = function(input, output, session) {
    observeEvent(input$reload, {
      session$reload()
    })
  }
)
