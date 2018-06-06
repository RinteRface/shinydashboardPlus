#' AdminLTE2 vertical progress bar
#'
#' This creates a vertical progress bar.
#' 
#' @param value Progress bar value. Must be between min and max.
#' @param min Progress bar minimum value (0 by default).
#' @param max Progress bar maximum value (100 by default).
#' @param height Progress bar default height (40 percent by default).
#' @param striped Whether the progress is striped or not. FALSE by default. 
#' @param active  Whether the progress is active or not. FALSE by default.
#' @param status Progress bar status. "primary" by default or "warning", "info",
#' "danger" or "success".
#' @param size Progress bar size. NULL by default: "sm", "xs" or "xxs" also available.
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
#'      body = dashboardBody(
#'       verticalProgress(
#'        value = 10,
#'        striped = TRUE,
#'        active = TRUE
#'       ),
#'       verticalProgress(
#'        value = 50,
#'        active = TRUE,
#'        status = "warning",
#'        size = "xs"
#'       ),
#'       verticalProgress(
#'        value = 20,
#'        status = "danger",
#'        size = "sm",
#'        height = "60%"
#'       )
#'      ),
#'      rightsidebar = rightSidebar(),
#'      title = "Right Sidebar"
#'    ),
#'    server = function(input, output) { }
#'  )
#' }
#' @export
verticalProgress <- function(value, min = 0, max = 100, height = "40%", striped = FALSE, 
                             active = FALSE, status = "primary", size = NULL) {
  
  stopifnot(value <= max)
  
  verticalProgressCl <- "progress vertical"
  if (isTRUE(active)) verticalProgressCl <- paste0(verticalProgressCl, " active")
  if (!is.null(size)) verticalProgressCl <- paste0(verticalProgressCl, " progress-", size)
  
  barCl <- "progress-bar"
  if (isTRUE(striped)) barCl <- paste0(barCl, " progress-bar-striped")
  if (!is.null(status)) barCl <- paste0(barCl, " progress-bar-", status)
  
  shiny::tags$div(
    class = verticalProgressCl,
    shiny::tags$div(
      `aria-valuemax` = max,
      `aria-valuemin` = min,
      `aria-valuenow` = value,
      class = barCl,
      style = paste0("height: ", height),
      shiny::tags$span(class = "sr-only", value)
    )
  )
}