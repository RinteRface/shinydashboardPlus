#' @title AdminLTE2 accordion container
#'
#' @description Create an accordion container
#'
#' @param ... slot for accordionItem.
#' @param inputId Unique accordion id.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'       accordion(
#'        inputId = "accordion1",
#'         accordionItem(
#'           title = "Accordion 1 Item 1",
#'           color = "danger",
#'           collapsed = TRUE,
#'           "This is some text!"
#'         ),
#'         accordionItem(
#'           title = "Accordion 1 Item 2",
#'           color = "warning",
#'           collapsed = FALSE,
#'           "This is some text!"
#'         )
#'       ),
#'       accordion(
#'        inputId = "accordion2",
#'         accordionItem(
#'           title = "Accordion 2 Item 1",
#'           color = "danger",
#'           collapsed = TRUE,
#'           "This is some text!"
#'         ),
#'         accordionItem(
#'           title = "Accordion 2 Item 2",
#'           color = "warning",
#'           collapsed = FALSE,
#'           "This is some text!"
#'         )
#'       )
#'     ),
#'     title = "Accordion"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
accordion <- function(..., inputId = NULL) {
  
  items <- list(...)
  len <- length(items)
  
  # patch that enables a proper accordion behavior
  # we add the data-parent non standard attribute to each
  # item. Each accordion must have a unique id.
  lapply(seq_len(len), FUN = function(i) {
    items[[i]]$children[[1]]$children[[1]]$children[[1]]$attribs[["data-parent"]] <<- paste0("#", inputId) 
    items[[i]]$children[[1]]$children[[1]]$children[[1]]$attribs[["href"]] <<- paste0("#collapse_", inputId, "_", i)
    items[[i]]$children[[2]]$attribs[["id"]] <<- paste0("collapse_", inputId, "_", i)
  })
  
  shiny::tags$div(
    class = "box-group",
    id = inputId,
    items
  )
  
}


#' @title AdminLTE2 accordion item
#'
#' @description Create an accordion item to put inside an accordion container
#'
#' @param ... text to write in the item.
#' @param title item title.
#' @param color item color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' @param collapsed Whether to expand or collapse the item. TRUE by default. Set it to FALSE if you want to expand it.
#' 
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
accordionItem <- function(..., title = NULL, color = NULL,
                          collapsed = TRUE) {
  
  cl <- "panel box"
  if (!is.null(color)) cl <- paste0(cl, " box-", color)
  
  shiny::tags$div(
    class = cl,
    
    # box header
    shiny::tags$div(
      class = "box-header with-border",
      shiny::tags$h4(
        class = "box-title",
        shiny::tags$a(
          href = NULL,
          `data-toggle` = "collapse",
          `data-parent` = NULL,
          `aria-expanded` = if (isTRUE(collapsed)) "false" else "true",
          class = if (isTRUE(collapsed)) "collapsed",
          title
        )
      )
    ),
    
    shiny::tags$div(
      id = NULL,  
      class = if (isTRUE(collapsed)) {
        "panel-collapse collapse"
      } else {
        "panel-collapse collapse in"
      },
      `aria-expanded` = if (isTRUE(collapsed)) "false" else "true",
      style = if (isTRUE(collapsed)) "height: 0px;" else NULL,
      shiny::tags$div(class = "box-body", ...)
    )
  )
}



#' @title AdminLTE2 attachment container
#'
#' @description Create an attachment container, nice to wrap articles...
#'
#' @param ... any element.
#' @param src url or path to the image.
#' @param title attachment title.
#' @param titleUrl external link.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       title = "Attachment example",
#'       attachmentBlock(
#'        src = "https://adminlte.io/themes/AdminLTE/dist/img/photo1.png",
#'        title = "Test",
#'        titleUrl = "https://google.com",
#'        "This is the content"
#'       )
#'      )
#'     ),
#'     title = "AttachmentBlock"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export

attachmentBlock <- function(..., src = NULL, title = NULL, titleUrl = NULL) {
  shiny::tags$div(
    class = "attachment-block clearfix",
    shiny::img(
      class = "attachment-img",
      src = src
    ),
    shiny::tags$div(
      class = "attachment-pushed",
      shiny::tags$h4(
        class = "attachment-heading",
        shiny::tags$a(
          href = titleUrl,
          target = "_blank",
          title
        )
      ),
      shiny::tags$div(
        class = "attachment-text",
        ...
      )
    )
  )
}



#' @title AdminLTE2 block quote
#'
#' @description If you want to quote text
#'
#' @param ... any element.
#' @param side blockquote orientation. "left" by default, can be set to "right".
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       title = "BlockQuote example",
#'       blockQuote("I quote some text here!")
#'      )
#'     ),
#'     title = "blockQuote"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
blockQuote <- function(..., side = "left") {
  shiny::tags$blockquote(
    class = if (side == "right") "pull-right" else NULL,
    ...
  )
}



