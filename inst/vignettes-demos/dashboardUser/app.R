library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

shinyApp(
  ui = dashboardPage(
    header = dashboardHeader(userOutput("user")),
    sidebar = dashboardSidebar(),
    body = dashboardBody(),
    title = "User dropdown"
  ),
  server = function(input, output) {
    output$user <- renderUser({
      dashboardUser(
        name = "Divad Nojnarg", 
        image = "https://adminlte.io/themes/AdminLTE/dist/img/user2-160x160.jpg", 
        title = "shinydashboardPlus",
        subtitle = "Author", 
        footer = p("The footer", class = "text-center"),
        fluidRow(
          dashboardUserItem(
            width = 6,
            socialButton(
              href = "https://dropbox.com",
              icon = icon("dropbox")
            )
          ),
          dashboardUserItem(
            width = 6,
            socialButton(
              href = "https://github.com",
              icon = icon("github")
            )
          )
        )
      )
    })
  }
)
