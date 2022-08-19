library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

shinyApp(
  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(),
    dashboardBody(
      radioButtons("controller", "Controller", choices = c(1, 2)),
      br(),
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
  server = function(input, output, session) {
    observeEvent(input$controller, {
      updateAccordion(id = "accordion1", selected = input$controller)
    })
    
    observe(print(input$accordion1))
    
    observeEvent(input$accordion1, {
      showNotification(
        sprintf("You selected accordion N° %s", input$accordion1), 
        type = "message",
        duration = 1
      )
    })
  }
)
