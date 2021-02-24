#' AdminLTE2 dashboard right sidebar
#'
#' \link{dashboardControlbar} create a right sidebar container.
#' 
#' @param ... slot for \link{controlbarMenu}. Not compatible with .items.
#' @param id To access the current state of the controlbar. Open is TRUE, closed
#' is FALSE. NULL by default.
#' @param disable If \code{TRUE}, the sidebar will be disabled.
#' @param width Sidebar width in pixels. Numeric value expected. 230 by default.
#' @param collapsed Whether the control bar on the right side is collapsed or not at start. TRUE by default.
#' @param overlay Whether the sidebar covers the content when expanded. Default to TRUE.
#' @param skin background color: "dark" or "light".
#' @param .list Pass element here if you do not want to embed them in panels. Not compatible with ...
#' 
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @note Until a maximum of 5 \link{controlbarItem}! AdminLTE 2 does not
#' support more panels.
#' 
#' @rdname controlbar
#'
#' @examples
#' 
#' # Controlbar example
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinydashboardPlus)
#'  shinyApp(
#'    ui = dashboardPage(
#'      header = dashboardHeader(),
#'      sidebar = dashboardSidebar(),
#'      body = dashboardBody(),
#'      controlbar = dashboardControlbar(
#'       skin = "dark",
#'       controlbarMenu(
#'        id = "menu",
#'        controlbarItem(
#'         "Tab 1",
#'         "Welcome to tab 1"
#'        ),
#'        controlbarItem(
#'         "Tab 2",
#'         "Welcome to tab 2"
#'        )
#'       )
#'      ),
#'      title = "Right Sidebar"
#'    ),
#'    server = function(input, output) { }
#'  )
#' }
#' @export
dashboardControlbar <- function(..., id = NULL, disable = FALSE, width = 230, 
                                collapsed = TRUE, overlay = TRUE, 
                                skin = "dark", .list = NULL) {
  items <- c(list(...), .list)
  
  if (is.null(id)) id <- "controlbarId"
  
  controlbarTag <- shiny::tagList(
    shiny::tags$aside(
      id = id,
      `data-collapsed` = if (collapsed) "true" else "false",
      `data-overlay` = if (overlay) "true" else "false",
      `data-show` = if (disable) "false" else "true",
      class = paste0("control-sidebar control-sidebar-", skin),
      style = paste0("width: ", width, "px;"),
      # automatically create the tab menu
      items
    ),
    # Add the sidebar background. This div must be placed
    # immediately after the control sidebar
    shiny::tags$div(class = "control-sidebar-bg")
  )
  
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        # custom css to correctly handle the width of the rightSidebar
        shiny::tags$style(
          shiny::HTML(
            paste0(
              ".control-sidebar-bg,
               .control-sidebar {
                  top: 0;
                  right: ", -width, "px;
                  width: ", width, "px;
                  -webkit-transition: right 0.3s ease-in-out;
                  -o-transition: right 0.3s ease-in-out;
                  transition: right 0.3s ease-in-out;
               }
              /* .control-sidebar-open .control-sidebar, .control-sidebar-open .control-sidebar-bg {
                right: ", -width, "px;
              } */
              @media (min-width:768px) {
                .control-sidebar-open .content-wrapper,
                .control-sidebar-open .main-footer, 
                .control-sidebar-open .right-side {
                  margin-right: ", width, "px;
                }
              }
              "
            )
          )
        )
      )
    ),
    controlbarTag
  )
}




#' Function to programmatically toggle the state of the controlbar
#' 
#' \link{updateControlbar} allows to toggle a \link{dashboardControlbar}.
#'
#' @param id Controlbar id.
#' @param session Shiny session object.
#' @export
#' @rdname controlbar
#'
#' @examples
#' 
#' # Toggle the dashboard controlbar
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinydashboardPlus)
#'  
#'  shinyApp(
#'    ui = dashboardPage(
#'      header = dashboardHeader(),
#'      sidebar = dashboardSidebar(),
#'      body = dashboardBody(
#'        actionButton(inputId = "controlbarToggle", label = "Toggle Controlbar")
#'      ),
#'      controlbar = dashboardControlbar(id = "controlbar")
#'    ),
#'    server = function(input, output, session) {
#'      
#'      observeEvent(input$controlbar, {
#'        if (input$controlbar) {
#'          showModal(modalDialog(
#'            title = "Alert",
#'            "The controlbar is opened.",
#'            easyClose = TRUE,
#'            footer = NULL
#'          ))
#'        }
#'      })
#'      
#'      observeEvent(input$controlbarToggle, {
#'        updateControlbar("controlbar")
#'      })
#'      
#'      observe({
#'        print(input$controlbar)
#'      })
#'    }
#'  )
#' }
updateControlbar <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(id, NULL)
}



