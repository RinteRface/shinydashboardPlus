box_pad1 <- 'box(
  title = "Box with a green boxPad",
  status = "warning",
  width = 12,
  fluidRow(
    column(width = 6),
    column(
      width = 6,
      boxPad(
        color = "green",
        descriptionBlock(
          header = "8390", 
          text = "VISITS", 
          rightBorder = FALSE,
          marginBottom = TRUE
        ),
        descriptionBlock(
          header = "30%", 
          text = "REFERRALS", 
          rightBorder = FALSE,
          marginBottom = TRUE
        ),
        descriptionBlock(
          header = "70%", 
          text = "ORGANIC", 
          rightBorder = FALSE,
          marginBottom = FALSE
        )
      )
    )
  )
)'

box_pad2 <- 'box(
  title = "Box with boxPad containing inputs",
  status = "warning",
  width = 12,
  fluidRow(
    column(
      width = 6,
      boxPad(
        color = "lime",
        sliderInput(
          "obs2", 
          "Number of observations:",
          min = 0, max = 1000, value = 500
        ),
        checkboxGroupInput(
          "variable", 
          "Variables to show:",
          c("Cylinders" = "cyl",
            "Transmission" = "am",
            "Gears" = "gear")
        ),
        
        knobInput(
          inputId = "myKnob",
          skin = "tron",
          readOnly = TRUE,
          label = "Display previous:",
          value = 50,
          min = -100,
          displayPrevious = TRUE,
          fgColor = "#428BCA",
          inputColor = "#428BCA"
        )
      )
    ),
    column(
      width = 6,
      plotOutput("distPlot2", height = "200px"),
      tableOutput("data")
    )
  )
)'