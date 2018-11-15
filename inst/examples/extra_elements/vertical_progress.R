vertical_progress <- 'box(
  title = "verticalProgress",
  width = NULL,
  verticalProgress(
    value = 10,
    striped = TRUE,
    active = TRUE
  ),
  verticalProgress(
    value = 50,
    active = TRUE,
    status = "warning",
    size = "xs"
  ),
  verticalProgress(
    value = 20,
    status = "danger",
    size = "sm",
    height = "60%"
  )
)'