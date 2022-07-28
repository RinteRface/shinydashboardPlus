library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

shinyApp(
  ui = dashboardPage(
    title = "Box Dropdown",
    dashboardHeader(),
    dashboardSidebar(),
    dashboardBody(
      box(
        title = "Closable Box with dropdown", 
        width = 12,
        status = "warning", 
        solidHeader = FALSE, 
        collapsible = TRUE,
        dropdownMenu = boxDropdown(
          icon = icon("wrench", class = "fa-2x"),
          boxDropdownItem("Click me", id = "dropdownItem", icon = icon("heart")),
          boxDropdownItem("item 2", href = "https://www.google.com/"),
          dropdownDivider(),
          boxDropdownItem("item 3", icon = icon("table-cells"))
        ),
        "My box"
      )
    )
  ),
  server = function(input, output) {
    observeEvent(input$dropdownItem, {
      showNotification("Hello", duration = 1, type = "error")
    })
  }
)
