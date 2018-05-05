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
#'     title = "mailForm"
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
#'         title = "Closable Box", 
#'          closable = TRUE, 
#'          label_status = "danger",
#'          status = "warning", 
#'          solidHeader = FALSE, 
#'          collapsible = TRUE,
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
#' }
#' @export
boxPlus <- function(..., title = NULL, footer = NULL, status = NULL, solidHeader = FALSE, 
                     background = NULL, width = 6, height = NULL, collapsible = FALSE, 
                     collapsed = FALSE, closable = TRUE, enable_label = FALSE,
                     label_text = NULL, label_status = "primary", footer_padding = TRUE) 
{
  boxClass <- "box"
  if (solidHeader || !is.null(background)) {
    boxClass <- paste(boxClass, "box-solid")
  }
  if (!is.null(status)) {
    validateStatus(status)
    boxClass <- paste0(boxClass, " box-", status)
  }
  if (collapsible && collapsed) {
    boxClass <- paste(boxClass, "collapsed-box")
  }
  if (!is.null(background)) {
    validateColor(background)
    boxClass <- paste0(boxClass, " bg-", background)
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
  
  
  # update boxToolTag
  boxToolTag <- shiny::tagAppendChildren(boxToolTag, labelTag, collapseTag, closableTag)
  
  headerTag <- NULL
  if (!is.null(titleTag) || !is.null(collapseTag)) {
    # replace by boxToolTag
    headerTag <- shiny::tags$div(class = "box-header", titleTag, boxToolTag)
  }
  shiny::tags$div(class = if (!is.null(width)) 
    paste0("col-sm-", width), shiny::tags$div(class = boxClass, style = if (!is.null(style)) 
      style, headerTag, shiny::tags$div(class = "box-body", ...), if (!is.null(footer)) 
        shiny::tags$div(class = if (isTRUE(footer_padding)) "box-footer" else "box-footer no-padding", footer)))
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
#'        src = "http://kiev.carpediem.cd/data/afisha/o/2d/c7/2dc7670333.jpg",
#'        title = "Test",
#'        title_url = "http://google.com",
#'        "This is the content"
#'       ),
#'       comments = tagList(
#'        boxComment(
#'         src = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
#'         title = "Comment 1",
#'         date = "01.05.2018",
#'         "The first comment"
#'        ),
#'        boxComment(
#'         src = "https://adminlte.io/themes/AdminLTE/dist/img/user5-128x128.jpg",
#'         title = "Comment 2",
#'         date = "01.05.2018",
#'         "The second comment"
#'        )
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
            shiny::a(href = "#", title)
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
      shiny::tags$div(
        class = "box-footer box-comments",
        comments
      ),
      
      # footer
      shiny::tags$div(
        class = if (isTRUE(footer_padding)) "box-footer" else "box-footer no-padding", 
        footer
      )
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
    shiny::img(class = "profile-user-img img-responsive img-circle", src = src),
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