#' Create an AdminLTE 2 controlbar menu
#' 
#' \link{controlbarMenu} is a tabset panel for the \link{dashboardControlbar}.
#' 
#' @inheritParams shiny::tabsetPanel
#' @export
#' @rdname controlbar
#' @examples 
#' 
#' # controlbar with controlbarMenu
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinydashboardPlus)
#'  
#'  shinyApp(
#'    ui = dashboardPage(
#'      header = dashboardHeader(),
#'      sidebar = dashboardSidebar(),
#'      body = dashboardBody(),
#'      controlbar = dashboardControlbar(
#'       id = "controlbar",
#'       controlbarMenu(
#'        id = "menu",
#'        controlbarItem(
#'         "Tab 1",
#'         "Welcome to tab 1"
#'        ),
#'        controlbarItem(
#'         "Tab 2",
#'         "Welcome to tab 2"
#'        )
#'       )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      
#'      observeEvent(input$menu, {
#'        showModal(modalDialog(
#'          title = "Alert",
#'          sprintf(" %s is active", input$menu),
#'          easyClose = TRUE,
#'          footer = NULL
#'        ))
#'      })
#'    }
#'  )
#' }
controlbarMenu <- function(..., id = NULL, selected = NULL) {
  # We run the Shiny tabsetPanel function, to edit it later. This
  # is to avoid to rewrite all internal functions...
  temp_tabset <- shiny::tabsetPanel(
    ...,
    id = id,
    selected = selected,
    type = "tabs",
    position = NULL
  )
  
  # remove parent div causing CSS margin issues
  temp_tabset <- temp_tabset$children
  
  # add AdminLTE 2 secific classes
  temp_tabset[[1]]$attribs$class <- paste(
    temp_tabset[[1]]$attribs$class,
    "nav-justified control-sidebar-tabs"
  )
  
  temp_tabset
}



#' Create an AdminLTE2 controlbar menu item
#' 
#' \link{controlbarItem} is a tabPanel for the \link{controlbarMenu}.
#' 
#' @inheritParams shiny::tabPanel
#' @export
#' @rdname controlbar
controlbarItem <- shiny::tabPanel





#' Update an AdminLTE2 controlbarMenu on the client
#' 
#' \link{updateControlbarMenu} allows to programmatically change the currently
#' selected \link{controlbarItem} on the client.
#' 
#' @param id Controlbar id.
#' @param selected Item to select.
#' @param session Shiny session object.
#' 
#' @export
#' @rdname controlbar
#' @examples
#' 
#' # Update a controlbar menu
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinydashboardPlus)
#'  
#'  shinyApp(
#'    ui = dashboardPage(
#'      header = dashboardHeader(),
#'      sidebar = dashboardSidebar(),
#'      body = dashboardBody(
#'       radioButtons("controller", "Controller", choices = c(1, 2, 3))
#'      ),
#'      controlbar = dashboardControlbar(
#'       id = "controlbar",
#'       controlbarMenu(
#'        id = "menu",
#'        controlbarItem(
#'          paste0("Tab", 1),
#'          paste("Welcome to tab", 1)
#'        ),
#'        controlbarItem(
#'          paste0("Tab", 2),
#'          paste("Welcome to tab", 2)
#'        ),
#'        controlbarItem(
#'          paste0("Tab", 3),
#'          paste("Welcome to tab", 3)
#'        )
#'       )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'     observeEvent(input$controller, {
#'      updateControlbarMenu(
#'       "menu", 
#'       selected = paste0("Tab", input$controller)
#'      )
#'     })
#'    }
#'  )
#' }
updateControlbarMenu <- function (id, selected = NULL, 
                                  session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(list(value = selected))
  session$sendInputMessage(id, message)
}
