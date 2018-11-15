box_sidebar <- 'boxPlus(
  width = 12,
  title = "boxPlus with sidebar", 
  closable = TRUE, 
  status = "warning", 
  solidHeader = FALSE, 
  collapsible = TRUE,
  enable_sidebar = TRUE,
  sidebar_width = 25,
  sidebar_start_open = TRUE,
  sidebar_content = tagList(
    checkboxInput("somevalue", "Some value", FALSE),
    verbatimTextOutput("value"),
    sliderInput(
      "slider_boxsidebar", 
      "Number of observations:",
      min = 0, 
      max = 1000, 
      value = 500
    )
  ),
  plotOutput("boxSidebarPlot")
)'