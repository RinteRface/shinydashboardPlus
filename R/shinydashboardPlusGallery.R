#' @title Launch the shinydashboardPlus Gallery
#'
#' @description
#' A gallery of all components available in shinydashboardPlus.
#'
#' @export
#'
#' @examples
#'
#' if (interactive()) {
#'
#'  shinydashboardPlusGallery()
#'
#' }
shinydashboardPlusGallery <- function() { # nocov start
  if (!requireNamespace(package = "shinydashboard"))
    message("Package 'shinydashboard' is required to run this function")
  if (!requireNamespace(package = "styler"))
    message("Package 'styler' is required to run this function")
  if (!requireNamespace(package = "shinyAce"))
    message("Package 'shinyAce' is required to run this function")
  if (!requireNamespace(package = "shinyWidgets"))
    message("Package 'shinyWidgets' is required to run this function")
  if (!requireNamespace(package = "shinyjqui"))
    message("Package 'shinyjqui' is required to run this function")
  
  shiny::shinyAppFile(system.file('examples/app.R', package = 'shinydashboardPlus', mustWork = TRUE))
}