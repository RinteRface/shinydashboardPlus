library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

shinyApp(
  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(),
    dashboardBody(
      accordion(
        id = "accordion1",
        accordionItem(
          title = "Accordion 1 Item 1",
          status = "danger",
          collapsed = TRUE,
          "This is some text!"
        ),
        accordionItem(
          title = "Accordion 1 Item 2",
          status = "warning",
          collapsed = FALSE,
          "This is some text!"
        )
      ),
      accordion(
        id = "accordion2",
        accordionItem(
          title = "Accordion 2 Item 1",
          status = "info",
          collapsed = TRUE,
          "This is some text!"
        ),
        accordionItem(
          title = "Accordion 2 Item 2",
          status = "success",
          collapsed = FALSE,
          "This is some text!"
        )
      )
    ),
    title = "Accordion"
  ),
  server = function(input, output) { }
)