#' @title AdminLTE2 vertical block container
#'
#' @description Create a vertical container for descriptionBlock.
#'
#' @param ... any element such as descriptionBlock.
#' @param color background color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' @param style custom CSS, if any.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(title = "Box with right pad",
#'       status = "warning",
#'       fluidRow(
#'         column(width = 6),
#'         column(
#'           width = 6,
#'           boxPad(
#'             color = "green",
#'             descriptionBlock(
#'               header = "8390", 
#'               text = "VISITS", 
#'               rightBorder = FALSE,
#'               marginBottom = TRUE
#'             ),
#'             descriptionBlock(
#'               header = "30%", 
#'               text = "REFERRALS", 
#'               rightBorder = FALSE,
#'               marginBottom = TRUE
#'             ),
#'             descriptionBlock(
#'               header = "70%", 
#'               text = "ORGANIC", 
#'               rightBorder = FALSE,
#'               marginBottom = FALSE
#'             )
#'           )
#'         )
#'       )
#'      )
#'     ),
#'     title = "boxPad"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
boxPad <- function(..., color = NULL, style = NULL) {
  cl <- "pad box-pane-right"
  if (!is.null(color)) cl <- paste0(cl, " bg-", color)
  
  shiny::tags$div(
    class = cl,
    style = style,
    ...
  )
}



#' @title AdminLTE2 special large button
#'
#' @description Create a large button ideal for web applications but identical
#' to the classic Shiny action button.
#'
#' @inheritParams shiny::actionButton
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       title = "App Buttons",
#'       status = NULL,
#'       appButton(
#'         inputId = "myAppButton",
#'         label = "Users", 
#'         icon = icon("users"), 
#'         dashboardBadge(textOutput("btnVal"))
#'       )
#'      )
#'     ),
#'     title = "App buttons"
#'   ),
#'   server = function(input, output) {
#'    output$btnVal <- renderText(input$myAppButton)
#'   }
#'  )
#' }
#'
#' @export
appButton <- function(..., inputId, label, icon = NULL, width = NULL) {
  shiny::tagAppendAttributes(
    shiny::actionButton(inputId, label, icon, width, ...),
    class = "btn-app"
  )
}



#' @title AdminLTE2 social button
#'
#' @description Create a social button
#'
#' @param url if the button should redirect somewhere.
#' @param type social network name: see here for valid names \url{https://adminlte.io/themes/AdminLTE/pages/UI/buttons.html}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       title = "Social Buttons",
#'       status = NULL,
#'       socialButton(
#'         url = "https://dropbox.com",
#'         type = "dropbox"
#'       ),
#'       socialButton(
#'         url = "https://github.com",
#'         type = "github"
#'       )
#'      )
#'     ),
#'     title = "Social Buttons"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
socialButton <- function(url, type = NULL) {
  
  cl <- "btn btn-social-icon"
  if (!is.null(type)) cl <- paste0(cl, " btn-", type)
  
  shiny::tags$a(
    href = url,
    target = "_blank",
    class = cl,
    shiny::icon(type)
  )
}



#' @title AdminLTE2 label
#'
#' @description Create a label
#'
#' @param ... any text.
#' @param status label status: "danger", "success", "info", "primary", "warning".
#' @param style label border style: "default" (rounded angles), "circle" or "square".
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      dashboardLabel("Label 1", status = "info"),
#'      dashboardLabel("Label 2", status = "danger", style = "circle"),
#'      dashboardLabel("Label 3", status = "success", style = "square")
#'     )
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
dashboardLabel <- function(..., status = "primary", style = "default") {
  validateStatus(status)
  shiny::tags$span(
    class = paste0("label", " label-", status),
    style = if (style == "circle") {
      "border-radius: 50%;"
    } else if (style == "square") {
      "border-radius: 0%;"
    } else NULL,
    ...
  )
}



#' @title AdminLTE2 badge
#'
#' @description Create a badge.
#'
#' @param ... Any html text element.
#' @param color label color.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      dashboardBadge("Badge 1"),
#'      actionButton(
#'       inputId = "badge", 
#'       label = "Hello", 
#'       icon = NULL, 
#'       width = NULL, 
#'       dashboardBadge(1, color = "orange")
#'      )
#'     )
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
dashboardBadge <- function(..., color = "blue") {
  validateColor(color)
  shiny::tags$span(class = paste0("badge bg-", color), ...)
}



#' @title AdminLTE2 description block
#'
#' @description Create a description block, perfect for writing statistics
#'
#' @param number any number.
#' @param numberColor number color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' @param numberIcon number icon, if any. Should be written like "fa fa-times".
#' @param header bold text.
#' @param text additional text.
#' @param rightBorder TRUE by default. Whether to display a right border to
#'   separate two blocks. The last block on the right should not have a right border.
#' @param marginBottom FALSE by default. Set it to TRUE when the
#'   descriptionBlock is used in a boxPad context.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       solidHeader = FALSE,
#'       title = "Status summary",
#'       background = NULL,
#'       width = 4,
#'       status = "danger",
#'       footer = fluidRow(
#'         column(
#'           width = 6,
#'           descriptionBlock(
#'             number = "17%", 
#'             numberColor = "green", 
#'             numberIcon = "caret-up",
#'             header = "$35,210.43", 
#'             text = "TOTAL REVENUE", 
#'             rightBorder = TRUE,
#'             marginBottom = FALSE
#'           )
#'         ),
#'         column(
#'           width = 6,
#'           descriptionBlock(
#'             number = "18%", 
#'             numberColor = "red", 
#'             numberIcon = "caret-down",
#'             header = "1200", 
#'             text = "GOAL COMPLETION", 
#'             rightBorder = FALSE,
#'             marginBottom = FALSE
#'           )
#'         )
#'       )
#'      )
#'     ),
#'     title = "Description Blocks"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
descriptionBlock <- function(number = NULL, numberColor = NULL, numberIcon = NULL,
                             header = NULL, text = NULL, rightBorder = TRUE,
                             marginBottom = FALSE) {
  
  cl <- "description-block"
  if (isTRUE(rightBorder)) cl <- paste0(cl, " border-right")
  if (isTRUE(marginBottom)) cl <- paste0(cl, " margin-bottom")
  
  numcl <- "description-percentage"
  if (!is.null(numberColor)) numcl <- paste0(numcl, " text-", numberColor)
  
  shiny::tags$div(
    class = cl,
    shiny::tags$span(
      class = numcl, 
      number,
      if (!is.null(numberIcon)) shiny::icon(numberIcon)
    ),
    shiny::tags$h5(class = "description-header", header),
    shiny::tags$span(class = "description-text", text)
  )
}



