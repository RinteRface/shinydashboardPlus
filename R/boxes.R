#' @title AdminLTE2 user box
#'
#' @description Create user box
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
#' @param footerPadding TRUE by default: whether the footer has margin or not.
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
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      userBox(
#'       title = "Nadia Carmichael",
#'       subtitle = "lead Developer",
#'       type = 2,
#'       src = "https://adminlte.io/themes/AdminLTE/dist/img/user7-128x128.jpg",
#'       color = "yellow",
#'       "Some text here!",
#'       footer = "The footer here!"
#'      ),
#'      userBox(
#'       title = "Alexander Pierce",
#'       subtitle = "Founder & CEO",
#'       type = NULL,
#'       src = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
#'       color = "aqua-active",
#'       closable = TRUE,
#'       "Some text here!",
#'       footer = "The footer here!"
#'      ),
#'      userBox(
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
userBox <- function(..., title = NULL, subtitle = NULL, type = NULL,
                          background = FALSE, backgroundUrl = NULL,
                          src = NULL, color = NULL, footer = NULL, footerPadding = TRUE,
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
        class = if (isTRUE(footerPadding)) "box-footer" else "box-footer no-padding", 
        footer
      )
    )
  )
}




#' Create a box for the main body of a dashboard
#'
#' Boxes can be used to hold content in the main body of a dashboard.
#' 
#' @param ... Contents of the box.
#' @param inputId Box unique id. \link{updateBox} target.
#' @param title Optional title.
#' @param footer Optional footer text.
#' @param status The status of the item This determines the item's background
#'   color. Valid statuses are listed in \link{validStatuses}.
#' @param solidHeader Should the header be shown with a solid color background?
#' @param background If NULL (the default), the background of the box will be
#'   white. Otherwise, a color string. Valid colors are listed in
#'   \link{validColors}.
#' @param icon Header icon. Displayed before title. Expect \code{\link[shiny]{icon}}.
#' @param gradient Whether to allow gradient effect for the background color. Default to FALSE.
#' @param boxToolSize Size of the toolbox: choose among "xs", "sm", "md", "lg".
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
#' @param closable If TRUE, display a button in the upper right that allows the user to close the box.
#' @param label Slot for \link{boxLabel}.
#' @param dropdownMenu List of items in the boxtool dropdown menu. Use \link{boxDropdown}.
#' @param sidebar Slot for \link{boxSidebar}.
#' @param footerPadding TRUE by default: whether the footer has margin or not.
#'
#' @family boxes
#'
#' @examples
#' ## Only run this example in interactive R sessions
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinydashboardPlus)
#' 
#'  shinyApp(
#'    ui = dashboardPage(
#'      dashboardHeader(),
#'      dashboardSidebar(),
#'      dashboardBody(
#'       box(
#'         title = "Closable Box with dropdown", 
#'         closable = TRUE, 
#'         width = 12,
#'         status = "warning", 
#'         solidHeader = FALSE, 
#'         collapsible = TRUE,
#'         label = boxLabel(
#'          text = 1,
#'          status = "danger",
#'          style = "circle"
#'         ),
#'         dropdownMenu = boxDropdown(
#'          boxDropdownItem(url = "http://www.google.com", name = "Link to google"),
#'          boxDropdownItem(url = "#", name = "item 2"),
#'          dropdownDivider(),
#'          boxDropdownItem(url = "#", name = "item 3")
#'         ),
#'         sidebar = boxSidebar(
#'          startOpen = TRUE,
#'          inputId = "mycardsidebar",
#'          sliderInput(
#'           "obs", 
#'           "Number of observations:",
#'           min = 0, 
#'           max = 1000, 
#'           value = 500
#'          )
#'         ),
#'         plotOutput("distPlot")
#'        )
#'      )
#'    ),
#'    server = function(input, output) {
#'     output$distPlot <- renderPlot({
#'      hist(rnorm(input$obs))
#'     })
#'    }
#'  )
#' }
#' @export
box <- function(..., inputId = NULL, title = NULL, footer = NULL, status = NULL, solidHeader = FALSE, 
                     background = NULL, icon = NULL, gradient = FALSE, boxToolSize = "sm", 
                     width = 6, height = NULL, collapsible = FALSE, 
                     collapsed = FALSE, closable = FALSE, label = NULL, dropdownMenu = NULL,
                    sidebar = NULL, footerPadding = TRUE) {
  
  
  if (!collapsible && collapsed) {
    stop("Cannot collapse a card that is not collapsible.")
  }
  
  if (is.null(status) && solidHeader) stop("solidHeader cannot be used when status is NULL.")
  if (gradient && is.null(background)) stop("gradient cannot be used when background is NULL.")
  
  
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
    boxClass <- paste0(boxClass, " bg-", background, if (gradient) "-gradient")
  }
  
  if (!is.null(sidebar)) {
    sidebarToggle <- sidebar[[2]]
    startOpen <- sidebar[[2]]$attribs$`data-start-open`
    if (startOpen == "true") {
      boxClass <- paste0(boxClass, " direct-chat direct-chat-contacts-open")
    } else {
      boxClass <- paste0(boxClass, " direct-chat")
    }
  }
  
  if (!is.null(width)) {
    stopifnot(is.numeric(width))
    # respect the bootstrap grid
    stopifnot(width <= 12)
    stopifnot(width >= 0)
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
    btnToolClass <- "btn"
    btnToolClass <- if (!is.null(status)) {
      paste(btnToolClass, "btn-box-tool")
    } else {
      paste0(
        btnToolClass, 
        if (!is.null(background)) paste0(" bg-", background),
        " btn-", boxToolSize
      )
    }
    
    boxToolTag <- shiny::tags$div(class = "box-tools pull-right")
  }
  
  collapseTag <- NULL
  if (collapsible) {
    buttonStatus <- status %OR% "default"
    collapseIcon <- if (collapsed) 
      "plus"
    else "minus"
    collapseTag <- shiny::tags$button(
      class = btnToolClass, 
      `data-widget` = "collapse", shiny::icon(collapseIcon)
    )
  }
  
  closableTag <- NULL
  if (closable) {
    closableTag <- shiny::tags$button(
      class = btnToolClass, 
      `data-widget` = "remove", 
      type = "button",
      shiny::tags$i(shiny::icon("times"))
    )
  } 
  
  # Modify sidebar trigger class if background ...
  if (!is.null(sidebar)) {
    if (is.null(status)) {
      sidebar[[2]]$attribs$class <- paste0(
        "btn",
        if (!is.null(background)) {
          paste0(" bg-", background)
        },
        " btn-", boxToolSize
      ) 
    }
  }
  
  # modify dropdown trigger if background
  if (!is.null(dropdownMenu)) {
    if (is.null(status)) {
      dropdownMenu$children[[1]]$attribs$class <- paste0(
        "btn", 
        paste0(
          if (!is.null(background)) {
            paste0(" bg-", background)
          },
          " btn-", boxToolSize
        ), 
        " dropdown-toggle"
      )
    }
    
  }
  
  # update boxToolTag
  boxToolTag <- shiny::tagAppendChildren(
    boxToolTag, 
    if (!is.null(label)) label, 
    if (!is.null(dropdownMenu)) dropdownMenu, 
    collapseTag, 
    closableTag,
    if (!is.null(sidebar)) sidebar[[2]]
  )
  
  
  headerTag <- NULL
  if (!is.null(titleTag) || !is.null(collapseTag)) {
    # replace by boxToolTag
    headerTag <- shiny::tags$div(
      class = "box-header",
      # header icon
      if (!is.null(icon)) icon, 
      titleTag, 
      boxToolTag
    )
  }
  
  boxTag <- shiny::tags$div(
    class = if (!is.null(width)) paste0("col-sm-", width), 
    shiny::tags$div(
      id = inputId,
      class = boxClass, 
      headerTag, 
      shiny::tags$div(
        class = "box-body", 
        style = if (is.null(sidebar)) {
          if (!is.null(style)) style
        },
        if (!is.null(sidebar)) {
          shiny::tags$div(
            class = "direct-chat-messages",
            shiny::tags$div(
              class = "direct-chat-msg", 
              ...,
              style = if (!is.null(style)) style
            ),
            sidebar[c(1, 3)],
          )
        } else {
          shiny::tagList(...)
        }
      ), 
      if (!is.null(footer)) shiny::tags$div(
        class = if (isTRUE(footerPadding)) "box-footer" else "box-footer no-padding", footer)
    )
  )
  
  boxTag
  
}



