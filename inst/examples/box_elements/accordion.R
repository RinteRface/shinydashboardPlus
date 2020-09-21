accordion <- 'box(
  title = "Accordion Demo",
  width = 12,
  accordion(
    id = "accordion1",
    accordionItem(
      title = "Accordion 1 Item 1",
      status = "success",
      collapsed = TRUE,
      "This is some text!"
    ),
    accordionItem(
      title = "Accordion 1 Item 2",
      status = "success",
      collapsed = FALSE,
      "This is some text!"
    )
  ),
  br(),
  accordion(
    id = "accordion2",
    accordionItem(
      title = "Accordion 2 Item 1",
      status = "danger",
      collapsed = FALSE,
      "This is some text!"
    ),
    accordionItem(
      title = "Accordion 2 Item 2",
      status = "danger",
      collapsed = TRUE,
      "This is some text!"
    )
  )
)'

