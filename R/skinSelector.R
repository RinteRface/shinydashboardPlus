#' AdminLTE2 skin selector
#'
#' This creates a skin selector element.
#' 
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinydashboard)
#'  library(shinydashboardPlus)
#'  
#'  shinyApp(
#'    ui = dashboardPage(
#'      header = dashboardHeader(),
#'      sidebar = dashboardSidebar(),
#'      body = dashboardBody(),
#'      controlbar = dashboardControlbar(skinSelector()),
#'      title = "Skin Selector"
#'    ),
#'    server = function(input, output) { }
#'  )
#' }
#' @export
skinSelector <- function() {
  
  items <- lapply(validSkins, function(skin) {
    skinSelectorItem(skin)
  })
  
  shiny::tags$ul(
    class = "list-unstyled clearfix skinSelector-widget",
    items
  )
}


#' AdminLTE2 skin selector item
#'
#' This creates an item to insert in a skin selector object.
#' 
#' @param color Skin color: "blue", "black", "purple", "red", "green", "yellow" as well as
#' "blue-light", "black-light", "purple-light", "red-light", "green-light" and  "yellow-light".
#' 
#' @author David Granjon, \email{dgranjon@@ymail.com}
skinSelectorItem <- function(color) {
  bg_color <- strsplit(x = color, split = "-")[[1]][1]
  skin <- paste0("skin-", color)
  
  shiny::tags$li(
    style = "float:left; width: 33.33333%; padding: 3px;",
    shiny::tags$a(
      onclick = sprintf("changeSkin('%s');", skin),
      `data-skin` = skin,
      style = "display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)",
      class = "clearfix full-opacity-hover",
      shiny::tags$div(
        shiny::tags$span(
          style = "display:block; width: 20%; float: left; height: 7px",
          class = paste0("bg-", bg_color, "-active")
        ),
        shiny::tags$span(
          class = paste0("bg-", bg_color),
          style = "display:block; width: 80%; float: left; height: 7px;"
        )
      ),
      shiny::tags$div(
        shiny::tags$span(
          # the sidebar color depends on if there is light in the color
          style = if (length(grep(x = color, pattern = "light")) != 0) {
            "display:block; width: 20%; float: left; height: 20px; background: #f9fafc"
          } else {
            "display:block; width: 20%; float: left; height: 20px; background: #222d32"
          }
        ),
        shiny::tags$span(style = "display:block; width: 80%; float: left; height: 20px; background: #f4f5f7")
      )
    ),
    shiny::tags$p(class = "text-center no-margin", color)
  )
} 