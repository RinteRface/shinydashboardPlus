#' flipBox
#' 
#' Create a flipping box based off of the AdminLTE flipBox.
#' 
#' @param id the \code{flipBox} id
#' @param front_content ui for the front of the flip box
#' @param back_content ui for the back of the flip box
#' @param front_text text for front button
#' @param back_text text for back button
#' 
#' @section Warning: this function is experimental.
#'
#' @references \url{https://rinterface.github.io/shinydashboardPlus/reference/flipBox.html}
#' 
#' @return HTML tagList
#' 
#' @details To access the state of the flipbox use the input alias \code{input$<id>_value}.
#'   For example, if your flipBox's id is myawesomeflipbox, you can access its state via
#'   \code{input$myawesomeflipbox_value} where a 0 corresponds to the front, 1 the back, and NULL 
#'   indicates the input has not been set yet (i.e. the card has not flipped yet). 
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
#'       flipBox(
#'         id = "id",
#'         front_content = div(
#'           class = "text-center",
#'           img(
#'             src = "https://image.flaticon.com/icons/svg/149/149076.svg",
#'             height = "300px",
#'             width = "100%"
#'           )
#'         ),
#'         back_content = div(
#'           class = "text-center",
#'           height = "300px",
#'           width = "100%",
#'           h1("Details...."),
#'           p("More information....")
#'         )
#'       )
#'     )
#'   ),
#'   
#'   server = function(input, output, session) {
#'   }
#' )
#'    
#' @export
#' @importFrom htmltools tagList tags
#' @importFrom shiny singleton
flipBox <- function(id, 
                    front_content, 
                    back_content, 
                    front_text = "More Info",
                    back_text = "Back to Front") {
  
  if (is.null(id) || missing(id)) stop("card id cannot be null or missing!")
  
  alias <- paste0(id, "_value")
  
  front_content <- htmltools::tagList(
    front_content,
    htmltools::tags$div(
      class = "text-center",
      id = "go_to_back",
      flipButtonFront("id", front_text)
    )
  )
  
  back_content <- htmltools::tagList(
    back_content,
    htmltools::tags$div(
      class = "text-center",
      id = "go_to_front",
      flipButtonBack("id", back_text)
    )
  )
  
  htmltools::tagList(
    htmltools::tags$div(
      class = "rotate-container",
      id = id,
      htmltools::tags$div(
        class = paste0("card-front-", id),
        style = "background-color: white;",
        front_content
      ),
      htmltools::tags$div(
        class = paste0("card-back-", id),
        style = "background-color: white;",
        back_content
      ),
      htmltools::tagList(
        shiny::singleton(
          htmltools::tags$head(
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
            htmltools::tags$script(
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
            htmltools::tags$script(
              paste0(
                "$(function() {
                $('#go_to_back').click(function(){
                  $('#go_to_back').hide()
                  $('#go_to_front').show()
                  Shiny.setInputValue(", "'", alias, "', 1, { priority: 'event'})
              });
              $('#go_to_front').click(function(){
                $('#go_to_front').hide()
                $('#go_to_back').show()
                Shiny.setInputValue(", "'", alias, "', 0, { priority: 'event'})
              });
              });
              "
              )
            )
          )
        )
      )
    )
  )
}


#' flipButtonFront
#' 
#' @export
#' @param id the \code{flipbox} id
#' @param text the button text
flipButtonFront <- function(id, text) {
  htmltools::tags$button(
    id = paste0("btn-flip-front-", id),
    class = "btn btn-primary btn-rotate",
    text
  )
}


#' flipButtonBack 
#' 
#' @export
#' @param id the \code{flipBox} id
#' @param text the button text
flipButtonBack <- function(id, text) {
  htmltools::tags$button(
    id = paste0("btn-flip-back-", id),
    class = "btn btn-primary btn-rotate",
    text
  )
}




#' flipBoxDemo
#' 
#' runs an internal flipBoxDemo application.
#'
#' @return shinyApp
#' @export
#'
#' @importFrom shiny runApp
#'
#' @examples
#' \dontrun{
#' library(shinydashboardPlus)
#' flipBoxDemo()
#' }
flipBoxDemo <- function() {
  
  shiny::runApp(appDir = system.file("flipBoxDemo", "app.R", package = "shinydashboardPlus"))
  
}
