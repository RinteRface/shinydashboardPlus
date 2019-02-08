extra_elements_tab <- tabItem(
  tabName = "extraelements",
  
  # ################
  # demo loadingState()
  # ################
  
  br(),
  
  column(
    width = 12,
    align = "center",
    h1("loadingState()")
  ),
  br(),
  
  fluidRow(
    # demo loading spinner
    column(
      width = 6,
      box(
        title = "loading spinner",
        width = NULL,
        loadingState()
      ) 
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "20px",
        outputId = "loadingstate_code",
        readOnly = TRUE,
        value = paste(
          style_text('loadingState()'), 
          collapse = "\n"
        )
      ) 
    )
  ),
  
  # ################
  # demo blockQuote()
  # ################
  
  br(),
  
  column(
    width = 12,
    align = "center",
    h1("blockQuote()")
  ),
  
  br(),
  
  fluidRow(
    # demo  blockQuote
    box(
      title = "BlockQuote example",
      blockQuote("I quote some text here!")
    ),
    box(
      title = "BlockQuote example",
      blockQuote("I quote some text here!", side = "right")
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "20px",
        outputId = "blockquote1_code",
        readOnly = TRUE,
        value = paste(
          style_text(
            'blockQuote("I quote some text here!")'
          ), 
          collapse = "\n"
        )
      )
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "20px",
        outputId = "blockquote2_code",
        readOnly = TRUE,
        value = paste(
          style_text(
            'blockQuote("I quote some text here!", side = "right")'
          ), 
          collapse = "\n"
        )
      )
    )
  ),
  
  # ################
  # demo dashboardLabel()
  # ################
  
  br(),
  column(
    width = 12,
    align = "center",
    h1("dashboardLabel()")
  ),
  br(),
  
  # demo dashboardLabel
  column(
    width = 6,
    dashboardLabel("Label 1", status = "info"),
    dashboardLabel("Label 2", status = "success"),
    dashboardLabel("Label 3", status = "warning"),
    dashboardLabel("Label 4", status = "primary"),
    dashboardLabel("Label 5", status = "danger") 
  ),
  
  column(
    width = 6,
    # ace editor
    aceEditor(
      theme = "dracula",
      mode = "r",
      height = "100px",
      outputId = "dahboardlabel_code",
      readOnly = TRUE,
      value = paste(
        style_text(
          'dashboardLabel("Label 1", status = "info")
         dashboardLabel("Label 2", status = "success")
         dashboardLabel("Label 3", status = "warning")
         dashboardLabel("Label 4", status = "primary")
         dashboardLabel("Label 5", status = "danger")'
        ), 
        collapse = "\n"
      )
    ) 
  ),
  
  # ################
  # demo starBlock()
  # ################
  
  br(),
  column(
    width = 12,
    align = "center",
    h1("starBlock()")
  ),
  br(),
  
  fluidRow(
    # demo starBlock
    column(
      width = 6,
      box(
        title = "Star example",
        width = NULL,
        starBlock(grade = 5),
        starBlock(grade = 5, color = "olive"),
        starBlock(grade = 1, color = "maroon"),
        starBlock(grade = 3, color = "teal")
      ) 
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "100px",
        outputId = "starblock_code",
        readOnly = TRUE,
        value = paste(
          style_text(
            'box(
            title = "Star example",
            starBlock(grade = 5),
            starBlock(grade = 5, color = "olive"),
            starBlock(grade = 1, color = "maroon"),
            starBlock(grade = 3, color = "teal")
          )'
          ), 
          collapse = "\n"
        )
      ) 
    )
  ),
  
  # ################
  # demo attachmentBlock()
  # ################
  
  br(),
  
  column(
    width = 12,
    align = "center",
    h1("attachmentBlock()")
  ),
  br(),
  
  fluidRow(
    # demo attachment block
    column(
      width = 6,
      box(
        title = "Attachment example",
        width = NULL,
        attachmentBlock(
          src = "http://kiev.carpediem.cd/data/afisha/o/2d/c7/2dc7670333.jpg",
          title = "Test",
          title_url = "http://google.com",
          "This is the content"
        )
      ) 
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "100px",
        outputId = "attachmentblock_code",
        readOnly = TRUE,
        value = paste(
          style_text(
            'attachmentBlock(
            src = "http://kiev.carpediem.cd/data/afisha/o/2d/c7/2dc7670333.jpg",
            title = "Test",
            title_url = "http://google.com",
            "This is the content"
          )'
          ), 
          collapse = "\n"
        )
      ) 
    )
  ),
  
  # ################
  # demo rightSidebarMenu()
  # ################
  
  br(),
  
  column(
    width = 12,
    align = "center",
    h1("rightSidebarMenu()")
  ),
  
  br(),
  
  fluidRow(
    # demo rightSidebarMenu
    column(
      width = 6,
      eval(parse(text = rightsidebar_menu)) 
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "400px",
        outputId = "rightSidebarMenu_code",
        readOnly = TRUE,
        value = paste(rightsidebar_menu, collapse = "\n")
      ) 
    )
  ),
  
  # ################
  # demo verticalProgress()
  # ################
  
  br(),
  
  column(
    width = 12,
    align = "center",
    h1("verticalProgress()")
  ),
  
  br(),
  
  fluidRow(
    # demo verticalProgress
    column(
      width = 6,
      eval(parse(text = vertical_progress)) 
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "350px",
        outputId = "verticalProgress_code",
        readOnly = TRUE,
        value = paste(vertical_progress, collapse = "\n")
      ) 
    )
  ),
  
  
  # ################
  # demo carousel()
  # ################
  
  br(),
  column(
    width = 12,
    align = "center",
    h1("carousel()")
  ),
  br(),
  
  # demo carousel
  fluidRow(
    carousel(
      id = "mycarousel",
      carouselItem(
        caption = "Item 1",
        tags$img(src = "http://placehold.it/900x500/3c8dbc/ffffff&text=I+Love+Bootstrap")
      ),
      carouselItem(
        caption = "Item 2",
        tags$img(src = "http://placehold.it/900x500/39CCCC/ffffff&text=I+Love+Bootstrap")
      )
    ),
    
    column(
      width = 6,
      # ace editor
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "200px",
        outputId = "carousel_code",
        readOnly = TRUE,
        value = paste(carousel, collapse = "\n")
      ) 
    )
  )
)