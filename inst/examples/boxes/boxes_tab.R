boxes_tab <- tabItem(
  tabName = "boxes",
  
  br(),
  
  # ############################################### #
  # demo enhanced classic boxes from shinydashboard # 
  # ############################################### #
  
  column(
    width = 12,
    align = "center",
    h1("box() v2: closable and labels")
  ),
  
  br(),
  
  fluidRow(
    # element
    column(
      width = 6,
      eval(parse(text = close_box))
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "300px",
        outputId = "boxplus1_code",
        readOnly = TRUE,
        value = paste(close_box, collapse = "\n")
      ) 
    )
  ),
  
  fluidRow(
    # element
    column(
      width = 6,
      eval(parse(text = label_box))
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "200px",
        outputId = "boxplus2_code",
        readOnly = TRUE,
        value = paste(label_box, collapse = "\n")
      )
    )
  ),
  
  
  # ################### #
  # demo widgetUser box #
  # ################### #
  
  br(),
  
  column(
    width = 12,
    align = "center",
    h1("userBox()")
  ),
  
  br(),
  
  fluidRow(
    # element
    column(
      width = 6,
      eval(parse(text = widget_user_box1))
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "200px",
        outputId = "widgetuserbox1_code",
        readOnly = TRUE,
        value = paste(widget_user_box1, collapse = "\n")
      ) 
    )
  ),
  
  fluidRow(
    # element
    column(
      width = 6,
      eval(parse(text = widget_user_box2))
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "200px",
        outputId = "widgetuserbox2_code",
        readOnly = TRUE,
        value = paste(widget_user_box2, collapse = "\n")
      ) 
    )
  ),
  
  fluidRow(
    # element
    column(
      width = 6,
      eval(parse(text = widget_user_box3))
    ),
    # code editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "200px",
        outputId = "widgetuserbox3_code",
        readOnly = TRUE,
        value = paste(widget_user_box3, collapse = "\n")
      ) 
    )
  ),
  
  # ################### #
  #   demo social box   #
  # ################### #
  
  br(),
  
  column(
    width = 12,
    align = "center",
    h1("socialBox()")
  ),
  
  br(),
  
  fluidRow(
    # element
    column(
      width = 6,
      eval(parse(text = social_box)) 
    ),
    # code editor
    column(
      width = 6,
      aceEditor(
        outputId = "socialBox_code",
        readOnly = TRUE,
        theme = "dracula",
        mode = "r",
        height = "500px",
        wordWrap = TRUE,
        value = paste(social_box, collapse = "\n")
      ) 
    )
  ),
  
  # ################### #
  #    demo flip box    #
  # ################### #
  
  br(),
  
  column(
    width = 12,
    align = "center",
    h1("flipBox()")
  ),
  
  br(),
  
  fluidRow(
    # element
    column(
      width = 6,
      align = "center",
      eval(parse(text = flip_box))
    ),
    # code editor
    column(
      width = 6,
      align = "center",
      aceEditor(
        outputId = "flipBox_code",
        readOnly = TRUE,
        theme = "dracula",
        mode = "r",
        height = "750px",
        wordWrap = TRUE,
        value = paste(flip_box, collapse = "\n")
      )
    )
  )
)
