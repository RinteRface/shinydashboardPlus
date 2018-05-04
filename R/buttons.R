#' @title AdminLTE2 special large button
#'
#' @description Create a large button ideal for web applications
#'
#' @param url if the button should redirect somewhere.
#' @param label button label.
#' @param icon button icon, if any. Should be written like "fa fa-times".
#' @param enable_badge Whether to display a badge on the top-right corner of the button.
#' @param badgeColor color of the badge: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' @param badgeLabel text to display in the badge. I personally recommend you to only put numbers.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       title = "App Buttons",
#'       status = NULL,
#'       appButton(
#'         url = "http://google.com",
#'         label = "Users", 
#'         icon = "fa fa-users", 
#'         enable_badge = TRUE, 
#'         badgeColor = "purple", 
#'         badgeLabel = 891
#'       ),
#'       appButton(
#'         label = "Edit", 
#'         icon = "fa fa-edit", 
#'         enable_badge = FALSE, 
#'         badgeColor = NULL, 
#'         badgeLabel = NULL
#'       ),
#'       appButton(
#'         label = "Likes", 
#'         icon = "fa fa-heart-o", 
#'         enable_badge = TRUE, 
#'         badgeColor = "red", 
#'         badgeLabel = 3
#'       )
#'      )
#'     ),
#'     title = "Buttons"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
appButton <- function(url = NULL, label = NULL, icon = NULL, enable_badge = FALSE, 
                      badgeColor = NULL, badgeLabel = NULL) {
  shiny::tags$a(
    class = "btn btn-app",
    if (isTRUE(enable_badge)) {
      cl <- "badge"
      if (!is.null(badgeColor)) cl <- paste0(cl, " bg-", badgeColor)
      shiny::tags$span(class = cl, badgeLabel)
    },
    shiny::tags$i(class = icon),
    label,
    href = url
  )
}



#' @title AdminLTE2 social button
#'
#' @description Create a social button
#'
#' @param url if the button should redirect somewhere.
#' @param type social network name: see here for valid names \url{https://adminlte.io/themes/AdminLTE/pages/UI/buttons.html}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'      box(
#'       title = "Social Buttons",
#'       status = NULL,
#'       socialButton(
#'         url = "http://dropbox.com",
#'         type = "dropbox"
#'       ),
#'       socialButton(
#'         url = "http://github.com",
#'         type = "github"
#'       )
#'      )
#'     ),
#'     title = "Description Blocks"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
socialButton <- function(url, type = NULL) {
  
  cl <- "btn btn-social-icon"
  if (!is.null(type)) cl <- paste0(cl, " btn-", type)
  
  shiny::tags$a(
    href = url,
    class = cl,
    shiny::icon(type)
  )
}