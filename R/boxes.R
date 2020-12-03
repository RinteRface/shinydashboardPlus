#' Create a box for the main body of a dashboard
#'
#' \link{box} can be used to hold content in the main body of a dashboard.
#' 
#' @param ... Contents of the box.
#' @param title Optional title.
#' @param footer Optional footer text.
#' @param status The status of the item This determines the item's background
#'   color.  Valid statuses are defined as follows:
#' \itemize{
#'   \item \code{primary}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}
#'   \item \code{success}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#00a65a")}
#'   \item \code{info}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#00c0ef")}
#'   \item \code{warning}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#f39c12")}
#'   \item \code{danger}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#f56954")}
#'   \item \code{navy}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#001F3F")}
#'   \item \code{teal}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#39CCCC")}
#'   \item \code{purple}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#605ca8")}
#'   \item \code{orange}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#ff851b")}
#'   \item \code{maroon}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#D81B60")}
#'   \item \code{black}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#111111")}
#' }
#' Only primary, success, info, warning and danger are compatible with solidHeader!
#' @param solidHeader Should the header be shown with a solid color background?
#' @param background If NULL (the default), the background of the box will be
#'   white. Otherwise, a color string. Valid colors are listed in
#'   \link{validColors}. See below:
#' \itemize{
#'  \item \code{light-blue (primary status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}.
#'  \item \code{red (danger status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#dd4b39")}.
#'  \item \code{green (success status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00a65a")}.
#'  \item \code{aqua (info status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00c0ef")}.
#'  \item \code{yellow (warning status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#f39c12")}.
#'  \item \code{blue}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#0073b7")}.
#'  \item \code{navy}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#001F3F")}.
#'  \item \code{teal}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#39CCCC")}.
#'  \item \code{olive}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3D9970")}.
#'  \item \code{lime}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#01FF70")}.
#'  \item \code{orange}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#FF851B")}.
#'  \item \code{fuchsia}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#F012BE")}.
#'  \item \code{purple}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#605ca8")}.
#'  \item \code{maroon}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#D81B60")}.
#'  \item \code{black}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#111")}.
#'  \item \code{gray}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#d2d6de")}.
#' }
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
#' @param icon Header icon. Displayed before title. Expect \code{\link[shiny]{icon}}.
#' @param gradient Whether to allow gradient effect for the background color. Default to FALSE.
#' @param boxToolSize Size of the toolbox: choose among "xs", "sm", "md", "lg".
#' @param headerBorder Whether to display a border between the header and body.
#' TRUE by default.
#' @param label Slot for \link{boxLabel}.
#' @param dropdownMenu List of items in the boxtool dropdown menu. Use \link{boxDropdown}.
#' @param sidebar Slot for \link{boxSidebar}.
#' @param footerPadding TRUE by default: whether the footer has margin or not.
#' @param id Box unique id. \link{updateBox} target.
#'
#' @rdname box
#'
#' @examples
#' 
#' # A box with label, sidebar, dropdown menu
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
#'          boxDropdownItem("Link to google", href = "http://www.google.com"),
#'          boxDropdownItem("item 2", href = "#"),
#'          dropdownDivider(),
#'          boxDropdownItem("item 3", href = "#", icon = icon("th"))
#'         ),
#'         sidebar = boxSidebar(
#'          startOpen = TRUE,
#'          id = "mycardsidebar",
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
box <- function(..., title = NULL, footer = NULL, status = NULL, solidHeader = FALSE, 
                background = NULL, width = 6, height = NULL, collapsible = FALSE, 
                collapsed = FALSE, closable = FALSE, icon = NULL, gradient = FALSE, boxToolSize = "sm", 
                headerBorder = TRUE, label = NULL, dropdownMenu = NULL,
                sidebar = NULL, footerPadding = TRUE, id = NULL) {
  
  # multiple validation
  validateBoxProps(
    title = title,
    label = label,
    sidebar = sidebar,
    dropdownMenu = dropdownMenu,
    status = status,
    gradient = gradient,
    collapsible = collapsible,
    collapsed = collapsed,
    solidHeader = solidHeader,
    background = background,
    width = width
  )
  
  props <- dropNulls(
    list(
      title = if (!is.null(title)) {
        if (inherits(title, "list")) {
          unlist(
            dropNulls(
              lapply(title, function(e) {
                if (inherits(e, "shiny.tag.list") ||
                    inherits(e, "shiny.tag")) {
                  as.character(e)
                }
              })
            )
          )
        } else {
          as.character(title)
        }
      } else {
        title
      },
      status = status,
      solidHeader = solidHeader,
      background = background,
      width = width,
      height = height,
      collapsible = collapsible,
      closable = closable,
      gradient = gradient
    )
  )
  
  # set box class
  boxClass <- setBoxClass(
    status, 
    solidHeader, 
    collapsible, 
    collapsed,
    gradient, 
    background, 
    sidebar
  )
  
  # set style
  style <- setBoxStyle(height, sidebar)
  
  # box tools
  boxToolTag <- NULL
  # create card tools whenever necessary
  if (collapsible || closable || 
      !is.null(dropdownMenu) || !is.null(sidebar) || !is.null(label)) {
    boxToolTag <- shiny::tags$div(class = "box-tools pull-right")
  }
  
  # update box tools
  boxToolTag <- shiny::tagAppendChildren(
    boxToolTag,
    label,
    createBoxTools(
      collapsible, 
      collapsed, 
      closable,
      sidebar, 
      dropdownMenu,
      boxToolSize,
      status,
      background,
      solidHeader
    )
  )
  
  # header
  if (is.null(title) && 
      (closable || collapsible || 
       !is.null(dropdownMenu) || !is.null(sidebar) || !is.null(label)
      )) title <- "\u200C"
  
  headerTag <- shiny::tags$div(
    class = paste0("box-header", if (headerBorder) " with-border"),
    # header icon
    icon, 
    shiny::tags$h3(class = "box-title", title)
  )
  
  headerTag <- shiny::tagAppendChild(headerTag, boxToolTag)
  
  
  # body
  bodyTag <- shiny::tags$div(
    class = "box-body",
    style = style,
    ...,
    sidebar[[2]]
  )
  
  # footer 
  footerTag <- if (!is.null(footer)) {
    shiny::tags$div(
      class = if (isTRUE(footerPadding)) "box-footer" else "box-footer no-padding", 
      footer
    )
  }
  
  boxTag <- shiny::tags$div(class = boxClass, id = id)
  boxTag <- shiny::tagAppendChildren(boxTag, headerTag, bodyTag, footerTag)
  
  # wrapper
  shiny::tags$div(
    class = if (!is.null(width)) paste0("col-sm-", width),
    boxTag,
    # config script to be used by card input binding
    shiny::tags$script(
      type = "application/json",
      `data-for` = id,
      jsonlite::toJSON(
        x = props,
        auto_unbox = TRUE,
        json_verbatim = TRUE
      )
    )
  )
  
}



