#' Create a header for a dashboard page
#'
#' A dashboard header can be left blank, or it can include dropdown menu items
#' on the right side.
#'
#' @importFrom shinydashboard dropdownMenu
#'
#' @param title An optional title to show in the header bar.. By default, this
#'   will also be used as the title shown in the browser's title bar. If you
#'   want that to be different from the text in the dashboard header bar, set
#'   the \code{title} in \code{\link{dashboardPage}}.
#' @param titleWidth The width of the title area. This must either be a number
#'   which specifies the width in pixels, or a string that specifies the width
#'   in CSS units.
#' @param disable If \code{TRUE}, don't display the header bar.
#' @param ... Items to put in the header. Should be \code{\link[shinydashboard]{dropdownMenu}}s.
#' @param .list An optional list containing items to put in the header. Same as
#'   the \code{...} arguments, but in list format. This can be useful when
#'   working with programmatically generated items.
#' @param leftUi Items that will appear on the left part of the navbar. Should
#' be wrapped in a tagList.
#' @param controlbarIcon Customize the trigger icon of the right sidebar.
#' @param fixed Whether the navbar is fixed-top or not. FALSE by default.
#'
#' @seealso \code{\link[shinydashboard]{dropdownMenu}}
#'
#' @note We do not recommend to insert shiny input elements (such as sliderInput)
#' in the left menu, since they will not be well displayed. Instead, wrap them in a
#'  \code{\link[shinydashboardPlus]{dropdownBlock}}
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyWidgets)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       header = dashboardHeader(
#'         leftUi = tagList(
#'           dropdownBlock(
#'             id = "mydropdown",
#'             title = "Dropdown 1",
#'             icon = icon("sliders"),
#'             sliderInput(
#'               inputId = "n",
#'               label = "Number of observations",
#'               min = 10, max = 100, value = 30
#'             ),
#'             prettyToggle(
#'               inputId = "na",
#'               label_on = "NAs kept",
#'               label_off = "NAs removed",
#'               icon_on = icon("check"),
#'               icon_off = icon("trash-can")
#'             )
#'           ),
#'           dropdownBlock(
#'             id = "mydropdown2",
#'             title = "Dropdown 2",
#'             icon = icon("sliders"),
#'             prettySwitch(
#'               inputId = "switch4",
#'               label = "Fill switch with status:",
#'               fill = TRUE,
#'               status = "primary"
#'             ),
#'             prettyCheckboxGroup(
#'               inputId = "checkgroup2",
#'               label = "Click me!",
#'               thick = TRUE,
#'               choices = c("Click me !", "Me !", "Or me !"),
#'               animation = "pulse",
#'               status = "info"
#'             )
#'           )
#'         ),
#'         dropdownMenu(
#'           type = "tasks",
#'           badgeStatus = "danger",
#'           taskItem(value = 20, color = "aqua", "Refactor code"),
#'           taskItem(value = 40, color = "green", "Design new layout"),
#'           taskItem(value = 60, color = "yellow", "Another task"),
#'           taskItem(value = 80, color = "red", "Write documentation")
#'         )
#'       ),
#'       sidebar = dashboardSidebar(),
#'       body = dashboardBody(
#'         setShadow(class = "dropdown-menu")
#'       ),
#'       title = "DashboardPage"
#'     ),
#'     server = function(input, output) { }
#'   )
#' }
#' @export
dashboardHeader <- function(..., title = NULL, titleWidth = NULL,
                            disable = FALSE, .list = NULL, leftUi = NULL,
                            controlbarIcon = shiny::icon("gears"), fixed = FALSE) {
  # handle right menu items
  items <- c(list(...), .list)
  lapply(items, tagAssert, type = "li", class = "dropdown")

  # handle left menu items
  if (!is.null(leftUi)) {
    left_menu_items <- lapply(seq_along(leftUi), FUN = function(i) {
      left_menu_item <- leftUi[[i]]
      name <- left_menu_item$name
      class <- left_menu_item$attribs$class

      # if the left menu item is not a li tag and does not have
      # the dropdown class, create a wrapper to make it work
      if (name != "li" || !is.null(class) || class != "dropdown") {
        dropdownTag <- shiny::tags$li(class = "dropdown")
        left_menu_item <- shiny::tagAppendChild(dropdownTag, left_menu_item)
        # add some custom css to make it nicer
        left_menu_item <- shiny::tagAppendAttributes(
          left_menu_item,
          style = "margin-top: 7.5px; margin-left: 5px; margin-right: 5px;"
        )
      } else {
        left_menu_item
      }
    })
    # when left_menu is null, left_menu_items are also NULL
  } else {
    left_menu_items <- leftUi
  }

  titleWidth <- shiny::validateCssUnit(titleWidth)

  # Set up custom CSS for custom width.
  custom_css <- NULL
  if (!is.null(titleWidth)) {
    # This CSS is derived from the header-related instances of '230px' (the
    # default sidebar width) from inst/AdminLTE/AdminLTE.css. One change is that
    # instead making changes to the global settings, we've put them in a media
    # query (min-width: 768px), so that it won't override other media queries
    # (like max-width: 767px) that work for narrower screens.
    custom_css <- shiny::tags$head(
      shiny::tags$style(
        shiny::HTML(
          gsub(
            "_WIDTH_",
            titleWidth,
            fixed = TRUE,
            "@media (min-width: 768px) {
              .main-header > .navbar {
                margin-left: _WIDTH_;
              }
              .main-header .logo {
                width: _WIDTH_;
              }
             }
              "
          )
        )
      )
    )
  }

  shiny::tags$header(
    class = "main-header",
    custom_css,
    style = if (disable) "display: none;",
    # only hide on small screen devices when title is NULL
    shiny::tags$span(class = if (is.null(title)) "logo hidden-xs" else "logo", title),
    shiny::tags$nav(
      class = paste0("navbar navbar-", if (fixed) "fixed" else "static", "-top"),
      role = "navigation",
      # Embed hidden icon so that we get the font-awesome dependency
      shiny::tags$span(shiny::icon("bars"), style = "display:none;"),
      # Sidebar toggle button
      shiny::tags$a(
        href = "#",
        class = "sidebar-toggle",
        `data-toggle` = "offcanvas",
        role = "button",
        shiny::tags$span(class = "sr-only", "Toggle navigation")
      ),
      # left menu
      shiny::tags$div(
        class = "navbar-custom-menu",
        style = "float: left; margin-left: 10px;",
        shiny::tags$ul(
          class = "nav navbar-nav",
          left_menu_items
        )
      ),
      # right menu
      shiny::tags$div(
        class = "navbar-custom-menu",
        shiny::tags$ul(
          class = "nav navbar-nav",
          items,
          # right sidebar
          shiny::tags$li(
            shiny::tags$a(
              href = "#",
              `data-toggle` = "control-sidebar",
              controlbarIcon
            )
          )
        )
      )
    )
  )
}