#' @title AdminLTE2 loading state element
#'
#' @description When a section is still work in progress or a computation is running
#' 
#' @note Loading state can be programmatically used when a conputation is running for instance.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       title = "loading spinner",
#'       loadingState()
#'       )
#'     ),
#'     title = "Loading State"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
loadingState <- function() {
  shiny::tags$div(
    class = "overlay",
    shiny::tags$i(class = "fa fa-refresh fa-spin")
  )
}



#' @title AdminLTE2 nav pill container
#'
#' @description Create a container for nav elements
#'
#' @param ... slot for navPillsItem.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       title = "Nav Pills",
#'       status = "info",
#'       "Box Body",
#'       footer = navPills(
#'         navPillsItem(
#'           pillName = "Item 1", 
#'           pillColor = "green",
#'           pillIcon = NULL, 
#'           pillText = 10
#'         ),
#'         navPillsItem(
#'           pillName = "Item 2", 
#'           pillColor = "red",
#'           pillIcon = "fa fa-angle-down", 
#'           pillText = "10%",
#'           active = TRUE
#'         )
#'       )
#'      )
#'     ),
#'     title = "Nav Pills"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
navPills <- function(...) {
  shiny::tags$ul(
    class = "nav nav-pills nav-stacked",
    ...
  )
}


#' @title AdminLTE2 nav pill item
#'
#' @description Create a nav pill item
#'
#' @param pillName pill name.
#' @param pillColor pill color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' @param pillIcon pill icon, if any. Should be written like "fa fa-times".
#' @param pillText pill text. Can also be a number.
#' @param active Whether the item is active or not. FALSE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
navPillsItem <- function(pillName = NULL, pillColor = NULL, 
                         pillIcon = NULL, pillText = NULL,
                         active = FALSE) {
  cl <- "pull-right"
  if (!is.null(pillColor)) cl <- paste0(cl, " text-", pillColor)
  
  shiny::tags$li(
    class = if (isTRUE(active)) "active" else NULL,
    shiny::tags$a(
      href = "javascript:void(0)", 
      pillName,
      shiny::tags$span(
        class = cl,
        shiny::tags$i(class = pillIcon),
        pillText
      )
    )
  )
}



#' AdminLTE2 preloader
#'
#' This creates a preloader.
#' 
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @note This function is only for internal use of shinydashboardPlus.
#' @export
preloader <- function() {
  loaderTag <- shiny::tags$div(
    id = "loader-wrapper",
    shiny::tags$div(id = "loader"),
    shiny::tags$div(class = "loader-section section-left"),
    shiny::tags$div(class = "loader-section section-right")
  )
  
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$style(
          shiny::HTML(
            paste0(
              '#loader-wrapper {
              position: fixed;
              top: 0;
              left: 0;
              width: 100%;
              height: 100%;
              z-index: 5000;
              }
              #loader {
              display: block;
              position: relative;
              left: 50%;
              top: 50%;
              width: 150px;
              height: 150px;
              margin: -75px 0 0 -75px;
              border: 3px solid transparent;
              border-top-color: #3498db;
              border-radius: 50%;
              z-index: 5001;
              -webkit-animation: spin 2s linear infinite;
              animation: spin 2s linear infinite;
              }
              #loader:before {
              content: "";
              position: absolute;
              top: 5px;
              left: 5px;
              right: 5px;
              bottom: 5px;
              border: 3px solid transparent;
              border-top-color: #e74c3c;
              border-radius: 50%;
              -webkit-animation: spin 3s linear infinite;
              animation: spin 3s linear infinite;
              }
              #loader:after {
              content: "";
              position: absolute;
              top: 15px;
              left: 15px;
              right: 15px;
              bottom: 15px;
              border: 3px solid transparent;
              border-top-color: #f9c922;
              border-radius: 50%;
              }
              
              
              /* copy and paste the animation inside all 3 elements */
              /* #loader, #loader:before, #loader:after */
              -webkit-animation: spin 1.5s linear infinite;
              animation: spin 1.5s linear infinite;
              
              /* include this only once */
              @-webkit-keyframes spin {
              0%   {
              -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */
              -ms-transform: rotate(0deg);  /* IE 9 */
              transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */
              }
              100% {
              -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */
              -ms-transform: rotate(360deg);  /* IE 9 */
              transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */
              }
              }
              @keyframes spin {
              0%   {
              -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */
              -ms-transform: rotate(0deg);  /* IE 9 */
              transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */
              }
              100% {
              -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */
              -ms-transform: rotate(360deg);  /* IE 9 */
              transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */
              }
              }
              
              
              #loader-wrapper .loader-section {
              position: fixed;
              top: 0;
              width: 51%;
              height: 100%;
              background: #222222;
              z-index: 5000;
              }
              #loader-wrapper .loader-section.section-left {
              left: 0;
              }
              #loader-wrapper .loader-section.section-right {
              right: 0;
              }
              
              
              /* Loaded */
              .loaded #loader-wrapper .loader-section.section-left {
              -webkit-transform: translateX(-100%);  /* Chrome, Opera 15+, Safari 3.1+ */
              -ms-transform: translateX(-100%);  /* IE 9 */
              transform: translateX(-100%);  /* Firefox 16+, IE 10+, Opera */
              }
              .loaded #loader-wrapper .loader-section.section-right {
              -webkit-transform: translateX(100%);  /* Chrome, Opera 15+, Safari 3.1+ */
              -ms-transform: translateX(100%);  /* IE 9 */
              transform: translateX(100%);  /* Firefox 16+, IE 10+, Opera */
              }
              
              .loaded #loader {
              opacity: 0;
              }
              
              .loaded #loader-wrapper {
              visibility: hidden;
              }
              
              .loaded #loader {
              opacity: 0;
              -webkit-transition: all 0.3s ease-out; 
              transition: all 0.3s ease-out;
              }
              
              .loaded #loader-wrapper .loader-section.section-right,
              .loaded #loader-wrapper .loader-section.section-left {
              
              -webkit-transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000); 
              transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000);
              }
              .loaded #loader-wrapper {
              -webkit-transform: translateY(-100%);
              -ms-transform: translateY(-100%);
              transform: translateY(-100%);
              
              -webkit-transition: all 0.3s 1s ease-out; 
              transition: all 0.3s 1s ease-out;
              }
              '
            )
          )
        )
      )
    ),
    loaderTag
  )
}



