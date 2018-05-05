#' @title AdminLTE2 product list container
#'
#' @description Create a container product list elements
#'
#' @param ... slot for productListItem.
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
#'       title = "Product List",
#'       status = "primary",
#'       productList(
#'         productListItem(
#'           src = "http://www.pngmart.com/files/1/Haier-TV-PNG.png", 
#'           productTitle = "Samsung TV", 
#'           productPrice = "$1800", 
#'           priceColor = "warning",
#'           "This is an amazing TV, but I don't like TV!"
#'         ),
#'         productListItem(
#'           src = "http://icon-park.com/imagefiles/imac.png", 
#'           productTitle = "Imac 27", 
#'           productPrice = "$2400", 
#'           priceColor = "danger",
#'           "This is were I spend most of my time!"
#'         )
#'       )
#'      )
#'     ),
#'     title = "Product List"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
productList <- function(...) {
  shiny::tags$ul(
    class = "products-list product-list-in-box",
    ...
  )
}


#' @title AdminLTE2 product item
#'
#' @description Create a product item
#'
#' @param ... product description.
#' @param src image url, if any.
#' @param productTitle product name.
#' @param productPrice product price.
#' @param priceColor price color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
productListItem <- function(..., src = NULL, productTitle = NULL, 
                            productPrice = NULL, priceColor = NULL) {
  cl <- "label pull-right"
  if (!is.null(priceColor)) cl <- paste0(cl, " label-", priceColor)
  
  shiny::tags$li(
    class = "item",
    shiny::tags$div(
      class = "product-img",
      shiny::tags$img(src = src, alt = "Product Image")
    ),
    shiny::tags$div(
      class = "product-info",
      shiny::tags$a(
        href = "javascript:void(0)", 
        class = "product-title",
        productTitle,
        shiny::tags$span(class = cl, productPrice)
      ),
      shiny::tags$span(
        class = "product-description",
        ...
      )
    )
  )
}