#' AdminLTE2 accordion container
#'
#' Create an accordion container. Accordions are part of collapsible elements.
#'
#' @param ... slot for \link{accordionItem}.
#' @param id Unique accordion id.
#' @param width The width of the accordion.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' @rdname accordion
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         accordion(
#'           id = "accordion1",
#'           accordionItem(
#'             title = "Accordion 1 Item 1",
#'             status = "danger",
#'             collapsed = TRUE,
#'             "This is some text!"
#'           ),
#'           accordionItem(
#'             title = "Accordion 1 Item 2",
#'             status = "warning",
#'             collapsed = FALSE,
#'             "This is some text!"
#'           )
#'         ),
#'         accordion(
#'           id = "accordion2",
#'           accordionItem(
#'             title = "Accordion 2 Item 1",
#'             status = "info",
#'             collapsed = TRUE,
#'             "This is some text!"
#'           ),
#'           accordionItem(
#'             title = "Accordion 2 Item 2",
#'             status = "success",
#'             collapsed = FALSE,
#'             "This is some text!"
#'           )
#'         )
#'       ),
#'       title = "Accordion"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export
accordion <- function(..., id = NULL, width = 12) {
  items <- list(...)
  len <- length(items)

  # patch that enables a proper accordion behavior
  # we add the data-parent non standard attribute to each
  # item. Each accordion must have a unique id.
  lapply(seq_len(len), FUN = function(i) {
    items[[i]]$children[[1]]$children[[1]]$children[[1]]$attribs[["data-parent"]] <<- paste0("#", id)
    items[[i]]$children[[1]]$children[[1]]$children[[1]]$attribs[["href"]] <<- paste0("#collapse_", id, "_", i)
    items[[i]]$children[[2]]$attribs[["id"]] <<- paste0("collapse_", id, "_", i)
  })

  shiny::tags$div(
    class = if (!is.null(width)) paste0("col-sm-", width),
    shiny::tags$div(
      class = "box-group accordion",
      id = id,
      items
    )
  )
}


#' AdminLTE2 accordion item
#'
#' \link{accordionItem} creates an accordion item to put inside an \link{accordion} container.
#'
#' @inheritParams box
#'
#' @rdname accordion
#'
#' @export
accordionItem <- function(..., title, status = NULL, collapsed = TRUE,
                          solidHeader = TRUE) {
  cl <- "panel box"
  if (!is.null(status)) {
    validateStatusPlus(status)
    cl <- paste0(cl, " box-", status)
  }

  if (solidHeader) cl <- paste0(cl, " box-solid")

  shiny::tags$div(
    class = cl,

    # box header
    shiny::tags$div(
      class = "box-header with-border",
      shiny::tags$h4(
        class = "box-title",
        shiny::tags$a(
          href = NULL,
          `data-toggle` = "collapse",
          `data-parent` = NULL,
          `aria-expanded` = if (collapsed) "false" else "true",
          class = if (collapsed) "collapsed",
          title
        )
      )
    ),
    shiny::tags$div(
      id = NULL,
      class = if (collapsed) {
        "panel-collapse collapse"
      } else {
        "panel-collapse collapse in"
      },
      `aria-expanded` = if (collapsed) "false" else "true",
      style = if (collapsed) "height: 0px;" else NULL,
      shiny::tags$div(class = "box-body", ...)
    )
  )
}




#' Update an accordion on the client
#'
#' \link{updateAccordion} toggles an \link{accordion} on the client.
#'
#' @param id Accordion to target.
#' @param selected Index of the newly selected \link{accordionItem}.
#' @param session Shiny session object.
#'
#' @export
#' @rdname accordion
#' @examples
#'
#' # Update accordion
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         radioButtons("controller", "Controller", choices = c(1, 2)),
#'         br(),
#'         accordion(
#'           id = "accordion1",
#'           accordionItem(
#'             title = "Accordion 1 Item 1",
#'             status = "danger",
#'             collapsed = TRUE,
#'             "This is some text!"
#'           ),
#'           accordionItem(
#'             title = "Accordion 1 Item 2",
#'             status = "warning",
#'             collapsed = TRUE,
#'             "This is some text!"
#'           )
#'         )
#'       ),
#'       title = "Update Accordion"
#'     ),
#'     server = function(input, output, session) {
#'       observeEvent(input$controller, {
#'         updateAccordion(id = "accordion1", selected = input$controller)
#'       })
#'       observe(print(input$accordion1))
#'       observeEvent(input$accordion1, {
#'         showNotification(
#'           sprintf("You selected accordion N° %s", input$accordion1),
#'           type = "message"
#'         )
#'       })
#'     }
#'   )
#' }
updateAccordion <- function(id, selected, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(id, selected)
}




#' AdminLTE2 attachment container
#'
#' \link{attachmentBlock} create an attachment container, nice to wrap articles...
#' and insert in a \link{box}.
#'
#' @param ... any element.
#' @param image url or path to the image.
#' @param title attachment title.
#' @param href external link.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#'
#' # Box with attachmentBlock
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         box(
#'           title = "Attachment example",
#'           attachmentBlock(
#'             image = "https://adminlte.io/themes/AdminLTE/dist/img/photo1.png",
#'             title = "Test",
#'             href = "https://google.com",
#'             "This is the content"
#'           )
#'         )
#'       ),
#'       title = "AttachmentBlock"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export

attachmentBlock <- function(..., image, title = NULL, href = NULL) {
  shiny::tags$div(
    class = "attachment-block clearfix",
    shiny::img(
      class = "attachment-img",
      src = image
    ),
    shiny::tags$div(
      class = "attachment-pushed",
      if (!is.null(title)) {
        shiny::tags$h4(
          class = "attachment-heading",
          shiny::tags$a(
            href = if (!is.null(href)) href else "#",
            target = if (!is.null(href)) {
              "_blank"
            },
            title
          )
        )
      },
      shiny::tags$div(
        class = "attachment-text",
        ...
      )
    )
  )
}



#' @title AdminLTE2 block quote
#'
#' @description If you want to quote text
#'
#' @param ... any element.
#' @param side blockquote orientation. "left" by default, can be set to "right".
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         box(
#'           title = "BlockQuote example",
#'           blockQuote("I quote some text here!"),
#'           blockQuote("I quote some text here!", side = "right")
#'         )
#'       ),
#'       title = "blockQuote"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export
blockQuote <- function(..., side = "left") {
  shiny::tags$blockquote(
    class = if (side == "right") "pull-right",
    ...
  )
}



#' AdminLTE2 vertical block container
#'
#' \link{boxPad} creates a vertical container for \link{descriptionBlock}.
#' It has to be included in a \link{box}.
#'
#' @param ... any element such as \link{descriptionBlock}.
#' @param color background color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' See below:
#' \itemize{
#'  \item \code{light-blue (primary status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}.
#'  \item \code{red (danger status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#dd4b39")}.
#'  \item \code{green (success status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00a65a")}.
#'  \item \code{aqua (info status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00c0ef")}.
#'  \item \code{yellow (warning status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#f39c12")}.
#'  \item \code{blue}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#0073b7")}.
#'  \item \code{navy}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#001F3F")}.
#'  \item \code{teal}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#39CCCC")}.
#'  \item \code{olive}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3D9970")}.
#'  \item \code{lime}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#01FF70")}.
#'  \item \code{orange}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#FF851B")}.
#'  \item \code{fuchsia}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#F012BE")}.
#'  \item \code{purple}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#605ca8")}.
#'  \item \code{maroon}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#D81B60")}.
#'  \item \code{black}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#111")}.
#'  \item \code{gray}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#d2d6de")}.
#' }
#' @param style custom CSS, if any.
#' @rdname box
#'
#' @examples
#'
#' # Box with boxPad container + descriptionBlock
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         box(
#'           title = "Box with right pad",
#'           status = "warning",
#'           fluidRow(
#'             column(width = 6),
#'             column(
#'               width = 6,
#'               boxPad(
#'                 color = "green",
#'                 descriptionBlock(
#'                   header = "8390",
#'                   text = "VISITS",
#'                   rightBorder = FALSE,
#'                   marginBottom = TRUE
#'                 ),
#'                 descriptionBlock(
#'                   header = "30%",
#'                   text = "REFERRALS",
#'                   rightBorder = FALSE,
#'                   marginBottom = TRUE
#'                 ),
#'                 descriptionBlock(
#'                   header = "70%",
#'                   text = "ORGANIC",
#'                   rightBorder = FALSE,
#'                   marginBottom = FALSE
#'                 )
#'               )
#'             )
#'           )
#'         )
#'       ),
#'       title = "boxPad"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export
boxPad <- function(..., color = NULL, style = NULL) {
  cl <- "pad box-pane-right"
  if (!is.null(color)) {
    validateColor(color)
    cl <- paste0(cl, " bg-", color)
  }

  shiny::tags$div(
    class = cl,
    style = style,
    ...
  )
}




#' AdminLTE2 carousel container
#'
#' \link{carousel} creates a carousel container to display media content.
#'
#' @param ... Slot for \link{carouselItem}
#' @param id Carousel id. Must be unique.
#' @param indicators Whether to display left and right indicators.
#' @param width Carousel width. 6 by default.
#' @param .list Should you need to pass \link{carouselItem} via \link{lapply} or similar,
#' put these item here instead of passing them in ...
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       header = dashboardHeader(),
#'       sidebar = dashboardSidebar(),
#'       body = dashboardBody(
#'         carousel(
#'           id = "mycarousel",
#'           carouselItem(
#'             caption = "Item 1",
#'             tags$img(src = "https://placehold.it/900x500/3c8dbc/ffffff&text=I+Love+Bootstrap")
#'           ),
#'           carouselItem(
#'             caption = "Item 2",
#'             tags$img(src = "https://placehold.it/900x500/39CCCC/ffffff&text=I+Love+Bootstrap")
#'           )
#'         )
#'       ),
#'       title = "Carousel"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#' @export
#' @rdname carousel
carousel <- function(..., id, indicators = TRUE, width = 6, .list = NULL) {
  items <- c(list(...), .list)

  generateCarouselNav <- function(items) {
    found_active <- FALSE
    navs <- lapply(seq_along(items), FUN = function(i) {
      # if we found an active item, all other active items are ignored.
      active <- if (found_active) {
        FALSE
      } else {
        sum(grep(x = items[[i]]$attribs$class, pattern = "active")) == 1
      }
      # if the item has active class and no item was found before, we found the active item
      if (active && !found_active) found_active <- TRUE

      shiny::tags$li(
        `data-target` = paste0("#", id),
        `data-slide-to` = i - 1,
        class = if (active) "active"
      )
    })

    actives <- dropNulls(lapply(navs, function(nav) {
      nav$attribs$class
    }))

    # Make sure at least the first item is active
    if (length(actives) == 0) {
      navs[[1]]$attribs$class <- "active"
      items[[1]]$attribs$class <<- paste0(
        items[[1]]$attribs$class,
        " active"
      )
    }

    navs
  }

  indicatorsTag <- shiny::tags$ol(
    class = "carousel-indicators",
    generateCarouselNav(items)
  )

  bodyTag <- shiny::tags$div(
    class = "carousel-inner",
    items
  )

  controlButtons <- if (indicators) {
    shiny::tagList(
      # previous
      shiny::tags$a(
        class = "left carousel-control",
        href = paste0("#", id),
        `data-slide` = "prev",
        shiny::tags$span(class = "fa fa-angle-left")
      ),
      # next
      shiny::tags$a(
        class = "right carousel-control",
        href = paste0("#", id),
        `data-slide` = "next",
        shiny::tags$span(class = "fa fa-angle-right")
      )
    )
  } else {
    NULL
  }

  carouselTag <- shiny::tags$div(
    class = "carousel slide",
    `data-ride` = "carousel",
    id = id
  )

  carouselTag <- shiny::tagAppendChildren(carouselTag, indicatorsTag, bodyTag, controlButtons)

  shiny::tags$div(
    class = if (!is.null(width)) paste0("col-sm-", width),
    carouselTag
  )
}




#' AdminLTE2 carousel item
#'
#' \link{carouselItem} creates a carousel item to insert in a \link{carousel}.
#'
#' @param ... Element such as images, iframe, ...
#' @param caption Item caption.
#' @param active Whether the item is active or not at start.
#'
#' @rdname carousel
#'
#' @export
carouselItem <- function(..., caption = NULL, active = FALSE) {
  shiny::tags$div(
    class = if (active) "item active" else "item",
    ...,
    if (!is.null(caption)) {
      shiny::tags$div(class = "carousel-caption", caption)
    }
  )
}




#' @title AdminLTE2 social button
#'
#' @description Create a social button
#'
#' @param href External link.
#' @param icon social network icon: see here for valid names \url{https://adminlte.io/themes/AdminLTE/pages/UI/buttons.html}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         box(
#'           title = "Social Buttons",
#'           status = NULL,
#'           socialButton(
#'             href = "https://dropbox.com",
#'             icon = icon("dropbox")
#'           ),
#'           socialButton(
#'             href = "https://github.com",
#'             icon = icon("github")
#'           )
#'         )
#'       ),
#'       title = "Social Buttons"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export
socialButton <- function(href, icon) {
  if (!is.null(icon)) tagAssert(icon, type = "i")

  name <- strsplit(icon$attribs$class, "-")[[1]][2]
  cl <- sprintf("btn btn-social-icon btn-%s", name)

  shiny::tags$a(
    href = href,
    target = "_blank",
    class = cl,
    icon
  )
}




#' @title AdminLTE2 badge
#'
#' @description Create a badge. It may be inserted in any element like inside
#' a \link[shiny]{actionButton} or a \link{dashboardSidebar}.
#'
#' @param ... Any html text element.
#' @param color label color.
#' See below:
#' \itemize{
#'  \item \code{light-blue (primary status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}.
#'  \item \code{red (danger status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#dd4b39")}.
#'  \item \code{green (success status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00a65a")}.
#'  \item \code{aqua (info status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00c0ef")}.
#'  \item \code{yellow (warning status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#f39c12")}.
#'  \item \code{blue}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#0073b7")}.
#'  \item \code{navy}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#001F3F")}.
#'  \item \code{teal}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#39CCCC")}.
#'  \item \code{olive}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3D9970")}.
#'  \item \code{lime}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#01FF70")}.
#'  \item \code{orange}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#FF851B")}.
#'  \item \code{fuchsia}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#F012BE")}.
#'  \item \code{purple}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#605ca8")}.
#'  \item \code{maroon}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#D81B60")}.
#'  \item \code{black}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#111")}.
#'  \item \code{gray}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#d2d6de")}.
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         dashboardBadge("Badge 1", color = "blue"),
#'         actionButton(
#'           inputId = "badge",
#'           label = "Hello",
#'           icon = NULL,
#'           width = NULL,
#'           dashboardBadge(1, color = "orange")
#'         )
#'       )
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export
dashboardBadge <- function(..., color) {
  validateColor(color)
  shiny::tags$span(class = paste0("badge bg-", color), ...)
}




#' @title AdminLTE2 label
#'
#' @description Create a label
#'
#' @param ... any text.
#' @param status label status. Valid statuses are defined as follows:
#' \itemize{
#'   \item \code{primary}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}
#'   \item \code{success}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#00a65a")}
#'   \item \code{info}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#00c0ef")}
#'   \item \code{warning}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#f39c12")}
#'   \item \code{danger}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#f56954")}
#' }
#' @param style label border style: "default" (rounded angles), "circle" or "square".
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         dashboardLabel("Label 1", status = "info"),
#'         dashboardLabel("Label 2", status = "danger", style = "circle"),
#'         dashboardLabel("Label 3", status = "success", style = "square")
#'       )
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export
dashboardLabel <- function(..., status, style = "default") {
  validateStatus(status)
  shiny::tags$span(
    class = paste0("label", " label-", status),
    style = if (style == "circle") {
      "border-radius: 50%;"
    } else if (style == "square") {
      "border-radius: 0%;"
    } else {
      NULL
    },
    ...
  )
}




#' AdminLTE2 description block
#'
#' \link{descriptionBlock} creates a description block, perfect for writing statistics
#' to insert in a \link{box}
#'
#' @param number any number.
#' @param numberColor number color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' See below:
#' \itemize{
#'  \item \code{light-blue (primary status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}.
#'  \item \code{red (danger status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#dd4b39")}.
#'  \item \code{green (success status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00a65a")}.
#'  \item \code{aqua (info status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00c0ef")}.
#'  \item \code{yellow (warning status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#f39c12")}.
#'  \item \code{blue}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#0073b7")}.
#'  \item \code{navy}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#001F3F")}.
#'  \item \code{teal}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#39CCCC")}.
#'  \item \code{olive}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3D9970")}.
#'  \item \code{lime}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#01FF70")}.
#'  \item \code{orange}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#FF851B")}.
#'  \item \code{fuchsia}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#F012BE")}.
#'  \item \code{purple}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#605ca8")}.
#'  \item \code{maroon}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#D81B60")}.
#'  \item \code{black}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#111")}.
#'  \item \code{gray}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#d2d6de")}.
#' }
#' @param numberIcon number icon, if any. Expect \code{\link[shiny]{icon}}.
#' @param header bold text.
#' @param text additional text.
#' @param rightBorder TRUE by default. Whether to display a right border to
#'   separate two blocks. The last block on the right should not have a right border.
#' @param marginBottom FALSE by default. Set it to TRUE when the
#'   descriptionBlock is used in a boxPad context.
#'
#' @rdname box
#'
#' @examples
#'
#' # Box with descriptionBlock
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         box(
#'           solidHeader = FALSE,
#'           title = "Status summary",
#'           background = NULL,
#'           width = 4,
#'           status = "danger",
#'           footer = fluidRow(
#'             column(
#'               width = 6,
#'               descriptionBlock(
#'                 number = "17%",
#'                 numberColor = "green",
#'                 numberIcon = icon("caret-up"),
#'                 header = "$35,210.43",
#'                 text = "TOTAL REVENUE",
#'                 rightBorder = TRUE,
#'                 marginBottom = FALSE
#'               )
#'             ),
#'             column(
#'               width = 6,
#'               descriptionBlock(
#'                 number = "18%",
#'                 numberColor = "red",
#'                 numberIcon = icon("caret-down"),
#'                 header = "1200",
#'                 text = "GOAL COMPLETION",
#'                 rightBorder = FALSE,
#'                 marginBottom = FALSE
#'               )
#'             )
#'           )
#'         )
#'       ),
#'       title = "Description Blocks"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export
descriptionBlock <- function(number = NULL, numberColor = NULL, numberIcon = NULL,
                             header = NULL, text = NULL, rightBorder = TRUE,
                             marginBottom = FALSE) {
  # icon check. Fails if the user does not pass icon("...")
  if (!is.null(numberIcon)) tagAssert(numberIcon, type = "i")

  cl <- "description-block"
  if (isTRUE(rightBorder)) cl <- paste0(cl, " border-right")
  if (isTRUE(marginBottom)) cl <- paste0(cl, " margin-bottom")

  numcl <- "description-percentage"
  if (!is.null(numberColor)) {
    validateColor(numberColor)
    numcl <- paste0(numcl, " text-", numberColor)
  }

  shiny::tags$div(
    class = cl,
    shiny::tags$span(
      class = numcl,
      number,
      if (!is.null(numberIcon)) numberIcon
    ),
    shiny::tags$h5(class = "description-header", header),
    shiny::tags$span(class = "description-text", text)
  )
}



#' @title AdminLTE2 loading state element
#'
#' @description When a section is still work in progress or a computation is running
#'
#' @note Loading state can be programmatically used when a conputation is running for instance.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         box(
#'           title = "loading spinner",
#'           loadingState()
#'         )
#'       ),
#'       title = "Loading State"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export
loadingState <- function() {
  shiny::tags$div(
    class = "overlay",
    shiny::tags$i(class = "fa fa-refresh fa-spin")
  )
}



#' AdminLTE2 nav pill container
#'
#' \link{navPills} creates a container for nav elements. They are vertically stacked.
#' To insert in \link{box}.
#'
#' @param ... slot for \link{navPillsItem}.
#' @param id Item unique id. Returns the R index of the currently selected item.
#' This is different from the JavaScript index.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#'
#' # navPills
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         box(
#'           title = "Nav Pills",
#'           status = "info",
#'           "Box Body",
#'           footer = navPills(
#'             id = "pillItem",
#'             navPillsItem(
#'               left = "Item 1",
#'               color = "green",
#'               right = 10
#'             ),
#'             navPillsItem(
#'               left = "Item 2",
#'               color = "red",
#'               icon = icon("angle-down"),
#'               right = "10%",
#'               active = TRUE
#'             )
#'           )
#'         )
#'       ),
#'       title = "Nav Pills"
#'     ),
#'     server = function(input, output) {
#'       observeEvent(input$pillItem, {
#'         showNotification(sprintf("You clicked on pill N° %s", input$pillItem), type = "message")
#'       })
#'     }
#'   )
#' }
#'
#' @export
#' @rdname navPills
navPills <- function(..., id = NULL) {
  shiny::tags$ul(
    class = "nav nav-pills nav-stacked shinydashboardplus-custom",
    id = if (!is.null(id)) id,
    ...
  )
}




#' Update navPills on the client
#'
#' \link{updateNavPills} allows to programmatically change the currently
#' selected \link{navPillsItem} on the client.
#'
#' @param id \link{navPills} unique id to target.
#' @param selected Index of the \link{navPillsItem} to select. Index is seen from the R side.
#' @param session Shiny session object.
#' @export
#'
#' @rdname navPills
#'
#' @examples
#'
#' # update navPills
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         radioButtons("controller", "Controller", choices = c(1, 2, 3)),
#'         br(),
#'         box(
#'           title = "Nav Pills",
#'           status = "info",
#'           "Box Body",
#'           footer = navPills(
#'             inputId = "pills",
#'             navPillsItem(
#'               left = "Item 1",
#'               color = "green",
#'               right = 10
#'             ),
#'             navPillsItem(
#'               left = "Item 2",
#'               color = "red",
#'               icon = icon("angle-down"),
#'               right = "10%"
#'             ),
#'             navPillsItem(
#'               left = "Item 3",
#'               color = "blue",
#'               icon = icon("angle-up"),
#'               right = "30%"
#'             )
#'           )
#'         )
#'       ),
#'       title = "Nav Pills"
#'     ),
#'     server = function(input, output, session) {
#'       observeEvent(input$controller, {
#'         updateNavPills(id = "pills", selected = input$controller)
#'       })
#'       observeEvent(input$pills, {
#'         showNotification(sprintf("You selected pill N° %s", input$pills), type = "message")
#'       })
#'     }
#'   )
#' }
updateNavPills <- function(id, selected, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(id, selected)
}



#' AdminLTE2 nav pill item
#'
#' \link{navPillsItem} creates a nav pill item.
#'
#' @param left pill left text.
#' @param right pill right text.
#' @param color pill color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' See below:
#' \itemize{
#'  \item \code{light-blue (primary status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}.
#'  \item \code{red (danger status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#dd4b39")}.
#'  \item \code{green (success status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00a65a")}.
#'  \item \code{aqua (info status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00c0ef")}.
#'  \item \code{yellow (warning status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#f39c12")}.
#'  \item \code{blue}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#0073b7")}.
#'  \item \code{navy}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#001F3F")}.
#'  \item \code{teal}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#39CCCC")}.
#'  \item \code{olive}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3D9970")}.
#'  \item \code{lime}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#01FF70")}.
#'  \item \code{orange}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#FF851B")}.
#'  \item \code{fuchsia}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#F012BE")}.
#'  \item \code{purple}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#605ca8")}.
#'  \item \code{maroon}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#D81B60")}.
#'  \item \code{black}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#111")}.
#'  \item \code{gray}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#d2d6de")}.
#' }
#' @param icon pill icon, if any.
#' @param selected Whether the item is active or not. FALSE by default.
#'
#' @rdname navPills
#'
#' @export
navPillsItem <- function(left = NULL, right = NULL,
                         color = NULL, icon = NULL,
                         selected = FALSE) {
  cl <- "pull-right"
  if (!is.null(color)) cl <- paste0(cl, " text-", color)

  shiny::tags$li(
    class = if (selected) "active" else NULL,
    shiny::tags$a(
      href = "javascript:void(0)",
      left,
      shiny::tags$span(
        class = cl,
        icon,
        right
      )
    )
  )
}




#' AdminLTE2 product list container
#'
#' \link{productList} creates a container to display commercial items in an elegant container.
#' Insert in a \link{box}.
#'
#' @param ... slot for \link{productListItem}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' @rdname productList
#'
#' @examples
#'
#' # Box with productList
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         box(
#'           title = "Product List",
#'           status = "primary",
#'           productList(
#'             productListItem(
#'               image = "https://www.pngmart.com/files/1/Haier-TV-PNG.png",
#'               title = "Samsung TV",
#'               subtitle = "$1800",
#'               color = "yellow",
#'               "This is an amazing TV, but I don't like TV!"
#'             ),
#'             productListItem(
#'               image = "https://upload.wikimedia.org/wikipedia/commons/7/77/IMac_Pro.svg",
#'               title = "Imac 27",
#'               subtitle = "$4999",
#'               color = "red",
#'               "This is were I spend most of my time!"
#'             )
#'           )
#'         )
#'       ),
#'       title = "Product List"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export
productList <- function(...) {
  shiny::tags$ul(
    class = "products-list product-list-in-box",
    ...
  )
}




#' AdminLTE2 product item
#'
#' \link{productListItem} creates a product item to insert in \link{productList}.
#'
#' @param ... product description.
#' @param image image url, if any.
#' @param title product name.
#' @param subtitle product price.
#' @param color price color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' See below:
#' \itemize{
#'  \item \code{light-blue (primary status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}.
#'  \item \code{red (danger status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#dd4b39")}.
#'  \item \code{green (success status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00a65a")}.
#'  \item \code{aqua (info status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00c0ef")}.
#'  \item \code{yellow (warning status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#f39c12")}.
#'  \item \code{blue}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#0073b7")}.
#'  \item \code{navy}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#001F3F")}.
#'  \item \code{teal}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#39CCCC")}.
#'  \item \code{olive}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3D9970")}.
#'  \item \code{lime}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#01FF70")}.
#'  \item \code{orange}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#FF851B")}.
#'  \item \code{fuchsia}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#F012BE")}.
#'  \item \code{purple}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#605ca8")}.
#'  \item \code{maroon}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#D81B60")}.
#'  \item \code{black}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#111")}.
#'  \item \code{gray}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#d2d6de")}.
#' }
#' @rdname productList
#'
#' @export
productListItem <- function(..., image = NULL, title = NULL,
                            subtitle = NULL, color = NULL) {
  cl <- "label pull-right"
  if (!is.null(color)) {
    validateColor(color)
    cl <- paste0(cl, " label-", color)
  }

  shiny::tags$li(
    class = "item",
    shiny::tags$div(
      class = "product-img",
      shiny::tags$img(src = image, alt = "Product Image")
    ),
    shiny::tags$div(
      class = "product-info",
      shiny::tags$a(
        href = "javascript:void(0)",
        class = "product-title",
        title,
        if (!is.null(subtitle)) shiny::tags$span(class = cl, subtitle)
      ),
      shiny::tags$span(
        class = "product-description",
        ...
      )
    )
  )
}




#' AdminLTE2 vertical progress bar
#'
#' This creates a vertical progress bar.
#'
#' @param value Progress bar value. Must be between min and max.
#' @param min Progress bar minimum value (0 by default).
#' @param max Progress bar maximum value (100 by default).
#' @param vertical Progress vertical layout. Default to FALSE
#' @param striped Whether the progress is striped or not. FALSE by default.
#' @param animated  Whether the progress is active or not. FALSE by default.
#' Works only if striped is TRUE.
#' @param status Progress bar status. "primary" by default or "warning", "info",
#' "danger" or "success".
#' Valid statuses are defined as follows:
#' \itemize{
#'   \item \code{primary}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}
#'   \item \code{success}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#00a65a")}
#'   \item \code{info}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#00c0ef")}
#'   \item \code{warning}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#f39c12")}
#'   \item \code{danger}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#f56954")}
#' }
#' @param size Progress bar size. NULL by default: "sm", "xs" or "xxs" also available.
#' @param label Progress label. NULL by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       header = dashboardHeader(),
#'       sidebar = dashboardSidebar(),
#'       body = dashboardBody(
#'         box(
#'           title = "Horizontal",
#'           progressBar(
#'             value = 10,
#'             striped = TRUE,
#'             animated = TRUE,
#'             label = "10%"
#'           ),
#'           progressBar(
#'             value = 50,
#'             status = "warning",
#'             size = "xs"
#'           ),
#'           progressBar(
#'             value = 20,
#'             status = "danger",
#'             size = "sm"
#'           )
#'         ),
#'         box(
#'           title = "Vertical",
#'           progressBar(
#'             value = 10,
#'             striped = TRUE,
#'             animated = TRUE,
#'             vertical = TRUE
#'           ),
#'           progressBar(
#'             value = 50,
#'             status = "warning",
#'             size = "xs",
#'             vertical = TRUE
#'           ),
#'           progressBar(
#'             value = 20,
#'             status = "danger",
#'             size = "sm",
#'             vertical = TRUE
#'           )
#'         )
#'       ),
#'       title = "Progress bars"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#' @export
progressBar <- function(value, min = 0, max = 100, vertical = FALSE, striped = FALSE,
                        animated = FALSE, status = "primary", size = NULL,
                        label = NULL) {
  if (!is.null(status)) validateStatus(status)
  stopifnot(value >= min)
  stopifnot(value <= max)

  progressCl <- if (isTRUE(vertical)) "progress vertical" else "progress mb-3"
  if (animated) progressCl <- paste0(progressCl, " active")
  if (!is.null(size)) progressCl <- paste0(progressCl, " progress-", size)

  barCl <- "progress-bar"
  if (striped) barCl <- paste0(barCl, " progress-bar-striped")
  if (!is.null(status)) barCl <- paste0(barCl, " progress-bar-", status)

  shiny::tags$div(
    class = progressCl,
    shiny::tags$div(
      `aria-valuemax` = max,
      `aria-valuemin` = min,
      `aria-valuenow` = value,
      class = barCl,
      style = if (vertical) {
        paste0("height: ", paste0(value, "%"))
      } else {
        paste0("width: ", paste0(value, "%"))
      },
      if (!is.null(label)) label
    )
  )
}




#' @title AdminLTE2 starBlock
#'
#' @description Create a starBlock item (ideal for rating)
#'
#' @param value Current score. Should be positive and lower or equal to max.
#' @param max Maximum number of stars by block.
#' @param color Star color: see \code{validColors()} in the documentation.
#' See below:
#' \itemize{
#'  \item \code{light-blue (primary status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}.
#'  \item \code{red (danger status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#dd4b39")}.
#'  \item \code{green (success status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00a65a")}.
#'  \item \code{aqua (info status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00c0ef")}.
#'  \item \code{yellow (warning status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#f39c12")}.
#'  \item \code{blue}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#0073b7")}.
#'  \item \code{navy}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#001F3F")}.
#'  \item \code{teal}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#39CCCC")}.
#'  \item \code{olive}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3D9970")}.
#'  \item \code{lime}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#01FF70")}.
#'  \item \code{orange}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#FF851B")}.
#'  \item \code{fuchsia}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#F012BE")}.
#'  \item \code{purple}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#605ca8")}.
#'  \item \code{maroon}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#D81B60")}.
#'  \item \code{black}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#111")}.
#'  \item \code{gray}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#d2d6de")}.
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         box(
#'           title = "Star example",
#'           starBlock(5),
#'           starBlock(5, color = "olive"),
#'           starBlock(1, color = "maroon"),
#'           starBlock(3, color = "teal")
#'         )
#'       ),
#'       title = "starBlock"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export
starBlock <- function(value, max = 5, color = "yellow") {
  stopifnot(!is.null(color))
  validateColor(color)
  stopifnot(!is.null(value))
  stopifnot(value >= 0)
  stopifnot(value <= max)

  shiny::tags$td(
    class = "mailbox-star",
    shiny::tags$a(
      href = "javascript:void(0)",
      if (value > 0) {
        full_star <- lapply(seq_len(value), FUN = function(i) {
          shiny::tags$i(class = paste0("fa text-", color, " fa-star"))
        })
      },
      if (value < max) {
        empty_star <- lapply(seq_len(max - value), FUN = function(i) {
          shiny::tags$i(class = paste0("fa text-", color, " fa-star-o"))
        })
      }
    ),
    shiny::tags$br()
  )
}



#' AdminLTE2 timeline block
#'
#' \link{timelineBlock} creates a timeline block that may be inserted in a \link{box} or outside.
#'
#' @param ... slot for timelineLabel or timelineItem.
#' @param reversed Whether the timeline is reversed or not.
#' @param width Timeline width. Between 1 and 12.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @rdname timeline
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         h3("When Reversed = TRUE, can be displayed inside a box"),
#'         box(
#'           title = "Timeline",
#'           status = "info",
#'           timelineBlock(
#'             width = 12,
#'             timelineEnd(color = "red"),
#'             timelineLabel(2018, color = "teal"),
#'             timelineItem(
#'               title = "Item 1",
#'               icon = icon("gears"),
#'               color = "olive",
#'               time = "now",
#'               footer = "Here is the footer",
#'               "This is the body"
#'             ),
#'             timelineItem(
#'               title = "Item 2",
#'               border = FALSE
#'             ),
#'             timelineLabel(2015, color = "orange"),
#'             timelineItem(
#'               title = "Item 3",
#'               icon = icon("paint-brush"),
#'               color = "maroon",
#'               timelineItemMedia(image = "https://placehold.it/150x100"),
#'               timelineItemMedia(image = "https://placehold.it/150x100")
#'             ),
#'             timelineStart(color = "purple")
#'           )
#'         ),
#'         h3("When Reversed = FALSE, can be displayed out of a box"),
#'         timelineBlock(
#'           reversed = FALSE,
#'           timelineEnd(color = "red"),
#'           timelineLabel(2018, color = "teal"),
#'           timelineItem(
#'             title = "Item 1",
#'             icon = icon("gears"),
#'             color = "olive",
#'             time = "now",
#'             footer = "Here is the footer",
#'             "This is the body"
#'           ),
#'           timelineItem(
#'             title = "Item 2",
#'             border = FALSE
#'           ),
#'           timelineLabel(2015, color = "orange"),
#'           timelineItem(
#'             title = "Item 3",
#'             icon = icon("paint-brush"),
#'             color = "maroon",
#'             timelineItemMedia(image = "https://placehold.it/150x100"),
#'             timelineItemMedia(image = "https://placehold.it/150x100")
#'           ),
#'           timelineStart(color = "purple")
#'         )
#'       ),
#'       title = "timelineBlock"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export
timelineBlock <- function(..., reversed = TRUE, width = 6) {
  cl <- "timeline"
  if (isTRUE(reversed)) cl <- paste0(cl, " timeline-inverse")
  if (!is.null(width)) cl <- paste0(cl, " col-sm-", width)

  shiny::tags$ul(
    class = cl,
    ...
  )
}


#' AdminLTE2 timeline label
#'
#' \link{timelineLabel} creates a timeline label element to highlight an event.
#'
#' @rdname timeline
#'
#' @param ... any element.
#' @param color label color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' See below:
#' \itemize{
#'  \item \code{light-blue (primary status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}.
#'  \item \code{red (danger status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#dd4b39")}.
#'  \item \code{green (success status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00a65a")}.
#'  \item \code{aqua (info status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00c0ef")}.
#'  \item \code{yellow (warning status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#f39c12")}.
#'  \item \code{blue}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#0073b7")}.
#'  \item \code{navy}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#001F3F")}.
#'  \item \code{teal}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#39CCCC")}.
#'  \item \code{olive}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3D9970")}.
#'  \item \code{lime}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#01FF70")}.
#'  \item \code{orange}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#FF851B")}.
#'  \item \code{fuchsia}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#F012BE")}.
#'  \item \code{purple}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#605ca8")}.
#'  \item \code{maroon}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#D81B60")}.
#'  \item \code{black}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#111")}.
#'  \item \code{gray}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#d2d6de")}.
#' }
#'
#' @export
timelineLabel <- function(..., color = NULL) {
  cl <- NULL
  if (!is.null(color)) {
    validateColor(color)
    cl <- paste0("bg-", color)
  }

  shiny::tags$li(
    class = "time-label",
    shiny::tags$span(
      class = cl,
      ...
    )
  )
}


#' AdminLTE2 timeline item
#'
#' \link{timelineItem} creates a timeline item that contains information for a
#' given event like the title, description, date, ...
#'
#' @param ... any element.
#' @param icon item icon. Expect \code{\link[shiny]{icon}}.
#' @param color item color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' See below:
#' \itemize{
#'  \item \code{light-blue (primary status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}.
#'  \item \code{red (danger status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#dd4b39")}.
#'  \item \code{green (success status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00a65a")}.
#'  \item \code{aqua (info status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00c0ef")}.
#'  \item \code{yellow (warning status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#f39c12")}.
#'  \item \code{blue}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#0073b7")}.
#'  \item \code{navy}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#001F3F")}.
#'  \item \code{teal}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#39CCCC")}.
#'  \item \code{olive}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3D9970")}.
#'  \item \code{lime}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#01FF70")}.
#'  \item \code{orange}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#FF851B")}.
#'  \item \code{fuchsia}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#F012BE")}.
#'  \item \code{purple}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#605ca8")}.
#'  \item \code{maroon}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#D81B60")}.
#'  \item \code{black}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#111")}.
#'  \item \code{gray}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#d2d6de")}.
#' }
#' @param time item date or time.
#' @param title item title.
#' @param border Whether to display a border between the header and the body. TRUE by default.
#' @param footer item footer if any.
#'
#' @rdname timeline
#'
#' @export
timelineItem <- function(..., icon = NULL, color = NULL, time = NULL,
                         title = NULL, border = TRUE, footer = NULL) {
  if (!is.null(icon)) {
    icon$attribs$class <- sub("fas", "fa", icon$attribs$class)
  }

  timeIcon <- shiny::icon("clock")
  timeIcon$attribs$class <- sub("fa(r|s)", "fa", timeIcon$attribs$class, perl = TRUE)

  if (!is.null(color)) {
    validateColor(color)
    icon$attribs$class <- paste0(icon$attribs$class, " bg-", color)
  }

  itemCl <- "timeline-header no-border"
  if (border) itemCl <- "timeline-header"

  shiny::tags$li(

    # timelineItem icon and color
    icon,

    # timelineItem container
    shiny::tags$div(
      class = "timeline-item",

      # timelineItem time/date
      shiny::tags$span(
        class = "time",
        timeIcon,
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
      if (!is.null(footer)) {
        shiny::tags$div(
          class = "timeline-footer",
          footer
        )
      }
    )
  )
}


#' AdminLTE2 timeline media item
#'
#' \link{timelineItemMedia} create a specific container for images.
#'
#' @param image media url or path.
#' @param height media height in pixels.
#' @param width media width in pixels.
#'
#' @rdname timeline
#'
#' @export
timelineItemMedia <- function(image = NULL, height = NULL, width = NULL) {
  shiny::img(
    class = "margin",
    src = image,
    height = height,
    width = width
  )
}




#' AdminLTE2 timeline starting point
#'
#' \link{timelineStart} indicates a starting point.
#'
#' @param icon item icon. Expect \code{\link[shiny]{icon}}.
#' @param color item color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' See below:
#' \itemize{
#'  \item \code{light-blue (primary status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}.
#'  \item \code{red (danger status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#dd4b39")}.
#'  \item \code{green (success status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00a65a")}.
#'  \item \code{aqua (info status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00c0ef")}.
#'  \item \code{yellow (warning status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#f39c12")}.
#'  \item \code{blue}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#0073b7")}.
#'  \item \code{navy}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#001F3F")}.
#'  \item \code{teal}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#39CCCC")}.
#'  \item \code{olive}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3D9970")}.
#'  \item \code{lime}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#01FF70")}.
#'  \item \code{orange}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#FF851B")}.
#'  \item \code{fuchsia}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#F012BE")}.
#'  \item \code{purple}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#605ca8")}.
#'  \item \code{maroon}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#D81B60")}.
#'  \item \code{black}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#111")}.
#'  \item \code{gray}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#d2d6de")}.
#' }
#' @rdname timeline
#'
#' @export
timelineStart <- function(icon = shiny::icon("clock"), color = NULL) {
  iconTag <- icon
  if (!is.null(color)) {
    validateColor(color)
    iconTag$attribs$class <- sub(
      "fa(r|s)",
      "fa",
      paste0(iconTag$attribs$class, " bg-", color),
      perl = TRUE
    )
  }
  shiny::tags$li(iconTag)
}


#' AdminLTE2 timeline ending point
#'
#' \link{timelineEnd} indicates an end point.
#'
#' @param icon item icon. Expect \code{\link[shiny]{icon}}.
#' @param color item color: see here for a list of valid colors \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' See below:
#' \itemize{
#'  \item \code{light-blue (primary status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}.
#'  \item \code{red (danger status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#dd4b39")}.
#'  \item \code{green (success status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00a65a")}.
#'  \item \code{aqua (info status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#00c0ef")}.
#'  \item \code{yellow (warning status)}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#f39c12")}.
#'  \item \code{blue}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#0073b7")}.
#'  \item \code{navy}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#001F3F")}.
#'  \item \code{teal}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#39CCCC")}.
#'  \item \code{olive}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#3D9970")}.
#'  \item \code{lime}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#01FF70")}.
#'  \item \code{orange}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#FF851B")}.
#'  \item \code{fuchsia}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#F012BE")}.
#'  \item \code{purple}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#605ca8")}.
#'  \item \code{maroon}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#D81B60")}.
#'  \item \code{black}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#111")}.
#'  \item \code{gray}: \Sexpr[results=rd, stage=install]{shinydashboardPlus:::rd_color_tag("#d2d6de")}.
#' }
#'
#' @rdname timeline
#'
#' @export
timelineEnd <- function(icon = shiny::icon("hourglass-end"), color = NULL) {
  iconTag <- icon

  iconTag$attribs$class <- sub(
    "fa(r|s)",
    "fa",
    iconTag$attribs$class,
    perl = TRUE
  )

  if (!is.null(color)) {
    validateColor(color)
    iconTag$attribs$class <- paste0(iconTag$attribs$class, " bg-", color)
  }

  shiny::tagList(
    shiny::tags$li(iconTag),
    shiny::br(),
    shiny::br()
  )
}



#' AdminLTE2 todo list container
#'
#' Create a todo list container. May be included in \link{box}.
#'
#' @param ... slot for todoListItem.
#' @param sortable Whether the list elements are sortable or not.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinyjqui)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         box(
#'           "Sortable todo list demo",
#'           status = "warning",
#'           todoList(
#'             todoListItem(
#'               label = "Design a nice theme",
#'               "Some text here"
#'             ),
#'             todoListItem(
#'               label = "Make the theme responsive",
#'               "Some text here"
#'             ),
#'             todoListItem(
#'               checked = TRUE,
#'               label = "Let theme shine like a star"
#'             )
#'           )
#'         ),
#'         box(
#'           "Simple todo list demo",
#'           status = "warning",
#'           todoList(
#'             sortable = FALSE,
#'             todoListItem(
#'               label = "Design a nice theme",
#'               "Some text here"
#'             ),
#'             todoListItem(
#'               label = "Make the theme responsive",
#'               "Some text here"
#'             ),
#'             todoListItem(
#'               checked = TRUE,
#'               label = "Let theme shine like a star"
#'             )
#'           )
#'         )
#'       ),
#'       title = "Todo Lists"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export
#' @rdname todoList
todoList <- function(..., sortable = TRUE) {
  todoListTag <- shiny::tags$ul(
    class = "todo-list",
    ...
  )

  if (sortable) todoListTag <- shinyjqui::jqui_sortable(todoListTag)

  todoListTag
}



#' AdminLTE2 todo list item
#'
#' \link{todoListItem} creates a todo list item.
#'
#' @param ... any element such as labels, ...
#' @param checked Whether the list item is checked or not.
#' @param label item label.
#'
#' @rdname todoList
#'
#' @export
todoListItem <- function(..., checked = FALSE, label = NULL) {
  cl <- NULL
  if (checked) cl <- "done"

  shiny::tags$li(
    class = cl,

    # sortable icon
    shiny::tags$span(
      class = "handle",
      shiny::tags$i(class = "fa fa-ellipsis-v"),
      shiny::tags$i(class = "fa fa-ellipsis-v")
    ),

    # checkbox trigger
    # need to be implemented (custom binding js)
    # shiny::tags$input(type = "checkbox"),

    # label
    shiny::tags$span(class = "text", label),

    # any element
    shiny::tags$small(
      ...
    )
  )
}



#' AdminLTE2 user list container
#'
#' \link{userList} creates a user list container to be inserted in a \link{box}.
#'
#' @param ... slot for \link{userListItem}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' @rdname userList
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         box(
#'           title = "User List example",
#'           status = "success",
#'           userList(
#'             userListItem(
#'               image = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
#'               title = "Shiny",
#'               subtitle = "Package 1"
#'             ),
#'             userListItem(
#'               image = "https://adminlte.io/themes/AdminLTE/dist/img/user7-128x128.jpg",
#'               title = "Tidyverse",
#'               subtitle = "Package 2"
#'             ),
#'             userListItem(
#'               image = "https://adminlte.io/themes/AdminLTE/dist/img/user5-128x128.jpg",
#'               title = "tidyr",
#'               subtitle = "Package 3"
#'             )
#'           )
#'         )
#'       ),
#'       title = "User List"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export
userList <- function(...) {
  shiny::tags$ul(
    class = "users-list clearfix",
    ...
  )
}


#' AdminLTE2 user list item
#'
#' \link{userListItem} creates a user list item.
#'
#' @param image image url or path.
#' @param title Item title.
#' @param subtitle Item subtitle.
#'
#' @rdname userList
#'
#' @export
userListItem <- function(image, title, subtitle = NULL) {
  shiny::tags$li(
    shiny::tags$img(
      src = image,
      alt = "User Image",
      shiny::tags$a(class = "users-list-name", title),
      if (!is.null(subtitle)) {
        shiny::tags$span(class = "users-list-date", subtitle)
      }
    )
  )
}



#' AdminLTE2 user post
#'
#' \link{userPost} creates a user post. This content may be inserted in a \link{box}.
#'
#' @param ... post content, also \link{userPostTagItems}.
#' @param id unique id of the post.
#' @param image profile image, if any.
#' @param author post author.
#' @param description post description.
#' @param collapsible If TRUE, display a button in the upper right that allows the user to collapse the comment.
#' @param collapsed Whether the comment is collapsed when the application starts, FALSE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' @rdname userPost
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         box(
#'           title = "Box with user comment",
#'           status = "primary",
#'           userPost(
#'             id = 1,
#'             image = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
#'             author = "Jonathan Burke Jr.",
#'             description = "Shared publicly - 7:30 PM today",
#'             "Lorem ipsum represents a long-held tradition for designers,
#'        typographers and the like. Some people hate it and argue for
#'        its demise, but others ignore the hate as they create awesome
#'        tools to help create filler text for everyone from bacon
#'        lovers to Charlie Sheen fans.",
#'             collapsible = FALSE,
#'             userPostTagItems(
#'               userPostTagItem(dashboardLabel("item 1", status = "info")),
#'               userPostTagItem(dashboardLabel("item 2", status = "danger"), side = "right")
#'             )
#'           ),
#'           userPost(
#'             id = 2,
#'             image = "https://adminlte.io/themes/AdminLTE/dist/img/user6-128x128.jpg",
#'             author = "Adam Jones",
#'             userPostMedia(image = "https://adminlte.io/themes/AdminLTE/dist/img/photo2.png"),
#'             userPostTagItems(
#'               userPostTagItem(dashboardLabel("item 1", status = "success")),
#'               userPostTagItem(dashboardLabel("item 2", status = "danger"), side = "right")
#'             )
#'           )
#'         )
#'       ),
#'       title = "userPost"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export
userPost <- function(..., id = NULL, image, author,
                     description = NULL, collapsible = TRUE,
                     collapsed = FALSE) {
  cl <- "collapse"
  id <- paste0("post-", id)

  if (!isTRUE(collapsed)) cl <- paste0(cl, " in")
  if (collapsed) collapsed <- "false" else collapsed <- "true"

  shiny::tags$div(
    class = "post",
    shiny::tags$div(
      class = "user-block",
      shiny::img(class = "img-circle img-bordered-sm", src = image),
      shiny::tags$span(
        class = "username",
        author,

        # box tool
        if (collapsible) {
          shiny::tags$button(
            class = "pull-right btn btn-default btn-xs",
            `data-toggle` = "collapse",
            `data-target` = paste0("#", id),
            `aria-expanded` = collapsed,
            type = "button",
            shiny::tags$i(class = "fa fa-eye")
          )
        }
      ),
      if (!is.null(description)) {
        shiny::tags$span(class = "description", description)
      }
    ),
    shiny::tags$p(
      class = cl,
      id = id,
      `aria-expanded` = collapsed,
      ...
    )
  )
}




#' AdminLTE2 user post tool item container
#'
#' \link{userPostTagItems} creates a container to host \link{userPostTagItem}.
#'
#' @param ... slot for \link{userPostTagItem}.
#'
#' @rdname userPost
#'
#' @export
userPostTagItems <- function(...) {
  shiny::tags$ul(
    class = "list-inline",
    ...
  )
}




#' AdminLTE2 user post tool item
#'
#' \link{userPostTagItem} creates a user post tool item
#'
#' @param ... tool content such as label, button, ...
#' @param side tool item orientation: "left" of "right", "left" by default.
#'
#' @rdname userPost
#'
#' @export
userPostTagItem <- function(..., side = "left") {
  cl <- if (side == "left") NULL else "pull-right"

  shiny::tags$li(
    class = cl,
    ...
  )
}



#' AdminLTE2 user post media
#'
#' \link{userPostMedia} creates a container to include an image in \link{userPost}.
#'
#' @param image image path or url ...
#' @param height media height in pixels.
#' @param width media width in pixels.
#'
#' @rdname userPost
#'
#' @export
userPostMedia <- function(image, height = NULL, width = NULL) {
  shiny::img(
    style = "margin: auto;",
    class = "img-responsive",
    src = image,
    height = height,
    width = width
  )
}





#' AdminLTE2 user message container
#'
#' \link{userMessages} creates a user message container. Maybe inserted in a \link{box}.
#'
#' @param ... Slot for \link{userMessage}.
#' @param id Optional. To use with \link{updateUserMessages}.
#' @param status Messages status. See here for a list of valid colors
#' \url{https://adminlte.io/themes/AdminLTE/pages/UI/general.html}.
#' Valid statuses are defined as follows:
#' \itemize{
#'   \item \code{primary}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#3c8dbc")}
#'   \item \code{success}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#00a65a")}
#'   \item \code{info}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#00c0ef")}
#'   \item \code{warning}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#f39c12")}
#'   \item \code{danger}: \Sexpr[results=rd, stage=render]{shinydashboardPlus:::rd_color_tag("#f56954")}
#' }
#' @param width Container width: between 1 and 12.
#' @param height Container height.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' @rdname userMessage
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         box(
#'           title = "Box with messages",
#'           solidHeader = TRUE,
#'           status = "warning",
#'           userMessages(
#'             width = 12,
#'             status = "success",
#'             userMessage(
#'               author = "Alexander Pierce",
#'               date = "20 Jan 2:00 pm",
#'               image = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
#'               type = "sent",
#'               "Is this template really for free? That's unbelievable!"
#'             ),
#'             userMessage(
#'               author = "Sarah Bullock",
#'               date = "23 Jan 2:05 pm",
#'               image = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
#'               type = "received",
#'               "You better believe it!"
#'             )
#'           )
#'         ),
#'         userMessages(
#'           width = 6,
#'           status = "danger",
#'           userMessage(
#'             author = "Alexander Pierce",
#'             date = "20 Jan 2:00 pm",
#'             image = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
#'             type = "received",
#'             "Is this template really for free? That's unbelievable!"
#'           ),
#'           userMessage(
#'             author = "Sarah Bullock",
#'             date = "23 Jan 2:05 pm",
#'             image = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
#'             type = "sent",
#'             "You better believe it!"
#'           )
#'         )
#'       ),
#'       title = "user Message"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#'
#' @export
userMessages <- function(..., id = NULL, status, width = 4, height = NULL) {
  cl <- "direct-chat-messages direct-chat"
  if (!is.null(height)) shiny::validateCssUnit(height)
  if (!is.null(status)) {
    validateStatus(status)
    cl <- paste0(cl, " direct-chat-", status)
  }
  msgtag <- shiny::tags$div(
    class = cl,
    ...,
    style = if (!is.null(height)) {
      sprintf("height: %s; overflow-y: auto;", height)
    } else {
      "height: 100%;"
    }
  )

  shiny::tags$div(
    id = id,
    class = if (!is.null(width)) paste0("col-sm-", width),
    msgtag
  )
}

#' AdminLTE2 user message
#'
#' \link{userMessage} creates a user message html element.
#'
#' @param ... Message text.
#' @param author Message author.
#' @param date Message date.
#' @param image Message author image path or url.
#' @param type Message type: \code{c("sent", "received")}.
#'
#' @rdname userMessage
#'
#' @export
userMessage <- function(..., author, date = NULL,
                        image = NULL, type = c("sent", "received")) {
  type <- match.arg(type)
  messageCl <- "direct-chat-msg"
  if (type == "sent") messageCl <- paste0(messageCl, " right")

  # message info
  messageInfo <- shiny::tags$div(
    class = "direct-chat-info clearfix",
    shiny::tags$span(
      class = if (type == "right") {
        "direct-chat-name pull-right"
      } else {
        "direct-chat-name"
      },
      author
    ),
    if (!is.null(date)) {
      shiny::tags$span(
        class = if (type == "right") {
          "direct-chat-timestamp right"
        } else {
          "direct-chat-timestamp"
        },
        date
      )
    }
  )

  # message Text
  messageTxt <- shiny::tags$div(class = "direct-chat-text", ...)

  # message author image
  messageImg <- shiny::tags$img(class = "direct-chat-img", src = image)

  shiny::tags$div(
    class = messageCl,
    messageInfo,
    messageImg,
    messageTxt
  )
}





#' Update a messages container in the server side
#'
#' \link{updateUserMessages} allows to interact with a \link{userMessages} container,
#' such as sending, removing or editing messages.
#'
#' @param id \link{userMessages} to target.
#' @param action Action to perform: add, remove or update.
#' @param index Index of item to update or remove.
#' @param content New message content in a list. For actions like add and update only! See example.
#' @param session Shiny session object.
#' @export
#' @rdname userMessage
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(),
#'       dashboardSidebar(),
#'       dashboardBody(
#'         fluidRow(
#'           actionButton("remove", "Remove message"),
#'           actionButton("add", "Add message"),
#'           actionButton("update", "Update message")
#'         ),
#'         numericInput("index", "Message index:", 1, min = 1, max = 3),
#'         br(),
#'         br(),
#'         userMessages(
#'           width = 6,
#'           status = "danger",
#'           id = "message",
#'           userMessage(
#'             author = "Alexander Pierce",
#'             date = "20 Jan 2:00 pm",
#'             image = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
#'             type = "received",
#'             "Is this template really for free? That's unbelievable!"
#'           ),
#'           userMessage(
#'             author = "Sarah Bullock",
#'             date = "23 Jan 2:05 pm",
#'             image = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
#'             type = "sent",
#'             "You better believe it!"
#'           )
#'         )
#'       ),
#'       title = "user Message"
#'     ),
#'     server = function(input, output, session) {
#'       observeEvent(input$remove, {
#'         updateUserMessages("message", action = "remove", index = input$index)
#'       })
#'       observeEvent(input$add, {
#'         updateUserMessages(
#'           "message",
#'           action = "add",
#'           content = list(
#'             author = "David",
#'             date = "Now",
#'             image = "https://i.pinimg.com/originals/f1/15/df/f115dfc9cab063597b1221d015996b39.jpg",
#'             type = "received",
#'             text = tagList(
#'               sliderInput(
#'                 "obs",
#'                 "Number of observations:",
#'                 min = 0,
#'                 max = 1000,
#'                 value = 500
#'               ),
#'               plotOutput("distPlot")
#'             )
#'           )
#'         )
#'       })
#'
#'       output$distPlot <- renderPlot({
#'         hist(rnorm(input$obs))
#'       })
#'
#'       observeEvent(input$update, {
#'         updateUserMessages(
#'           "message",
#'           action = "update",
#'           index = input$index,
#'           content = list(
#'             text = tagList(
#'               appButton(
#'                 inputId = "reload",
#'                 label = "Click me!",
#'                 icon = icon("arrows-rotate"),
#'                 dashboardBadge(1, color = "orange")
#'               )
#'             )
#'           )
#'         )
#'       })
#'
#'       observeEvent(input$reload, {
#'         showNotification("Yeah!", duration = 1, type = "default")
#'       })
#'     }
#'   )
#' }
updateUserMessages <- function(id, action = c("add", "remove", "update"),
                               index = NULL, content = NULL,
                               session = shiny::getDefaultReactiveDomain()) {
  action <- match.arg(action)

  content <- lapply(content, function(c) {
    if (inherits(c, "shiny.tag") || inherits(c, "shiny.tag.list")) {
      # necessary if the user pass input/output with deps
      # that are not yet available in the page before inserting the new tag
      c <- processDeps(c, session)
    }
    c
  })

  session$sendCustomMessage(
    "user-messages",
    list(
      id = id,
      action = action,
      index = index,
      body = content
    )
  )
}