#' Create a dashboard user profile.
#'
#' @param ... Body content. Slot for \link{dashboardUserItem}.
#' @param name User name.
#' @param image User profile picture.
#' @param title A title.
#' @param subtitle A subtitle.
#' @param footer Footer is any.
#'
#' @seealso \code{\link{userOutput}} and \code{\link{renderUser}} for
#' dynamically-generating \code{\link{dashboardUser}}.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyWidgets)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       header = dashboardHeader(userOutput("user")),
#'       sidebar = dashboardSidebar(),
#'       body = dashboardBody(),
#'       title = "DashboardPage"
#'     ),
#'     server = function(input, output) {
#'       output$user <- renderUser({
#'         dashboardUser(
#'           name = "Divad Nojnarg",
#'           image = "https://adminlte.io/themes/AdminLTE/dist/img/user2-160x160.jpg",
#'           title = "shinydashboardPlus",
#'           subtitle = "Author",
#'           footer = p("The footer", class = "text-center"),
#'           fluidRow(
#'             dashboardUserItem(
#'               width = 6,
#'               socialButton(
#'                 href = "https://dropbox.com",
#'                 icon = icon("dropbox")
#'               )
#'             ),
#'             dashboardUserItem(
#'               width = 6,
#'               socialButton(
#'                 href = "https://github.com",
#'                 icon = icon("github")
#'               )
#'             )
#'           )
#'         )
#'       })
#'     }
#'   )
#' }
#'
#' @export
dashboardUser <- function(..., name = NULL, image = NULL, title = NULL,
                          subtitle = NULL, footer = NULL) {
  # Create line 1 for menu
  if (!is.null(title)) {
    line_1 <- paste0(name, " - ", title)
  } else {
    line_1 <- name
  }

  # Create user_text based on if subtitle exists
  # If subtitle doesn't exist, make the menu height smaller
  if (!is.null(subtitle)) {
    user_text <- shiny::tags$p(line_1, shiny::tags$small(subtitle))
    user_header_height <- NULL
  } else {
    user_text <- shiny::tags$p(line_1)
    user_header_height <- shiny::tags$script(shiny::HTML('$(".user-header").css("height", "145px")'))
  }

  # create user account menu
  userTag <- shiny::tagList(
    shiny::tags$head(
      shiny::tags$script(
        "$(function() {
          $('.dashboard-user').on('click', function(e){
            e.stopPropagation();
          });
        });
        "
      )
    ),
    # menu toggle button
    shiny::tags$a(
      href = "#",
      class = "dropdown-toggle",
      `data-toggle` = "dropdown",
      # user img and name in navbar (controlbar - header)
      shiny::tags$img(src = image, class = "user-image", alt = "User Image"),
      shiny::tags$span(class = "hidden-xs", name)
    ),
    # menu dropdown main
    shiny::tags$ul(
      class = "dropdown-menu dashboard-user",
      # user img in the menu
      shiny::tags$li(
        class = "user-header",
        if (!is.null(user_header_height)) user_header_height,
        shiny::tags$img(src = image, class = "img-circle", alt = "User Image"),
        user_text
      ),
      # menu body
      if (length(list(...)) > 0) shiny::tags$li(class = "user-body", ...),
      # menu footer. Do not show if NULL
      if (!is.null(footer)) shiny::tags$li(class = "user-footer", footer)
    )
  )

  userTag
}




