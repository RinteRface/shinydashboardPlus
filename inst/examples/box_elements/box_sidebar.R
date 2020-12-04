box_sidebar <- 'box(
  width = 12,
  title = "boxPlus with sidebar", 
  closable = TRUE, 
  status = "warning", 
  solidHeader = FALSE, 
  collapsible = TRUE,
  sidebar = boxSidebar(
    id = "boxsidebar",
    width = 25,
    startOpen = TRUE,
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