#' Create a label for \link{box} 
#' 
#' \link{boxLabel} is inserted in the label slot of \link{box}.
#'
#' @param text Label text. In practice only few letters or a number.
#' @param status label color status. See \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' Valid statuses are defined as follows:
#' \itemize{
#'   \item \code{primary}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}
#'   \item \code{success}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#00a65a")}
#'   \item \code{info}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#00c0ef")}
#'   \item \code{warning}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#f39c12")}
#'   \item \code{danger}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#f56954")}
#' }
#' @param style label border style: "default" (rounded angles), "circle" or "square".
#' @export
boxLabel <- function(text, status, style = "default") {
  
  if (nchar(text) > 10) warning("Avoid long texts in boxPlusLabel.")
  dashboardLabel(text, status = status, style = style)
}




#' Create a sidebar for a box
#' 
#' \link{boxSidebar} is inserted in the sidebar slot of \link{box}.
#'
#' @param ... Sidebar content.
#' @param id Unique sidebar id. Useful if you want to use \link{updateBoxSidebar}.
#' @param width Sidebar opening width in percentage. 50\% by default, 
#' means the card sidebar will take 50% of the card width, when opened. 
#' A numeric value between 25 and 100.
#' @param background Sidebar background color. Dark by default. Expect a HEX code.
#' @param startOpen Whether the sidebar is open at start. FALSE by default.
#' @param icon Sidebar icon. Expect \code{\link[shiny]{icon}}.
#' 
#' @export
#' @rdname boxSidebar
boxSidebar <- function(..., id = NULL, width = 50, background = "#333a40", 
                       startOpen = FALSE, icon = shiny::icon("cogs")) {
  
  stopifnot(width > 25 && width <= 100)
  
  # Toggle to insert in bs4Card
  toolbarTag <- shiny::tags$button(
    id = id,
    `data-background`= background, 
    `data-width` = width,
    `data-widget` = "chat-pane-toggle",
    `data-toggle` = "tooltip",
    `data-original-title` = "More",
    `data-start-open` = tolower(startOpen),
    type = "button",
    icon
  )
  
  # sidebar content
  contentTag <- shiny::tags$div(
    style = "z-index: 1; height: inherit;",
    class = "direct-chat-contacts",
    shiny::tags$ul(
      class = "contacts-list", 
      shiny::tags$li(
        ...
      )
    )
  )
  
  shiny::tagList(toolbarTag, contentTag)
}




