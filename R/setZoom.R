#' Custom zoom
#'
#' Allow to apply a zoom on a given element.
#'
#' @param class The element to which the zoom should be applied.
#' For example, class is set to box.
#' @param scale Zoom scale. 1.05 by default (5\% bigger than the normal). We do not
#' recommand using higher values, except in some particular cases.
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
#'       tags$h2("Add zoom and hover interactions to any element"),
#'
#'       setZoom("box", scale = 1.05),
#'       setZoom("info-box", scale = 1.05),
#'       setZoom("progress", scale = 1.05),
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
setZoom <- function(class, scale = 1.05) {
  
  # zoom css
  cssZoom <- paste0(
    " transition: transform .2s; /* Animation */
   ")
  cssZoom <- paste0(".", class, " {", cssZoom, "}")
  
  # hover effect css
  cssHover <- paste0("transform: scale(", scale, "); 
  /* (x% zoom - Note: if the zoom is too large, 
  it will go outside of the viewport) 
  */")
  cssHover <- paste0(".", class, ":hover", " {", cssHover, "}")
  
  css <- paste(cssZoom, cssHover)
  
  # wrap everything in the head
  htmltools::tags$head(
    htmltools::tags$style(css)
  )
}

