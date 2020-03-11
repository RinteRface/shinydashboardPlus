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
#' @param footer_padding TRUE by default: whether the footer has margin or not.
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
#'       footer = sliderInput(
#'        "obs", 
#'        "Number of observations:",
#'         min = 0, max = 1000, value = 500
#'        ),
#'       "This is a gradient box"
#'       ),
#'       gradientBox(
#'       title = "My gradient Box",
#'       icon = "fa fa-heart",
#'       gradientColor = "maroon", 
#'       boxToolSize = "xs", 
#'       closable = TRUE,
#'       footer = "The footer goes here. You can include anything",
#'       "This is a gradient box"
#'       )
#'     ),
#'     title = "gradientBox"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
gradientBox <- function(..., title = NULL, icon = NULL, gradientColor = NULL, 
                        boxToolSize = "sm", footer = NULL, width = 6, height = NULL,
                        collapsible = TRUE, closable = FALSE, footer_padding = TRUE) {
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
        class = if (isTRUE(footer_padding)) {
          "box-footer text-black"
        } else {
          "box-footer text-black no-padding"
        },
        footer
      )
    )
  )
}



# #' @title AdminLTE2 mail form
# #'
# #' @description Create a mail form
# #'
# #' @param ... message text.
# #' @param mailto person who should receive the mail.
# #'
# #' @author David Granjon, \email{dgranjon@@ymail.com}
# #'
# #' @examples
# #' if (interactive()) {
# #'  library(shiny)
# #'  library(shinydashboard)
# #'  shinyApp(
# #'   ui = dashboardPage(
# #'     dashboardHeader(),
# #'     dashboardSidebar(),
# #'     dashboardBody(
# #'      box(
# #'       title = "Mail box demo",
# #'       mailForm(mailto = "dgranjon@ymail.com")
# #'      )
# #'     ),
# #'     title = "mailForm"
# #'   ),
# #'   server = function(input, output) { }
# #'  )
# #' }
# #'
# #' @export
# mailForm <- function(..., mailto = "#") {
#   shiny::tags$form(
#     action = paste0("mailto:", mailto),
#     method = "post",
#     
#     # subject input
#     shiny::tags$div(
#       class = "form-group",
#       shiny::tags$input(
#         type = "text",
#         class = "form-control",
#         name = "subject",
#         placeholder = "Subject"
#       )
#     ),
#     
#     # body
#     shiny::tags$div(
#       
#       ## mail toolbar
#       # shiny::tags$ul(
#       #   class = "wysihtml5-toolbar",
#       #   shiny::tags$li(
#       #     class = "dropdown",
#       #     shiny::tags$a(
#       #       class = "btn btn-default dropdown-toggle",
#       #       `data-toggle` = "dropdown",
#       #       `aria-expanded` = "false",
#       #       
#       #     )
#       #   )
#       # ),
#       
#       shiny::tags$textarea(
#         class = "textarea",
#         style = "width: 100%; height: 125px; font-size: 14px; line-height: 18px; 
#                  border: 1px solid rgb(221, 221, 221); padding: 10px; display: none;",
#         placeholder = "Message"
#       ),
#       
#       shiny::tags$input(type = "hidden", name = "_wysihtml5_mode", value = "1"),
#       
#       shiny::tags$iframe(
#         class = "wysihtml5-sandbox",
#         security = "restricted",
#         allowtransparency = "true",
#         frameborder = "0",
#         width = "0",
#         height = "0",
#         marginwidth = "0",
#         marginheight = "0",
#         style = "display: inline-block; background-color: rgb(255, 255, 255); 
#                 border-collapse: separate; border: 1px solid rgb(221, 221, 221); 
#                 clear: none; float: none; margin: 0px; outline: rgb(51, 51, 51) none 0px; 
#                 outline-offset: 0px; padding: 10px; position: static; top: auto; left: auto; 
#                 right: auto; bottom: auto; z-index: auto; vertical-align: baseline; 
#                 text-align: start; box-sizing: border-box; -webkit-box-shadow: none; 
#                 box-shadow: none; border-top-right-radius: 0px; border-bottom-right-radius: 0px; 
#                 border-bottom-left-radius: 0px; border-top-left-radius: 0px; width: 100%; height: 125px;",
#         
#         shiny::tags$html(
#           shiny::tags$body(
#             marginwidth = "0",
#             marginheight = "0",
#             class = "textarea wysihtml5-editor",
#             spellcheck = "true",
#             contenteditable = "true",
#             style = "font-variant-ligatures: normal; font-variant-caps: normal; 
#                      font-variant-east-asian: normal; font-variant-position: normal; 
#                      background-color: rgb(255, 255, 255); color: rgb(51, 51, 51); 
#                      cursor: auto; font-family: &quot;Source Sans Pro&quot;, 
#                      &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; 
#                      font-size: 14px; font-style: normal; font-weight: normal; line-height: 18px; 
#                      letter-spacing: normal; text-align: start; text-decoration: none; text-indent: 0px; 
#                      text-rendering: auto; word-break: normal; word-wrap: break-word; word-spacing: 0px;",
#             ...
#           )
#         )
#       )
#       
#     ),
#     
#     # send button
#     shiny::tags$input(
#       type = "submit",
#       #class = "pull-right btn btn-default",
#       value = "Send"
#       #shiny::tags$i(class = "fa fa-arrow-circle-right")
#     )
#   )
# }




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
#' @param collapsed If TRUE, start collapsed. This must be used with \code{collapsible=TRUE}.
#' @param closable If TRUE, display a button in the upper right that allows the user to close the box.
#' @param footer_padding TRUE by default: whether the footer has margin or not.
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
#'       backgroundUrl = "https://www.planwallpaper.com/static/images/744081-background-wallpaper.jpg",
#'       closable = TRUE,
#'       "Some text here!",
#'       footer = "The footer here!"
#'      )
#'     ),
#'     title = "widgetUserBox"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
widgetUserBox <- function(..., title = NULL, subtitle = NULL, type = NULL,
                          background = FALSE, backgroundUrl = NULL,
                          src = NULL, color = NULL, footer = NULL, footer_padding = TRUE,
                          width = 6, height = NULL, boxToolSize = "sm",
                          collapsible = TRUE, collapsed = FALSE, closable = FALSE) {
  
  cl <- "widget-user-header"
  if (!is.null(color) && background == FALSE) cl <- paste0(cl, " bg-", color)
  if (isTRUE(background)) cl <- paste0(cl, " bg-black")
  
  boxCl <- "box box-widget widget-user"
  if (!is.null(type)) boxCl <- paste0(boxCl, "-", type)
  if (collapsible && collapsed) {
    boxCl <- paste(boxCl, "collapsed-box")
  }
  
  style <- NULL
  if (!is.null(height)) {
    style <- paste0("height: ", shiny::validateCssUnit(height))
  }
  
  backgroundStyle <- NULL
  if (isTRUE(background)) {
    backgroundStyle <- paste0("background: url('", backgroundUrl, "') center center;")
  }
  
  # collapseTag
  collapseTag <- NULL
  if (collapsible) {
    collapseIcon <- if (collapsed) 
      "plus"
    else "minus"
    collapseTag <- shiny::tags$button(
      class = paste0("btn btn-box-tool", " bg-", color, " btn-", boxToolSize), 
      type = "button",
      `data-widget` = "collapse", 
      shiny::icon(collapseIcon)
    )
  }
  
  # closeTag
  closeTag <- NULL
  if (closable) {
    closeTag <- shiny::tags$button(
      class = paste0("btn btn-box-tool", " bg-", color, " btn-", boxToolSize),
      `data-widget` = "remove",
      type = "button",
      shiny::tags$i(class = "fa fa-times")
    )
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
          collapseTag,
          closeTag
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
      shiny::tags$div(
        class = if (isTRUE(footer_padding)) "box-footer" else "box-footer no-padding", 
        footer
      )
    )
  )
}