#' Create a dashboard user profile item
#'
#' This can be inserted in a \code{\link{dashboardUser}}.
#'
#' @param item HTML Tag.
#' @param width Item width between 1 and 12.
#'
#' @export
dashboardUserItem <- function(item, width) {
  item <- shiny::div(
    align = "center",
    class = paste0("col-xs-", width),
    item
  )
}




#' Create a dynamic user output (client side)
#'
#' This can be used as a placeholder for dynamically-generated \code{\link{dashboardUser}}.
#'
#' @param id Output variable name.
#' @param tag A tag function, like \code{tags$li} or \code{tags$ul}.
#'
#' @seealso \code{\link{renderUser}} for the corresponding server side function
#'   and examples.
#' @family user outputs
#' @export
userOutput <- function(id, tag = shiny::tags$li) {
  shiny::uiOutput(outputId = id, container = tag, class = "dropdown user user-menu")
}

#' Create dynamic user output (server side)
#'
#' @inheritParams shiny::renderUI
#'
#' @seealso \code{\link{userOutput}} for the corresponding client side function
#'   and examples.
#' @family user outputs
#' @export
renderUser <- function(expr, env = parent.frame(), quoted = FALSE, outputArgs = list()) {
  if (!quoted) {
    expr <- substitute(expr)
    quoted <- TRUE
  }
  shiny::renderUI(expr, env = env, quoted = quoted, outputArgs = outputArgs)
}

# make R CMD check happy
globalVariables("func")



