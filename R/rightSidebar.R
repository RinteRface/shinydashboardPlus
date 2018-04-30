#' AdminLTE2 dashboard right sidebar
#'
#' This creates a right sidebar.
#' 
#' @param ... slot for other elements such as rightSidebarTabList,
#' rightSidebarTabItem, rigthSidebarPanel and rightSidebarTabContent.
#' @param background background color: "dark" or "light".
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
#'      body = dashboardBody(),
#'      rightsidebar = rightSidebar(
#'       background = "dark",
#'        rightSidebarTabList(
#'         rightSidebarTabItem(
#'          id = 1,
#'          icon = "desktop"
#'         ),
#'         rightSidebarTabItem(
#'          id = 2
#'         ),
#'         rightSidebarTabItem(
#'          id = 3,
#'          icon = "paint-brush"
#'         )
#'        ),
#'        rigthSidebarPanel(
#'         rightSidebarTabContent(
#'          id = 1,
#'          title = "Tab 1",
#'          sliderInput(
#'           "obs", 
#'           "Number of observations:",
#'            min = 0, max = 1000, value = 500
#'           )
#'         ),
#'         rightSidebarTabContent(
#'          id = 2,
#'          title = "Tab 2",
#'          textInput("caption", "Caption", "Data Summary")
#'         ),
#'         rightSidebarTabContent(
#'          id = 3,
#'          title = "Tab 3",
#'          numericInput("obs", "Observations:", 10, min = 1, max = 100)
#'         )
#'        )
#'      ),
#'      title = "Right Sidebar"
#'    ),
#'    server = function(input, output) { }
#'  )
#' }
#' @export
rightSidebar <- function(..., background = "dark") {
  shiny::withTags(
    shiny::tags$div(
      id = "right_sidebar",
      shiny::tags$aside(
        class = paste0("control-sidebar control-sidebar-", background),
       ...
      ),
      # Add the sidebar background. This div must be placed
      # immediately after the control sidebar
      shiny::tags$div(class = "control-sidebar-bg", "")
    )
  )
}



#' AdminLTE2 right sidebar tab list
#'
#' This creates a right sidebar tab list.
#' 
#' @param ... slot for rightSidebarTabItem.
#' 
#' @note Until a maximum of 5 rightSidebarTabItem!
#' 
#' @export
rightSidebarTabList <- function(...) {
  shiny::tags$ul(
    class = "nav nav-tabs nav-justified control-sidebar-tabs",
    ...
  )
}


#' AdminLTE2 right sidebar tab item
#'
#' This creates a right sidebar tab item to be inserted in a rightSidebarTabList.
#' 
#' @param id unique item id. If id = 1, the tab is set to active.
#' @param icon tab icon.
#' 
#' @export
rightSidebarTabItem <- function(id, icon = "database") {
  
  stopifnot(!is.null(id))
  
  shiny::tags$li(
    class = if (id == 1) "active" else NULL,
    shiny::tags$a(
      href = paste0("#control-sidebar-", id, "-tab"), 
      `data-toggle` = "tab",
      shiny::tags$i(class = paste0("fa fa-", icon))
    )
  )
}


#' AdminLTE2 wrapper for tab content
#'
#' This creates a wrapper that will contain rightSidebarTabContent.
#' 
#' @param ... slot for rightSidebarTabContent.
#' 
#' @export
rigthSidebarPanel <- function(...) {
  shiny::tags$div(
    class = "tab-content",
    ...
  )
}

#' AdminLTE2 tab content
#'
#' This creates a wrapper that will contain rightSidebarTabContent.
#' 
#' @param ... any element such as sliderInput, ...
#' @param id should correspond to the id given in rightSidebarTabItem.
#' @param title content title.
#' 
#' @export
rightSidebarTabContent <- function(..., id, title = NULL) {
  
  stopifnot(!is.null(id))
  
  shiny::tags$div(
    class = if (id == 1) "tab-pane active" else "tab-pane", 
    id = paste0("control-sidebar-", id, "-tab"),
    shiny::tags$h3(class = "control-sidebar-heading", title),
    ...
  )
}