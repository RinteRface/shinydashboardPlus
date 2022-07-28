flip_box <- 'flipBox(
  id = 1,
  width = 12,
  front = tagList(
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, 
    sed do eiusmod tempor incididunt ut labore et dolore magna 
    aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
    ullamco laboris nisi ut aliquip ex ea commodo consequat. 
    Duis aute irure dolor in reprehenderit in voluptate velit 
    esse cillum dolore eu fugiat nulla pariatur. Excepteur sint 
    occaecat cupidatat non proident, sunt in culpa qui officia 
    deserunt mollit anim id est laborum",
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
  ),
  back = tagList(
    column(
      width = 12,
      align = "center",
      sliderInput(
        "flip_obs", 
        "Number of observations:",
        min = 0, 
        max = 1000, 
        value = 500
      )
    ),
    plotOutput("flipPlot")
  )
)'