#' Create a box for the main body of a dashboard
#'
#' Boxes can be used to hold content in the main body of a dashboard.
#'
#' @param title Optional title.
#' @param footer Optional footer text.
#' @param status The status of the item This determines the item's background
#'   color. Valid statuses are listed in \link{validStatuses}.
#' @param solidHeader Should the header be shown with a solid color background?
#' @param background If NULL (the default), the background of the box will be
#'   white. Otherwise, a color string. Valid colors are listed in
#'   \link{validColors}.
#' @param width The width of the box, using the Bootstrap grid system. This is
#'   used for row-based layouts. The overall width of a region is 12, so the
#'   default valueBox width of 4 occupies 1/3 of that width. For column-based
#'   layouts, use \code{NULL} for the width; the width is set by the column that
#'   contains the box.
#' @param height The height of a box, in pixels or other CSS unit. By default
#'   the height scales automatically with the content.
#' @param collapsible If TRUE, display a button in the upper right that allows
#'   the user to collapse the box.
#' @param collapsed If TRUE, start collapsed. This must be used with
#'   \code{collapsible=TRUE}.
#' @param ... Contents of the box.
#' @param closable If TRUE, display a button in the upper right that allows the user to close the box.
#' @param enable_label Whether to display a label in the boxtool.
#' @param label_text label text.
#' @param label_status status of the box label: "danger", "success", "info", "primary", "warning".
#' @param enable_dropdown Whether to display a dropdown menu in the boxtool. FALSE by default.
#' @param dropdown_icon Dropdown icon. "wrench" by default.
#' @param dropdown_menu List of items in the the boxtool dropdown menu. Use dropdownItemList().
#' @param enable_sidebar Whether to display the box sidebar. FALSE by default.
#' @param sidebar_content Box sidebar content, if any.
#' @param sidebar_title Box sidebar title.
#' @param sidebar_width Box sidebar width in percentage. 25\% by default. Numeric value between 0 and 100.
#' @param sidebar_background Box sidebar background color. Dark by default.
#' @param sidebar_start_open Whether the box sidebar is open at start. FALSE by default.
#' @param sidebar_icon Box sidebar icon. 
#' @param footer_padding TRUE by default: whether the footer has margin or not.
#'
#' @family boxes
#'
#' @examples
#' ## Only run this example in interactive R sessions
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#' 
#'  shinyApp(
#'    ui = dashboardPagePlus(
#'      dashboardHeaderPlus(),
#'      dashboardSidebar(),
#'      dashboardBody(
#'       fluidRow(
#'        boxPlus(
#'         title = "Closable Box with dropdown", 
#'          closable = TRUE, 
#'          status = "warning", 
#'          solidHeader = FALSE, 
#'          collapsible = TRUE,
#'          enable_dropdown = TRUE,
#'          dropdown_icon = "wrench",
#'          dropdown_menu = dropdownItemList(
#'           dropdownItem(url = "https://www.google.com", name = "Link to google"),
#'           dropdownItem(url = "#", name = "item 2"),
#'           dropdownDivider(),
#'           dropdownItem(url = "#", name = "item 3")
#'          ),
#'          p("Box Content")
#'        ),
#'        boxPlus(
#'         title = "Closable box, with label", 
#'          closable = TRUE, 
#'          enable_label = TRUE,
#'          label_text = 1,
#'          label_status = "danger",
#'          status = "warning", 
#'          solidHeader = FALSE, 
#'          collapsible = TRUE,
#'          p("Box Content")
#'        )
#'      )
#'     )
#'    ),
#'    server = function(input, output) {}
#'  )
#'  
#'  # boxPlus with sidebar
#'  shinyApp(
#'   ui = dashboardPagePlus(
#'     dashboardHeaderPlus(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'       fluidRow(
#'         boxPlus(
#'           title = "Closable Box with dropdown", 
#'           closable = TRUE, 
#'           status = "warning", 
#'           solidHeader = FALSE, 
#'           collapsible = TRUE,
#'           enable_sidebar = TRUE,
#'           sidebar_width = 25,
#'           side_bar_title = "Title",
#'           sidebar_start_open = TRUE,
#'           sidebar_content = sliderInput(
#'            "obs", 
#'            "Number of observations:",
#'            min = 0, 
#'            max = 1000, 
#'            value = 500
#'           ),
#'           plotOutput("distPlot")
#'         )
#'       )
#'     )
#'   ),
#'   server = function(input, output) {
#'     output$distPlot <- renderPlot({
#'       hist(rnorm(input$obs))
#'     })
#'   }
#'  )
#' }
#' @export
boxPlus <- function(..., title = NULL, footer = NULL, status = NULL, solidHeader = FALSE, 
                     background = NULL, width = 6, height = NULL, collapsible = FALSE, 
                     collapsed = FALSE, closable = TRUE, enable_label = FALSE,
                     label_text = NULL, label_status = "primary", enable_dropdown = FALSE,
                     dropdown_icon = "wrench", dropdown_menu = NULL, enable_sidebar = FALSE,
                     sidebar_content = NULL, sidebar_title = NA_character_, sidebar_width = 25, sidebar_background = "#222d32", 
                     sidebar_start_open = FALSE, sidebar_icon = "cogs", footer_padding = TRUE) 
{
  
  if (sidebar_width < 0 || sidebar_width > 100) 
    stop("The box sidebar should be between 0 and 100")
  
  boxClass <- "box"
  if (solidHeader || !is.null(background)) {
    boxClass <- paste(boxClass, "box-solid")
  }
  if (!is.null(status)) {
    validateStatusPlus(status)
    boxClass <- paste0(boxClass, " box-", status)
  }
  if (collapsible && collapsed) {
    boxClass <- paste(boxClass, "collapsed-box")
  }
  if (!is.null(background)) {
    validateColor(background)
    boxClass <- paste0(boxClass, " bg-", background)
  }
  if (enable_sidebar) {
    if (sidebar_start_open) {
      boxClass <- paste0(boxClass, " direct-chat direct-chat-contacts-open")
    } else {
      boxClass <- paste0(boxClass, " direct-chat")
    }
  }
  style <- NULL
  if (!is.null(height)) {
    style <- paste0("height: ", shiny::validateCssUnit(height))
  }
  titleTag <- NULL
  if (!is.null(title)) {
    titleTag <- shiny::tags$h3(class = "box-title", title)
  }
  
  # the new boxtool section
  boxToolTag <- NULL
  if (collapsible || closable) {
    boxToolTag <- shiny::tags$div(class = "box-tools pull-right")
  }
  
  collapseTag <- NULL
  if (collapsible) {
    buttonStatus <- status %OR% "default"
    collapseIcon <- if (collapsed) 
      "plus"
    else "minus"
    collapseTag <- shiny::tags$button(
      class = paste0("btn btn-box-tool"), 
      `data-widget` = "collapse", shiny::icon(collapseIcon)
    )
  }
  
  closableTag <- NULL
  if (closable) {
    closableTag <- shiny::tags$button(
      class = "btn btn-box-tool", 
      `data-widget` = "remove", 
      type = "button",
      shiny::tags$i(shiny::icon("times"))
    )
  } 
  
  labelTag <- NULL
  if (enable_label) {
    labelTag <- dashboardLabel(label_text, status = label_status)
  }

  dropdownTag <- NULL
  if (enable_dropdown) {
    dropdownTag <- shiny::tags$div(
      class = "btn-group",
      shiny::tags$button(
        type = "button",
        class = "btn btn-box-tool dropdown-toggle",
        `data-toggle` = "dropdown",
        shiny::icon(dropdown_icon)
      ),
      shiny::tagList(dropdown_menu)
    )
  }
  
  sidebarTag <- NULL
  if (enable_sidebar) {
    sidebarTag <- shiny::tags$button(
      class = "btn btn-box-tool",
      `data-widget` = "chat-pane-toggle",
      `data-toggle` = "tooltip",
      `data-original-title` = "More",
      title = sidebar_title,
      type = "button",
      shiny::icon(sidebar_icon)
    )
  }
  
  
  # update boxToolTag
  boxToolTag <- shiny::tagAppendChildren(
    boxToolTag, 
    labelTag, 
    dropdownTag, 
    sidebarTag, 
    collapseTag, 
    closableTag
  )
  
  headerTag <- NULL
  if (!is.null(titleTag) || !is.null(collapseTag)) {
    # replace by boxToolTag
    headerTag <- shiny::tags$div(class = "box-header", titleTag, boxToolTag)
  }
  
  boxPlusTag <- shiny::tags$div(
    class = if (!is.null(width)) paste0("col-sm-", width), 
    shiny::tags$div(
      class = boxClass, 
      style = if (!is.null(style)) style, 
      headerTag, 
      shiny::tags$div(
        class = "box-body", 
        ...,
        if (enable_sidebar) {
          shiny::tags$div(
            style = "z-index: 1000;",
            class = "direct-chat-contacts",
            shiny::tags$ul(
              class = "contacts-list", 
              shiny::tags$li(
                style = paste0("width: ", sidebar_width, "%;"), 
                sidebar_content
              )
            )
          )
        }
      ), 
      if (!is.null(footer)) shiny::tags$div(
        class = if (isTRUE(footer_padding)) "box-footer" else "box-footer no-padding", footer)
    )
  )
  
  translation_rate <- paste0(100 - sidebar_width, "%")
  
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$style(
          shiny::HTML(
            # the first CSS class will be useful maybe for
            # later release but is useless right now
            paste0(
              ".direct-chat-contacts {
                 -webkit-transform: translate(100%, 0);
                 -ms-transform: translate(100%, 0);
                 -o-transform: translate(100%, 0);
                 transform: translate(100%, 0);
                 position: absolute;
                 top: 0;
                 bottom: 0;
                 height: 100%;
                 width: 100%;
                 background: ", sidebar_background, ";
                 color: #fff;
                 overflow: auto;
              }
              .direct-chat-contacts-open .direct-chat-contacts {
                -webkit-transform: translate(", translation_rate, ", 0);
                -ms-transform: translate(", translation_rate, ", 0);
                -o-transform: translate(", translation_rate, ", 0);
                transform: translate(", translation_rate, ", 0);
              }
              "
            )
          )
        )
      )
    ),
    boxPlusTag
  )
  
}



