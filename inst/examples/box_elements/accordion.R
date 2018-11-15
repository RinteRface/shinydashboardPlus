accordion <- 'box(
  title = "Accordion Demo",
  width = NULL,
  accordion(
    accordionItem(
      id = 1,
      title = "Accordion Item 1",
      color = "danger",
      collapsed = TRUE,
      "This is some text!"
    ),
    accordionItem(
      id = 2,
      title = "Accordion Item 2",
      color = "warning",
      collapsed = FALSE,
      "This is some text!"
    ),
    accordionItem(
      id = 3,
      title = "Accordion Item 3",
      color = "info",
      collapsed = FALSE,
      "This is some text!"
    )
  )
)'