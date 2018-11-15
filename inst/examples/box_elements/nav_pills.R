nav_pills <- 'boxPlus(
  title = "Nav Pills",
  status = "info",
  width = NULL,
  footer_padding = FALSE,
  footer = navPills(
    navPillsItem(
      active = TRUE,
      pillName = "Item 1", 
      pillColor = "green",
      pillIcon = NULL, 
      pillText = "Some text here"
    ),
    navPillsItem(
      pillName = "Item 2", 
      pillColor = "red",
      pillIcon = "fa fa-angle-down", 
      pillText = "10%"
    )
  )
)'