#' @title AdminLTE2 product list container
#'
#' @description Create a container product list elements
#'
#' @param ... slot for productListItem.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       title = "Product List",
#'       status = "primary",
#'       productList(
#'         productListItem(
#'           src = "https://www.pngmart.com/files/1/Haier-TV-PNG.png", 
#'           productTitle = "Samsung TV", 
#'           productPrice = "$1800", 
#'           priceColor = "warning",
#'           "This is an amazing TV, but I don't like TV!"
#'         ),
#'         productListItem(
#'           src = "https://upload.wikimedia.org/wikipedia/commons/7/77/IMac_Pro.svg", 
#'           productTitle = "Imac 27", 
#'           productPrice = "$4999", 
#'           priceColor = "danger",
#'           "This is were I spend most of my time!"
#'         )
#'       )
#'      )
#'     ),
#'     title = "Product List"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
productList <- function(...) {
  shiny::tags$ul(
    class = "products-list product-list-in-box",
    ...
  )
}


#' @title AdminLTE2 product item
#'
#' @description Create a product item
#'
#' @param ... product description.
#' @param src image url, if any.
#' @param productTitle product name.
#' @param productPrice product price.
#' @param priceColor price color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
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



#' @title AdminLTE2 starBlock
#'
#' @description Create a starBlock item (ideal for rating)
#'
#' @param maxstar Maximum number of stars by block.
#' @param grade Current score. Should be positive and lower or equal to maxstar.
#' @param color Star color: see \code{validColors()} in the documentation.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       title = "Star example",
#'       starBlock(grade = 5),
#'       starBlock(grade = 5, color = "olive"),
#'       starBlock(grade = 1, color = "maroon"),
#'       starBlock(grade = 3, color = "teal")
#'      )
#'     ),
#'     title = "starBlock"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
starBlock <- function(maxstar = 5, grade, color = "yellow") {
  
  stopifnot(!is.null(grade))
  stopifnot(grade >= 0)
  stopifnot(grade <= maxstar)
  
  shiny::tags$td(
    class = "mailbox-star",
    shiny::tags$a(
      href = "javascript:void(0)",
      if (grade > 0) {
        full_star <- lapply(1:grade, FUN = function(i) {
          shiny::tags$i(class = paste0("fa text-", color, " fa-star"))
        })
      },
      if (grade < maxstar) {
        empty_star <- lapply(1:(maxstar - grade), FUN = function(i) {
          shiny::tags$i(class = paste0("fa text-", color, " fa-star-o"))
        })
      }
    ),
    shiny::tags$br()
  )
}



#' @title AdminLTE2 timeline block
#'
#' @description Create a timeline block
#'
#' @param ... slot for timelineLabel or timelineItem.
#' @param reversed Whether the timeline is reversed or not.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      h3("When Reversed = TRUE, can be displayed inside a box"),
#'      box(
#'       title = "Timeline",
#'       status = "info",
#'       timelineBlock(
#'        timelineEnd(color = "danger"),
#'        timelineLabel(2018, color = "teal"),
#'        timelineItem(
#'         title = "Item 1",
#'         icon = "gears",
#'         color = "olive",
#'         time = "now",
#'         footer = "Here is the footer",
#'         "This is the body"
#'        ),
#'        timelineItem(
#'         title = "Item 2",
#'         border = FALSE
#'        ),
#'        timelineLabel(2015, color = "orange"),
#'        timelineItem(
#'         title = "Item 3",
#'         icon = "paint-brush",
#'         color = "maroon",
#'         timelineItemMedia(src = "https://placehold.it/150x100"),
#'         timelineItemMedia(src = "https://placehold.it/150x100")
#'        ),
#'        timelineStart(color = "gray")
#'       )
#'      ),
#'      
#'      column(
#'       width = 6,
#'       h3("When Reversed = FALSE, can be displayed out of a box"),
#'       timelineBlock(
#'        reversed = FALSE,
#'        timelineEnd(color = "danger"),
#'        timelineLabel(2018, color = "teal"),
#'        timelineItem(
#'         title = "Item 1",
#'         icon = "gears",
#'         color = "olive",
#'         time = "now",
#'         footer = "Here is the footer",
#'         "This is the body"
#'        ),
#'        timelineItem(
#'         title = "Item 2",
#'         border = FALSE
#'        ),
#'        timelineLabel(2015, color = "orange"),
#'        timelineItem(
#'         title = "Item 3",
#'         icon = "paint-brush",
#'         color = "maroon",
#'         timelineItemMedia(src = "https://placehold.it/150x100"),
#'         timelineItemMedia(src = "https://placehold.it/150x100")
#'        ),
#'        timelineStart(color = "gray")
#'       )
#'      )
#'     ),
#'     title = "timelineBlock"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
timelineBlock <- function(..., reversed = TRUE) {
  
  cl <- "timeline"
  if (isTRUE(reversed)) cl <- paste0(cl, " timeline-inverse")
  
  shiny::tags$ul(
    class = cl,
    ...
  )
}