#' Create a box dropdown item list
#'
#' Can be used to add dropdown items to a boxtool.
#'
#' @param ... Slot for dropdownItem.
#'
#' @export
dropdownItemList <- function(...) {
  shiny::tags$ul(
    class = "dropdown-menu",
    role = "menu",
    ...
  )
}


#' Create a box dropdown item 
#'
#' @param url Target url or page.
#' @param name Menu name.
#'
#' @export
dropdownItem <- function(url = NULL, name = NULL) {
  shiny::tags$li(
    shiny::tags$a(
      href = url,
      target = "_blank",
      name 
    )
  )
}


#' Create a box dropdown divider 
#'
#' @note Useful to separate 2 sections of dropdown items.
#'
#' @export
dropdownDivider <- function() {
  shiny::tags$li(class = "divider")
}


#' @title AdminLTE2 social box
#'
#' @description Create social box
#'
#' @param ... body content. May include attachmentBlock for instance.
#' @param src header image, if any.
#' @param title box title.
#' @param subtitle box subtitle.
#' @param width box width (between 1 and 12). 
#' @param height box height.
#' @param collapsible If TRUE, display a button in the upper right that allows the user to collapse the box. 
#' @param closable If TRUE, display a button in the upper right that allows the user to close the box.
#' @param comments slot for boxComments.
#' @param footer box footer, if any.
#' @param footer_padding TRUE by default: whether the footer has margin or not.
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
#'      socialBox(
#'       title = "Social Box",
#'       subtitle = "example-01.05.2018",
#'       src = "https://adminlte.io/themes/AdminLTE/dist/img/user4-128x128.jpg",
#'       "Some text here!",
#'       attachmentBlock(
#'        src = "https://adminlte.io/themes/AdminLTE/dist/img/photo1.png",
#'        title = "Test",
#'        title_url = "https://google.com",
#'        "This is the content"
#'       ),
#'       comments = tagList(
#'        lapply(X = 1:10, FUN = function(i) {
#'         boxComment(
#'           src = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
#'           title = paste("Comment", i),
#'           date = "01.05.2018",
#'           paste0("The ", i, "-th comment")
#'         )
#'        })
#'       ),
#'       footer = "The footer here!"
#'      )
#'     ),
#'     title = "socialBox"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
socialBox <- function(..., src = NULL, title = NULL, subtitle = NULL, 
                      width = 6, height = NULL, collapsible = TRUE,
                      closable = TRUE, comments = NULL, footer = NULL,
                      footer_padding = TRUE) {
  
  style <- NULL
  if (!is.null(height)) {
    style <- paste0("height: ", shiny::validateCssUnit(height))
  }
  
  shiny::column(
    width = width,
    shiny::tags$div(
      class = "box box-widget",
      style = style,
      
      # header
      shiny::tags$div(
        class = "box-header with-border",
        
        # userblock
        shiny::tags$div(
          class = "user-block",
          shiny::img(class = "img-circle", src = src),
          shiny::tags$span(
            class = "username",
            shiny::a(href = "javascript:void(0)", title)
          ),
          shiny::tags$span(class = "description", subtitle)
        ),
        
        # boxTool
        shiny::tags$div(
          class = "box-tools",
          if (collapsible) {
            shiny::tags$button(
              class = "btn btn-box-tool",
              `data-widget` = "collapse",
              type = "button",
              shiny::tags$i(class = "fa fa-minus")
            )
          },
          if (closable) {
            shiny::tags$button(
              class = "btn btn-box-tool",
              `data-widget` = "remove",
              type = "button",
              shiny::tags$i(class = "fa fa-times")
            )
          }
        )
      ),
      
      # box body
      shiny::tags$div(
        class = "box-body",
        ...
      ),
      
      # box comments
      if (!is.null(comments)) {
        shiny::tags$div(
          class = "box-footer box-comments",
          style = "overflow-y: auto; max-height: 150px;",
          comments
        ) 
      },
      
      # footer
      if (!is.null(footer)) {
        shiny::tags$div(
          class = if (isTRUE(footer_padding)) "box-footer" else "box-footer no-padding", 
          footer
        ) 
      }
    )
  )
}


