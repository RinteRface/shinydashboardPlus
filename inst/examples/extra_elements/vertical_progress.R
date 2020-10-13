vertical_progress <- 'box(
  title = "progress",
  width = 12,
  progressBar(
    value = 10,
    striped = TRUE,
    animated = TRUE
  ),
  progressBar(
    value = 50,
    animated = TRUE,
    status = "warning",
    size = "xs"
  ),
  progressBar(
    value = 20,
    status = "danger",
    size = "sm",
    vertical = TRUE
  )
)'