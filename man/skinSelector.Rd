% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/skinSelector.R
\name{skinSelector}
\alias{skinSelector}
\title{AdminLTE2 skin selector}
\usage{
skinSelector()
}
\description{
This creates a skin selector element.
}
\examples{
if (interactive()) {
 library(shiny)
 library(shinydashboard)
 library(shinydashboardPlus)
 
 shinyApp(
   ui = dashboardPage(
     header = dashboardHeader(),
     sidebar = dashboardSidebar(),
     body = dashboardBody(),
     controlbar = dashboardControlbar(skinSelector()),
     title = "Skin Selector"
   ),
   server = function(input, output) { }
 )
}
}
\author{
David Granjon, \email{dgranjon@ymail.com}
}