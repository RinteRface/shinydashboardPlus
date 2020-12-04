vertical_progress <- 'box(
  title = "progress",
  width = 12,
  shinydashboardPlus::progressBar(
    value = 10,
    striped = TRUE,
    animated = TRUE
  ),
  shinydashboardPlus::progressBar(
    value = 50,
    animated = TRUE,
    status = "warning",
    size = "xs"
  ),
  shinydashboardPlus::progressBar(
    value = 20,
    status = "danger",
    size = "sm",
    vertical = TRUE
  )
)'