#' @title AdminLTE2 timeline label
#'
#' @description Create a timeline label
#'
#' @param ... any element.
#' @param color label color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
timelineLabel <- function(..., color = NULL) {
  
  cl <- "bg-"
  if (!is.null(color)) cl <- paste0(cl, color)
  
  shiny::tags$li(
    class = "time-label",
    shiny::tags$span(
      class = cl,
      ...
    )
  )
}


#' @title AdminLTE2 timeline item
#'
#' @description Create a timeline item
#'
#' @param ... any element such as timeLineItemMedia ...
#' @param icon item icon such as "clock-o", "times", ...
#' @param color item color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' @param time item date or time.
#' @param title item title.
#' @param border Whether to display a border between the header and the body. TRUE by default.
#' @param footer item footer if any.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
timelineItem <- function(..., icon = NULL, color = NULL, time = NULL,
                         title = NULL, border = TRUE, footer = NULL) {
  
  cl <- "fa fa-"
  if (!is.null(icon)) cl <- paste0(cl, icon)
  if (!is.null(color)) cl <- paste0(cl, " bg-", color)
  
  itemCl <- "timeline-header no-border"
  if (isTRUE(border)) itemCl <- "timeline-header"
  
  shiny::tags$li(
    
    # timelineItem icon and color
    shiny::tags$i(class = cl),
    
    # timelineItem container
    shiny::tags$div(
      class = "timeline-item",
      
      #timelineItem time/date
      shiny::tags$span(
        class = "time",
        shiny::icon("clock-o"),
        time
      ),
      
      # timelineItem title
      shiny::tags$h3(
        class = itemCl,
        title
      ),
      
      # timelineItem body
      shiny::tags$div(
        class = "timeline-body",
        ...
      ),
      
      # timelineItem footer
      if (!is.null(footer)) {
        shiny::tags$div(
          class = "timeline-footer",
          footer
        )
      }
    )
  )
}


#' @title AdminLTE2 timeline media item
#'
#' @description Create a timeline media item
#'
#' @param src media url or path.
#' @param height media height in pixels.
#' @param width media width in pixels.
#' 
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
timelineItemMedia <- function(src = NULL, height = NULL, width = NULL) {
  shiny::img(
    class = "margin", 
    src = src, 
    height = height,
    width = width
  )
}




#' @title AdminLTE2 timeline starting point
#'
#' @description Create a timeline starting point
#'
#' @param icon item icon such as "clock-o", "times", ...
#' @param color item color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
timelineStart <- function(icon = "clock-o", color = NULL) {
  
  cl <- "fa fa-"
  if (!is.null(icon)) cl <- paste0(cl, icon)
  if (!is.null(color)) cl <- paste0(cl, " bg-", color)
  
  shiny::tags$li(
    shiny::tags$i(class = cl)
  )
}


#' @title AdminLTE2 timeline ending point
#'
#' @description Create a timeline ending point
#'
#' @param icon item icon such as "clock-o", "times", ...
#' @param color item color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
timelineEnd <- function(icon = "hourglass-end", color = NULL) {
  
  cl <- "fa fa-"
  if (!is.null(icon)) cl <- paste0(cl, icon)
  if (!is.null(color)) cl <- paste0(cl, " bg-", color)
  
  shiny::tagList(
    shiny::tags$li(
      shiny::tags$i(class = cl)
    ),
    shiny::br(), 
    shiny::br()
  )
}



#' @title AdminLTE2 todo list container
#'
#' @description Create a todo list container
#'
#' @param ... slot for todoListItem.
#' @param sortable Whether the list elements are sortable or not.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinyjqui)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       "Sortable todo list demo",
#'       status = "warning",
#'       todoList(
#'         todoListItem(
#'           label = "Design a nice theme",
#'           "Some text here"
#'         ),
#'         todoListItem(
#'           label = "Make the theme responsive",
#'           "Some text here"
#'         ),
#'         todoListItem(
#'           checked = TRUE,
#'           label = "Let theme shine like a star"
#'         )
#'        )
#'       ),
#'       box(
#'       "Simple todo list demo",
#'       status = "warning",
#'       todoList(
#'       sortable = FALSE,
#'         todoListItem(
#'           label = "Design a nice theme",
#'           "Some text here"
#'         ),
#'         todoListItem(
#'           label = "Make the theme responsive",
#'           "Some text here"
#'         ),
#'         todoListItem(
#'           checked = TRUE,
#'           label = "Let theme shine like a star"
#'         )
#'        )
#'       )
#'     ),
#'     title = "Todo Lists"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
todoList <- function(..., sortable = TRUE) {
  todoListTag <- shiny::tags$ul(
    class = "todo-list",
    ...
  )
  
  if (isTRUE(sortable)) todoListTag <- shinyjqui::jqui_sortabled(todoListTag) 
  
  todoListTag
  
}



