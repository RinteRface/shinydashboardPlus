#' @title AdminLTE2 gradient box
#'
#' @description Create an enhanced box
#'
#' @param ... body content.
#' @param title box title.
#' @param icon header icon, if any. Should be written like "fa fa-times".
#' @param gradientColor color of the box: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' @param boxToolSize size of the toolbox: choose among "xs", "sm", "md", "lg".
#' @param footer the box footer. 
#' @param width box width (between 1 and 12). 
#' @param height box height.
#' @param collapsible If TRUE, display a button in the upper right that allows the user to collapse the box. 
#' @param closable If TRUE, display a button in the upper right that allows the user to close the box.
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
#'      gradientBox(
#'       title = "My gradient Box",
#'       icon = "fa fa-th",
#'       gradientColor = "teal", 
#'       boxToolSize = "sm", 
#'       footer = fluidRow(
#'         column(
#'           width = 6,
#'           descriptionBlock(
#'             number = "17%", 
#'             number_color = "green", 
#'             number_icon = "fa fa-caret-up",
#'             header = "$35,210.43", 
#'             text = "TOTAL REVENUE", 
#'             right_border = TRUE,
#'             margin_bottom = FALSE
#'           )
#'         ),
#'         column(
#'           width = 6,
#'           descriptionBlock(
#'             number = "18%", 
#'             number_color = "red", 
#'             number_icon = "fa fa-caret-down",
#'             header = "1200", 
#'             text = "GOAL COMPLETION", 
#'             right_border = FALSE,
#'             margin_bottom = FALSE
#'           )
#'         )
#'       ),
#'       "This is a gradient box"
#'       )
#'     ),
#'     title = "Description Blocks"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
gradientBox <- function(..., title = NULL, icon = NULL, gradientColor = NULL, 
                        boxToolSize = "sm", footer = NULL, width = 6, height = NULL,
                        collapsible = TRUE, closable = FALSE) {
  cl <- "box box-solid"
  if (!is.null(gradientColor)) cl <- paste0(cl, " bg-", gradientColor, "-gradient")
  
  style <- NULL
  if (!is.null(height)) {
    style <- paste0("height: ", shiny::validateCssUnit(height))
  }
  
  shiny::column(
    width = width,
    shiny::tags$div(
      class = cl,
      style = style,
      
      # box header
      shiny::tags$div(
        class = "box-header",
        #style="cursor: move;",
        
        shiny::tags$i(class = icon),
        shiny::tags$h3(class = "box-title", title),
        
        # box header buttons
        shiny::tags$div(
          class = "pull-right box-tools",
          if (collapsible) {
            shiny::tags$button(
              class = paste0("btn", " bg-", gradientColor, " btn-", boxToolSize),
              `data-widget` = "collapse",
              type = "button",
              shiny::tags$i(class = "fa fa-minus")
            )
          },
          if (closable) {
            shiny::tags$button(
              class = paste0("btn", " bg-", gradientColor, " btn-", boxToolSize),
              `data-widget` = "remove",
              type = "button",
              shiny::tags$i(class = "fa fa-times")
            )
          }
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
  )
}



#' @title AdminLTE2 mail form
#'
#' @description Create a mail form
#'
#' @param ... message text.
#' @param mailto person who should receive the mail.
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
#'       title = "Mail box demo",
#'       mailForm(mailto = "dgranjon@ymail.com")
#'      )
#'     ),
#'     title = "Description Blocks"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
mailForm <- function(..., mailto = "#") {
  shiny::tags$form(
    action = paste0("mailto:", mailto),
    method = "post",
    
    # subject input
    shiny::tags$div(
      class = "form-group",
      shiny::tags$input(
        type = "text",
        class = "form-control",
        name = "subject",
        placeholder = "Subject"
      )
    ),
    
    # body
    shiny::tags$div(
      
      ## mail toolbar
      # shiny::tags$ul(
      #   class = "wysihtml5-toolbar",
      #   shiny::tags$li(
      #     class = "dropdown",
      #     shiny::tags$a(
      #       class = "btn btn-default dropdown-toggle",
      #       `data-toggle` = "dropdown",
      #       `aria-expanded` = "false",
      #       
      #     )
      #   )
      # ),
      
      shiny::tags$textarea(
        class = "textarea",
        style = "width: 100%; height: 125px; font-size: 14px; line-height: 18px; 
                 border: 1px solid rgb(221, 221, 221); padding: 10px; display: none;",
        placeholder = "Message"
      ),
      
      shiny::tags$input(type = "hidden", name = "_wysihtml5_mode", value = "1"),
      
      shiny::tags$iframe(
        class = "wysihtml5-sandbox",
        security = "restricted",
        allowtransparency = "true",
        frameborder = "0",
        width = "0",
        height = "0",
        marginwidth = "0",
        marginheight = "0",
        style = "display: inline-block; background-color: rgb(255, 255, 255); 
                border-collapse: separate; border: 1px solid rgb(221, 221, 221); 
                clear: none; float: none; margin: 0px; outline: rgb(51, 51, 51) none 0px; 
                outline-offset: 0px; padding: 10px; position: static; top: auto; left: auto; 
                right: auto; bottom: auto; z-index: auto; vertical-align: baseline; 
                text-align: start; box-sizing: border-box; -webkit-box-shadow: none; 
                box-shadow: none; border-top-right-radius: 0px; border-bottom-right-radius: 0px; 
                border-bottom-left-radius: 0px; border-top-left-radius: 0px; width: 100%; height: 125px;",
        
        shiny::tags$html(
          shiny::tags$body(
            marginwidth = "0",
            marginheight = "0",
            class = "textarea wysihtml5-editor",
            spellcheck = "true",
            contenteditable = "true",
            style = "font-variant-ligatures: normal; font-variant-caps: normal; 
                     font-variant-east-asian: normal; font-variant-position: normal; 
                     background-color: rgb(255, 255, 255); color: rgb(51, 51, 51); 
                     cursor: auto; font-family: &quot;Source Sans Pro&quot;, 
                     &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; 
                     font-size: 14px; font-style: normal; font-weight: normal; line-height: 18px; 
                     letter-spacing: normal; text-align: start; text-decoration: none; text-indent: 0px; 
                     text-rendering: auto; word-break: normal; word-wrap: break-word; word-spacing: 0px;",
            ...
          )
        )
      )
      
    ),
    
    # send button
    shiny::tags$input(
      type = "submit",
      #class = "pull-right btn btn-default",
      value = "Send"
      #shiny::tags$i(class = "fa fa-arrow-circle-right")
    )
  )
}




#' @title AdminLTE2 widget user box
#'
#' @description Create widget user box
#'
#' @param ... body content.
#' @param title box title.
#' @param subtitle box subtitle.
#' @param type NULL by default. Choose the value 2 to try another skin.
#' @param background Whether to enable a background image in the box header.
#' @param backgroundUrl image url, if any. Background needs to be TRUE.
#' @param src header image, if any (this is different of the background image).
#' @param color background color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' @param footer box footer.
#' @param width box width (between 1 and 12). 
#' @param height box height.
#' @param boxToolSize size of the toolbox: choose among "xs", "sm", "md", "lg".
#' @param collapsible If TRUE, display a button in the upper right that allows the user to collapse the box. 
#' @param closable If TRUE, display a button in the upper right that allows the user to close the box.
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
#'      widgetUserBox(
#'       title = "Nadia Carmichael",
#'       subtitle = "lead Developer",
#'       type = 2,
#'       src = "https://adminlte.io/themes/AdminLTE/dist/img/user7-128x128.jpg",
#'       color = "yellow",
#'       "Some text here!",
#'       footer = "The footer here!"
#'      ),
#'      widgetUserBox(
#'       title = "Alexander Pierce",
#'       subtitle = "Founder & CEO",
#'       type = NULL,
#'       src = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
#'       color = "aqua-active",
#'       closable = TRUE,
#'       "Some text here!",
#'       footer = "The footer here!"
#'      ),
#'      widgetUserBox(
#'       title = "Elizabeth Pierce",
#'       subtitle = "Web Designer",
#'       type = NULL,
#'       src = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
#'       background = TRUE,
#'       backgroundUrl = "https://images.pexels.com/photos/531880/pexels-photo-531880.jpeg?auto=compress&cs=tinysrgb&h=350",
#'       closable = TRUE,
#'       "Some text here!",
#'       footer = "The footer here!"
#'      )
#'     ),
#'     title = "Description Blocks"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
widgetUserBox <- function(..., title = NULL, subtitle = NULL, type = NULL,
                          background = FALSE, backgroundUrl = NULL,
                          src = NULL, color = NULL, footer = NULL,
                          width = 6, height = NULL, boxToolSize = "sm",
                          collapsible = TRUE, closable = FALSE) {
  
  cl <- "widget-user-header"
  if (!is.null(color) && background == FALSE) cl <- paste0(cl, " bg-", color)
  if (isTRUE(background)) cl <- paste0(cl, " bg-black")
  
  boxCl <- "box box-widget widget-user"
  if (!is.null(type)) boxCl <- paste0(boxCl, "-", type)
  
  style <- NULL
  if (!is.null(height)) {
    style <- paste0("height: ", shiny::validateCssUnit(height))
  }
  
  backgroundStyle <- NULL
  if (isTRUE(background)) {
    backgroundStyle <- paste0("background: url('", backgroundUrl, "') center center;")
  }
  
  shiny::column(
    width = width,
    shiny::tags$div(
      class = boxCl,
      style = style,
      
      # header
      shiny::tags$div(
        class = cl,
        style = backgroundStyle,
        
        # box header buttons
        shiny::tags$div(
          class = "pull-right box-tools",
          if (collapsible) {
            shiny::tags$button(
              class = paste0("btn", " bg-", color, " btn-", boxToolSize),
              `data-widget` = "collapse",
              type = "button",
              shiny::tags$i(class = "fa fa-minus")
            )
          },
          if (closable) {
            shiny::tags$button(
              class = paste0("btn", " bg-", color, " btn-", boxToolSize),
              `data-widget` = "remove",
              type = "button",
              shiny::tags$i(class = "fa fa-times")
            )
          }
        ),
        
        # image
        shiny::tags$div(
          class = "widget-user-image",
          shiny::tags$img(class = "img-circle", src = src)
        ),
        
        # titles
        shiny::tags$h3(class = "widget-user-username", title),
        shiny::tags$h5(class = "widget-user-desc", subtitle)
        
      ),
      
      # body
      shiny::tags$div(class = "box-body", ...),
      
      # footer
      shiny::tags$div(class = "box-footer", footer)
    )
  )
}