#' @title AdminLTE2 box comment
#'
#' @description Create box comment
#'
#' @param ... comment content.
#' @param src author image, if any.
#' @param title comment title.
#' @param date date of publication.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
boxComment <- function(..., src = NULL, title = NULL, date = NULL) {
  shiny::tags$div(
    class = "box-comment",
    shiny::img(class = "img-circle", src = src),
    shiny::tags$div(
      class = "comment-text",
      shiny::tags$span(
        class = "username", 
        title,
        shiny::tags$span(class = "text-muted pull-right", date)
      ),
      ...
    )
  )
}

#' @title AdminLTE2 box profile
#'
#' @description Create box profile
#'
#' @param ... any element such as boxProfileItemList.
#' @param src profile image, if any.
#' @param title title.
#' @param subtitle subtitle.
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
#'       title = "Box with profile",
#'       status = "primary",
#'       boxProfile(
#'        src = "https://adminlte.io/themes/AdminLTE/dist/img/user4-128x128.jpg",
#'        title = "Nina Mcintire",
#'        subtitle = "Software Engineer",
#'        boxProfileItemList(
#'         bordered = TRUE,
#'         boxProfileItem(
#'          title = "Followers",
#'          description = 1322
#'         ),
#'         boxProfileItem(
#'          title = "Following",
#'          description = 543
#'         ),
#'         boxProfileItem(
#'          title = "Friends",
#'          description = 13287
#'         )
#'        )
#'       )
#'      )
#'     ),
#'     title = "boxProfile"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#' 
#' @export
boxProfile <- function(..., src = NULL, title = NULL, subtitle = NULL) {
  shiny::tags$div(
    class = "box-body, box-profile",
    if (!is.null(src)) {
      shiny::img(class = "profile-user-img img-responsive img-circle", src = src)
    },
    shiny::h3(class = "profile-username text-center", title),
    shiny::p(class = "text-muted text-center", subtitle),
    ...
  )
}

