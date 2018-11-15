gradient_box1 <- 'gradientBox(
  title = "My gradient Box",
  icon = "fa fa-th",
  width = 12,
  gradientColor = "teal", 
  boxToolSize = "sm", 
  footer = column(
    width = 12,
    align = "center",
    sliderInput(
      "obs", 
      "Number of observations:",
      min = 0, max = 1000, value = 500
    )
  ),
  plotOutput("distPlot")
)'


gradient_box2 <- 'gradientBox(
  title = "My gradient Box",
  width = 12,
  icon = "fa fa-heart",
  gradientColor = "maroon", 
  boxToolSize = "xs", 
  closable = TRUE,
  footer = "The footer goes here. You can include anything",
  "This is a gradient box"
)'