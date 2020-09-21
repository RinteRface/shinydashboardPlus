library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

shinyApp(
  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(),
    dashboardBody(
      fluidRow(
        actionButton("remove", "Remove message"),
        actionButton("add", "Add message"),
        actionButton("update", "Update message")
      ),
      numericInput("index", "Message index:", 1, min = 1, max = 3),
      br(),
      br(),
      userMessages(
        width = 6,
        status = "danger",
        id = "message",
        userMessage(
          author = "Alexander Pierce",
          date = "20 Jan 2:00 pm",
          image = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
          type = "received",
          "Is this template really for free? That's unbelievable!"
        ),
        userMessage(
          author = "Sarah Bullock",
          date = "23 Jan 2:05 pm",
          image = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
          type = "sent",
          "You better believe it!"
        )
      )
    ),
    title = "user Message"
  ),
  server = function(input, output, session) {
    observeEvent(input$remove, {
      updateUserMessages("message", action = "remove", index = input$index)
    })
    observeEvent(input$add, {
      updateUserMessages(
        "message", 
        action = "add", 
        content = list(
          author = "David",
          date = "Now",
          image = "https://i.pinimg.com/originals/f1/15/df/f115dfc9cab063597b1221d015996b39.jpg",
          type = "received",
          text = tagList(
            sliderInput(
              "obs", 
              "Number of observations:",
              min = 0, 
              max = 1000, 
              value = 500
            ),
            plotOutput("distPlot")
          )
        )
      )
    })
    
    output$distPlot <- renderPlot({
      hist(rnorm(input$obs))
    })
    
    observeEvent(input$update, {
      updateUserMessages(
        "message", 
        action = "update", 
        index = input$index,
        content = list(
          text = tagList(
            appButton(
              inputId = "reload",
              label = "Click me!", 
              icon = icon("sync"), 
              dashboardBadge(1, color = "orange")
            )
          )
        )
      )
    })
    
    observeEvent(input$reload, {
      showNotification("Yeah!", duration = 1, type = "default")
    })
  }
)