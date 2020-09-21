app_buttons <- 'box(
  title = "App Buttons",
  width = 12,
  appButton(
    inputId = "myAppButton",
    label = "Users", 
    icon = icon("users"), 
    dashboardBadge(textOutput("appBtnVal"), color = "maroon")
  )
)'