#' Collapse a \link{box} tag.
#' 
#' \link{updateBox} is used to toggle, close or restore a \link{box} on the client.
#'
#' @param id Box to toggle.
#' @param action Action to trigger: either collapse, remove, restore or update.
#' @param options If action is update, a list of new options to configure the box, such as
#' \code{list(title = "new title", status = NULL, solidHeader = FALSE, 
#' background = "red", width = 6, height = "200px", collapsible = FALSE, closable = FALSE)}.
#' If the box had a background/status (any item that may be NULL), you must explicitly pass background = NULL, 
#' if you want to remove the background value.
#' @param session Shiny session object.
#' @export
#'
#' @examples
#' 
#' # Toggle a box on the client
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
#'      actionButton("update_box", "Update Box", class = "bg-info"), 
#'      actionButton("update_box2", "Update Box 2", class = "bg-info"),
#'      br(),
#'      br(),
#'      box(
#'        title = textOutput("box_state"),
#'        id = "mybox",
#'        status = "danger", 
#'        background = "maroon", 
#'        gradient = TRUE,
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
#'    observeEvent(input$update_box, {
#'      updateBox(
#'        "mybox", 
#'        action = "update", 
#'        options = list(
#'          title = tagList(h2("hello"), dashboardLabel(1, status = "primary")),
#'          status = "warning", 
#'          solidHeader = TRUE, 
#'          width = 12, 
#'          background = NULL, 
#'          height = "900px", 
#'          closable = FALSE
#'        )
#'      )
#'    })
#'     
#'     observeEvent(input$update_box2, {
#'       updateBox(
#'         "mybox", 
#'         action = "update", 
#'         options = list(
#'           status = NULL, 
#'           solidHeader = FALSE,
#'           width = 4, 
#'           background = "green", 
#'           height = "500px", 
#'           closable = TRUE
#'         )
#'       )
#'     })
#'    
#'  }
#'  
#'  shinyApp(ui, server)
#' }
#' @rdname box
updateBox <- function(id, action = c("remove", "toggle", "restore", "update"), options = NULL,
                      session = shiny::getDefaultReactiveDomain()) {
  # for update, we take a list of options
  if (action == "update") {
    # handle case whare options are shiny tag or a list of tags ...
    options <- lapply(options, function(o) {
      if (inherits(o, "shiny.tag") || inherits(o, "shiny.tag.list")) {
        o <- as.character(o)
        return(o)
      }
      if (inherits(o, "list")) {
        o <- unlist(
          dropNulls(
            lapply(o, function(e) {
              if (inherits(e, "shiny.tag.list") ||
                  inherits(e, "shiny.tag")) {
                as.character(e)
              } else {
                e
              }
            })
          )
        )
      }
      o
    })
    message <- dropNulls(c(action = action, options = list(options)))
    session$sendInputMessage(id, message)
  } else {
    session$sendInputMessage(id, message = match.arg(action))
  }
}




