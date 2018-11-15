buttons_tab <- tabItem(
  tabName = "buttons",
  
  # ################
  # demo app buttons
  # ################
  
  br(),
  
  column(
    width = 12,
    align = "center",
    h1("appButton()")
  ),
  
  br(),
  
  fluidRow(
    # element
    column(
      width = 6,
      eval(parse(text = app_buttons))
    ),
    # code editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "400px",
        outputId = "appbutton_code",
        readOnly = TRUE,
        value = paste(app_buttons, collapse = "\n")
      ) 
    )
  ),
  
  # ################
  # demo social buttons
  # ################
  
  br(),
  
  column(
    width = 12,
    align = "center",
    h1("socialButton()")
  ),
  
  br(),
  
  fluidRow(
    # element
    column(
      width = 6,
      eval(parse(text = social_buttons))
    ),
    # Code editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "200px",
        outputId = "socialbutton_code",
        readOnly = TRUE,
        value = paste(social_buttons, collapse = "\n")
      )
    )
  )
)