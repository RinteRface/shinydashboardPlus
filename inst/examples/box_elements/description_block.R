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
        number_color = "green", 
        number_icon = "fa fa-caret-up",
        header = "$35,210.43", 
        text = "TOTAL REVENUE", 
        right_border = TRUE,
        margin_bottom = FALSE
      )
    ),
    column(
      width = 6,
      descriptionBlock(
        number = "18%", 
        number_color = "red", 
        number_icon = "fa fa-caret-down",
        header = "1200", 
        text = "GOAL COMPLETION", 
        right_border = FALSE,
        margin_bottom = FALSE
      )
    )
  )
)'