#' Programmatically toggle a \link{boxSidebar}
#' 
#' \link{updateBoxSidebar} toggle a \link{boxSidebar} on the client.
#'
#' @param id Sidebar id.
#' @param session Shiny session object.
#' 
#' @export
#' @examples
#' 
#' # Toggle a box sidebar
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
#'           id = "mycardsidebar",
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
#'       updateBoxSidebar("mycardsidebar")
#'     })
#'     
#'   }
#'  )
#' }
#' @rdname boxSidebar
updateBoxSidebar <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(id, NULL)
}




#' Create a box dropdown item list
#'
#' \link{boxDropdown} is used in the dropdown parameter of \link{box}.
#'
#' @param ... Slot for \link{boxDropdownItem}.
#' @param icon Dropdown menu icon. Expect \code{\link[shiny]{icon}}.
#'
#' @export
#' @rdname box
#' @examples 
#' 
#' # Box with dropdown items and input
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
#'        box(
#'          title = "Closable Box with dropdown", 
#'          closable = TRUE, 
#'          width = 12,
#'          status = "warning", 
#'          solidHeader = FALSE, 
#'          collapsible = TRUE,
#'          dropdownMenu = boxDropdown(
#'            boxDropdownItem("Click me", id = "dropdownItem", icon = icon("heart")),
#'            boxDropdownItem("item 2", href = "https://www.google.com/"),
#'            dropdownDivider(),
#'            boxDropdownItem("item 3", icon = icon("th"))
#'          ),
#'          "My box"
#'        )
#'      )
#'    ),
#'    server = function(input, output) {
#'      observeEvent(input$dropdownItem, {
#'        showNotification("Hello", duration = 1, type = "message")
#'      })
#'    }
#'  )
#' }
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
      `data-toggle` = "dropdown",
      icon
    ),
    contentTag
  )
  
  toolbarTag
  
}



#' Create a box dropdown item 
#' 
#' \link{boxDropdownItem} goes in \link{boxDropdown}.
#' 
#' @param ... Item content.
#' @param id If passed, the item will behave like an action button.
#' @param href Target url or page.
#' @param icon Optional icon. Expect \link[shiny]{icon}.
#'
#' @export
#' @rdname box
boxDropdownItem <- function(..., id = NULL, href = NULL, icon = NULL) {
  shiny::tags$li(
    shiny::tags$a(
      id = id,
      class = if (!is.null(id)) "action-button",
      href = href,
      target = if (!is.null(href)) {
        "_blank"
      } else {
        "#"
      },
      if (!is.null(icon)) icon, 
      ... 
    )
  )
}


#' Create a box dropdown divider 
#' 
#' \link{dropdownDivider} goes in \link{boxDropdown} but also in any
#' dropdown menu container.
#'
#' @export
#' @rdname box
dropdownDivider <- function() {
  shiny::tags$li(class = "divider")
}




