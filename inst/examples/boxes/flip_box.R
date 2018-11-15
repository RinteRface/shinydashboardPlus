flip_box <- 'flipBox(
  id = 1,
  main_img = "https://image.flaticon.com/icons/svg/149/149076.svg",
  header_img = "https://image.flaticon.com/icons/svg/119/119595.svg",
  front_title = "John Doe",
  back_title = "About John",
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, 
         sed do eiusmod tempor incididunt ut labore et dolore magna 
         aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
         ullamco laboris nisi ut aliquip ex ea commodo consequat. 
         Duis aute irure dolor in reprehenderit in voluptate velit 
         esse cillum dolore eu fugiat nulla pariatur. Excepteur sint 
         occaecat cupidatat non proident, sunt in culpa qui officia 
         deserunt mollit anim id est laborum",
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
  ),
  back_content = tagList(
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