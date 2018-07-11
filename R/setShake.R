#' Custom shake animation
#'
#' Allow to apply a shake animation on a given element.
#'
#' @param class The element to which the shake should be applied.
#' For example, class is set to box.
#' @param duration Shake total duration. 0.82s by default.
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
#'       setShake("box"),
#'       setShake("info-box"),
#'       setShake("progress"),
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
setShake <- function(class, duration = 0.82) {
  
  # shake css
  cssShake <- paste0(
    "animation: shake ", duration ,"s cubic-bezier(.36,.07,.19,.97) both;
     transform: translate3d(0, 0, 0);
     backface-visibility: hidden;
     perspective: 1000px;
    "
  )
  cssHover <- paste0(".", class, ":hover", " {", cssShake, "}")
  
  # other CSS elements
  extracss <- paste0(
    "@keyframes shake {
      10%, 90% {
        transform: translate3d(-1px, 0, 0);
      }

      20%, 80% {
        transform: translate3d(2px, 0, 0);
      }
      
      30%, 50%, 70% {
        transform: translate3d(-4px, 0, 0);
      }
      
      40%, 60% {
        transform: translate3d(4px, 0, 0);
      }
     }
    "
  )
  
  css <- paste(cssHover, extracss)
  
  # wrap everything in the head
  htmltools::tags$head(
    htmltools::tags$style(css)
  )
}