#' @title AdminLTE2 box profile item container
#'
#' @description Create box profile item list
#'
#' @param ... slot for boxProfileItem.
#' @param bordered Whether the container should have a border or not. FALSE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
boxProfileItemList <- function(..., bordered = FALSE) {
  
  cl <- if (isTRUE(bordered)) "list-group" else "list-group list-group-unbordered"
  
  shiny::tags$ul(
    class = cl,
    ...
  )
}

#' @title AdminLTE2 box profile item 
#'
#' @description Create box profile item 
#'
#' @param title item title.
#' @param description item info.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
boxProfileItem <- function(title = NULL, description = NULL) {
  shiny::tags$li(
    class = "list-group-item",
    shiny::strong(title),
    shiny::a(class = "pull-right", description)
  )
}



#' @title AdminLTE2 flipping box
#'
#' @description Create a flipping box
#'
#' @param ... front body content.
#' @param back_content back body content.
#' @param id Box id. Must be unique!
#' @param front_title Box front title.
#' @param back_title Box back title.
#' @param front_btn_text Front button text.
#' @param back_btn_text Back button text.
#' @param header_img Header background image url or path.
#' @param main_img Main image url or path (for instance profile image).
#' 
#' @param width box width (between 1 and 12). 6 by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinydashboardPlus)
#'  shinyApp(
#'    ui = dashboardPage(
#'      dashboardHeader(),
#'      dashboardSidebar(),
#'      dashboardBody(
#'        setShadow("card"),
#'        fluidRow(
#'          column(
#'            width = 6,
#'            align = "center",
#'            flipBox(
#'              id = 1,
#'              main_img = "https://image.flaticon.com/icons/svg/149/149076.svg",
#'              header_img = "https://image.flaticon.com/icons/svg/119/119595.svg",
#'              front_title = "John Doe",
#'              back_title = "About John",
#'              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, 
#'              sed do eiusmod tempor incididunt ut labore et dolore magna 
#'              aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
#'              ullamco laboris nisi ut aliquip ex ea commodo consequat. 
#'              Duis aute irure dolor in reprehenderit in voluptate velit 
#'              esse cillum dolore eu fugiat nulla pariatur. Excepteur sint 
#'              occaecat cupidatat non proident, sunt in culpa qui officia 
#'              deserunt mollit anim id est laborum",
#'              fluidRow(
#'                dashboardLabel("Label 1", status = "info"),
#'                dashboardLabel("Label 2", status = "success"),
#'                dashboardLabel("Label 3", status = "warning"),
#'                dashboardLabel("Label 4", status = "primary"),
#'                dashboardLabel("Label 5", status = "danger")
#'              ),
#'              hr(),
#'              fluidRow(
#'                column(
#'                  width = 6,
#'                  align = "center",
#'                  starBlock(grade = 5),
#'                  starBlock(grade = 5, color = "olive"),
#'                  starBlock(grade = 1, color = "maroon"),
#'                  starBlock(grade = 3, color = "teal")
#'                ),
#'                column(
#'                  width = 6,
#'                  align = "center",
#'                  appButton(
#'                    url = "https://google.com",
#'                    label = "Users",
#'                    icon = "fa fa-users",
#'                    enable_badge = TRUE,
#'                    badgeColor = "purple",
#'                    badgeLabel = 891
#'                  ),
#'                  appButton(
#'                    label = "Edit",
#'                    icon = "fa fa-edit",
#'                    enable_badge = FALSE,
#'                    badgeColor = NULL,
#'                    badgeLabel = NULL
#'                  )
#'                )
#'              ),
#'              back_content = tagList(
#'                column(
#'                  width = 12,
#'                  align = "center",
#'                  sliderInput(
#'                    "obs", 
#'                    "Number of observations:",
#'                    min = 0, 
#'                    max = 1000, 
#'                    value = 500
#'                  )
#'                ),
#'                plotOutput("distPlot")
#'              )
#'            )
#'        ),
#'        column(
#'          width = 6,
#'          align = "center",
#'          flipBox(
#'            id = 2,
#'            main_img = "https://image.flaticon.com/icons/svg/149/149073.svg",
#'            header_img = "https://image.flaticon.com/icons/svg/119/119598.svg",
#'            front_title = "Johanna Doe",
#'            back_title = "About Johanna",
#'            fluidRow(
#'              column(
#'                width = 6,
#'                align = "center",
#'                boxPad(
#'                  color = "green",
#'                  descriptionBlock(
#'                    header = "8390",
#'                    text = "VISITS",
#'                    right_border = FALSE,
#'                    margin_bottom = TRUE
#'                  ),
#'                  descriptionBlock(
#'                    header = "30%",
#'                    text = "REFERRALS",
#'                    right_border = FALSE,
#'                    margin_bottom = TRUE
#'                  ),
#'                  descriptionBlock(
#'                    header = "70%",
#'                    text = "ORGANIC",
#'                    right_border = FALSE,
#'                    margin_bottom = FALSE
#'                  )
#'                )
#'              ),
#'              column(
#'                width = 6,
#'                align = "center",
#'                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, 
#'                sed do eiusmod tempor.",
#'                br(),
#'                verticalProgress(
#'                  value = 10,
#'                  striped = TRUE,
#'                  active = TRUE
#'                ),
#'                verticalProgress(
#'                  value = 50,
#'                  active = TRUE,
#'                  status = "warning",
#'                  size = "xs"
#'                ),
#'                verticalProgress(
#'                  value = 20,
#'                  status = "danger",
#'                  size = "sm",
#'                  height = "60%"
#'                )
#'              )
#'            ),
#'            back_content = tagList(
#'              column(
#'                width = 12,
#'                align = "center",
#'                radioButtons(
#'                  "dist", 
#'                  "Distribution type:",
#'                  c("Normal" = "norm",
#'                    "Uniform" = "unif",
#'                    "Log-normal" = "lnorm",
#'                    "Exponential" = "exp"
#'                  )
#'                )
#'              ),
#'              plotOutput("plot")
#'            )
#'        )
#'        )
#'      )
#'    ),
#'    title = "flipBox"
#'    ),
#'    server = function(input, output) {
#'      output$distPlot <- renderPlot({
#'        hist(rnorm(input$obs))
#'      })
#'      output$plot <- renderPlot({
#'        dist <- switch(input$dist,
#'                       norm = rnorm,
#'                       unif = runif,
#'                       lnorm = rlnorm,
#'                       exp = rexp,
#'                       rnorm)
#'        
#'        hist(dist(500))
#'      })
#'    }
#'   )
#' }
#'
#' @export
flipBox <- function(..., back_content, id, front_title = NULL, back_title = NULL, 
                    front_btn_text = "More", back_btn_text = "Back to main", 
                    header_img = NULL, main_img = NULL, width = 6) {
  
  if (is.null(id)) stop("card id cannot be null and must be unique")
  
  flipBoxTag <- shiny::tags$div(
    class = paste0("col sm-", width),
    shiny::tags$div(
      class = "rotate-container",
      # Front
      shiny::tags$div(
        class = paste0("card card-front-", id , " text-center"),
        style = "background-color: #ffffff;",
        # background
        shiny::tags$div(class = paste0("card-background-", id)),
        shiny::tags$div(
          class = "card-block",
          shiny::tags$img(
            class = "avatar",
            src = main_img,
            alt = "Avatar"
          ),
          shiny::tags$h3(class = "card-title", front_title),
          shiny::tags$p(...),
          shiny::tags$button(
            id = paste0("btn-", id, "-front"),
            class = "btn btn-primary btn-rotate",
            shiny::tags$i(class = "fa fa-long-arrow-right"), 
            front_btn_text      
          )
        )
      ),
      # back
      shiny::tags$div(
        class = paste0("card card-back-", id , " text-center"),
        style = "background-color: #ffffff;",
        shiny::br(),
        shiny::tags$div(
          class = "card-header",
          shiny::tags$p(
            shiny::tags$button(
              id = paste0("btn-", id, "-back"),
              class = "btn btn-primary btn-rotate",
              shiny::tags$i(class = "fa fa-long-arrow-left"), 
              back_btn_text      
            ),
            shiny::h4(back_title)
          )
        ),
        shiny::hr(),
        shiny::tags$div(
          class = "card-block",
          shiny::tags$p(back_content)
        )
      )
    )
  )
  
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        # CSS
        shiny::tags$style(
          shiny::HTML(
            paste0(
              "/* Card styles for rotation */
              .rotate-container {
                position: relative;
               }
               .rotate-container .card-front-", id, ", .rotate-container .card-back-", id," {
                width: 100%;
                height: 100%;
                -webkit-transform: perspective(600px) rotateY(0deg);
                transform: perspective(600px) rotateY(0deg);
                -webkit-backface-visibility: hidden;
                backface-visibility: hidden;
                transition: all 0.5s linear 0s;
               }
               .rotate-container .card-back-", id, " {
                -webkit-transform: perspective(1600px) rotateY(180deg);
                transform: perspective(1600px) rotateY(180deg);
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
               }
               .rotate-container .rotate-card-front-", id, " {
                -webkit-transform: perspective(1600px) rotateY(-180deg);
                transform: perspective(1600px) rotateY(-180deg);
               }
               .rotate-container .rotate-card-back-", id, " {
                -webkit-transform: perspective(1600px) rotateY(0deg);
                transform: perspective(1600px) rotateY(0deg);
               }
               
               /* Modified card styles */
               .card {
                box-shadow: 0 8px 6px -6px rgba(0, 0, 0, 0.5);
               }
               .card .card-header p {
                margin: 0;
               }
               
               .card .card-background-", id, " {
                background: url('", header_img, "');
                height: 8em;
                background-position: center center;
                background-size: cover;
               }
               .card .avatar {
                max-width: 6em;
                max-height: 6em;
                margin-top: -4em;
                margin-bottom: 1em;
                border: 4px solid white;
                border-radius: 50%;
                background: radial-gradient(#e3e3e3, #329A7C, #109381);
               }
               .card .btn {
                margin-bottom: 1em;
                cursor: pointer;
               }
               .card .social-links li {
                margin: 0.5em;
               }
               .card .social-links a {
                font-size: 1.5em;
               }
               " 
            )
          )
        ),
        # Javascript
        shiny::tags$script(
          shiny::HTML(
            paste0(
              "$(function() {
                // For card rotation
                $('#btn-", id,"-front').click(function(){
                  $('.card-front-", id,"').addClass(' rotate-card-front-", id, "');
                  $('.card-back-", id,"').addClass(' rotate-card-back-", id, "');
                });
                $('#btn-", id,"-back').click(function(){
                  $('.card-front-", id,"').removeClass(' rotate-card-front-", id, "');
                  $('.card-back-", id,"').removeClass(' rotate-card-back-", id, "');
                });
              });
              "
            )
          )
        )
      )
    ),
    flipBoxTag
  )
}