#' @title AdminLTE2 todo list item
#'
#' @description Create a todo list item
#'
#' @param ... any element such as labels, ...
#' @param checked Whether the list item is checked or not.
#' @param label item label.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
todoListItem <- function(..., checked = FALSE, label = NULL) {
  cl <- NULL
  if (isTRUE(checked)) cl <- "done"
  
  shiny::tags$li(
    class = cl,
    
    # sortable icon
    shiny::tags$span(
      class = "handle",
      shiny::tags$i(class = "fa fa-ellipsis-v"),
      shiny::tags$i(class = "fa fa-ellipsis-v")
    ),
    
    # checkbox trigger
    # need to be implemented (custom binding js)
    #shiny::tags$input(type = "checkbox"),
    
    # label
    shiny::tags$span(class = "text", label),
    
    # any element
    shiny::tags$small(
      ...
    )
  )
  
}



#' @title AdminLTE2 user list container
#'
#' @description Create a user list container
#'
#' @param ... slot for userListItem.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       title = "User List example",
#'       status = "success",
#'       userList(
#'         userListItem(
#'           src = "https://www.rstudio.com/wp-content/uploads/2014/04/shiny.png", 
#'           user_name = "Shiny", 
#'           description = "28.04.2018"
#'         ),
#'         userListItem(
#'           src = "https://www.rstudio.com/wp-content/uploads/2014/04/knitr.png", 
#'           user_name = "knitr", 
#'           description = "28.04.2018"
#'         ),
#'         userListItem(
#'           src = "https://www.rstudio.com/wp-content/uploads/2017/05/rmarkdown.png", 
#'           user_name = "Rmarkdown", 
#'           description = "28.04.2018"
#'         ),
#'         userListItem(
#'           src = "https://www.tidyverse.org/images/hex-tidyverse.png", 
#'           user_name = "Tidyverse", 
#'           description = "28.04.2018"
#'         ),
#'         userListItem(
#'           src = "https://www.rstudio.com/wp-content/uploads/2014/04/tidyr.png", 
#'           user_name = "tidyr", 
#'           description = "28.04.2018"
#'         ),
#'         userListItem(
#'           src = "https://www.rstudio.com/wp-content/uploads/2014/04/packrat.png", 
#'           user_name = "packrat", 
#'           description = "28.04.2018"
#'         ),
#'         userListItem(
#'           src = "https://www.rstudio.com/wp-content/uploads/2014/04/sparklyr.png", 
#'           user_name = "packrat", 
#'           description = "28.04.2018"
#'         )
#'       )
#'      )
#'     ),
#'     title = "User List"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
userList <- function(...) {
  shiny::tags$div(
    class = "box-body no-padding",
    shiny::tags$ul(
      class = "users-list clearfix",
      ...
    )
  )
}


#' @title AdminLTE2 user list item
#'
#' @description Create a user list item
#'
#' @param src image url or path.
#' @param user_name user name.
#' @param description any date element.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
userListItem <- function(src = NULL, user_name = NULL, description = NULL) {
  shiny::tags$li(
    shiny::tags$img(
      src = src, alt = "User Image",
      shiny::tags$a(class = "users-list-name", user_name),
      shiny::tags$span(class = "users-list-date", description)
    )
  )
}



#' @title AdminLTE2 user post
#'
#' @description Create a user post
#'
#' @param ... post content, slot for userPostToolItemList.
#' @param id unique id of the post.
#' @param src profile image, if any.
#' @param author post author.
#' @param description post description.
#' @param collapsible If TRUE, display a button in the upper right that allows the user to collapse the comment. 
#' @param collapsed Whether the comment is collapsed when the application starts, FALSE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       title = "Box with user comment",
#'       status = "primary",
#'       userPost(
#'        id = 1,
#'        src = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
#'        author = "Jonathan Burke Jr.",
#'        description = "Shared publicly - 7:30 PM today",
#'        "Lorem ipsum represents a long-held tradition for designers, 
#'        typographers and the like. Some people hate it and argue for 
#'        its demise, but others ignore the hate as they create awesome 
#'        tools to help create filler text for everyone from bacon 
#'        lovers to Charlie Sheen fans.",
#'        userPostToolItemList(
#'         userPostToolItem(dashboardLabel("item 1")),
#'         userPostToolItem(dashboardLabel("item 2", status = "danger"), side = "right")
#'        )
#'       ),
#'       userPost(
#'        id = 2,
#'        src = "https://adminlte.io/themes/AdminLTE/dist/img/user6-128x128.jpg",
#'        author = "Adam Jones",
#'        description = "Shared publicly - 5 days ago",
#'        userPostMedia(src = "https://adminlte.io/themes/AdminLTE/dist/img/photo2.png"),
#'        userPostToolItemList(
#'         userPostToolItem(dashboardLabel("item 1")),
#'         userPostToolItem(dashboardLabel("item 2", status = "danger"), side = "right")
#'        )
#'       )
#'      )
#'     ),
#'     title = "userPost"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#' 
#' @export
userPost <- function(..., id = NULL, src = NULL, author = NULL, 
                     description = NULL, collapsible = TRUE, 
                     collapsed = FALSE) {
  
  cl <- "collapse"
  if (!isTRUE(collapsed)) cl <- paste0(cl, " in")
  if (collapsed) collapsed <- "false" else collapsed <- "true"
  
  shiny::tags$div(
    class = "post",
    
    shiny::tags$div(
      class = "user-block",
      shiny::img(class = "img-circle img-bordered-sm", src = src),
      shiny::tags$span(
        class = "username", 
        author,
        
        # box tool
        if (collapsible) {
          shiny::tags$button(
            class = "pull-right btn-box-tool",
            `data-toggle` = "collapse",
            `data-target` = paste0("#", id),
            `aria-expanded` = collapsed,
            type = "button",
            shiny::tags$i(class = "fa fa-eye")
          )
        }
        
      ),
      shiny::tags$span(class = "description", description)
    ),
    shiny::tags$p(
      class = cl,
      id = id,
      `aria-expanded` = collapsed,
      ...
    )
  )
  
}