#' Create a dropdown block to place in a dashboard header
#'
#' @param ... Items to put in the menu.
#' @param id Dropdown block id.
#' @param icon An icon to display in the header. Expect \code{\link[shiny]{icon}}.
#' @param title Dropdown block title.
#' @param badgeStatus Dropdown badge status.
#'
#' @seealso \code{\link{dashboardHeader}} for example usage.
#'
#' @export
dropdownBlock <- function(..., id, icon = NULL, title = NULL,
                          badgeStatus = "danger") {
  if (!is.null(badgeStatus)) {
    validateStatus(badgeStatus)
  }
  items <- c(list(...))

  # Make sure the items are li tags
  # lapply(items, tagAssert, type = "li")
  # items <- lapply(1:length(items), FUN = function(i) {
  #   item <- items[[i]]
  #   name <- item$name
  #   if (name != "li") {
  #     wrapper <- shiny::tags$li()
  #     item <- shiny::tagAppendChild(wrapper, item)
  #   }
  # })

  dropdownClass <- paste0("dropdown")

  numItems <- length(items)
  if (is.null(badgeStatus)) {
    badge <- NULL
  } else {
    badge <- dashboardLabel(status = badgeStatus, numItems)
  }

  shiny::tags$li(
    shiny::singleton(
      shiny::tags$head(
        # custom javascript so that the dropdown
        # is not hidden when the user click on it
        shiny::tags$script(
          shiny::HTML(
            paste0(
              "$(document).ready(function(){
                $('#", id, "').find('ul').click(function(e){
                  e.stopPropagation();
                });
              });
              "
            )
          )
        )
      )
    ),
    class = dropdownClass,
    id = id,
    shiny::tags$a(
      href = "#",
      class = "dropdown-toggle",
      `data-toggle` = "dropdown",
      icon,
      title,
      badge
    ),
    shiny::tags$ul(
      class = "dropdown-menu",
      style = "left: 0; right: auto;",
      shiny::tags$li(
        shiny::tags$ul(
          class = "menu",
          shiny::tags$div(
            style = "margin-left: auto; margin-right: auto; width: 80%;",
            items
          )
        )
      )
    )
  )
}



#' Custom taskItem
#'
#' @inheritParams shinydashboard::taskItem
#' @param inputId If not NULL, this item behaves like an action button.
#' @export
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'
#'   shinyApp(
#'     ui = dashboardPage(
#'       dashboardHeader(
#'         dropdownMenu(
#'           type = "tasks",
#'           badgeStatus = "danger",
#'           taskItem(
#'             inputId = "mytask",
#'             value = 20,
#'             color = "aqua",
#'             text = "Click me!"
#'           ),
#'           taskItem(
#'             value = 40,
#'             color = "green",
#'             text = "Basic item"
#'           )
#'         )
#'       ),
#'       dashboardSidebar(),
#'       dashboardBody(),
#'       title = "Dashboard example"
#'     ),
#'     server = function(input, output) {
#'       observeEvent(input$mytask, {
#'         showModal(modalDialog(
#'           title = "Important message",
#'           "This is an important message!"
#'         ))
#'       })
#'     }
#'   )
#' }
taskItem <- function(text, value = 0, color = "aqua", href = NULL, inputId = NULL) {
  validateColor(color)
  if (is.null(href)) href <- "#"

  shiny::tags$li(
    shiny::a(
      id = inputId,
      class = if (!is.null(inputId)) "action-button",
      href = href,
      shiny::h3(text, shiny::tags$small(class = "pull-right", paste0(value, "%"))),
      shiny::div(
        class = "progress xs",
        shiny::div(
          class = paste0("progress-bar progress-bar-", color),
          style = paste0("width: ", value, "%"),
          role = "progressbar",
          `aria-valuenow` = value,
          `aria-valuemin` = "0",
          `aria-valuemax` = "100",
          shiny::span(class = "sr-only", paste0(value, "% complete"))
        )
      )
    )
  )
}


#' Custom notificationItem
#'
#' @inheritParams shinydashboard::notificationItem
#' @param inputId If not NULL, this item behaves like an action button.
#' @export
notificationItem <- function(text, icon = shiny::icon("triangle-exclamation"), status = "success",
                             href = NULL, inputId = NULL) {
  tagAssert(icon, type = "i")
  validateStatus(status)
  if (is.null(href)) href <- "#"
  icon <- shiny::tagAppendAttributes(icon, class = paste0("text-", status))
  shiny::tags$li(
    shiny::a(
      id = inputId,
      class = if (!is.null(inputId)) "action-button",
      href = href,
      icon,
      text
    )
  )
}



#' Custom messageItem
#'
#' @inheritParams shinydashboard::messageItem
#' @param inputId If not NULL, this item behaves like an action button.
#' @export
messageItem <- function(from, message, icon = shiny::icon("user"), time = NULL,
                        href = NULL, inputId = NULL) {
  tagAssert(icon, type = "i")
  if (is.null(href)) href <- "#"
  shiny::tags$li(
    shiny::a(
      id = inputId,
      class = if (!is.null(inputId)) "action-button",
      href = href,
      icon,
      shiny::h4(from, if (!is.null(time)) {
        shiny::tags$small(shiny::icon("clock"), time)
      }), shiny::p(message)
    )
  )
}
