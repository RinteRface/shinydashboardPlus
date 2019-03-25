source("global.R")

shinyApp(
  ui = dashboardPagePlus(md = TRUE,
    dashboardHeaderPlus(
      fixed = TRUE,
      title = tagList(
        span(class = "logo-lg", "shinydashboardPlus"), 
        img(src = "ShinyDashboardPlus_FINAL.svg")),
      enable_rightsidebar = TRUE,
      rightSidebarIcon = "bars",
      left_menu = tagList(
        dropdownBlock(
          id = "mydropdown",
          title = "Dropdown 1",
          icon = "sliders",
          sliderInput(
            inputId = "n",
            label = "Number of observations",
            min = 10, 
            max = 100, 
            value = 30
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
          icon = "sliders",
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
      ),
      userOutput("user")
    ),
    dashboardSidebar(
      sidebarMenu(
        menuItem(
          text = "New rightSidebar", 
          tabName = "rightsidebar",
          badgeLabel = "new", 
          badgeColor = "green",
          icon = icon("gears")
        ),
        menuItem(
          text = "Improved header", 
          tabName = "header",
          badgeLabel = "new", 
          badgeColor = "green",
          icon = icon("folder-open")
        ),
        menuItem(
          text = "New boxes", 
          tabName = "boxes",
          badgeLabel = "new", 
          badgeColor = "green",
          icon = icon("briefcase")
        ),
        menuItem(
          text = "New buttons", 
          tabName = "buttons",
          badgeLabel = "new", 
          badgeColor = "green",
          icon = icon("cubes")
        ),
        menuItem(
          text = "New Box elements", 
          tabName = "boxelements",
          badgeLabel = "new", 
          badgeColor = "green",
          icon = icon("th")
        ),
        menuItem(
          text = "New extra elements", 
          tabName = "extraelements",
          badgeLabel = "new", 
          badgeColor = "green",
          icon = icon("plus-circle")
        )
      )
    ),
    rightsidebar = rightSidebar(
      background = "dark",
      rightSidebarTabContent(
        id = 1,
        title = "Tab 1",
        icon = "desktop",
        active = TRUE,
        sliderInput(
          inputId = "inputsidebar1", 
          label = "Number of observations:",
          min = 0, 
          max = 1000, 
          value = 500
        )
      ),
      rightSidebarTabContent(
        id = 2,
        title = "Tab 2",
        textInput(
          inputId = "inputsidebar2", 
          label = "Caption", 
          "Data Summary"
        )
      ),
      rightSidebarTabContent(
        id = 3,
        icon = "paint-brush",
        title = "Tab 3",
        numericInput(
          inputId = "inputsidebar3", 
          label = "Observations:", 
          value = 10, 
          min = 1, 
          max = 100
        )
      )
    ),
    dashboardBody(
      
      # use a bit of shinyEffects
      setShadow(class = "dropdown-menu"),
      setShadow(class = "box"),
      
      shiny::tags$head(
        # shiny::includeCSS(
        #   system.file("css", "qtcreator_dark.css", package = "shinydashboardPlus")
        # ),
        # shiny::includeScript(
        #   system.file("js", "highlight.pack.js", package = "shinydashboardPlus")
        # )
        shiny::tags$style(
          rel = "stylesheet",
          type = "text/css",
          href = "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/qtcreator_dark.min.css"
        ),
        
        shiny::tags$script(
          src = "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"
        )
      ),
      
      # All tabs
      tabItems(
        rightsidebar_tab,
        header_tab,
        boxes_tab,
        buttons_tab,
        box_elements_tab,
        extra_elements_tab
      )
    ),
    title = "shinyDashboardPlus",
    footer = dashboardFooter(
      left_text = "By Divad Nojnarg",
      right_text = "Zurich, 2019"
    )
  ),
  server = function(input, output) {
    output$distPlot <- renderPlot({
      hist(rnorm(input$obs))
    })
    
    output$distPlot2 <- renderPlot({
      hist(rnorm(input$obs2))
    })
    
    output$flipPlot <- renderPlot({
      hist(rnorm(input$flip_obs))
    })
    
    output$data <- renderTable({
      head(mtcars[, c("mpg", input$variable), drop = FALSE])
    }, rownames = TRUE)
    
    output$value <- renderText({input$somevalue})
    
    output$boxSidebarPlot <- renderPlot({
      hist(rnorm(input$slider_boxsidebar))
    })
    
    output$user <- renderUser({
      dashboardUser(
        name = "Divad Nojnarg", 
        src = "https://adminlte.io/themes/AdminLTE/dist/img/user2-160x160.jpg", 
        title = "shinydashboardPlus",
        subtitle = "Author", 
        footer = p("The footer", class = "text-center"),
        fluidRow(
          dashboardUserItem(
            width = 6,
            descriptionBlock(
              number = "17%", 
              number_color = "green", 
              number_icon = "fa fa-caret-up",
              header = "$35,210.43", 
              text = "TOTAL REVENUE", 
              right_border = TRUE,
              margin_bottom = FALSE
            )
          ),
          dashboardUserItem(
            width = 6,
            descriptionBlock(
              number = "18%", 
              number_color = "red", 
              number_icon = "fa fa-caret-down",
              header = "1200", 
              text = "GOAL COMPLETION", 
              right_border = FALSE,
              margin_bottom = FALSE
            )
          )
        )
      )
    })
    
  }
)