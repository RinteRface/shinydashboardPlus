library(shiny)
library(shinyjqui)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyAce)
library(styler)
library(shinyWidgets)

shinyApp(
  ui = dashboardPagePlus(
    dashboardHeaderPlus(
      fixed = TRUE,
      title = "shinydashboardPlus",
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
      )
    ),
    dashboardSidebar(
      sidebarMenu(
        menuItem("New rightSidebar", tabName = "rightsidebar",
                 badgeLabel = "new", badgeColor = "green",
                 icon = icon("gears")),
        menuItem("Improved header", tabName = "header",
                 badgeLabel = "new", badgeColor = "green",
                 icon = icon("folder-open")),
        menuItem("New boxes", tabName = "boxes",
                 badgeLabel = "new", badgeColor = "green",
                 icon = icon("briefcase")),
        menuItem("New buttons", tabName = "buttons",
                 badgeLabel = "new", badgeColor = "green",
                 icon = icon("cubes")),
        menuItem("New Box elements", tabName = "boxelements",
                 badgeLabel = "new", badgeColor = "green",
                 icon = icon("th")),
        menuItem("Extra CSS effects", tabName = "extracss",
                 badgeLabel = "new", badgeColor = "green",
                 icon = icon("magic")),
        menuItem("New extra elements", tabName = "extraelements",
                 badgeLabel = "new", badgeColor = "green",
                 icon = icon("plus-circle"))
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
          "inputsidebar1", 
          "Number of observations:",
          min = 0, max = 1000, value = 500
        )
      ),
      rightSidebarTabContent(
        id = 2,
        title = "Tab 2",
        textInput("inputsidebar2", "Caption", "Data Summary")
      ),
      rightSidebarTabContent(
        id = 3,
        icon = "paint-brush",
        title = "Tab 3",
        numericInput("inputsidebar3", "Observations:", 10, min = 1, max = 100)
      )
    ),
    dashboardBody(
      
      setShadow("dropdown-menu"),
      
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
      
      tabItems(
        
        tabItem(
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
            theme = "vibrant_ink",
            mode = "r",
            height = "600px",
            outputId = "rightsidebar_code",
            readOnly = TRUE,
            value = paste(style_text('library(shiny)
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
            )'), collapse = "\n")
          )
          
        ),
        
        tabItem(
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
            theme = "vibrant_ink",
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
                )
                '
              ), 
              collapse = "\n"
            )
          )
          
        ),
        
        tabItem(
          tabName = "boxes",
          
          br(),
          
          column(
            width = 12,
            align = "center",
            h1("boxPlus(): closable and labels")
          ),
          br(),
          
          fluidRow(
            # demo enhanced classic boxes from shinydashboard
            boxPlus(
              title = "Closable Box with dropdown", 
              closable = TRUE, 
              status = "warning", 
              solidHeader = FALSE, 
              collapsible = TRUE,
              enable_dropdown = TRUE,
              dropdown_icon = "wrench",
              dropdown_menu = dropdownItemList(
                dropdownItem(url = "http://www.google.com", name = "Link to google"),
                dropdownItem(url = "#", name = "item 2"),
                dropdownDivider(),
                dropdownItem(url = "#", name = "item 3")
              ),
              p("Box Content")
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "300px",
              outputId = "boxplus1_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'boxPlus(
                   title = "Closable Box with dropdown", 
                    closable = TRUE, 
                    status = "warning", 
                    solidHeader = FALSE, 
                    collapsible = TRUE,
                    enable_dropdown = TRUE,
                    dropdown_icon = "wrench",
                    dropdown_menu = dropdownItemList(
                     dropdownItem(url = "http://www.google.com", name = "Link to google"),
                     dropdownItem(url = "#", name = "item 2"),
                     dropdownDivider(),
                     dropdownItem(url = "#", name = "item 3")
                    ),
                    p("Box Content")
                  )'
                ), 
                collapse = "\n"
              )
            )
            
          ),
          
          fluidRow(
            boxPlus(
              title = "Closable box, with label", 
              closable = TRUE, 
              enable_label = TRUE,
              label_text = 1,
              label_status = "danger",
              status = "warning", 
              solidHeader = FALSE, 
              collapsible = TRUE,
              p("Box Content")
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "200px",
              outputId = "boxplus2_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'boxPlus(
                  title = "Closable box, with label", 
                  closable = TRUE, 
                  enable_label = TRUE,
                  label_text = 1,
                  label_status = "danger",
                  status = "warning", 
                  solidHeader = FALSE, 
                  collapsible = TRUE,
                  p("Box Content")
                )'
                ), 
                collapse = "\n"
              )
            )
            
          ),
          
          
          br(),
          column(
            width = 12,
            align = "center",
            h1("gradientBox()")
          ),
          br(),
          
          fluidRow(
            gradientBox(
              title = "My gradient Box",
              icon = "fa fa-th",
              gradientColor = "teal", 
              boxToolSize = "sm", 
              footer = column(
                width = 12,
                align = "center",
                sliderInput(
                  "obs", 
                  "Number of observations:",
                  min = 0, max = 1000, value = 500
                )
              ),
              plotOutput("distPlot")
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "400px",
              outputId = "gradientbox1_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'gradientBox(
                  title = "My gradient Box",
                  icon = "fa fa-th",
                  gradientColor = "teal", 
                  boxToolSize = "sm", 
                  footer = column(
                  width = 12,
                  align = "center",
                  sliderInput(
                  "obs", 
                  "Number of observations:",
                  min = 0, max = 1000, value = 500
                  )
                  ),
                  plotOutput("distPlot")
                )'
                ), 
                collapse = "\n"
              )
            )
            
          ),
          
          fluidRow(
            # demo gradient boxes
            gradientBox(
              title = "My gradient Box",
              icon = "fa fa-heart",
              gradientColor = "maroon", 
              boxToolSize = "xs", 
              closable = TRUE,
              footer = "The footer goes here. You can include anything",
              "This is a gradient box"
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "200px",
              outputId = "gradientbox2_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'gradientBox(
                  title = "My gradient Box",
                  icon = "fa fa-heart",
                  gradientColor = "maroon", 
                  boxToolSize = "xs", 
                  closable = TRUE,
                  footer = "The footer goes here. You can include anything",
                  "This is a gradient box"
                )'
                ), 
                collapse = "\n"
              )
            )
            
          ),
          
          br(),
          column(
            width = 12,
            align = "center",
            h1("widgetUserBox()")
          ),
          br(),
          
          fluidRow(
            widgetUserBox(
              title = "Nadia Carmichael",
              subtitle = "lead Developer",
              type = 2,
              src = "https://adminlte.io/themes/AdminLTE/dist/img/user7-128x128.jpg",
              color = "yellow",
              "Some text here!",
              footer = "The footer here!"
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "200px",
              outputId = "widgetuserbox1_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'widgetUserBox(
                  title = "Nadia Carmichael",
                  subtitle = "lead Developer",
                  type = 2,
                  src = "https://adminlte.io/themes/AdminLTE/dist/img/user7-128x128.jpg",
                  color = "yellow",
                  "Some text here!",
                  footer = "The footer here!"
                )'
                ), 
                collapse = "\n"
              )
            )
            
          ),
          
          fluidRow(
            widgetUserBox(
              title = "Alexander Pierce",
              subtitle = "Founder & CEO",
              type = NULL,
              src = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
              color = "aqua-active",
              closable = TRUE,
              "Some text here!",
              footer = "The footer here!"
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "200px",
              outputId = "widgetuserbox2_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'widgetUserBox(
                  title = "Alexander Pierce",
                  subtitle = "Founder & CEO",
                  type = NULL,
                  src = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
                  color = "aqua-active",
                  closable = TRUE,
                  "Some text here!",
                  footer = "The footer here!"
                )'
                ), 
                collapse = "\n"
              )
            )
            
          ),
          
          fluidRow(
            widgetUserBox(
              title = "Elizabeth Pierce",
              subtitle = "Web Designer",
              type = NULL,
              src = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
              background = TRUE,
              backgroundUrl = "https://images.pexels.com/photos/531880/pexels-photo-531880.jpeg?auto=compress&cs=tinysrgb&h=350",
              closable = TRUE,
              "Some text here!",
              footer = "The footer here!"
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "200px",
              outputId = "widgetuserbox3_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'widgetUserBox(
                  title = "Elizabeth Pierce",
                  subtitle = "Web Designer",
                  type = NULL,
                  src = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
                  background = TRUE,
                  backgroundUrl = "https://images.pexels.com/photos/531880/pexels-photo-531880.jpeg?auto=compress&cs=tinysrgb&h=350",
                  closable = TRUE,
                  "Some text here!",
                  footer = "The footer here!"
                )'
                ), 
                collapse = "\n"
              )
            )
            
          ),
          
          br(),
          column(
            width = 12,
            align = "center",
            h1("socialBox()")
          ),
          br(),
          
          fluidRow(
            # demo social box
            socialBox(
              title = "Social Box",
              subtitle = "example-01.05.2018",
              src = "https://adminlte.io/themes/AdminLTE/dist/img/user4-128x128.jpg",
              "Some text here!",
              attachmentBlock(
                src = "http://kiev.carpediem.cd/data/afisha/o/2d/c7/2dc7670333.jpg",
                title = "Test",
                title_url = "http://google.com",
                "This is the content"
              ),
              comments = tagList(
                boxComment(
                  src = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
                  title = "Comment 1",
                  date = "01.05.2018",
                  "The first comment"
                ),
                boxComment(
                  src = "https://adminlte.io/themes/AdminLTE/dist/img/user5-128x128.jpg",
                  title = "Comment 2",
                  date = "01.05.2018",
                  "The second comment"
                )
              ),
              footer = "The footer here!"
            ),
            
            aceEditor(
              outputId = "socialBox_code",
              readOnly = TRUE,
              theme = "vibrant_ink",
              mode = "r",
              wordWrap = TRUE,
              value = paste(
                style_text(
                  'socialBox(
                  title = "Social Box",
                  subtitle = "example-01.05.2018",
                  src = "https://adminlte.io/themes/AdminLTE/dist/img/user4-128x128.jpg",
                  "Some text here!",
                  attachmentBlock(
                  src = "http://kiev.carpediem.cd/data/afisha/o/2d/c7/2dc7670333.jpg",
                  title = "Test",
                  title_url = "http://google.com",
                  "This is the content"
                  ),
                  comments = tagList(
                  boxComment(
                  src = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
                  title = "Comment 1",
                  date = "01.05.2018",
                  "The first comment"
                  ),
                  boxComment(
                  src = "https://adminlte.io/themes/AdminLTE/dist/img/user5-128x128.jpg",
                  title = "Comment 2",
                  date = "01.05.2018",
                  "The second comment"
                  )
                  ),
                  footer = "The footer here!"
                )'
                ), 
                collapse = "\n"
              )
            )
          ),
          
          
          br(),
          column(
            width = 12,
            align = "center",
            h1("flipBox()")
          ),
          br(),
          
          fluidRow(
            # demo flip box
            column(
              width = 6,
              align = "center",
              flipBox(
                id = 1,
                main_img = "https://image.flaticon.com/icons/svg/149/149076.svg",
                header_img = "https://image.flaticon.com/icons/svg/119/119595.svg",
                front_title = "John Doe",
                back_title = "About John",
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, 
                sed do eiusmod tempor incididunt ut labore et dolore magna 
                aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
                ullamco laboris nisi ut aliquip ex ea commodo consequat. 
                Duis aute irure dolor in reprehenderit in voluptate velit 
                esse cillum dolore eu fugiat nulla pariatur. Excepteur sint 
                occaecat cupidatat non proident, sunt in culpa qui officia 
                deserunt mollit anim id est laborum",
                verticalProgress(
                  value = 10,
                  striped = TRUE,
                  active = TRUE
                ),
                verticalProgress(
                  value = 50,
                  active = TRUE,
                  status = "warning",
                  size = "xs"
                ),
                verticalProgress(
                  value = 20,
                  status = "danger",
                  size = "sm",
                  height = "60%"
                ),
                back_content = tagList(
                  column(
                    width = 12,
                    align = "center",
                    sliderInput(
                      "flip_obs", 
                      "Number of observations:",
                      min = 0, 
                      max = 1000, 
                      value = 500
                    )
                  ),
                  plotOutput("flipPlot")
                )
              )
            ),
            
            column(
              width = 6,
              align = "center",
              aceEditor(
                outputId = "flipBox_code",
                readOnly = TRUE,
                theme = "vibrant_ink",
                mode = "r",
                wordWrap = TRUE,
                value = paste(
                  style_text(
                    'flipBox(
                    id = 1,
                    main_img = "https://image.flaticon.com/icons/svg/149/149076.svg",
                    header_img = "https://image.flaticon.com/icons/svg/119/119595.svg",
                    front_title = "John Doe",
                    back_title = "About John",
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, 
                    sed do eiusmod tempor incididunt ut labore et dolore magna 
                    aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
                    ullamco laboris nisi ut aliquip ex ea commodo consequat. 
                    Duis aute irure dolor in reprehenderit in voluptate velit 
                    esse cillum dolore eu fugiat nulla pariatur. Excepteur sint 
                    occaecat cupidatat non proident, sunt in culpa qui officia 
                    deserunt mollit anim id est laborum",
                    verticalProgress(
                    value = 10,
                    striped = TRUE,
                    active = TRUE
                    ),
                    verticalProgress(
                    value = 50,
                    active = TRUE,
                    status = "warning",
                    size = "xs"
                    ),
                    verticalProgress(
                    value = 20,
                    status = "danger",
                    size = "sm",
                    height = "60%"
                    ),
                    back_content = tagList(
                    column(
                    width = 12,
                    align = "center",
                    sliderInput(
                    "obs", 
                    "Number of observations:",
                    min = 0, 
                    max = 1000, 
                    value = 500
                    )
                    ),
                    plotOutput("distPlot")
                    )
                  )'
                  ), 
                  collapse = "\n"
                )
              )
            )
          )
        ),
        
        
        tabItem(
          tabName = "buttons",
          
          br(),
          
          column(
            width = 12,
            align = "center",
            h1("appButton()")
          ),
          br(),
          
          fluidRow(
            # demo app buttons
            box(
              width = 6,
              title = "App Buttons",
              status = NULL,
              appButton(
                url = "http://google.com",
                label = "Users", 
                icon = "fa fa-users", 
                enable_badge = TRUE, 
                badgeColor = "purple", 
                badgeLabel = 891
              ),
              appButton(
                label = "Edit", 
                icon = "fa fa-edit", 
                enable_badge = FALSE, 
                badgeColor = NULL, 
                badgeLabel = NULL
              ),
              appButton(
                label = "Likes", 
                icon = "fa fa-heart-o", 
                enable_badge = TRUE, 
                badgeColor = "red", 
                badgeLabel = 3
              )
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "200px",
              outputId = "appbutton_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'box(
                    title = "App Buttons",
                    status = NULL,
                    appButton(
                    url = "http://google.com",
                    label = "Users", 
                    icon = "fa fa-users", 
                    enable_badge = TRUE, 
                    badgeColor = "purple", 
                    badgeLabel = 891
                    ),
                    appButton(
                    label = "Edit", 
                    icon = "fa fa-edit", 
                    enable_badge = FALSE, 
                    badgeColor = NULL, 
                    badgeLabel = NULL
                    ),
                    appButton(
                    label = "Likes", 
                    icon = "fa fa-heart-o", 
                    enable_badge = TRUE, 
                    badgeColor = "red", 
                    badgeLabel = 3
                    )
                  )'
                ), 
                collapse = "\n"
              )
            )
            
          ),
          
          column(
            width = 12,
            align = "center",
            h1("socialButton()")
          ),
          br(),
          
          fluidRow(
            # demo social button
            box(
              width = 6,
              title = "Social Buttons",
              status = NULL,
              socialButton(
                url = "http://dropbox.com",
                type = "dropbox"
              ),
              socialButton(
                url = "http://github.com",
                type = "github"
              )
            ),
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "200px",
              outputId = "socialbutton_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'box(
                    title = "Social Buttons",
                    status = NULL,
                    socialButton(
                    url = "http://dropbox.com",
                    type = "dropbox"
                    ),
                    socialButton(
                    url = "http://github.com",
                    type = "github"
                    )
                  )'
                ), 
                collapse = "\n"
              )
            )
          )
        ),
        
        tabItem(
          tabName = "boxelements",
          
          br(),
          
          column(
            width = 12,
            align = "center",
            h1("Create box with sidebar")
          ),
          br(),
          
          fluidRow(
            column(
              width = 6,
              boxPlus(
                width = 12,
                title = "boxPlus with sidebar", 
                closable = TRUE, 
                status = "warning", 
                solidHeader = FALSE, 
                collapsible = TRUE,
                enable_sidebar = TRUE,
                sidebar_width = 25,
                sidebar_start_open = TRUE,
                sidebar_content = tagList(
                  checkboxInput("somevalue", "Some value", FALSE),
                  verbatimTextOutput("value"),
                  sliderInput(
                    "slider_boxsidebar", 
                    "Number of observations:",
                    min = 0, 
                    max = 1000, 
                    value = 500
                  )
                ),
                plotOutput("boxSidebarPlot")
              )
            ),
            
            column(
              width = 6,
              aceEditor(
                theme = "vibrant_ink",
                mode = "r",
                height = "300px",
                outputId = "boxPlus-sidebar_code",
                readOnly = TRUE,
                value = paste(
                  style_text(
                    'boxPlus(
                    width = 12,
                    title = "boxPlus with sidebar", 
                    closable = TRUE, 
                    status = "warning", 
                    solidHeader = FALSE, 
                    collapsible = TRUE,
                    enable_sidebar = TRUE,
                    sidebar_width = 25,
                    sidebar_start_open = TRUE,
                    sidebar_content = tagList(
                    checkboxInput("somevalue", "Some value", FALSE),
                    verbatimTextOutput("value"),
                    sliderInput(
                    "slider_boxsidebar", 
                    "Number of observations:",
                    min = 0, 
                    max = 1000, 
                    value = 500
                    )
                    ),
                    plotOutput("boxSidebarPlot")
                  )
                    '
                  ), 
                  collapse = "\n"
                )
              )
            )
          ),
          
          column(
            width = 12,
            align = "center",
            h1("descriptionBlock()")
          ),
          br(),
          
          fluidRow(
            column(
              width = 6,
              #align = "center",
              # descriptionBlock demo in footer
              box(
                solidHeader = FALSE,
                title = "Status summary",
                background = NULL,
                width = 12,
                status = "danger",
                footer = fluidRow(
                  column(
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
                  column(
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
            ),
            
            column(
              width = 6,
              aceEditor(
                theme = "vibrant_ink",
                mode = "r",
                height = "200px",
                outputId = "descriptionblock_code",
                readOnly = TRUE,
                value = paste(
                  style_text(
                    'box(
                    solidHeader = FALSE,
                    title = "Status summary",
                    background = NULL,
                    width = 4,
                    status = "danger",
                    footer = fluidRow(
                    column(
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
                    column(
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
                  )'
                  ), 
                  collapse = "\n"
                )
              )
            )
          ),
          
          br(),
          column(
            width = 12,
            align = "center",
            h1("boxPad()")
          ),
          br(),
          
          fluidRow(
            # descriptionBlock demo in box side
            box(title = "Box with a green boxPad",
                status = "warning",
                fluidRow(
                  column(width = 6),
                  column(
                    width = 6,
                    boxPad(
                      color = "green",
                      descriptionBlock(
                        header = "8390", 
                        text = "VISITS", 
                        right_border = FALSE,
                        margin_bottom = TRUE
                      ),
                      descriptionBlock(
                        header = "30%", 
                        text = "REFERRALS", 
                        right_border = FALSE,
                        margin_bottom = TRUE
                      ),
                      descriptionBlock(
                        header = "70%", 
                        text = "ORGANIC", 
                        right_border = FALSE,
                        margin_bottom = FALSE
                      )
                    )
                  )
                )
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "300px",
              outputId = "boxPad1_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'box(title = "Box with a green boxPad",
                    status = "warning",
                    fluidRow(
                    column(width = 6),
                    column(
                    width = 6,
                    boxPad(
                    color = "green",
                    descriptionBlock(
                    header = "8390", 
                    text = "VISITS", 
                    right_border = FALSE,
                    margin_bottom = TRUE
                    ),
                    descriptionBlock(
                    header = "30%", 
                    text = "REFERRALS", 
                    right_border = FALSE,
                    margin_bottom = TRUE
                    ),
                    descriptionBlock(
                    header = "70%", 
                    text = "ORGANIC", 
                    right_border = FALSE,
                    margin_bottom = FALSE
                    )
                    )
                    )
                    )
                  )'
                ), 
                collapse = "\n"
              )
            )
          ),
          
          fluidRow(
            box(title = "Box with boxPad containing inputs",
                status = "warning",
                fluidRow(
                  column(
                    width = 6,
                    boxPad(
                      color = "gray",
                      sliderInput(
                        "obs2", 
                        "Number of observations:",
                        min = 0, max = 1000, value = 500
                      ),
                      checkboxGroupInput(
                        "variable", 
                        "Variables to show:",
                        c("Cylinders" = "cyl",
                          "Transmission" = "am",
                          "Gears" = "gear")
                      ),
                      
                      knobInput(
                        inputId = "myKnob",
                        skin = "tron",
                        readOnly = TRUE,
                        label = "Display previous:",
                        value = 50,
                        min = -100,
                        displayPrevious = TRUE,
                        fgColor = "#428BCA",
                        inputColor = "#428BCA"
                      )
                    )
                  ),
                  column(
                    width = 6,
                    plotOutput("distPlot2", height = "200px"),
                    tableOutput("data")
                  )
                )
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "500px",
              outputId = "boxPad2_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'box(title = "Box with boxPad containing inputs",
                  status = "warning",
                  fluidRow(
                  column(
                  width = 6,
                  boxPad(
                  color = "gray",
                  sliderInput(
                  "obs2", 
                  "Number of observations:",
                  min = 0, max = 1000, value = 500
                  ),
                  checkboxGroupInput(
                  "variable", 
                  "Variables to show:",
                  c("Cylinders" = "cyl",
                  "Transmission" = "am",
                  "Gears" = "gear")
                  ),
                  
                  knobInput(
                  inputId = "myKnob",
                  skin = "tron",
                  readOnly = TRUE,
                  label = "Display previous:",
                  value = 50,
                  min = -100,
                  displayPrevious = TRUE,
                  fgColor = "#428BCA",
                  inputColor = "#428BCA"
                  )
                  )
                  ),
                  column(
                  width = 6,
                  plotOutput("distPlot2", height = "200px"),
                  tableOutput("data")
                  )
                  )
                )'
                ), 
                collapse = "\n"
              )
            )
          ),
          
          
          br(),
          column(
            width = 12,
            align = "center",
            h1("userList()")
          ),
          br(),
          
          
          fluidRow(
            
            # userList examples
            box(
              title = "User List example",
              status = "success",
              userList(
                userListItem(
                  src = "https://www.rstudio.com/wp-content/uploads/2014/04/shiny.png", 
                  user_name = "Shiny", 
                  description = "28.04.2018"
                ),
                userListItem(
                  src = "https://www.rstudio.com/wp-content/uploads/2014/04/knitr.png", 
                  user_name = "knitr", 
                  description = "28.04.2018"
                ),
                userListItem(
                  src = "https://www.rstudio.com/wp-content/uploads/2017/05/rmarkdown.png", 
                  user_name = "Rmarkdown", 
                  description = "28.04.2018"
                ),
                userListItem(
                  src = "https://d33wubrfki0l68.cloudfront.net/071952491ec4a6a532a3f70ecfa2507af4d341f9/c167c/images/hex-dplyr.png", 
                  user_name = "Tidyverse", 
                  description = "28.04.2018"
                ),
                userListItem(
                  src = "https://www.rstudio.com/wp-content/uploads/2014/04/tidyr.png", 
                  user_name = "tidyr", 
                  description = "28.04.2018"
                ),
                userListItem(
                  src = "https://www.rstudio.com/wp-content/uploads/2014/04/packrat.png", 
                  user_name = "packrat", 
                  description = "28.04.2018"
                ),
                userListItem(
                  src = "https://www.rstudio.com/wp-content/uploads/2014/04/sparklyr.png", 
                  user_name = "packrat", 
                  description = "28.04.2018"
                )
              )
            ),
            
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "400px",
              outputId = "userlist_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'box(
                   title = "User List example",
                   status = "success",
                   userList(
                   userListItem(
                   src = "https://www.rstudio.com/wp-content/uploads/2014/04/shiny.png", 
                   user_name = "Shiny", 
                   description = "28.04.2018"
                   ),
                   userListItem(
                   src = "https://www.rstudio.com/wp-content/uploads/2014/04/knitr.png", 
                   user_name = "knitr", 
                   description = "28.04.2018"
                   ),
                   userListItem(
                   src = "https://www.rstudio.com/wp-content/uploads/2017/05/rmarkdown.png", 
                   user_name = "Rmarkdown", 
                   description = "28.04.2018"
                   ),
                   userListItem(
                   src = "https://d33wubrfki0l68.cloudfront.net/071952491ec4a6a532a3f70ecfa2507af4d341f9/c167c/images/hex-dplyr.png", 
                   user_name = "Tidyverse", 
                   description = "28.04.2018"
                   ),
                   userListItem(
                   src = "https://www.rstudio.com/wp-content/uploads/2014/04/tidyr.png", 
                   user_name = "tidyr", 
                   description = "28.04.2018"
                   ),
                   userListItem(
                   src = "https://www.rstudio.com/wp-content/uploads/2014/04/packrat.png", 
                   user_name = "packrat", 
                   description = "28.04.2018"
                   ),
                   userListItem(
                   src = "https://www.rstudio.com/wp-content/uploads/2014/04/sparklyr.png", 
                   user_name = "packrat", 
                   description = "28.04.2018"
                   )
                  )
                 )'
                ), 
                collapse = "\n"
              )
              
            )
          ),
          
          
          br(),
          column(
            width = 12,
            align = "center",
            h1("navPills()")
          ),
          br(),
          
          fluidRow(
            # navPills demo
            boxPlus(
              title = "Nav Pills",
              status = "info",
              footer_padding = FALSE,
              footer = navPills(
                navPillsItem(
                  active = TRUE,
                  pillName = "Item 1", 
                  pillColor = "green",
                  pillIcon = NULL, 
                  pillText = "Some text here"
                ),
                navPillsItem(
                  pillName = "Item 2", 
                  pillColor = "red",
                  pillIcon = "fa fa-angle-down", 
                  pillText = "10%"
                )
              )
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "400px",
              outputId = "navpills_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'boxPlus(
                  title = "Nav Pills",
                  status = "info",
                  footer_padding = FALSE,
                  footer = navPills(
                  navPillsItem(
                  active = TRUE,
                  pillName = "Item 1", 
                  pillColor = "green",
                  pillIcon = NULL, 
                  pillText = "Some text here"
                  ),
                  navPillsItem(
                  pillName = "Item 2", 
                  pillColor = "red",
                  pillIcon = "fa fa-angle-down", 
                  pillText = "10%"
                  )
                  )
                )'
                ), 
                collapse = "\n"
              )
              
            )
            
          ),
          
          
          br(),
          column(
            width = 12,
            align = "center",
            h1("productList()")
          ),
          br(),
          
          fluidRow(
            # product list demo
            box(
              title = "Product List",
              status = "primary",
              productList(
                productListItem(
                  src = "https://image.darty.com/hifi_video/televiseurs-led/grand_ecran_led/samsung_ue55mu9005_4k_uhd_s1703224306074A_140323143.jpg", 
                  productTitle = "Samsung TV", 
                  productPrice = "$1800", 
                  priceColor = "warning",
                  "This is an amazing TV, but I don't like TV!"
                ),
                productListItem(
                  src = "http://icon-park.com/imagefiles/imac.png", 
                  productTitle = "Imac 27", 
                  productPrice = "$2400", 
                  priceColor = "danger",
                  "This is were I spend most of my time!"
                )
              )
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "300px",
              outputId = "productlist_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'productList(
                  productListItem(
                  src = "https://image.darty.com/hifi_video/televiseurs-led/grand_ecran_led/samsung_ue55mu9005_4k_uhd_s1703224306074A_140323143.jpg", 
                  productTitle = "Samsung TV", 
                  productPrice = "$1800", 
                  priceColor = "warning",
                  "This is an amazing TV, but I don\'t like TV!"
                  ),
                  productListItem(
                  src = "http://icon-park.com/imagefiles/imac.png", 
                  productTitle = "Imac 27", 
                  productPrice = "$2400", 
                  priceColor = "danger",
                  "This is were I spend most of my time!"
                  )
                 )'
                ), 
                collapse = "\n"
              )
            )
          ),
          
          
          br(),
          column(
            width = 12,
            align = "center",
            h1("accordion()")
          ),
          br(),
          
          fluidRow(
            # demo accordion
            box(
              title = "Accordion Demo",
              accordion(
                accordionItem(
                  id = 1,
                  title = "Accordion Item 1",
                  color = "danger",
                  collapsed = TRUE,
                  "This is some text!"
                ),
                accordionItem(
                  id = 2,
                  title = "Accordion Item 2",
                  color = "warning",
                  collapsed = FALSE,
                  "This is some text!"
                ),
                accordionItem(
                  id = 3,
                  title = "Accordion Item 3",
                  color = "info",
                  collapsed = FALSE,
                  "This is some text!"
                )
              )
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "400px",
              outputId = "accordion_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'box(
                  title = "Accordion Demo",
                  accordion(
                  accordionItem(
                  id = 1,
                  title = "Accordion Item 1",
                  color = "danger",
                  collapsed = TRUE,
                  "This is some text!"
                  ),
                  accordionItem(
                  id = 2,
                  title = "Accordion Item 2",
                  color = "warning",
                  collapsed = FALSE,
                  "This is some text!"
                  ),
                  accordionItem(
                  id = 3,
                  title = "Accordion Item 3",
                  color = "info",
                  collapsed = FALSE,
                  "This is some text!"
                  )
                  )
                )'
                ), 
                collapse = "\n"
              )
            )
          ),
          
          br(),
          column(
            width = 12,
            align = "center",
            h1("todoList()")
          ),
          br(),
          
          fluidRow(
            box(
              "Sortable todo list demo",
              status = "warning",
              todoList(
                todoListItem(
                  label = "Design a nice theme",
                  "Some text here"
                ),
                todoListItem(
                  label = "Make the theme responsive",
                  "Some text here"
                ),
                todoListItem(
                  checked = TRUE,
                  label = "Let theme shine like a star"
                )
              )
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "350px",
              outputId = "todolist1_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'box(
                  "Sortable todo list demo",
                  status = "warning",
                  todoList(
                  todoListItem(
                  label = "Design a nice theme",
                  "Some text here"
                  ),
                  todoListItem(
                  label = "Make the theme responsive",
                  "Some text here"
                  ),
                  todoListItem(
                  checked = TRUE,
                  label = "Let theme shine like a star"
                  )
                  )
                )'
                ), 
                collapse = "\n"
              )
              
            ),
            
            
            box(
              "Simple todo list demo",
              status = "warning",
              todoList(
                sortable = FALSE,
                todoListItem(
                  label = "Design a nice theme",
                  "Some text here"
                ),
                todoListItem(
                  label = "Make the theme responsive",
                  "Some text here"
                ),
                todoListItem(
                  checked = TRUE,
                  label = "Let theme shine like a star"
                )
              )
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "350px",
              outputId = "todolist2_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'box(
                  "Simple todo list demo",
                  status = "warning",
                  todoList(
                  sortable = FALSE,
                  todoListItem(
                  label = "Design a nice theme",
                  "Some text here"
                  ),
                  todoListItem(
                  label = "Make the theme responsive",
                  "Some text here"
                  ),
                  todoListItem(
                  checked = TRUE,
                  label = "Let theme shine like a star"
                  )
                  )
                )'
                ), 
                collapse = "\n"
              )
            )
          ),
          
          
          br(),
          column(
            width = 12,
            align = "center",
            h1("timelineBlock()")
          ),
          br(),
          
          fluidRow(
            box(
              title = "Reversed Timeline: ideal to include in a box",
              status = "info",
              timelineBlock(
                timelineEnd(color = "danger"),
                timelineLabel(2018, color = "teal"),
                timelineItem(
                  title = "Item 1",
                  icon = "gears",
                  color = "olive",
                  time = "now",
                  footer = "Here is the footer",
                  "This is the body"
                ),
                timelineItem(
                  title = "Item 2",
                  border = FALSE
                ),
                timelineLabel(2015, color = "orange"),
                timelineItem(
                  title = "Item 3",
                  icon = "paint-brush",
                  color = "maroon",
                  timelineItemMedia(src = "http://placehold.it/150x100"),
                  timelineItemMedia(src = "http://placehold.it/150x100")
                ),
                timelineStart(color = "gray")
              )
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "700px",
              outputId = "timelineBlock1_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'box(
                   title = "Timeline",
                   status = "info",
                   timelineBlock(
                    timelineEnd(color = "danger"),
                    timelineLabel(2018, color = "teal"),
                    timelineItem(
                     title = "Item 1",
                     icon = "gears",
                     color = "olive",
                     time = "now",
                     footer = "Here is the footer",
                     "This is the body"
                    ),
                    timelineItem(
                     title = "Item 2",
                     border = FALSE
                    ),
                    timelineLabel(2015, color = "orange"),
                    timelineItem(
                     title = "Item 3",
                     icon = "paint-brush",
                     color = "maroon",
                     timelineItemMedia(src = "http://placehold.it/150x100"),
                     timelineItemMedia(src = "http://placehold.it/150x100")
                    ),
                    timelineStart(color = "gray")
                   )
                  )'
                ), 
                collapse = "\n"
              )
            )
          ),
          
          fluidRow(
            h3("Timeline non reversed: ideal to include oustide of a box"),
            column(
              width = 6,
              timelineBlock(
                reversed = FALSE,
                timelineEnd(color = "danger"),
                timelineLabel(2018, color = "teal"),
                timelineItem(
                  title = "Item 1",
                  icon = "gears",
                  color = "olive",
                  time = "now",
                  footer = "Here is the footer",
                  "This is the body"
                ),
                timelineItem(
                  title = "Item 2",
                  border = FALSE
                ),
                timelineLabel(2015, color = "orange"),
                timelineItem(
                  title = "Item 3",
                  icon = "paint-brush",
                  color = "maroon",
                  timelineItemMedia(src = "http://placehold.it/150x100"),
                  timelineItemMedia(src = "http://placehold.it/150x100")
                ),
                timelineStart(color = "gray")
              )
            ),
            
            column(
              width = 6,
              aceEditor(
                theme = "vibrant_ink",
                mode = "r",
                height = "600px",
                outputId = "timelineBlock2_code",
                readOnly = TRUE,
                value = paste(
                  style_text(
                    'timelineBlock(
                      reversed = FALSE,
                      timelineEnd(color = "danger"),
                      timelineLabel(2018, color = "teal"),
                      timelineItem(
                      title = "Item 1",
                      icon = "gears",
                      color = "olive",
                      time = "now",
                      footer = "Here is the footer",
                      "This is the body"
                      ),
                      timelineItem(
                      title = "Item 2",
                      border = FALSE
                      ),
                      timelineLabel(2015, color = "orange"),
                      timelineItem(
                      title = "Item 3",
                      icon = "paint-brush",
                      color = "maroon",
                      timelineItemMedia(src = "http://placehold.it/150x100"),
                      timelineItemMedia(src = "http://placehold.it/150x100")
                      ),
                      timelineStart(color = "gray")
                    )'
                  ), 
                  collapse = "\n"
                )
              )
            )
          ),
          
          br(),
          column(
            width = 12,
            align = "center",
            h1("boxProfile()")
          ),
          br(),
          
          fluidRow(
            box(
              title = "Box with profile",
              status = "primary",
              boxProfile(
                src = "https://adminlte.io/themes/AdminLTE/dist/img/user4-128x128.jpg",
                title = "Nina Mcintire",
                subtitle = "Software Engineer",
                boxProfileItemList(
                  bordered = TRUE,
                  boxProfileItem(
                    title = "Followers",
                    description = 1322
                  ),
                  boxProfileItem(
                    title = "Following",
                    description = 543
                  ),
                  boxProfileItem(
                    title = "Friends",
                    description = 13287
                  )
                )
              )
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "350px",
              outputId = "boxProfile_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'box(
                  title = "Box with profile",
                  status = "primary",
                  boxProfile(
                  src = "https://adminlte.io/themes/AdminLTE/dist/img/user4-128x128.jpg",
                  title = "Nina Mcintire",
                  subtitle = "Software Engineer",
                  boxProfileItemList(
                  bordered = TRUE,
                  boxProfileItem(
                  title = "Followers",
                  description = 1322
                  ),
                  boxProfileItem(
                  title = "Following",
                  description = 543
                  ),
                  boxProfileItem(
                  title = "Friends",
                  description = 13287
                  )
                  )
                  )
                 )'
                ), 
                collapse = "\n"
              )
            )
          ),
          
          
          br(),
          column(
            width = 12,
            align = "center",
            h1("userPost()")
          ),
          br(),
          
          fluidRow(
            box(
              title = "Box with user comment",
              status = "primary",
              userPost(
                id = 1,
                src = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
                author = "Jonathan Burke Jr.",
                description = "Shared publicly - 7:30 PM today",
                "Lorem ipsum represents a long-held tradition for designers, 
              typographers and the like. Some people hate it and argue for 
              its demise, but others ignore the hate as they create awesome 
              tools to help create filler text for everyone from bacon 
              lovers to Charlie Sheen fans.",
                userPostToolItemList(
                  userPostToolItem(dashboardLabel("item 1")),
                  userPostToolItem(dashboardLabel("item 2", status = "danger"), side = "right")
                )
              ),
              userPost(
                id = 2,
                src = "https://adminlte.io/themes/AdminLTE/dist/img/user6-128x128.jpg",
                author = "Adam Jones",
                description = "Shared publicly - 5 days ago",
                userPostMedia(src = "https://adminlte.io/themes/AdminLTE/dist/img/photo2.png"),
                userPostToolItemList(
                  userPostToolItem(dashboardLabel("item 1")),
                  userPostToolItem(dashboardLabel("item 2", status = "danger"), side = "right")
                )
              )
            ),
            
            aceEditor(
              theme = "vibrant_ink",
              mode = "r",
              height = "500px",
              outputId = "userPost_code",
              readOnly = TRUE,
              value = paste(
                style_text(
                  'box(
                    title = "Box with user comment",
                    status = "primary",
                    userPost(
                     id = 1,
                     src = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
                     author = "Jonathan Burke Jr.",
                     description = "Shared publicly - 7:30 PM today",
                     "Lorem ipsum represents a long-held tradition for designers, 
                     typographers and the like. Some people hate it and argue for 
                     its demise, but others ignore the hate as they create awesome 
                     tools to help create filler text for everyone from bacon 
                     lovers to Charlie Sheen fans.",
                     userPostToolItemList(
                      userPostToolItem(dashboardLabel("item 1")),
                      userPostToolItem(dashboardLabel("item 2", status = "danger"), side = "right")
                     )
                    ),
                    userPost(
                     id = 2,
                     src = "https://adminlte.io/themes/AdminLTE/dist/img/user6-128x128.jpg",
                     author = "Adam Jones",
                     description = "Shared publicly - 5 days ago",
                     userPostMedia(src = "https://adminlte.io/themes/AdminLTE/dist/img/photo2.png"),
                     userPostToolItemList(
                      userPostToolItem(dashboardLabel("item 1")),
                      userPostToolItem(dashboardLabel("item 2", status = "danger"), side = "right")
                     )
                    )
                  )'
                ), 
                collapse = "\n"
              )
            )
          )
          
        ),
        
        tabItem(
          tabName = "extracss",
          
          br(),
        
          column(
            width = 12,
            align = "center",
            h1("Add shadows to any dashboard element: setShadow()")
          ),
          br(),
          
          fluidRow(
            column(
              width = 6,
              setShadow("box"),
              box(
                width = 12,
                background = "light-blue",
                p("This is content. The background color is set to light-blue")
              )
            ),
            
            column(
              width = 6,
              aceEditor(
                theme = "vibrant_ink",
                mode = "r",
                height = "300px",
                outputId = "box-shadow_code",
                readOnly = TRUE,
                value = paste(
                  style_text(
                    'setShadow("box")
                     box(
                       width = 12,
                       background = "light-blue",
                       p("This is content. The background color is set to light-blue")
                     )
                    '
                  ), 
                  collapse = "\n"
                )
              )
            )
          )
          
          
        ),
        
        tabItem(
          tabName = "extraelements",
          
          fluidRow(
            
            br(),
            
            column(
              width = 12,
              align = "center",
              h1("loadingState()")
            ),
            br(),
            
            fluidRow(
              # demo loading spinner
              box(
                title = "loading spinner",
                loadingState()
              ),
              
              aceEditor(
                theme = "vibrant_ink",
                mode = "r",
                height = "20px",
                outputId = "loadingstate_code",
                readOnly = TRUE,
                value = paste(
                  style_text(
                    'loadingState()'
                  ), 
                  collapse = "\n"
                )
              )
              
            ),
            
            
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("blockQuote()")
            ),
            br(),
            
            fluidRow(
              # demo  blockQuote
              box(
                title = "BlockQuote example",
                blockQuote("I quote some text here!")
              ),
              box(
                title = "BlockQuote example",
                blockQuote("I quote some text here!", side = "right")
              ),
              
              column(
                width = 6,
                aceEditor(
                  theme = "vibrant_ink",
                  mode = "r",
                  height = "20px",
                  outputId = "blockquote1_code",
                  readOnly = TRUE,
                  value = paste(
                    style_text(
                      'blockQuote("I quote some text here!")'
                    ), 
                    collapse = "\n"
                  )
                )
              ),
              
              column(
                width = 6,
                aceEditor(
                  theme = "vibrant_ink",
                  mode = "r",
                  height = "20px",
                  outputId = "blockquote2_code",
                  readOnly = TRUE,
                  value = paste(
                    style_text(
                      'blockQuote("I quote some text here!", side = "right")'
                    ), 
                    collapse = "\n"
                  )
                )
              )
              
              
            ),
            
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("dashboardLabel()")
            ),
            br(),
            
            fluidRow(
              # demo dashboardLabel
              dashboardLabel("Label 1", status = "info"),
              dashboardLabel("Label 2", status = "success"),
              dashboardLabel("Label 3", status = "warning"),
              dashboardLabel("Label 4", status = "primary"),
              dashboardLabel("Label 5", status = "danger"),
              
              aceEditor(
                theme = "vibrant_ink",
                mode = "r",
                height = "100px",
                outputId = "dahboardlabel_code",
                readOnly = TRUE,
                value = paste(
                  style_text(
                    'dashboardLabel("Label 1", status = "info")
                     dashboardLabel("Label 2", status = "success")
                     dashboardLabel("Label 3", status = "warning")
                     dashboardLabel("Label 4", status = "primary")
                     dashboardLabel("Label 5", status = "danger")'
                  ), 
                  collapse = "\n"
                )
              )
              
            ),
            
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("starBlock()")
            ),
            br(),
            
            fluidRow(
              # demo starBlock
              box(
                title = "Star example",
                starBlock(grade = 5),
                starBlock(grade = 5, color = "olive"),
                starBlock(grade = 1, color = "maroon"),
                starBlock(grade = 3, color = "teal")
              ),
              
              aceEditor(
                theme = "vibrant_ink",
                mode = "r",
                height = "100px",
                outputId = "starblock_code",
                readOnly = TRUE,
                value = paste(
                  style_text(
                    'box(
                    title = "Star example",
                    starBlock(grade = 5),
                    starBlock(grade = 5, color = "olive"),
                    starBlock(grade = 1, color = "maroon"),
                    starBlock(grade = 3, color = "teal")
                   )'
                  ), 
                  collapse = "\n"
                )
              )
              
            ),
            
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("attachmentBlock()")
            ),
            br(),
            
            fluidRow(
              # demo attachment block
              box(
                title = "Attachment example",
                attachmentBlock(
                  src = "http://kiev.carpediem.cd/data/afisha/o/2d/c7/2dc7670333.jpg",
                  title = "Test",
                  title_url = "http://google.com",
                  "This is the content"
                )
              ),
              
              aceEditor(
                theme = "vibrant_ink",
                mode = "r",
                height = "100px",
                outputId = "attachmentblock_code",
                readOnly = TRUE,
                value = paste(
                  style_text(
                    'attachmentBlock(
                     src = "http://kiev.carpediem.cd/data/afisha/o/2d/c7/2dc7670333.jpg",
                    title = "Test",
                    title_url = "http://google.com",
                    "This is the content"
                   )'
                  ), 
                  collapse = "\n"
                )
              )
              
            ),
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("rightSidebarMenu()")
            ),
            br(),
            
            fluidRow(
              # demo rightSidebarMenu
              box(
                title = "rightSidebarMenu",
                rightSidebarMenu(
                  rightSidebarMenuItem(
                    icon = menuIcon(
                      name = "birthday-cake",
                      color = "red"
                    ),
                    info = menuInfo(
                      title = "Langdon's Birthday",
                      description = "Will be 23 on April 24th"
                    )
                  ),
                  rightSidebarMenuItem(
                    icon = menuIcon(
                      name = "user",
                      color = "yellow"
                    ),
                    info = menuInfo(
                      title = "Frodo Updated His Profile",
                      description = "New phone +1(800)555-1234"
                    )
                  )
                )
              ),
              
              aceEditor(
                theme = "vibrant_ink",
                mode = "r",
                height = "400px",
                outputId = "rightSidebarMenu_code",
                readOnly = TRUE,
                value = paste(
                  style_text(
                    'box(
                    title = "rightSidebarMenu example",
                    rightSidebarMenu(
                    rightSidebarMenuItem(
                    icon = menuIcon(
                    name = "birthday-cake",
                    color = "red"
                    ),
                    info = menuInfo(
                    title = "Langdon\'s Birthday",
                    description = "Will be 23 on April 24th"
                    )
                    ),
                    rightSidebarMenuItem(
                    icon = menuIcon(
                    name = "user",
                    color = "yellow"
                    ),
                    info = menuInfo(
                    title = "Frodo Updated His Profile",
                    description = "New phone +1(800)555-1234"
                    )
                    )
                    )
                  )'
                  ), 
                  collapse = "\n"
                )
              )
              
            ),
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("verticalProgress()")
            ),
            br(),
            
            fluidRow(
              # demo rightSidebarMenu
              box(
                title = "verticalProgress",
                verticalProgress(
                  value = 10,
                  striped = TRUE,
                  active = TRUE
                ),
                verticalProgress(
                  value = 50,
                  active = TRUE,
                  status = "warning",
                  size = "xs"
                ),
                verticalProgress(
                  value = 20,
                  status = "danger",
                  size = "sm",
                  height = "60%"
                )
              ),
              
              aceEditor(
                theme = "vibrant_ink",
                mode = "r",
                height = "350px",
                outputId = "verticalProgress_code",
                readOnly = TRUE,
                value = paste(
                  style_text(
                    'box(
                     title = "verticalProgress",
                     verticalProgress(
                       value = 10,
                       striped = TRUE,
                       active = TRUE
                     ),
                     verticalProgress(
                       value = 50,
                       active = TRUE,
                       status = "warning",
                       size = "xs"
                     ),
                     verticalProgress(
                       value = 20,
                       status = "danger",
                       size = "sm",
                       height = "60%"
                     )
                    )'
                  ), 
                  collapse = "\n"
                )
              )
            )
          )
        )
       )
      ),
      title = "shinyDashboardPlus"
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
      
    }
  )