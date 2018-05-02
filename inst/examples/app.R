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
      title = "shinyDashboardPlus",
      enable_rightsidebar = TRUE,
      rightSidebarIcon = "bars"
    ),
    dashboardSidebar(
      sidebarMenu(
        menuItem("New rightSidebar", tabName = "rightsidebar",
                 badgeLabel = "new", badgeColor = "green"),
        menuItem("New boxes", tabName = "boxes",
                 badgeLabel = "new", badgeColor = "green"),
        menuItem("New buttons", tabName = "buttons",
                 badgeLabel = "new", badgeColor = "green"),
        menuItem("New Box elements", tabName = "boxelements",
                 badgeLabel = "new", badgeColor = "green"),
        menuItem("New extra elements", tabName = "extraelements",
                 badgeLabel = "new", badgeColor = "green")
      )
    ),
    rightsidebar = rightSidebar(
      background = "dark",
      rightSidebarTabList(
        rightSidebarTabItem(
          id = 1,
          icon = "desktop"
        ),
        rightSidebarTabItem(
          id = 2
        ),
        rightSidebarTabItem(
          id = 3,
          icon = "paint-brush"
        )
      ),
      rigthSidebarPanel(
        rightSidebarTabContent(
          id = 1,
          title = "Tab 1",
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
          title = "Tab 3",
          numericInput("inputsidebar3", "Observations:", 10, min = 1, max = 100)
        )
      )
    ),
    dashboardBody(
      
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
            rightSidebarTabList(
            rightSidebarTabItem(
            id = 1,
            icon = "desktop"
            ),
            rightSidebarTabItem(
            id = 2
            ),
            rightSidebarTabItem(
            id = 3,
            icon = "paint-brush"
            )
            ),
            rigthSidebarPanel(
            rightSidebarTabContent(
            id = 1,
            title = "Tab 1",
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
            title = "Tab 3",
            numericInput("obs", "Observations:", 10, min = 1, max = 100)
            )
            )
            ),
            title = "Right Sidebar"
            ),
            server = function(input, output) { }
            )'), collapse = "\n")
          )
          
        ),
        
        tabItem(
          tabName = "boxes",
          
          fluidRow(
            
            column(
              width = 12,
              align = "center",
              h1("boxPlus(): closable and labels")
            ),
            br(),
            
            
            # demo enhanced classic boxes from shinydashboard
            column(
              width = 12,
              boxPlus(
                title = "Closable Box", 
                closable = TRUE, 
                label_status = "danger",
                status = "warning", 
                solidHeader = FALSE, 
                collapsible = TRUE,
                p("Box Content")
              ),
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
              )
            ),
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("gradientBox()")
            ),
            br(),
            
            column(
              width = 12,
              # demo gradient box
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
              gradientBox(
                title = "My gradient Box",
                icon = "fa fa-heart",
                gradientColor = "maroon", 
                boxToolSize = "xs", 
                closable = TRUE,
                footer = "The footer goes here. You can include anything",
                "This is a gradient box"
              )
            ),
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("widgetUserBox()")
            ),
            br(),
            
            column(
              width = 12,
              # demo widgetUserBox
              widgetUserBox(
                title = "Nadia Carmichael",
                subtitle = "lead Developer",
                type = 2,
                src = "https://adminlte.io/themes/AdminLTE/dist/img/user7-128x128.jpg",
                color = "yellow",
                "Some text here!",
                footer = "The footer here!"
              ),
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
              )
            ),
            
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("socialBox()")
            ),
            br(),
            
            
            column(
              width = 12,
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
                 value = paste(style_text('socialBox(
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
               )'), collapse = "\n")
              )
            )
            
          )
          
        ),
        
        
        tabItem(
          tabName = "buttons",
          
          fluidRow(
            
            column(
              width = 12,
              align = "center",
              h1("appButton()")
            ),
            br(),
            
            column(
              width = 12,
              align = "center",
              # demo app buttons
              box(
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
              )
            ),
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("socialButton()")
            ),
            br(),
            
            column(
              width = 12,
              align = "center",
              # demo social button
              box(
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
              )
            )
            
          )
        ),
        
        tabItem(
          tabName = "boxelements",
          
          fluidRow(
            
            column(
              width = 12,
              align = "center",
              h1("descriptionBlock()")
            ),
            br(),
            
            column(
              width = 12,
              align = "center",
              # descriptionBlock demo in footer
              box(
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
              )
            ),
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("boxPad()")
            ),
            br(),
            
            column(
              width = 12,
              align = "center",
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
              )
              
            ),
            
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("userList()")
            ),
            br(),
            
            column(
              width = 12,
              align = "center",
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
              )
              
            ),
            
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("navPills()")
            ),
            br(),
            
            column(
              width = 12,
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
              )
            ),
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("productList()")
            ),
            br(),
            
            column(
              width = 12,
              align = "center",
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
              )
            ),
            
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("accordion()")
            ),
            br(),
            
            column(
              width = 12,
              align = "center",
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
              )
            ),
            
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("todoList()")
            ),
            br(),
            
            column(
              width = 12,
              #align = "center",
              # demo todo list
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
              )
            )
            
            
          )
        ),
        
        
        tabItem(
          tabName = "extraelements",
          
          fluidRow(
            
            column(
              width = 12,
              align = "center",
              h1("loadingState()")
            ),
            br(),
            
            column(
              width = 12,
              #align = "center",
              # demo loading spinner
              box(
                title = "loading spinner",
                loadingState()
              )
            ),
            
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("blockQuote()")
            ),
            br(),
            
            column(
              width = 12,
              # demo  blockQuote
              box(
                title = "BlockQuote example",
                blockQuote("I quote some text here!")
              ),
              box(
                title = "BlockQuote example",
                blockQuote("I quote some text here!", side = "right")
              )
            ),
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("dashboardLabel()")
            ),
            br(),
            
            column(
              width = 12,
              # demo dashboardLabel
              dashboardLabel("Label 1", status = "info"),
              dashboardLabel("Label 2", status = "success"),
              dashboardLabel("Label 3", status = "warning"),
              dashboardLabel("Label 4", status = "primary"),
              dashboardLabel("Label 5", status = "danger")
            ),
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("starBlock()")
            ),
            br(),
            
            column(
              width = 12,
              #align = "center",
              # demo starBlock
              box(
                title = "Star example",
                starBlock(grade = 5),
                starBlock(grade = 5, color = "olive"),
                starBlock(grade = 1, color = "maroon"),
                starBlock(grade = 3, color = "teal")
              )
            ),
            
            br(),
            column(
              width = 12,
              align = "center",
              h1("attachmentBlock()")
            ),
            br(),
            
            column(
              width = 12,
              # demo attachment block
              box(
                title = "Attachment example",
                attachmentBlock(
                  src = "http://kiev.carpediem.cd/data/afisha/o/2d/c7/2dc7670333.jpg",
                  title = "Test",
                  title_url = "http://google.com",
                  "This is the content"
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
    
    output$data <- renderTable({
      head(mtcars[, c("mpg", input$variable), drop = FALSE])
    }, rownames = TRUE)
    
  }
)