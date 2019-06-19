timeline1 <- 'box(
  title = "Reversed Timeline: ideal to include in a box",
  status = "info",
  width = NULL,
  timelineBlock(
    timelineEnd(color = "danger"),
    timelineLabel(2018, color = "teal"),
    timelineItem(
      title = "Item 1",
      icon = "gears",
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
      icon = "paint-brush",
      color = "maroon",
      timelineItemMedia(src = "https://placehold.it/150x100"),
      timelineItemMedia(src = "https://placehold.it/150x100")
    ),
    timelineStart(color = "gray")
  )
)'


timeline2 <- 'timelineBlock(
  reversed = FALSE,
  timelineEnd(color = "danger"),
  timelineLabel(2018, color = "teal"),
  timelineItem(
    title = "Item 1",
    icon = "gears",
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
    icon = "paint-brush",
    color = "maroon",
    timelineItemMedia(src = "https://placehold.it/150x100"),
    timelineItemMedia(src = "https://placehold.it/150x100")
  ),
  timelineStart(color = "gray")
)'