#' @title AdminLTE2 user post tool item container
#'
#' @description Create a user post tool item container
#'
#' @param ... slot for userPostToolItem.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
userPostToolItemList <- function(...) {
  
  shiny::tags$ul(
    class = "list-inline",
    ...
  )
}




#' @title AdminLTE2 user post tool item
#'
#' @description Create a user post tool item
#'
#' @param ... tool content such as label, button, ...
#' @param side tool item orientation: "left" of "right", "left" by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
userPostToolItem <- function(..., side = "left") {
  
  cl <- if (side == "left") NULL else "pull-right"
  
  shiny::tags$li(
    class = cl,
    ...
  )
}



#' @title AdminLTE2 user post media
#'
#' @description Create a user post media (image)
#'
#' @param src image path or url ...
#' @param height media height in pixels.
#' @param width media width in pixels.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
userPostMedia <- function(src = NULL, height = NULL, width = NULL) {
  shiny::img(
    style = "margin: auto;",
    class = "img-responsive", 
    src = src,
    height = height,
    width = width
  )
}



#' AdminLTE2 vertical progress bar
#'
#' This creates a vertical progress bar.
#' 
#' @param value Progress bar value. Must be between min and max.
#' @param min Progress bar minimum value (0 by default).
#' @param max Progress bar maximum value (100 by default).
#' @param height Progress bar default height (40 percent by default).
#' @param striped Whether the progress is striped or not. FALSE by default. 
#' @param active  Whether the progress is active or not. FALSE by default.
#' @param status Progress bar status. "primary" by default or "warning", "info",
#' "danger" or "success".
#' @param size Progress bar size. NULL by default: "sm", "xs" or "xxs" also available.
#' 
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'    ui = dashboardPagePlus(
#'      header = dashboardHeaderPlus(
#'       enable_rightsidebar = TRUE,
#'       rightSidebarIcon = "gears"
#'      ),
#'      sidebar = dashboardSidebar(),
#'      body = dashboardBody(
#'       verticalProgress(
#'        value = 10,
#'        striped = TRUE,
#'        active = TRUE
#'       ),
#'       verticalProgress(
#'        value = 50,
#'        active = TRUE,
#'        status = "warning",
#'        size = "xs"
#'       ),
#'       verticalProgress(
#'        value = 20,
#'        status = "danger",
#'        size = "sm",
#'        height = "60%"
#'       )
#'      ),
#'      rightsidebar = rightSidebar(),
#'      title = "Right Sidebar"
#'    ),
#'    server = function(input, output) { }
#'  )
#' }
#' @export
verticalProgress <- function(value, min = 0, max = 100, height = "40%", striped = FALSE, 
                             active = FALSE, status = "primary", size = NULL) {
  
  stopifnot(value <= max)
  
  verticalProgressCl <- "progress vertical"
  if (isTRUE(active)) verticalProgressCl <- paste0(verticalProgressCl, " active")
  if (!is.null(size)) verticalProgressCl <- paste0(verticalProgressCl, " progress-", size)
  
  barCl <- "progress-bar"
  if (isTRUE(striped)) barCl <- paste0(barCl, " progress-bar-striped")
  if (!is.null(status)) barCl <- paste0(barCl, " progress-bar-", status)
  
  shiny::tags$div(
    class = verticalProgressCl,
    shiny::tags$div(
      `aria-valuemax` = max,
      `aria-valuemin` = min,
      `aria-valuenow` = value,
      class = barCl,
      style = paste0("height: ", height),
      shiny::tags$span(class = "sr-only", value)
    )
  )
}





