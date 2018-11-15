header_tab <- tabItem(
  tabName = "header",
  
  br(),
  
  column(
    width = 12,
    align = "center",
    h1("Add a left menu in the navbar!")
  ),
  br(),
  
  h4("To activate this feature, you must replace dashboardHeader by dashboardHeaderPlus.
      Pass all your arguments in the left_menu argument. You can also decide whether
      the navbar should be fixed-top or not using the fixed argument. 
      To include custom input elements, such as sliderInput, ... wrap them in a
      dropdownBlock, which was specially built for the left menu."),
  
  aceEditor(
    theme = "dracula",
    mode = "r",
    height = "800px",
    outputId = "left_menu_header_code",
    readOnly = TRUE,
    value = paste(
      style_text(
        'library(shiny)
         library(shinyWidgets)
         library(shinydashboard)
         library(shinydashboardPlus)
         
         shinyApp(
           ui = dashboardPagePlus(
             header = dashboardHeaderPlus(
               fixed = TRUE,
               enable_rightsidebar = TRUE,
               rightSidebarIcon = "gears",
               left_menu = tagList(
                 dropdownBlock(
                   id = "mydropdown",
                   title = "Dropdown 1",
                   icon = icon("sliders"),
                   sliderInput(
                     inputId = "n",
                     label = "Number of observations",
                     min = 10, max = 100, value = 30
                   ),
                   prettyToggle(
                     inputId = "na",
                     label_on = "NAs keeped",
                     label_off = "NAs removed",
                     icon_on = icon("check"),
                     icon_off = icon("remove")
                   )
                 ),
                 dropdownBlock(
                   id = "mydropdown2",
                   title = "Dropdown 2",
                   icon = icon("sliders"),
                   prettySwitch(
                     inputId = "switch4",
                     label = "Fill switch with status:",
                     fill = TRUE, 
                     status = "primary"
                   ),
                   prettyCheckboxGroup(
                     inputId = "checkgroup2",
                     label = "Click me!", 
                     thick = TRUE,
                     choices = c("Click me !", "Me !", "Or me !"),
                     animation = "pulse", 
                     status = "info"
                   )
                 )
               ),
               dropdownMenu(
                 type = "tasks", 
                 badgeStatus = "danger",
                 taskItem(value = 20, color = "aqua", "Refactor code"),
                 taskItem(value = 40, color = "green", "Design new layout"),
                 taskItem(value = 60, color = "yellow", "Another task"),
                 taskItem(value = 80, color = "red", "Write documentation")
               )
             ),
             sidebar = dashboardSidebar(),
             body = dashboardBody(
               setShadow(class = "dropdown-menu")
             ),
             rightsidebar = rightSidebar(),
             title = "DashboardPage"
           ),
           server = function(input, output) { }
         )'
      ), 
      collapse = "\n"
    )
  )
)