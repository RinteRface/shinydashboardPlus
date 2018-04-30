#' AdminLTE2 dashboard right sidebar
#'
#' This creates a right sidebar.
#'
#' @examples
#' ## Only run this example in interactive R sessions
#' if (interactive()) {
#' # Basic dashboard page template
#' library(shiny)
#' shinyApp(
#'   ui = dashboardPage(
#'     header = dashboardHeader(
#'      enable_rightsidebar = TRUE,
#'      rightSidebarIcon = "gears"
#'     ),
#'     sidebar = dashboardSidebar(),
#'     body = dashboardBody(),
#'     rightsidebar = rightSidebar(),
#'     title = "Right Sidebar"
#'   ),
#'   server = function(input, output) { }
#' )
#' }
#' @export
rightSidebar <- function() {
  shiny::withTags(
    div(
      id = "right_sidebar",
      # Control Sidebar Open
      aside(class = "control-sidebar control-sidebar-dark",
            
            # # # # # # # #
            #
            # Navigation tabs
            #
            # # # # # # # #
            ul(class = "nav nav-tabs nav-justified control-sidebar-tabs",
               # first tabs
               li(class = "active",
                  a(href = "#control-sidebar-first-tab", `data-toggle` = "tab",
                    i(class = "fa fa-sliders")
                  )
               ),
               # second tabs
               li(
                 a(href = "#control-sidebar-second-tab", `data-toggle` = "tab",
                   i(class = "fa fa-map")
                 )
               ),
               # third tab
               li(
                 a(href = "#control-sidebar-third-tab", `data-toggle` = "tab",
                   i(class = "fa fa-paint-brush")
                 )
               )
            ),
            
            # # # # # # # #
            #
            # Tab Panels
            #
            # # # # # # # # 
            div(class = "tab-content",
                
                #########################
                #  First tab content  #
                #########################
                div(class = "tab-pane active", id = "control-sidebar-first-tab",
                    h3(class = "control-sidebar-heading", "Tab 1"),
                    
                    # write elements here
                    sliderInput("obs", "Number of observations:",
                                min = 0, max = 1000, value = 500
                    )
                    
                ),
                
                
                #########################
                # Second tab content #
                #########################
                div(class = "tab-pane", id = "control-sidebar-second-tab", 
                    h3(class = "control-sidebar-heading", "Tab 2"),
                    
                    # write other elements here
                    checkboxInput("somevalue", "Some value", FALSE)
                    
                    
                ),
                
                #########################
                # Third tab content #
                #########################
                div(class = "tab-pane", id = "control-sidebar-third-tab",
                    
                    # third tab elements here
                    radioButtons("dist", "Distribution type:",
                                 c("Normal" = "norm",
                                   "Uniform" = "unif",
                                   "Log-normal" = "lnorm",
                                   "Exponential" = "exp")
                    )
                )
            )
      ),
      # control-sidebar
      # Add the sidebar background. This div must be placed
      # immediately after the control sidebar
      div(class = "control-sidebar-bg", "")
    )
  )
}