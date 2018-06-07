#' @title AdminLTE2 user post
#'
#' @description Create a user post
#'
#' @param ... post content, slot for userPostToolItemList.
#' @param id unique id of the post.
#' @param src profile image, if any.
#' @param author post author.
#' @param description post description.
#' @param collapsible If TRUE, display a button in the upper right that allows the user to collapse the comment. 
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
#'       title = "Box with user comment",
#'       status = "primary",
#'       userPost(
#'        id = 1,
#'        src = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
#'        author = "Jonathan Burke Jr.",
#'        description = "Shared publicly - 7:30 PM today",
#'        "Lorem ipsum represents a long-held tradition for designers, 
#'        typographers and the like. Some people hate it and argue for 
#'        its demise, but others ignore the hate as they create awesome 
#'        tools to help create filler text for everyone from bacon 
#'        lovers to Charlie Sheen fans.",
#'        userPostToolItemList(
#'         userPostToolItem(dashboardLabel("item 1")),
#'         userPostToolItem(dashboardLabel("item 2", status = "danger"), side = "right")
#'        )
#'       ),
#'       userPost(
#'        id = 2,
#'        src = "https://adminlte.io/themes/AdminLTE/dist/img/user6-128x128.jpg",
#'        author = "Adam Jones",
#'        description = "Shared publicly - 5 days ago",
#'        userPostMedia(src = "https://adminlte.io/themes/AdminLTE/dist/img/photo2.png"),
#'        userPostToolItemList(
#'         userPostToolItem(dashboardLabel("item 1")),
#'         userPostToolItem(dashboardLabel("item 2", status = "danger"), side = "right")
#'        )
#'       )
#'      )
#'     ),
#'     title = "userPost"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#' 
#' @export
userPost <- function(..., id = NULL, src = NULL, author = NULL, 
                     description = NULL, collapsible = TRUE) {
  
  cl <- "collapse"
  
  shiny::tags$div(
    class = "post",
    
    shiny::tags$div(
      class = "user-block",
      shiny::img(class = "img-circle img-bordered-sm", src = src),
      shiny::tags$span(
        class = "username", 
        author,
        
        # box tool
        if (collapsible) {
          shiny::tags$button(
            class = "pull-right btn-box-tool",
            `data-toggle` = "collapse",
            `data-target` = paste0("#", id),
            type = "button",
            shiny::tags$i(class = "fa fa-eye")
          )
        }
        
      ),
      shiny::tags$span(class = "description", description)
    ),
    shiny::tags$p(
      class = cl,
      id = id,
      ...
    )
  )
  
}




#' @title AdminLTE2 user post tool item container
#'
#' @description Create a user post tool item container
#'
#' @param ... slot for userPostToolItem.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
userPostToolItemList <- function(...) {
  
  shiny::tags$ul(
    class = "list-inline",
    ...
  )
}




#' @title AdminLTE2 user post tool item
#'
#' @description Create a user post tool item
#'
#' @param ... tool content such as label, button, ...
#' @param side tool item orientation: "left" of "right", "left" by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
userPostToolItem <- function(..., side = "left") {
  
  cl <- if (side == "left") NULL else "pull-right"
  
  shiny::tags$li(
    class = cl,
    ...
  )
}



#' @title AdminLTE2 user post media
#'
#' @description Create a user post media (image)
#'
#' @param src image path or url ...
#' @param height media height in pixels.
#' @param width media width in pixels.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
userPostMedia <- function(src = NULL, height = NULL, width = NULL) {
  shiny::img(
    class = "img-responsive", 
    src = src,
    height = height,
    width = width
  )
}
