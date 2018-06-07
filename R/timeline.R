#' @title AdminLTE2 timeline block
#'
#' @description Create a timeline block
#'
#' @param ... slot for timelineLabel or timelineItem.
#' @param reversed Whether the timeline is reversed or not.
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
#'      h3("When Reversed = TRUE, can be displayed inside a box"),
#'      box(
#'       title = "Timeline",
#'       status = "info",
#'       timelineBlock(
#'        timelineEnd(color = "danger"),
#'        timelineLabel(2018, color = "teal"),
#'        timelineItem(
#'         title = "Item 1",
#'         icon = "gears",
#'         color = "olive",
#'         time = "now",
#'         footer = "Here is the footer",
#'         "This is the body"
#'        ),
#'        timelineItem(
#'         title = "Item 2",
#'         border = FALSE
#'        ),
#'        timelineLabel(2015, color = "orange"),
#'        timelineItem(
#'         title = "Item 3",
#'         icon = "paint-brush",
#'         color = "maroon",
#'         timelineItemMedia(src = "http://placehold.it/150x100"),
#'         timelineItemMedia(src = "http://placehold.it/150x100")
#'        ),
#'        timelineStart(color = "gray")
#'       )
#'      ),
#'      
#'      column(
#'       width = 6,
#'       h3("When Reversed = FALSE, can be displayed out of a box"),
#'       timelineBlock(
#'        reversed = FALSE,
#'        timelineEnd(color = "danger"),
#'        timelineLabel(2018, color = "teal"),
#'        timelineItem(
#'         title = "Item 1",
#'         icon = "gears",
#'         color = "olive",
#'         time = "now",
#'         footer = "Here is the footer",
#'         "This is the body"
#'        ),
#'        timelineItem(
#'         title = "Item 2",
#'         border = FALSE
#'        ),
#'        timelineLabel(2015, color = "orange"),
#'        timelineItem(
#'         title = "Item 3",
#'         icon = "paint-brush",
#'         color = "maroon",
#'         timelineItemMedia(src = "http://placehold.it/150x100"),
#'         timelineItemMedia(src = "http://placehold.it/150x100")
#'        ),
#'        timelineStart(color = "gray")
#'       )
#'      )
#'     ),
#'     title = "timelineBlock"
#'   ),
#'   server = function(input, output) { }
#'  )
#' }
#'
#' @export
timelineBlock <- function(..., reversed = TRUE) {
  
  cl <- "timeline"
  if (isTRUE(reversed)) cl <- paste0(cl, " timeline-inverse")
  
  shiny::tags$ul(
    class = cl,
    ...
  )
}


#' @title AdminLTE2 timeline label
#'
#' @description Create a timeline label
#'
#' @param ... any element.
#' @param color label color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
timelineLabel <- function(..., color = NULL) {
  
  cl <- "bg-"
  if (!is.null(color)) cl <- paste0(cl, color)
  
  shiny::tags$li(
    class = "time-label",
    shiny::tags$span(
      class = cl,
      ...
    )
  )
}


#' @title AdminLTE2 timeline item
#'
#' @description Create a timeline item
#'
#' @param ... any element such as timeLineItemMedia ...
#' @param icon item icon such as "clock-o", "times", ...
#' @param color item color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' @param time item date or time.
#' @param title item title.
#' @param border Whether to display a border between the header and the body. TRUE by default.
#' @param footer item footer if any.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
timelineItem <- function(..., icon = NULL, color = NULL, time = NULL,
                         title = NULL, border = TRUE, footer = NULL) {
  
  cl <- "fa fa-"
  if (!is.null(icon)) cl <- paste0(cl, icon)
  if (!is.null(color)) cl <- paste0(cl, " bg-", color)
  
  itemCl <- "timeline-header no-border"
  if (isTRUE(border)) itemCl <- "timeline-header"
  
  shiny::tags$li(
    
    # timelineItem icon and color
    shiny::tags$i(class = cl),
    
    # timelineItem container
    shiny::tags$div(
      class = "timeline-item",
      
      #timelineItem time/date
      shiny::tags$span(
        class = "time",
        shiny::icon("clock-o"),
        time
      ),
      
      # timelineItem title
      shiny::tags$h3(
        class = itemCl,
        title
      ),
      
      # timelineItem body
      shiny::tags$div(
        class = "timeline-body",
        ...
      ),
      
      # timelineItem footer
      shiny::tags$div(
        class = "timeline-footer",
        footer
      )
    )
  )
}


#' @title AdminLTE2 timeline media item
#'
#' @description Create a timeline media item
#'
#' @param src media url or path.
#' @param height media height in pixels.
#' @param width media width in pixels.
#' 
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
timelineItemMedia <- function(src = NULL, height = NULL, width = NULL) {
  shiny::img(
    class = "margin", 
    src = src, 
    height = height,
    width = width
  )
}




#' @title AdminLTE2 timeline starting point
#'
#' @description Create a timeline starting point
#'
#' @param icon item icon such as "clock-o", "times", ...
#' @param color item color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
timelineStart <- function(icon = "clock-o", color = NULL) {
  
  cl <- "fa fa-"
  if (!is.null(icon)) cl <- paste0(cl, icon)
  if (!is.null(color)) cl <- paste0(cl, " bg-", color)
  
  shiny::tags$li(
    shiny::tags$i(class = cl)
  )
}


#' @title AdminLTE2 timeline ending point
#'
#' @description Create a timeline ending point
#'
#' @param icon item icon such as "clock-o", "times", ...
#' @param color item color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' 
#' @export
timelineEnd <- function(icon = "hourglass-end", color = NULL) {
  
  cl <- "fa fa-"
  if (!is.null(icon)) cl <- paste0(cl, icon)
  if (!is.null(color)) cl <- paste0(cl, " bg-", color)
  
  shiny::tagList(
    shiny::tags$li(
      shiny::tags$i(class = cl)
    ),
    shiny::br(), 
    shiny::br()
  )
}