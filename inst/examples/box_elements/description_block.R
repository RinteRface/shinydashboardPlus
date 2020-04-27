description_block <- 'box(
  solidHeader = FALSE,
  title = "Status summary",
  background = NULL,
  width = 12,
  status = "danger",
  footer = fluidRow(
    column(
      width = 6,
      descriptionBlock(
        number = "17%", 
        numberColor = "green", 
        numberIcon = "caret-up",
        header = "$35,210.43", 
        text = "TOTAL REVENUE", 
        rightBorder = TRUE,
        marginBottom = FALSE
      )
    ),
    column(
      width = 6,
      descriptionBlock(
        number = "18%", 
        numberColor = "red", 
        numberIcon = "caret-down",
        header = "1200", 
        text = "GOAL COMPLETION", 
        rightBorder = FALSE,
        marginBottom = FALSE
      )
    )
  )
)'