#' AdminLTE2 carousel container
#'
#' This creates a carousel
#' 
#' @param ... Slot for \link{carouselItem}
#' @param id Carousel id. Must be unique.
#' @param indicators Whether to display left and right indicators.
#' @param width Carousel width. 6 by default.
#' @param .list Should you need to pass \link{carouselItem} via \link{lapply} or similar,
#' put these item here instead of passing them in ...
#' 
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'    ui = dashboardPagePlus(
#'      header = dashboardHeaderPlus(
#'       enable_rightsidebar = TRUE,
#'       rightSidebarIcon = "gears"
#'      ),
#'      sidebar = dashboardSidebar(),
#'      body = dashboardBody(
#'       carousel(
#'        id = "mycarousel",
#'        carouselItem(
#'         caption = "Item 1",
#'         tags$img(src = "https://placehold.it/900x500/3c8dbc/ffffff&text=I+Love+Bootstrap")
#'        ),
#'        carouselItem(
#'         caption = "Item 2",
#'         tags$img(src = "https://placehold.it/900x500/39CCCC/ffffff&text=I+Love+Bootstrap")
#'        )
#'       )
#'      ),
#'      rightsidebar = rightSidebar(),
#'      title = "Right Sidebar"
#'    ),
#'    server = function(input, output) { }
#'  )
#' }
#' @export
carousel <- function(..., id, indicators = TRUE, width = 6, .list = NULL) {
  
  items <- c(list(...), .list)
  indicatorsId <- paste0("#", id)
  
  items[[1]]$attribs$class <- "item active"
  
  carouselTag <- shiny::tags$div(
    class = "carousel slide",
    id = id,
    `data-ride` = "carousel",
    shiny::tags$ol(
      class="carousel-indicators",
      lapply(
        seq_along(items), 
        FUN = function(i) {
          shiny::tags$li( 
            `data-target` = indicatorsId,
            `data-slide-to` = i - 1,
            class = ""
          )
        }
      )
    ),
    shiny::tags$div(class = "carousel-inner", items),
    # display indicators if needed
    if (indicators) {
      shiny::tagList(
        shiny::tags$a(
          class = "left carousel-control",
          href= indicatorsId,
          `data-slide` = "prev",
          shiny::tags$span(class="fa fa-angle-left")
        ),
        shiny::tags$a(
          class = "right carousel-control",
          href= indicatorsId,
          `data-slide` = "next",
          shiny::tags$span(class="fa fa-angle-right")
        )
      )
    }
  )
  
  shiny::column(width = width, carouselTag)
  
}




#' AdminLTE2 carousel item
#'
#' This creates a carousel item
#' 
#' @param ... Element such as images, iframe, ...
#' @param caption Item caption.
#' 
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
carouselItem <- function(..., caption = "") {
  shiny::tags$div(
    class = "item",
    ...,
    shiny::tags$div(class = "carousel-caption", caption)
  )
}





#' @title AdminLTE2 user message container
#'
#' @description Create a user message container
#'
#' @param ... Slot for \link{userMessage}.
#' @param status Messages status. See here for a list of valid colors 
#' \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' @param width Container width: between 1 and 12.
#' 
#' @note Better to include in a \link{boxPlus}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinydashboardPlus)
#'  
#'  shinyApp(
#'   ui = dashboardPagePlus(
#'     dashboardHeaderPlus(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      boxPlus(
#'       "Box with messages",
#'       solidheader = TRUE,
#'       status = "warning",
#'       userMessages(
#'        width = 12,
#'        status = "success",
#'         userMessage(
#'          author = "Alexander Pierce",
#'          date = "20 Jan 2:00 pm",
#'          src = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
#'          side = NULL,
#'          "Is this template really for free? That's unbelievable!"
#'        ),
#'        userMessage(
#'          author = "Sarah Bullock",
#'          date = "23 Jan 2:05 pm",
#'          src = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
#'          side = "right",
#'          "You better believe it!"
#'        )
#'       )
#'      ),
#'      userMessages(
#'        width = 6,
#'        status = "danger",
#'         userMessage(
#'          author = "Alexander Pierce",
#'          date = "20 Jan 2:00 pm",
#'          src = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
#'          side = NULL,
#'          "Is this template really for free? That's unbelievable!"
#'        ),
#'        userMessage(
#'          author = "Sarah Bullock",
#'          date = "23 Jan 2:05 pm",
#'          src = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
#'          side = "right",
#'          "You better believe it!"
#'        )
#'       )
#'     ),
#'     title = "user Message"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
userMessages <- function(..., status, width = 4) {
  cl <- "direct-chat-messages direct-chat"
  if (!is.null(status)) cl <- paste0(cl, " direct-chat-", status)
  msgtag <- shiny::tags$div(class = cl, ...)
  
  shiny::tags$div(
    class = if (!is.null(width)) paste0("col-sm-", width),
    msgtag
  )
  
}

#' @title AdminLTE2 user message 
#'
#' @description Create a user message
#'
#' @param ... Message text.
#' @param author Message author.
#' @param date Message date.
#' @param src Message author image path or url.
#' @param side Side where author is displayed: NULL (left, by default) or "right".
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
userMessage <- function(..., author = NULL, date = NULL, 
                        src = NULL, side = NULL) {
  
  messageCl <- "direct-chat-msg"
  if (!is.null(side)) messageCl <- paste0(messageCl, " right")
  
  # message info
  messageInfo <- shiny::tags$div(
    class = "direct-chat-info clearfix",
    shiny::tags$span(
      class = if (!is.null(side)) {
        "direct-chat-name float-left"
      } else {
        "direct-chat-name float-right"
      }, 
      author
    ),
    shiny::tags$span(
      class = if (!is.null(side)) {
        "direct-chat-timestamp float-right"
      } else {
        "direct-chat-timestamp float-left"
      }, 
      date
    )
  )
  
  # message Text
  messageTxt <- shiny::tags$div(class = "direct-chat-text", ...)
  
  # message author image
  messageImg <- shiny::tags$img(class = "direct-chat-img", src = src)
  
  shiny::tags$div(
    class = messageCl,
    messageInfo,
    messageImg, 
    messageTxt
  )
}