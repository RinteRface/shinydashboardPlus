library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

menu <- controlbarMenu(
  id = "controlbarMenu",
  controlbarItem(
    "Tab 1",
    "Welcome to tab 1"
  ),
  controlbarItem(
    "Tab 2",
    numericInput("num", "Observations:", 200, min = 1, max = 1000, step = 100)
  )
)

shinyApp(
  ui = dashboardPage(
    header = dashboardHeader(),
    sidebar = dashboardSidebar(
      width = "100px",
      minified = TRUE, 
      collapsed = TRUE,
      sidebarMenu(
        id = "sidebarMenu",
        lapply(1:3, function(i) {
          menuItem(
            sprintf("Menu %s", i), 
            tabName = sprintf("menu_%s", i), 
            icon = icon("circle")
          )
        })
      )
    ),
    body = dashboardBody(
      tabItems(
        tabItem(tabName = "menu_1", "Content 1"), 
        tabItem(
          tabName = "menu_2",
          box(
            title = "Always the same plot!",
            collapsible = TRUE, 
            width = 6,
            plotOutput("distPlot"),
            sidebar = boxSidebar(
              id = "boxSidebar",
              background = "#808080",
              width = "50%",
              sliderInput(
                "obs", 
                "Number of observations:",
                min = 0,
                max = 1000, 
                value = 500
              )
            )
          )
        )
      )
    ),
    controlbar = dashboardControlbar(
      id = "controlbar",
      menu
    ),
    title = "Controlbar API"
  ),
  server = function(input, output, session) {
    output$distPlot <- renderPlot({
      hist(rnorm(input$obs))
    })
    # Switch controlbar menu based on sidebar item value. Moreover
    # if the sidebar menu item is 2, the controlbar opens
    observeEvent(input$sidebarMenu, {
      idx <- strsplit(input$sidebarMenu, "_")[[1]][2]
      if (idx == 2) {
        updateControlbar("controlbar")
      }
      updateControlbarMenu("controlbarMenu", selected = idx)
    })
    
    # Clicking on the second controlbar item makes the box sidebar open
    observeEvent(input$controlbarMenu, {
      if (input$controlbarMenu == "Tab 2") updateBoxSidebar("boxSidebar")
    })
    
    observeEvent(input$num, {
      updateSliderInput(session, "obs", value = input$num)
    }, ignoreInit = TRUE)
    
  }
)
