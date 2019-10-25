accordion <- 'box(
  title = "Accordion Demo",
  width = NULL,
  accordion(
    inputId = "accordion1",
    accordionItem(
      title = "Accordion 1 Item 1",
      color = "success",
      collapsed = TRUE,
      "This is some text!"
    ),
    accordionItem(
      title = "Accordion 1 Item 2",
      color = "success",
      collapsed = FALSE,
      "This is some text!"
    )
  ),
  br(),
  accordion(
    inputId = "accordion2",
    accordionItem(
      title = "Accordion 2 Item 1",
      color = "danger",
      collapsed = FALSE,
      "This is some text!"
    ),
    accordionItem(
      title = "Accordion 2 Item 2",
      color = "danger",
      collapsed = TRUE,
      "This is some text!"
    )
  )
)'

