# #' AdminLTE2 skin selector
# #'
# #' This creates a skin selector element.
# #' 
# #' @param ... slot for skinSelectorItem.
# #' 
# #' @author David Granjon, \email{dgranjon@@ymail.com}
# #'
# #' @examples
# #' if (interactive()) {
# #'  library(shiny)
# #'  library(shinydashboard)
# #'  shinyApp(
# #'    ui = dashboardPagePlus(
# #'      header = dashboardHeaderPlus(
# #'       enable_rightsidebar = TRUE,
# #'       rightSidebarIcon = "gears"
# #'      ),
# #'      sidebar = dashboardSidebar(),
# #'      body = dashboardBody(),
# #'      rightsidebar = rightSidebar(
# #'       background = "dark",
# #'        rightSidebarTabContent(
# #'         id = 1,
# #'         title = "Tab 1",
# #'         skinSelector(
# #'          skinSelectorItem(color = "red"),
# #'          skinSelectorItem(color = "green"),
# #'          skinSelectorItem(color = "yellow-light")
# #'         )
# #'        ),
# #'        rightSidebarTabContent(
# #'         id = 2,
# #'         title = "Tab 2",
# #'         textInput("caption", "Caption", "Data Summary")
# #'        ),
# #'        rightSidebarTabContent(
# #'         id = 3,
# #'         title = "Tab 3",
# #'         numericInput("obs", "Observations:", 10, min = 1, max = 100)
# #'        )
# #'      ),
# #'      title = "Right Sidebar"
# #'    ),
# #'    server = function(input, output) { }
# #'  )
# #' }
# #' @export
# skinSelector <- function(...) {
#   shiny::tags$ul(
#     class = "list-unstyled clearfix",
#     ...
#   )
# }
# 
# 
# #' AdminLTE2 skin selector item
# #'
# #' This creates an item to insert in a skin selector object.
# #' 
# #' @param color Skin color: "blue", "black", "purple", "red", "green", "yellow" as well as
# #' "blue-light", "black-light", "purple-light", "red-light", "green-light" and  "yellow-light".
# #' 
# #' @author David Granjon, \email{dgranjon@@ymail.com}
# #'
# #' @export
# skinSelectorItem <- function(color) {
#   
#   stopifnot(!is.null(color))
#   
#   bg_color <- strsplit(x = color, split = "-")[[1]][1]
#   
#   shiny::tags$li(
#     style = "float:left; width: 33.33333%; padding: 5px;",
#     shiny::tags$a(
#       href = "javascript:void(0)",
#       `data-skin` = paste0("skin-", color),
#       style = "display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)",
#       class = "clearfix full-opacity-hover",
#       shiny::tags$div(
#         shiny::tags$span(
#           style = "display:block; width: 20%; float: left; height: 7px",
#           class = paste0("bg-", bg_color, "-active")
#         ),
#         shiny::tags$span(
#           class = paste0("bg-", bg_color),
#           style = "display:block; width: 80%; float: left; height: 7px;"
#         )
#       ),
#       shiny::tags$div(
#         shiny::tags$span(
#           # the sidebar color depends on if there is light in the color
#           style = if (length(grep(x = color, pattern = "light")) != 0) {
#             "display:block; width: 20%; float: left; height: 20px; background: #f9fafc"
#           } else {
#             "display:block; width: 20%; float: left; height: 20px; background: #222d32"
#           }
#         ),
#         shiny::tags$span(style = "display:block; width: 80%; float: left; height: 20px; background: #f4f5f7")
#       )
#     ),
#     shiny::tags$p(class = "text-center no-margin", color)
#   )
# } 