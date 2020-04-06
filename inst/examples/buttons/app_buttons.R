app_buttons <- 'box(
  width = NULL,
  title = "App Buttons",
  status = NULL,
  appButton(
    inputId = "myAppButton",
    label = "Users", 
    icon = icon("users"), 
    dashboardBadge(textOutput("appBtnVal"))
  )
)'