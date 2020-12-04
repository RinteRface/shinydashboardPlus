library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

shinyApp(
  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(),
    dashboardBody(
      userBox(
        title = userDescription(
          title = "Nadia Carmichael",
          subtitle = "lead Developer",
          type = 2,
          image = "https://adminlte.io/themes/AdminLTE/dist/img/user7-128x128.jpg",
        ),
        status = "warning",
        navPills(
          id = "pillItem",
          navPillsItem(
            left = "Item 1", 
            color = "green",
            right = 10
          ),
          navPillsItem(
            left = "Item 2", 
            color = "red",
            icon = icon("angle-down"), 
            right = "10%"
          )
        ),
        footer = "The footer here!"
      )
    ),
    title = "userBox"
  ),
  server = function(input, output) {
    
    observeEvent(input$pillItem, {
      if (input$pillItem == 2) {
        showModal(
          modalDialog("A modal")
        )
      }
    })
    
    observeEvent(input$pillItem, {
      showNotification(
        sprintf("You clicked on pill N° %s", input$pillItem), 
        type = "warning",
        duration = 1
      )
    })
  }
)