#' Custom pulse animation
#'
#' Allow to apply a pulse animation on a given element.
#'
#' @param class The element to which the pulse should be applied.
#' For example, class is set to box.
#' @param duration Pulse frequency. 1s by default.
#' @param iteration Pulse iteration. 5 by default.
#'
#' @export
#'
#' @examples
#'  if (interactive()) {
#'
#'   library(shiny)
#'   library(shinyWidgets)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'   
#'   shinyApp(
#'    ui = dashboardPagePlus(
#'      header = dashboardHeaderPlus(
#'        enable_rightsidebar = TRUE,
#'        rightSidebarIcon = "gears"
#'      ),
#'      sidebar = dashboardSidebar(),
#'      body = dashboardBody(
#'       tags$h2("Add pulse animation to any element"),
#'
#'       setPulse("box", duration = 1, iteration = 5),
#'       setPulse("info-box", duration = 1, iteration = 5),
#'       setPulse("progress", duration = 1, iteration = 5),
#'  
#'       fluidRow(
#'        boxPlus(
#'          title = "Closable Box with dropdown",
#'          closable = TRUE,
#'          status = "warning",
#'          solidHeader = FALSE,
#'          collapsible = TRUE,
#'          enable_dropdown = TRUE,
#'          dropdown_icon = "wrench",
#'          dropdown_menu = dropdownItemList(
#'            dropdownItem(url = "http://www.google.com", name = "Link to google"),
#'            dropdownItem(url = "#", name = "item 2"),
#'            dropdownDivider(),
#'            dropdownItem(url = "#", name = "item 3")
#'          ),
#'          p("Box Content")
#'        ),
#'        boxPlus(
#'          title = "Closable box, with label",
#'          closable = TRUE,
#'          enable_label = TRUE,
#'          label_text = 1,
#'          label_status = "danger",
#'          status = "warning",
#'          solidHeader = FALSE,
#'          collapsible = TRUE,
#'          p("Box Content")
#'        )
#'       ),
#'       fluidRow(
#'        infoBox(
#'        "Orders",
#'        "50",
#'        "Subtitle", icon = icon("credit-card")
#'        )
#'       ),
#'       fluidRow(
#'        verticalProgress(
#'         value = 10,
#'         striped = TRUE,
#'         active = TRUE
#'        ),
#'        verticalProgress(
#'          value = 50,
#'          active = TRUE,
#'          status = "warning",
#'          size = "xs"
#'        ),
#'        verticalProgress(
#'          value = 20,
#'          status = "danger",
#'          size = "sm",
#'          height = "60%"
#'        )
#'       )
#'      ),
#'      rightsidebar = rightSidebar(),
#'      title = "DashboardPage"
#'    ),
#'    server = function(input, output) { }
#'   )
#' }
setPulse <- function(class, duration = 1, iteration = 5) {
  
  # pulse css
  cssPulse <- paste0(
    "animation: pulse ", duration, "s;
     animation-iteration-count: ", iteration, ";
    "
  )
  cssPulse <- paste0(".", class, " {", cssPulse, "}")
  
  # other CSS elements
  extracss <- paste0(
    "@-webkit-keyframes pulse {
      0% {
        -webkit-box-shadow: 0 0 0 0 rgba(204,169,44, 0.4);
      }
      70% {
        -webkit-box-shadow: 0 0 0 10px rgba(204,169,44, 0);
      }
      100% {
        -webkit-box-shadow: 0 0 0 0 rgba(204,169,44, 0);
      }
     }
     @keyframes pulse {
      0% {
        -moz-box-shadow: 0 0 0 0 rgba(204,169,44, 0.4);
        box-shadow: 0 0 0 0 rgba(204,169,44, 0.4);
      }
      70% {
        -moz-box-shadow: 0 0 0 10px rgba(204,169,44, 0);
        box-shadow: 0 0 0 10px rgba(204,169,44, 0);
      }
      100% {
        -moz-box-shadow: 0 0 0 0 rgba(204,169,44, 0);
        box-shadow: 0 0 0 0 rgba(204,169,44, 0);
      }
     }
    "
  )
  
  css <- paste(cssPulse, extracss)
  
  # wrap everything in the head
  htmltools::tags$head(
    htmltools::tags$style(css)
  )
}

