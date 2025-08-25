timeline1 <- 'box(
  title = "Reversed Timeline: ideal to include in a box",
  status = "info",
  width = 12,
  timelineBlock(
    width = 12,
    timelineEnd(color = "red"),
    timelineLabel(2018, color = "teal"),
    timelineItem(
      title = "Item 1",
      icon = icon("gears"),
      color = "olive",
      time = "now",
      footer = "Here is the footer",
      "This is the body"
    ),
    timelineItem(
      title = "Item 2",
      border = FALSE
    ),
    timelineLabel(2015, color = "orange"),
    timelineItem(
      title = "Item 3",
      icon = icon("paint-brush"),
      color = "maroon",
      timelineItemMedia(image = "placeholders/150x150.png"),
      timelineItemMedia(image = "placeholders/150x150.png")
    ),
    timelineStart(color = "purple")
  )
)'


timeline2 <- 'timelineBlock(
  reversed = FALSE,
  width = 12,
  timelineEnd(color = "red"),
  timelineLabel(2018, color = "teal"),
  timelineItem(
    title = "Item 1",
    icon = icon("gears"),
    color = "olive",
    time = "now",
    footer = "Here is the footer",
    "This is the body"
  ),
  timelineItem(
    title = "Item 2",
    border = FALSE
  ),
  timelineLabel(2015, color = "orange"),
  timelineItem(
    title = "Item 3",
    icon = icon("paint-brush"),
    color = "maroon",
    timelineItemMedia(image = "placeholders/150x150.png"),
    timelineItemMedia(image = "placeholders/150x150.png")
  ),
  timelineStart(color = "purple")
)'
