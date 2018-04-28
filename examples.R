library(shinydashboard)
library(shiny)

# perfect for business boxes
descriptionBlock <- function(number = NULL, number_color = NULL, number_icon = NULL,
                             header = NULL, text = NULL, right_border = TRUE,
                             margin_bottom = FALSE) {
  
  cl <- "description-block"
  if (isTRUE(right_border)) cl <- paste0(cl, " border-right")
  if (isTRUE(margin_bottom)) cl <- paste0(cl, " margin-bottom")
  
  numcl <- "description-percentage"
  if (!is.null(number_color)) numcl <- paste0(numcl, " text-", number_color)
  
  shiny::tags$div(
    class = cl,
    shiny::tags$span(
      class = numcl, number,
      if (!is.null(number_icon)) shiny::tags$i(class = number_icon)
    ),
    shiny::tags$h5(class = "description-header", header),
    shiny::tags$span(class = "description-text", text)
  )
}


# rigth or left pad
boxPad <- function(..., color = NULL, style = NULL) {
  cl <- "pad box-pane-right"
  if (!is.null(color)) cl <- paste0(cl, " bg-", color)
  
  shiny::tags$div(
    class = cl,
    style = style,
    ...
  )
}

# userlist: insert userListItem inside
userList <- function(...) {
  shiny::tags$div(
    class = "box-body no-padding",
    shiny::tags$ul(
      class="users-list clearfix",
      ...
    )
  )
}

userListItem <- function(src = NULL, user_name = NULL, date = NULL) {
  shiny::tags$li(
    shiny::tags$img(
      src = src, alt = "User Image",
      shiny::tags$a(class = "users-list-name", user_name),
      shiny::tags$span(class="users-list-date", date)
    )
  )
}

# nav pills: include navPillsItem inside
navPills <- function(...) {
  shiny::tags$ul(
    class = "nav nav-pills nav-stacked",
    ...
  )
}

navPillsItem <- function(pillName = NULL, pillColor = NULL, 
                         pillIcon = NULL, pillNumber = NULL) {
  cl <- "pull-right"
  if (!is.null(pillColor)) paste0(cl, " text-", pillColor)
  
  shiny::tags$li(
    shiny::tags$a(
      href = "#", pillName,
      shiny::tags$span(
        class = cl,
        shiny::tags$i(class = pillIcon),
        pillNumber
      )
    )
  )
}

# product list: include productListItem inside
productList <- function(...) {
  shiny::tags$ul(
    class = "products-list product-list-in-box",
    ...
  )
}

productListItem <- function(..., src = NULL, productTitle = NULL, 
                            productPrice = NULL, priceColor = NULL) {
  cl <- "label pull-right"
  if (!is.null(priceColor)) cl <- paste0(cl, " label-", priceColor)
  
  shiny::tags$li(
    class = "item",
    shiny::tags$div(
      class = "product-img",
      shiny::tags$img(src = src, alt = "Product Image")
    ),
    shiny::tags$div(
      class = "product-info",
      shiny::tags$a(
        href = "javascript:void(0)", 
        class = "product-title",
        productTitle,
        shiny::tags$span(class = cl, productPrice)
      ),
      shiny::tags$span(
        class = "product-description",
        ...
      )
    )
  )
}


# blockquote
blockQuote <- function(...) {
  shiny::tags$blockquote(
    ...
  )
}

# app buttons
appButton <- function(url = NULL, label = NULL, icon = NULL, enable_badge = FALSE, 
                      badgeColor = NULL, badgeLabel = NULL) {
  shiny::tags$a(
    class = "btn btn-app",
    if (isTRUE(enable_badge)) {
      cl <- "badge"
      if (!is.null(badgeColor)) cl <- paste0(cl, " bg-", badgeColor)
      shiny::tags$span(class = cl, badgeLabel)
    },
    shiny::tags$i(class = icon),
    label,
    href = url
  )
}



# loading spinner
loadingState <- function() {
  shiny::tags$div(
    class = "overlay",
    shiny::tags$i(class = "fa fa-refresh fa-spin")
  )
}



# gradient box
gradientBox <- function(..., title = NULL, icon = NULL, gradientColor = NULL, 
                        boxToolSize = "sm", footer = NULL) {
  cl <- "box box-solid"
  if (!is.null(gradientColor)) cl <- paste0(cl, " bg-", gradientColor, "-gradient")
  shiny::tags$div(
    class = cl,
    
    # box header
    shiny::tags$div(
      class = "box-header",
      style="cursor: move;",
      
      shiny::tags$i(class = icon),
      shiny::tags$h3(class = "box-title", title),
      
      # box header buttons
      shiny::tags$div(
        class = "pull-right box-tools",
        shiny::tags$button(
          class = paste0("btn", " bg-", gradientColor, " btn-", boxToolSize),
          `data-widget` = "collapse",
          type = "button",
          shiny::tags$i(class = "fa fa-minus")
        ),
        shiny::tags$button(
          class = paste0("btn", " bg-", gradientColor, " btn-", boxToolSize),
          `data-widget` = "remove",
          type = "button",
          shiny::tags$i(class = "fa fa-times")
        )
      )
    ),
    
    # box body
    shiny::tags$div(
      class = "box-body border-radius-none",
      ...
    ),
    
    # box footer
    shiny::tags$div(
      class="box-footer no-border",
      footer
    )
  )
  
}


shinyApp(
  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(),
    dashboardBody(
      
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
        footer = NULL,
        "This is a gradient box"
      )
      
    ),
    title = "Dashboard example"
  ),
  server = function(input, output) { }
)