#' @title AdminLTE2 user box
#'
#' @description Create user box
#'
#' @param ... body content.
#' @param title box title.
#' @param subtitle box subtitle.
#' @param footer box footer.
#' @param color background color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' See below:
#' \itemize{
#'  \item \code{light-blue (primary status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}.
#'  \item \code{red (danger status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#dd4b39")}.
#'  \item \code{green (success status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00a65a")}.
#'  \item \code{aqua (info status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00c0ef")}.
#'  \item \code{yellow (warning status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#f39c12")}.
#'  \item \code{blue}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#0073b7")}.
#'  \item \code{navy}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#001F3F")}.
#'  \item \code{teal}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#39CCCC")}.
#'  \item \code{olive}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3D9970")}.
#'  \item \code{lime}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#01FF70")}.
#'  \item \code{orange}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#FF851B")}.
#'  \item \code{fuchsia}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#F012BE")}.
#'  \item \code{purple}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#605ca8")}.
#'  \item \code{maroon}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#D81B60")}.
#'  \item \code{black}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#111")}.
#'  \item \code{gray}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#d2d6de")}.
#' }
#' @param width box width (between 1 and 12). 
#' @param height box height.
#' @param collapsible If TRUE, display a button in the upper right that allows the user to collapse the box. 
#' @param collapsed If TRUE, start collapsed. This must be used with \code{collapsible=TRUE}.
#' @param closable If TRUE, display a button in the upper right that allows the user to close the box.
#' @param type User box type. Either 1 or 2. 1 corresponds to a centered user image,
#' while 2 is a left aligned user image.
#' @param image header image, if any (this is different of the background image).
#' @param backgroundImage image url, if any. Background needs to be TRUE.
#' @param boxToolSize size of the toolbox: choose among "xs", "sm", "md", "lg".
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
#'       image = "https://adminlte.io/themes/AdminLTE/dist/img/user7-128x128.jpg",
#'       color = "yellow",
#'       "Some text here!",
#'       footer = "The footer here!"
#'      ),
#'      userBox(
#'       title = "Alexander Pierce",
#'       subtitle = "Founder & CEO",
#'       type = 1,
#'       image = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
#'       color = "aqua",
#'       closable = TRUE,
#'       "Some text here!",
#'       footer = "The footer here!"
#'      ),
#'      userBox(
#'       title = "Elizabeth Pierce",
#'       subtitle = "Web Designer",
#'       image = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
#'       backgroundImage = "https://cdn.statically.io/img/wallpaperaccess.com/full/1119564.jpg",
#'       closable = TRUE,
#'       "Some text here!",
#'       footer = "The footer here!"
#'      )
#'     ),
#'     title = "UserBox"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
userBox <- function(..., title, subtitle = NULL, footer = NULL, color = NULL, 
                    width = 6, height = NULL, collapsible = TRUE, collapsed = FALSE, 
                    closable = FALSE, type = c(1, 2), image = NULL, backgroundImage = NULL, 
                    boxToolSize = "sm", footerPadding = TRUE
                    ) {
  
  if (!is.null(color)) validateColor(color)
  
  if (!collapsible && collapsed) {
    stop("Cannot collapse a card that is not collapsible.")
  }
  
  if (!is.null(width)) {
    stopifnot(is.numeric(width))
    # respect the bootstrap grid
    stopifnot(width <= 12)
    stopifnot(width >= 0)
  }
  
  # if type is not explicitly provided, it will use the default value, c(1, 2).
  # Below we ensure that whenever it is the case, we only select the first element
  # by default. We also need to convert to character for match.arg
  if (length(type) == 2) {
    type <- as.character(type[1])
    type <- match.arg(type)
  }
  
  # once type is assigned, if it is "1" we actually put it back to NULL since 
  # the class widget-user-1 does not exist (only widget-user-2).
  if (!is.null(type)) {
    type <- as.character(type)
    type <- match.arg(type)
    if (type == "1") type <- NULL
  }
  
  boxCl <- "box box-widget widget-user"
  if (!is.null(type)) boxCl <- paste0(boxCl, "-", type)
  if (collapsible && collapsed) {
    boxCl <- paste(boxCl, "collapsed-box")
  }
  
  style <- NULL
  if (!is.null(height)) {
    style <- paste0("height: ", shiny::validateCssUnit(height))
  }
  
  headerCl <- "widget-user-header"
  if (!is.null(color) && is.null(backgroundImage)) headerCl <- paste0(headerCl, " bg-", color)
  if (!is.null(backgroundImage)) headerCl <- paste0(headerCl, " bg-black")
  
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
        class = headerCl,
        style = if (!is.null(backgroundImage)) {
          paste0("background: url('", backgroundImage, "') center center;")
        },
        # box header buttons
        shiny::tags$div(
          class = "pull-right box-tools",
          collapseTag,
          closeTag
        ),
        # image
        shiny::tags$div(
          class = "widget-user-image",
          shiny::tags$img(class = "img-circle", src = image)
        ),
        # titles
        shiny::tags$h3(class = "widget-user-username", title),
        if (!is.null(subtitle)) {
          shiny::tags$h5(class = "widget-user-desc", subtitle)
        }
      ),
      # body
      shiny::tags$div(class = "box-body", ...),
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




