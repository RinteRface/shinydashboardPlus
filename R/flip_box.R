#' @param id the flipbox id
#' @param text the button text
#'
#' @export
#'
#' @importFrom htmltools tags
#' @describeIn flip_box flip_button_front button to flip to the front of the \code{flip_box}.
flip_button_front <- function(id, text) {
  htmltools::tags$button(
    id = paste0("btn-flip-front-", id),
    class = "btn btn-primary btn-rotate",
    text
  )
}


#' @param id the flipbox id
#' @param text the button text
#'
#' @export
#'
#' @importFrom htmltools tags
#' @describeIn flip_box flip_button_back button to flip to the back of the \code{flip_box}.
flip_button_back <- function(id, text) {
  htmltools::tags$button(
    id = paste0("btn-flip-back-", id),
    class = "btn btn-primary btn-rotate",
    text
  )
}


#' flip_box
#'
#' UI for the flip_box - based off of \href{https://rinterface.github.io/shinydashboardPlus/}{shinydashboardplus::flipBox}
#'
#' @param id the flipbox id
#' @param front_content ui for the front of the flip box
#' @param back_content ui for the back of the flip box
#'
#' @importFrom htmltools tagList tags h1
#' @importFrom shiny singleton
#'
#' @section Warning: this function is experimental.
#'
#' @references \url{https://rinterface.github.io/shinydashboardPlus/reference/flipBox.html}
#' 
#' @return HTML tagList
#' 
#' @examples
#' library(shiny)
#' library(shinydashboard)
#' library(shinydashboardPlus)
#' shinyApp(
#'   ui = dashboardPage(
#'     dashboardHeader(),
#'     dashboardSidebar(),
#'     dashboardBody(
#'       box(
#'         width = 12,
#'         style = paste0("background-color: #000; color: #FFF;"),
#'         fluidRow(
#'           column(
#'             width = 12,
#'             flip_box(
#'               id = "id",
#'               front_content = img(
#'                 src = "https://image.flaticon.com/icons/svg/149/149076.svg",
#'                 width = "100%",
#'                 height = "300px",
#'                 style = "border: 1px solid black"
#'               ),
#'               back_content = div(
#'                 style = "border: 1px solid black; height: 300px; background-color: #FFFFFF; color: #000000;",
#'                 h1(
#'                   class = "text-center",
#'                   "Details...."
#'                 ),
#'                 p("More information....")
#'               )
#'             )
#'           )
#'         ),
#'         
#'         fluidRow(
#'           column(
#'             width = 12,
#'             br(),
#'             div(
#'               id = "go_to_back",
#'               class = "pull_right",
#'               style = "display: inline-block; margin-right: 5px;",
#'               flip_button_front("id", "More Info")
#'             ),
#'             div(
#'               id = "go_to_front",
#'               class = "pull-right",
#'               style = "display: inline-block; margin-right: 5px;",
#'               flip_button_back("id", "Back to Front")
#'             )
#'           )
#'         )
#'       )
#'     )
#'   ),
#'   
#'   server = function(input, output) {
#'     
#'   }
#' )
#'    
#'
#' @export
flip_box <- function(
  id,
  front_content = htmltools::h1("Hi From the Front"),
  back_content = tags$div(
    style = "background-color: #FFF; height: 380px;",
    back_content
  )
) {
  
  if (is.null(id)) stop("card id cannot be null and must be unique")
  
  htmltools::tagList(
    tags$div(
      class = "rotate-container",
      tags$div(
        class = paste0("card-front-", id),
        style = "background-color: white;",
        front_content
      ),
      tags$div(
        class = paste0("card-back-", id),
        back_content
      )
    ),
    tagList(
      shiny::singleton(
        tags$head(
          tags$style(
            paste0(
              "/* Card styles for rotation */

             .rotate-container {
                position: relative;
            }

            .rotate-container .card-front-", id, ", .rotate-container .card-back-", id, " {
              width: 100%;
              height: 100%;
              -webkit-transform: perspective(600px) rotateY(0deg);
              transform: perspective(600px) rotateY(0deg);
              -webkit-backface-visibility: hidden;
              backface-visibility: hidden;
              transition: all 0.5s linear 0s;
            }

            .card .card-background-", id, " {
              height: 1em
            }

            .rotate-container .card-back-", id, " {
              -webkit-transform: perspective(1600px) rotateY(180deg);
              transform: perspective(1600px) rotateY(180deg);
              position: absolute;
              top: 0;
              left: 0;
              right: 0;
            }

            .rotate-container .rotate-card-front-", id, " {
              -webkit-transform: perspective(1600px) rotateY(-180deg);
              transform: perspective(1600px) rotateY(-180deg);
            }

            .rotate-container .rotate-card-back-", id, " {
              -webkit-transform: perspective(1600px) rotateY(0deg);
              transform: perspective(1600px) rotateY(0deg);
            }

          "
            )
          ),
          tags$script(
            paste0(
              "$(function() {

                // For card rotation
                $('#btn-flip-front-", id, "').click(function(){
                  $('.card-front-", id, "').addClass(' rotate-card-front-", id, "');
                  $('.card-back-", id, "').addClass(' rotate-card-back-", id, "');
                });

                $('#btn-flip-back-", id, "').click(function(){

                  $('.card-front-", id, "').removeClass(' rotate-card-front-", id, "');
                  $('.card-back-", id, "').removeClass(' rotate-card-back-", id, "');
                });

              });"
            )
          ),
          tags$script(
            paste0(
              "$(function() {
                $('#go_to_back').click(function(){
                  $('#go_to_back').hide()
                  $('#go_to_front').show()
              });
              $('#go_to_front').click(function(){
                $('#go_to_front').hide()
                $('#go_to_back').show()
              });
              });
              "
            )
          )
        )
      )
    )
  )
}