#' Create a label for \link{box} 
#'
#' @param text Label text. In practice only few letters or a number.
#' @param status label color status. See \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' @param style label border style: "default" (rounded angles), "circle" or "square".
#' @export
#' @seealso \link{dashboardLabel}
boxLabel <- function(text, status, style = "default") {
  
  if (nchar(text) > 10) warning("Avoid long texts in boxPlusLabel.")
  dashboardLabel(text, status = status, style = style)
}




#' Create a sidebar for a box
#' 
#' To insert in the sidebar slot of \link{box}.
#'
#' @param ... Sidebar content.
#' @param inputId Unique sidebar id. Useful if you want to use \link{updateBoxSidebar}.
#' @param width Sidebar width in percentage. 25\% by default. A character value of any width CSS understands (e.g. "100px").
#' @param background Sidebar background color. Dark by default.
#' @param startOpen Whether the sidebar is open at start. FALSE by default.
#' @param icon Sidebar icon. Expect \code{\link[shiny]{icon}}.
#' 
#' @export
boxSidebar <- function(..., inputId = NULL, width = "25%", background = "#333a40", 
                           startOpen = FALSE, icon = shiny::icon("cogs")) {
  
  # Toggle to insert in bs4Card
  toolbarTag <- shiny::tags$button(
    class = "btn btn-box-tool",
    id = inputId,
    `data-widget` = "chat-pane-toggle",
    `data-toggle` = "tooltip",
    `data-original-title` = "More",
    `data-start-open` = tolower(startOpen),
    type = "button",
    icon
  )
  
  # sidebar content
  contentTag <- shiny::tags$div(
    style = "z-index: 10000;",
    class = "direct-chat-contacts",
    shiny::tags$ul(
      class = "contacts-list", 
      shiny::tags$li(
        style = paste0("width: ", width, ";"), 
        ...
      )
    )
  )
  
  # custom CSS
  translation_rate <- paste0("calc(100% - ", width, ")")
  sidebarCSS <- shiny::singleton(
    shiny::tags$head(
      shiny::tags$style(
        shiny::HTML(
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
                background: ", background, ";
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
  )
  
  shiny::tagList(sidebarCSS, toolbarTag, contentTag)
}




#' Collapse a \link{box} tag.
#'
#' @param inputId Box to toggle.
#' @param action Action to trigger: either collapse, remove or restore.
#' @param session Shiny session object.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinydashboardPlus)
#'  
#'  ui <- dashboardPage(
#'    dashboardHeader(),
#'    dashboardSidebar(),
#'    dashboardBody(
#'      tags$style("body { background-color: ghostwhite}"),
#'      fluidRow(
#'        actionButton("toggle_box", "Toggle Box"),
#'        actionButton("remove_box", "Remove Box", class = "bg-danger"),
#'        actionButton("restore_box", "Restore Box", class = "bg-success")
#'      ),
#'      br(),
#'      box(
#'        title = textOutput("box_state"),
#'        "Box body",
#'        inputId = "mybox",
#'        collapsible = TRUE,
#'        closable = TRUE,
#'        plotOutput("plot")
#'      )
#'    )
#'  )
#'  
#'  server <- function(input, output, session) {
#'    output$plot <- renderPlot({
#'      req(!input$mybox$collapsed)
#'      plot(rnorm(200))
#'    })
#'    
#'    output$box_state <- renderText({
#'      state <- if (input$mybox$collapsed) "collapsed" else "uncollapsed"
#'      paste("My box is", state)
#'    })
#'    
#'    observeEvent(input$toggle_box, {
#'      updateBox("mybox", action = "toggle")
#'    })
#'    
#'    observeEvent(input$remove_box, {
#'      updateBox("mybox", action = "remove")
#'    })
#'    
#'    observeEvent(input$restore_box, {
#'      updateBox("mybox", action = "restore")
#'    })
#'    
#'    observeEvent(input$mybox$visible, {
#'      collapsed <- if (input$mybox$collapsed) "collapsed" else "uncollapsed"
#'      visible <- if (input$mybox$visible) "visible" else "hidden"
#'      message <- paste("My box is", collapsed, "and", visible)
#'      showNotification(message, type = "warning", duration = 1)
#'    })
#'    
#'  }
#'  
#'  shinyApp(ui, server)
#' }
updateBox <- function(inputId, action = c("remove", "toggle", "restore"), 
                          session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(inputId, message = match.arg(action))
}




#' Programmatically toggle a \link{boxSidebar}
#'
#' @param inputId Sidebar id.
#' @param session Shiny session object.
#' 
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinydashboardPlus)
#'  
#'  shinyApp(
#'   ui = dashboardPage(
#'     header = dashboardHeader(),
#'     body = dashboardBody(
#'       box(
#'         title = "Update box sidebar", 
#'         closable = TRUE, 
#'         width = 12,
#'         height = "500px",
#'         solidHeader = FALSE, 
#'         collapsible = TRUE,
#'         actionButton("update", "Toggle card sidebar"),
#'         sidebar = boxSidebar(
#'           inputId = "mycardsidebar",
#'           p("Sidebar Content")
#'         )
#'       )
#'     ),
#'     sidebar = dashboardSidebar()
#'   ),
#'   server = function(input, output, session) {
#'     observe(print(input$mycardsidebar))
#'     
#'     observeEvent(input$update, {
#'       updateBoxSidebar(inputId = "mycardsidebar")
#'     })
#'     
#'   }
#'  )
#' }
updateBoxSidebar <- function(inputId, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(inputId, NULL)
}




#' Create a box dropdown item list
#'
#' Can be used to add dropdown items to a boxtool.
#'
#' @param ... Slot for \link{boxDropdownItem}.
#' @param icon Dropdown menu icon. Expect \code{\link[shiny]{icon}}.
#'
#' @export
boxDropdown <- function(..., icon = shiny::icon("wrench")) {
  contentTag <- shiny::tags$div(
    class = "dropdown-menu dropdown-menu-right",
    role = "menu",
    ...
  )
  
  # for bs4Card toolbar
  toolbarTag <- shiny::tags$div(
    class = "btn-group",
    shiny::tags$button(
      type = "button",
      class = "btn btn-box-tool dropdown-toggle",
      `data-toggle` = "dropdown",
      icon
    ),
    contentTag
  )
  
  toolbarTag
  
}



#' Create a box dropdown item 
#'
#' @param url Target url or page.
#' @param name Menu name.
#'
#' @export
boxDropdownItem <- function(url, name) {
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
#' @param ... body content. May include \link{attachmentBlock} for instance.
#' @param src header image, if any.
#' @param title box title.
#' @param subtitle box subtitle.
#' @param width box width (between 1 and 12). 
#' @param height box height.
#' @param collapsible If TRUE, display a button in the upper right that allows the user to collapse the box. 
#' @param closable If TRUE, display a button in the upper right that allows the user to close the box.
#' @param comments slot for \link{boxComment}.
#' @param footer box footer, if any.
#' @param footerPadding TRUE by default: whether the footer has margin or not.
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
socialBox <- function(..., src, title, subtitle = NULL, 
                      width = 6, height = NULL, collapsible = TRUE,
                      closable = TRUE, comments = NULL, footer = NULL,
                      footerPadding = TRUE) {
  
  if (!is.null(width)) {
    stopifnot(is.numeric(width))
    # respect the bootstrap grid
    stopifnot(width <= 12)
    stopifnot(width >= 0)
  }
  
  # check that comment slot is really used by cardComment
  if (!is.null(comments)) {
    # handle tagList
    if (class(comments)[[1]] %in% c("list", "shiny.tag.list")) {
      for (i in seq_along(comments)) {
        commentsCl <- comments[[i]]$attribs$class
        if (commentsCl != "box-comment") {
          stop("You must provide a boxComment in the comments slot.")
        }
        break
      }
    } else {
      commentsCl <- comments$attribs$class
      if (is.null(commentsCl)) {
        stop("You must provide a boxComment in the comments slot.")
      } else {
        if (commentsCl != "box-comment") {
          stop("You must provide a boxComment in the comments slot.")
        }
      }
    }
  }
  
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
          if (!is.null(subtitle)) {
            shiny::tags$span(class = "description", subtitle) 
          }
        ),
        
        # boxTool
        if (collapsible || closable) {
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
        }
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
          class = if (isTRUE(footerPadding)) "box-footer" else "box-footer no-padding", 
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
boxComment <- function(..., src, title, date = NULL) {
  
  items <- list(...)
  if (length(items) == 0) stop("You must enter a comment.")
  
  shiny::tags$div(
    class = "box-comment",
    shiny::img(class = "img-circle", src = src),
    shiny::tags$div(
      class = "comment-text",
      shiny::tags$span(
        class = "username", 
        title,
        if (!is.null(date)) shiny::tags$span(class = "text-muted pull-right", date)
      ),
      ...
    )
  )
}

#' @title AdminLTE2 box profile
#'
#' @description Create box profile
#'
#' @param ... any element such as \link{boxProfileItem}.
#' @param src profile image, if any.
#' @param title title.
#' @param subtitle subtitle.
#' @param bordered Whether the container should have a border or not. FALSE by default.
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
#'        bordered = TRUE,
#'        boxProfileItem(
#'         title = "Followers",
#'         description = 1322
#'        ),
#'        boxProfileItem(
#'         title = "Following",
#'         description = 543
#'        ),
#'        boxProfileItem(
#'         title = "Friends",
#'         description = 13287
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
boxProfile <- function(..., src = NULL, title, subtitle = NULL, bordered = FALSE) {
  
  cl <- if (isTRUE(bordered)) "list-group" else "list-group list-group-unbordered"
  
  shiny::tags$div(
    class = "box-body box-profile",
    if (!is.null(src)) {
      shiny::img(class = "profile-user-img img-responsive img-circle", src = src)
    },
    shiny::h3(class = "profile-username text-center", title),
    if (!is.null(subtitle)) shiny::p(class = "text-muted text-center", subtitle),
    shiny::tags$ul(
      class = cl,
      ...
    )
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
boxProfileItem <- function(title, description) {
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
#'  
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