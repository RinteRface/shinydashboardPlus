library(shiny)
library(shinyjqui)
library(shinydashboard)
library(shinydashboardPlus)

shinyApp(
  ui = dashboardPagePlus(
    dashboardHeaderPlus(
      enable_rightsidebar = TRUE,
      rightSidebarIcon = "bars"
    ),
    dashboardSidebar(),
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
    dashboardBody(
      
      fluidRow(
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
        ),
        
        # descriptionBlock demo in box side
        box(title = "Box with right pad",
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
        
        # userList examples
        box(
          title = "User List example",
          status = "success",
          userList(
            userListItem(
              src = "https://www.rstudio.com/wp-content/uploads/2014/04/shiny.png", 
              user_name = "Shiny", 
              date = "28.04.2018"
            ),
            userListItem(
              src = "https://www.rstudio.com/wp-content/uploads/2014/04/knitr.png", 
              user_name = "knitr", 
              date = "28.04.2018"
            ),
            userListItem(
              src = "https://www.rstudio.com/wp-content/uploads/2017/05/rmarkdown.png", 
              user_name = "Rmarkdown", 
              date = "28.04.2018"
            ),
            userListItem(
              src = "https://d33wubrfki0l68.cloudfront.net/071952491ec4a6a532a3f70ecfa2507af4d341f9/c167c/images/hex-dplyr.png", 
              user_name = "Tidyverse", 
              date = "28.04.2018"
            ),
            userListItem(
              src = "https://www.rstudio.com/wp-content/uploads/2014/04/tidyr.png", 
              user_name = "tidyr", 
              date = "28.04.2018"
            ),
            userListItem(
              src = "https://www.rstudio.com/wp-content/uploads/2014/04/packrat.png", 
              user_name = "packrat", 
              date = "28.04.2018"
            ),
            userListItem(
              src = "https://www.rstudio.com/wp-content/uploads/2014/04/sparklyr.png", 
              user_name = "packrat", 
              date = "28.04.2018"
            )
          )
        ),
        
        # navPills demo
        box(
          title = "Nav Pills",
          status = "info",
          footer = navPills(
            navPillsItem(
              pillName = "Item 1", 
              pillColor = "green",
              pillIcon = NULL, 
              pillNumber = 10
            ),
            navPillsItem(
              pillName = "Item 2", 
              pillColor = "red",
              pillIcon = "fa fa-angle-down", 
              pillNumber = "10%"
            )
          )
        ),
        
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
        
        # demo buttons
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
        ),
        
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
        ),
        
        
        # demo loading spinner
        box(
          title = "loading spinner",
          loadingState()
        ),
        
        
        # demo gradient box
        gradientBox(
          title = "My gradient Box",
          icon = "fa fa-th",
          gradientColor = "teal", 
          boxToolSize = "sm", 
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
          ),
          "This is a gradient box"
        ),
        
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
        
        # demo  blockQuote
        box(
          title = "BlockQuote example",
          blockQuote("I quote some text here!")
        ),
        
        # demo dashboardLabel
        dashboardLabel("Label 1", status = "info"),
        dashboardLabel("Label 2", status = "success"),
        dashboardLabel("Label 3", status = "warning"),
        
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
        ),
        
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
        
      )
      
    ),
    title = "shinyDashboardPlus showcase"
  ),
  server = function(input, output) { }
)