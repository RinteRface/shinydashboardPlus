#' AdminLTE2 dashboard right sidebar
#'
#' This creates a right sidebar.
#' 
#' @param ... slot for rightSidebarTabContent. Not compatible with .items.
#' @param background background color: "dark" or "light".
#' @param width Sidebar width in pixels. Numeric value expected. 230 by default.
#' @param .items Pass element here if you do not want to embed them in panels. Not compatible with ...
#' 
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @note Until a maximum of 5 rightSidebarTabContent inside! AdminLTE 2 does not
#' support more panels.
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
#'        rightSidebarTabContent(
#'         id = 1,
#'         icon = "desktop",
#'         title = "Tab 1",
#'         active = TRUE,
#'         sliderInput(
#'          "obs", 
#'          "Number of observations:",
#'           min = 0, max = 1000, value = 500
#'          )
#'        ),
#'        rightSidebarTabContent(
#'         id = 2,
#'         title = "Tab 2",
#'         textInput("caption", "Caption", "Data Summary")
#'        ),
#'        rightSidebarTabContent(
#'         id = 3,
#'         title = "Tab 3",
#'         icon = "paint-brush",
#'         numericInput("obs", "Observations:", 10, min = 1, max = 100)
#'        )
#'      ),
#'      title = "Right Sidebar"
#'    ),
#'    server = function(input, output) { }
#'  )
#' }
#' @export
rightSidebar <- function(..., background = "dark", width = 230, .items = NULL) {
  
  panels <- list(...)
  
  sidebarTag <- shiny::tags$div(
    id = "controlbar",
    shiny::tags$aside(
      class = paste0("control-sidebar control-sidebar-", background),
      style = paste0("width: ", width, "px;"),
      # automatically create the tab menu
      if (length(panels) > 0) rightSidebarTabList(rigthSidebarPanel(...)),
      if (length(panels) > 0) rigthSidebarPanel(...) else rigthSidebarPanel(.items)
    ),
    # Add the sidebar background. This div must be placed
    # immediately after the control sidebar
    shiny::tags$div(class = "control-sidebar-bg", style = paste0("width: ", width, "px;"))
  )
  
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        # Will be usefull to fix issue #4 on github
        # shiny::includeScript(
        #   system.file(file.path("js", "rightSidebar.js"), package = "shinydashboardPlus")
        # ),
        
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
              "
            )
          )
        )
      )
    ),
    sidebarTag
  )
}



#' AdminLTE2 right sidebar tab list
#'
#' This creates a right sidebar tab list.
#' 
#' @param ... slot that takes all rightSidebarTabContent as input to automatically
#' generate the same number of items in the tab menu with corresponding icons,
#' ids, ...
#' 
rightSidebarTabList <- function(...) {
  
  tabItems <- list(...)
  tabItems <- tabItems[[1]]$children
  len <- length(tabItems)
  
  if (len > 0) {
    # generate tab items based on panel items
    tabItemList <- lapply(1:len, FUN = function(i) {
      
      item <- tabItems[[i]]
      id <- item$attribs$id
      id <- gsub(x = id, pattern = "control-sidebar-", replacement = "")
      id <- gsub(x = id, pattern = "-tab", replacement = "")
      active <- sum(grep(x = item$attribs$class, pattern = "active")) == 1
      icon <- item$attribs$icon
      
      rightSidebarTabItem(id = id, icon = icon, active = active)
    })
    
    # put everything inside the container
    shiny::tags$ul(
      class = "nav nav-tabs nav-justified control-sidebar-tabs",
      tabItemList
    )
  }
}


