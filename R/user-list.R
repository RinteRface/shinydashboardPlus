#' @title AdminLTE2 user list container
#'
#' @description Create a user list container
#'
#' @param ... slot for userListItem.
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
#'       title = "User List example",
#'       status = "success",
#'       userList(
#'         userListItem(
#'           src = "https://www.rstudio.com/wp-content/uploads/2014/04/shiny.png", 
#'           user_name = "Shiny", 
#'           description = "28.04.2018"
#'         ),
#'         userListItem(
#'           src = "https://www.rstudio.com/wp-content/uploads/2014/04/knitr.png", 
#'           user_name = "knitr", 
#'           description = "28.04.2018"
#'         ),
#'         userListItem(
#'           src = "https://www.rstudio.com/wp-content/uploads/2017/05/rmarkdown.png", 
#'           user_name = "Rmarkdown", 
#'           description = "28.04.2018"
#'         ),
#'         userListItem(
#'           src = "https://www.tidyverse.org/images/hex-tidyverse.png", 
#'           user_name = "Tidyverse", 
#'           description = "28.04.2018"
#'         ),
#'         userListItem(
#'           src = "https://www.rstudio.com/wp-content/uploads/2014/04/tidyr.png", 
#'           user_name = "tidyr", 
#'           description = "28.04.2018"
#'         ),
#'         userListItem(
#'           src = "https://www.rstudio.com/wp-content/uploads/2014/04/packrat.png", 
#'           user_name = "packrat", 
#'           description = "28.04.2018"
#'         ),
#'         userListItem(
#'           src = "https://www.rstudio.com/wp-content/uploads/2014/04/sparklyr.png", 
#'           user_name = "packrat", 
#'           description = "28.04.2018"
#'         )
#'       )
#'      )
#'     ),
#'     title = "User List"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
userList <- function(...) {
  shiny::tags$div(
    class = "box-body no-padding",
    shiny::tags$ul(
      class = "users-list clearfix",
      ...
    )
  )
}


#' @title AdminLTE2 user list item
#'
#' @description Create a user list item
#'
#' @param src image url or path.
#' @param user_name user name.
#' @param description any date element.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
userListItem <- function(src = NULL, user_name = NULL, description = NULL) {
  shiny::tags$li(
    shiny::tags$img(
      src = src, alt = "User Image",
      shiny::tags$a(class = "users-list-name", user_name),
      shiny::tags$span(class = "users-list-date", description)
    )
  )
}