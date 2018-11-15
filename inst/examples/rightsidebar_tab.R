rightsidebar_tab <- tabItem(
  tabName = "rightsidebar",
  br(),
  
  column(
    width = 12,
    align = "center",
    h1("rightsideBar(): additional dashboardSidebar!")
  ),
  br(),
  
  h4("To activate the right sidebar, you must replace dashboardPage with
      dashboardPagePlus and dashboardHeader by dashboardHeaderPlus:"),
  
  aceEditor(
    theme = "dracula",
    mode = "r",
    height = "600px",
    outputId = "rightsidebar_code",
    readOnly = TRUE,
    value = paste(
      style_text(
        'library(shiny)
         library(shinydashboard)
         shinyApp(
           ui = dashboardPagePlus(
             header = dashboardHeaderPlus(
               enable_rightsidebar = TRUE,
               rightSidebarIcon = "gears"
             ),
             sidebar = dashboardSidebar(),
             body = dashboardBody(),
             rightsidebar = rightSidebar(
               background = "dark",
               rightSidebarTabContent(
                 id = 1,
                 title = "Tab 1",
                 icon = "desktop",
                 active = TRUE,
                 sliderInput(
                   "obs", 
                   "Number of observations:",
                   min = 0, max = 1000, value = 500
                 )
               ),
               rightSidebarTabContent(
                 id = 2,
                 title = "Tab 2",
                 textInput("caption", "Caption", "Data Summary")
               ),
               rightSidebarTabContent(
                 id = 3,
                 icon = "paint-brush",
                 title = "Tab 3",
                 numericInput("obs", "Observations:", 10, min = 1, max = 100)
               )
             ),
             title = "Right Sidebar"
           ),
           server = function(input, output) { }
         )'
      ), 
      collapse = "\n"
    )
  )
)