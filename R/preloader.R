#' AdminLTE2 preloader
#'
#' This creates a preloader.
#' 
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @note This function is only for internal use of shinydashboardPlus.
#' @export
preloader <- function() {
  loaderTag <- shiny::tags$div(
    id = "loader-wrapper",
    shiny::tags$div(id = "loader"),
    shiny::tags$div(class = "loader-section section-left"),
    shiny::tags$div(class = "loader-section section-right")
  )
  
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$style(
          shiny::HTML(
            paste0(
              '#loader-wrapper {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: 5000;
               }
              #loader {
                display: block;
                position: relative;
                left: 50%;
                top: 50%;
                width: 150px;
                height: 150px;
                margin: -75px 0 0 -75px;
                border: 3px solid transparent;
                border-top-color: #3498db;
                border-radius: 50%;
                z-index: 5001;
                -webkit-animation: spin 2s linear infinite;
                animation: spin 2s linear infinite;
              }
              #loader:before {
                content: "";
                position: absolute;
                top: 5px;
                left: 5px;
                right: 5px;
                bottom: 5px;
                border: 3px solid transparent;
                border-top-color: #e74c3c;
                border-radius: 50%;
                -webkit-animation: spin 3s linear infinite;
                animation: spin 3s linear infinite;
              }
              #loader:after {
                content: "";
                position: absolute;
                top: 15px;
                left: 15px;
                right: 15px;
                bottom: 15px;
                border: 3px solid transparent;
                border-top-color: #f9c922;
                border-radius: 50%;
              }


              /* copy and paste the animation inside all 3 elements */
              /* #loader, #loader:before, #loader:after */
              -webkit-animation: spin 1.5s linear infinite;
              animation: spin 1.5s linear infinite;
              
              /* include this only once */
              @-webkit-keyframes spin {
                0%   {
                  -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */
                  -ms-transform: rotate(0deg);  /* IE 9 */
                  transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */
                }
                100% {
                  -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */
                  -ms-transform: rotate(360deg);  /* IE 9 */
                  transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */
                }
              }
              @keyframes spin {
                0%   {
                  -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */
                  -ms-transform: rotate(0deg);  /* IE 9 */
                  transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */
                }
                100% {
                  -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */
                  -ms-transform: rotate(360deg);  /* IE 9 */
                  transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */
                }
              }


              #loader-wrapper .loader-section {
                position: fixed;
                top: 0;
                width: 51%;
                height: 100%;
                background: #222222;
                z-index: 5000;
              }
              #loader-wrapper .loader-section.section-left {
                left: 0;
              }
              #loader-wrapper .loader-section.section-right {
                right: 0;
              }


              /* Loaded */
              .loaded #loader-wrapper .loader-section.section-left {
                -webkit-transform: translateX(-100%);  /* Chrome, Opera 15+, Safari 3.1+ */
                -ms-transform: translateX(-100%);  /* IE 9 */
                transform: translateX(-100%);  /* Firefox 16+, IE 10+, Opera */
              }
              .loaded #loader-wrapper .loader-section.section-right {
                -webkit-transform: translateX(100%);  /* Chrome, Opera 15+, Safari 3.1+ */
                -ms-transform: translateX(100%);  /* IE 9 */
                transform: translateX(100%);  /* Firefox 16+, IE 10+, Opera */
              }

              .loaded #loader {
                  opacity: 0;
              }

              .loaded #loader-wrapper {
                  visibility: hidden;
              }

              .loaded #loader {
                opacity: 0;
                -webkit-transition: all 0.3s ease-out; 
                transition: all 0.3s ease-out;
              }

              .loaded #loader-wrapper .loader-section.section-right,
              .loaded #loader-wrapper .loader-section.section-left {
                            
                -webkit-transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000); 
                transition: all 0.7s 0.3s cubic-bezier(0.645, 0.045, 0.355, 1.000);
              }
              .loaded #loader-wrapper {
                -webkit-transform: translateY(-100%);
                -ms-transform: translateY(-100%);
                transform: translateY(-100%);
              
                -webkit-transition: all 0.3s 1s ease-out; 
                transition: all 0.3s 1s ease-out;
              }
              '
            )
          )
        )
      )
    ),
    loaderTag
  )
}