#' AdminLTE2 right sidebar tab item
#'
#' This creates a right sidebar tab item to be inserted in a rightSidebarTabList.
#' 
#' @param id unique item id.
#' @param icon tab icon.
#' @param active Whether the tab item is active or not.
#' 
rightSidebarTabItem <- function(id, icon, active) {
  
  stopifnot(!is.null(id))
  
  shiny::tags$li(
    class = if (isTRUE(active)) "active" else NULL,
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
rigthSidebarPanel <- function(...) {
  shiny::tags$div(
    class = "controlbar tab-content",
    ...
  )
}

#' AdminLTE2 tab content
#'
#' This creates a wrapper that will contain rightSidebarTabContent.
#' 
#' @param ... any element such as sliderInput, ...
#' @param id should be unique.
#' @param title content title.
#' @param active whether the tab content is active or not. FALSE by default.
#' @param icon tab icon.
#' 
#' @export
rightSidebarTabContent <- function(..., id, title = NULL, active = FALSE,
                                   icon = "database") {
  
  stopifnot(!is.null(id))
  
  shiny::tags$div(
    class = if (isTRUE(active)) "tab-pane active" else "tab-pane", 
    id = paste0("control-sidebar-", id, "-tab"),
    icon = icon,
    shiny::tags$h3(class = "control-sidebar-heading", title),
    ...
  )
}




#' @title AdminLTE2 right sidebar menu 
#'
#' @description Create a nice right sidebar menu.
#'
#' @param ... Slot for rightsidebarMenuItem.
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
#'        enable_rightsidebar = TRUE,
#'        rightSidebarIcon = "gears"
#'      ),
#'      sidebar = dashboardSidebar(),
#'      body = dashboardBody(),
#'      rightsidebar = rightSidebar(
#'        background = "dark",
#'        rightSidebarTabContent(
#'          id = 1,
#'          icon = "desktop",
#'          title = "Tab 1",
#'          active = TRUE,
#'          rightSidebarMenu(
#'           rightSidebarMenuItem(
#'            icon = menuIcon(
#'             name = "birthday-cake",
#'             color = "red"
#'            ),
#'            info = menuInfo(
#'             title = "Langdon's Birthday",
#'             description = "Will be 23 on April 24th"
#'            )
#'           ),
#'           rightSidebarMenuItem(
#'            icon = menuIcon(
#'             name = "user",
#'             color = "yellow"
#'            ),
#'            info = menuInfo(
#'             title = "Frodo Updated His Profile",
#'             description = "New phone +1(800)555-1234"
#'            )
#'           )
#'          )
#'        ),
#'        rightSidebarTabContent(
#'          id = 2,
#'          title = "Tab 2",
#'          textInput("caption", "Caption", "Data Summary")
#'        ),
#'        rightSidebarTabContent(
#'          id = 3,
#'          icon = "paint-brush",
#'          title = "Tab 3",
#'          numericInput("obs", "Observations:", 10, min = 1, max = 100)
#'        )
#'      ),
#'      title = "Right Sidebar"
#'    ),
#'    server = function(input, output) { }
#'  )
#' }
#'
#' @export
rightSidebarMenu <- function(...) {
  shiny::tags$ul(
    class = "control-sidebar-menu",
    ...
  )
}



#' @title AdminLTE2 right sidebar menu item
#'
#' @description Item to insert in a rightsidebarMenu.
#'
#' @param icon Slot for menuIcon.
#' @param info Slot for menuInfo.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
rightSidebarMenuItem <- function(icon, info) {
  shiny::tags$li(
    shiny::tags$a(
      href = "javascript:void(0)",
      icon,
      info
    )
  )
}


#' @title AdminLTE2 menu icon item
#'
#' @description Create a nice menu icon to insert in a rightsidebarMenuItem.
#'
#' @param name Icon name.
#' @param color background color: see here for a list of valid colors 
#' \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
menuIcon <- function(name, color) {
  
  stopifnot(!is.null(name))
  stopifnot(!is.null(color))
  
  menuIconCl <- paste0("menu-icon", " fa fa-", name, " bg-", color)
  shiny::tags$i(class = menuIconCl)
}




#' @title AdminLTE2 menu info item
#'
#' @description Create a nice menu info to insert in a rightsidebarMenuItem.
#'
#' @param title Menu title.
#' @param description Extra informations.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
menuInfo <- function(title = NULL, description = NULL) {
  shiny::tags$div(
    class = "menu-info",
    shiny::tags$h4(class = "control-sidebar-subheading", title),
    shiny::tags$p(description)
  )
}