#' AdminLTE2 social box
#'
#' \link{socialBox} creates a special box dedicated for social content.
#'
#' @param ... body content. May include \link{attachmentBlock} for instance.
#' @param image header image, if any.
#' @param title box title.
#' @param subtitle box subtitle.
#' @param comments slot for \link{boxComment}.
#' @param footer box footer, if any.
#' @param width box width (between 1 and 12). 
#' @param height box height.
#' @param collapsible If TRUE, display a button in the upper right that allows the user to collapse the box. 
#' @param closable If TRUE, display a button in the upper right that allows the user to close the box.
#' @param footerPadding TRUE by default: whether the footer has margin or not.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' @rdname socialBox
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
#'       image = "https://adminlte.io/themes/AdminLTE/dist/img/user4-128x128.jpg",
#'       "Some text here!",
#'       attachmentBlock(
#'        image = "https://adminlte.io/themes/AdminLTE/dist/img/photo1.png",
#'        title = "Test",
#'        href = "https://google.com",
#'        "This is the content"
#'       ),
#'       comments = tagList(
#'        lapply(X = 1:10, FUN = function(i) {
#'         boxComment(
#'           image = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
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
socialBox <- function(..., image, title, subtitle = NULL, comments = NULL, 
                      footer = NULL, width = 6, height = NULL, collapsible = TRUE,
                      closable = FALSE, footerPadding = TRUE) {
  
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
        commentsCl <- comments[[1]][[i]]$attribs$class
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
          shiny::img(class = "img-circle", src = image),
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


#' AdminLTE2 box comment
#'
#' \link{boxComment} has to be inserted in the comment slot of \link{socialBox}.
#'
#' @param ... comment content.
#' @param image author image, if any.
#' @param title comment title.
#' @param date date of publication.
#' 
#' @export
#' @rdname socialBox
boxComment <- function(..., image, title, date = NULL) {
  
  items <- list(...)
  if (length(items) == 0) stop("You must enter a comment.")
  
  shiny::tags$div(
    class = "box-comment",
    shiny::img(class = "img-circle", src = image),
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

#' AdminLTE2 box profile
#'
#' \link{boxProfile} goes inside a \link{box}. Displays user informations in an elegant
#' container.
#'
#' @param ... any element such as \link{boxProfileItem}.
#' @param image profile image, if any.
#' @param title title.
#' @param subtitle subtitle.
#' @param bordered Whether the container should have a border or not. FALSE by default.
#'
#' @rdname boxProfile
#' 
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'   
#' @examples
#' 
#' # Box with boxProfile
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
#'        image = "https://adminlte.io/themes/AdminLTE/dist/img/user4-128x128.jpg",
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
boxProfile <- function(..., image = NULL, title, subtitle = NULL, bordered = FALSE) {
  
  cl <- if (isTRUE(bordered)) "list-group" else "list-group list-group-unbordered"
  
  shiny::tags$div(
    class = "box-body box-profile",
    if (!is.null(image)) {
      shiny::img(class = "profile-user-img img-responsive img-circle", src = image)
    },
    shiny::h3(class = "profile-username text-center", title),
    if (!is.null(subtitle)) shiny::p(class = "text-muted text-center", subtitle),
    shiny::tags$ul(
      class = cl,
      ...
    )
  )
}




#' AdminLTE2 box profile item 
#'
#' \link{boxProfileItem} is an sub-element of a \link{boxProfile}.
#'
#' @param title item title.
#' @param description item info.
#' 
#' @export
#' @rdname boxProfile
boxProfileItem <- function(title, description) {
  shiny::tags$li(
    class = "list-group-item",
    shiny::strong(title),
    shiny::a(class = "pull-right", description)
  )
}


#' A flipBox based on the W3C example
#' 
#' A box that flips from back to front and inversely
#' 
#' @param id the \code{flipBox} id
#' @param front ui for the front of the flip box
#' @param back ui for the back of the flip box
#' @param trigger How to trigger rotate effect. Either click or hover. Default to click.
#' @param width flipbox width. Between 1 and 12.
#' 
#' @details To access the state of the flipbox use the input alias \code{input$<id>}.
#' For example, if your flipBox's id is myawesomeflipbox, you can access its state via
#' \code{input$myawesomeflipbox} where TRUE corresponds to the front, FALSE to the back. 
#'   
#' @rdname flipbox
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinydashboardPlus)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'       fluidRow(
#'         column(
#'           width = 6,
#'           uiOutput("active_side"), 
#'           flipBox(
#'             id = "myflipbox", 
#'             trigger = "hover",
#'             width = 12,
#'             front = div(
#'               class = "text-center",
#'               h1("Flip on hover"),
#'               img(
#'                 src = "https://image.flaticon.com/icons/svg/149/149076.svg",
#'                 height = "300px",
#'                 width = "100%"
#'               )
#'             ),
#'             back = div(
#'               class = "text-center",
#'               height = "300px",
#'               width = "100%",
#'               h1("Flip on hover"),
#'               p("More information....")
#'             )
#'           )
#'         ),
#'         column(
#'           width = 6,
#'           uiOutput("active_side_2"),
#'           flipBox(
#'             id = "myflipbox2",
#'             width = 12,
#'             front = div(
#'               class = "text-center",
#'               h1("Flip on click"),
#'               img(
#'                 src = "https://image.flaticon.com/icons/svg/149/149076.svg",
#'                 height = "300px",
#'                 width = "100%"
#'               )
#'             ),
#'             back = div(
#'               class = "text-center",
#'               height = "300px",
#'               width = "100%",
#'               h1("Flip on click"),
#'               p("More information....")
#'             )
#'           )
#'         )
#'       )
#'     )
#'   ),
#'   
#'   server = function(input, output, session) {
#'     output$active_side <- renderUI({
#'       side <- if (input$myflipbox) "front" else "back"
#'       dashboardBadge(side, color = "blue")
#'     })
#'     
#'     output$active_side_2<- renderUI({
#'       side <- if (input$myflipbox2) "front" else "back"
#'       dashboardBadge(side, color = "blue")
#'     })
#'   }
#'  )
#' }
#' @export
flipBox <- function(id, front, back, trigger = c("click", "hover"), width = 6) {
  
  if (is.null(id) || missing(id)) stop("card id cannot be null or missing!")
  trigger <- match.arg(trigger)
  
  shiny::column(
    width = width,
    shiny::tags$div(
      style = "position: relative",
      class = "flipbox",
      id = id,
      `data-rotate` = trigger, # used by the input binding to handle events
      shiny::tags$div(
        class = "card-front active",
        style = "background-color: white;",
        front
      ),
      shiny::tags$div(
        class = "card-back",
        style = "background-color: white;",
        back
      )  
    )
  )
}


#' Toggle a \link{flipBox} on the client
#'
#' @param id \link{flipBox} id.
#' @param session Shiny session object.
#' @export
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
#'        actionButton("toggle", "Toggle flip box"),
#'        uiOutput("active_side"), 
#'        flipBox(
#'          id = "myflipbox",
#'          front = div(
#'            class = "text-center",
#'            img(
#'              src = "https://image.flaticon.com/icons/svg/149/149076.svg",
#'              height = "300px",
#'              width = "100%"
#'            )
#'          ),
#'          back = div(
#'            class = "text-center",
#'            height = "300px",
#'            width = "100%",
#'            h1("Details...."),
#'            p("More information....")
#'          )
#'        )
#'      )
#'    ),
#'    
#'    server = function(input, output, session) {
#'     output$active_side <- renderUI({
#'      side <- if (input$myflipbox) "front" else "back"
#'      dashboardBadge(side, color = "blue")
#'     })
#'     
#'     observeEvent(input$toggle, {
#'      updateFlipBox("myflipbox")
#'     })
#'    }
#'  )
#' }
#' @rdname flipbox
updateFlipBox <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(id, message = NULL)
}
