nav_pills <- 'box(
  title = "Nav Pills",
  status = "info",
  width = 12,
  footerPadding = FALSE,
  footer = navPills(
    navPillsItem(
      selected = TRUE,
      left = "Item 1", 
      color = "green",
      right = "Some text here"
    ),
    navPillsItem(
      left = "Item 2", 
      color = "red",
      icon = icon("fa fa-angle-down"), 
      right = "10%"
    )
  )
)'