#' @title AdminLTE2 attachment container
#'
#' @description Create an attachment container, nice to wrap articles...
#'
#' @param ... any element.
#' @param src url or path to the image.
#' @param title attachment title.
#' @param title_url external link.
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
#'       title = "Attachment example",
#'       attachmentBlock(
#'        src = "http://kiev.carpediem.cd/data/afisha/o/2d/c7/2dc7670333.jpg",
#'        title = "Test",
#'        title_url = "http://google.com",
#'        "This is the content"
#'       )
#'      )
#'     ),
#'     title = "AttachmentBlock"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export

attachmentBlock <- function(..., src = NULL, title = NULL, title_url = NULL) {
  shiny::tags$div(
    class = "attachment-block clearfix",
    shiny::img(
      class = "attachment-img",
      src = src
    ),
    shiny::tags$div(
      class = "attachment-pushed",
      shiny::tags$h4(
        class = "attachment-heading",
        shiny::tags$a(
          href = title_url,
          title
        )
      ),
      shiny::tags$div(
        class = "attachment-text",
        ...
      )
    )
  )
}