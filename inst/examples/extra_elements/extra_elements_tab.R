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
        starBlock(5),
        starBlock(5, color = "olive"),
        starBlock(1, color = "maroon"),
        starBlock(3, color = "teal")
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
            starBlock(5),
            starBlock(5, color = "olive"),
            starBlock(1, color = "maroon"),
            starBlock(3, color = "teal")
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
          image = "https://adminlte.io/themes/AdminLTE/dist/img/photo1.png",
          title = "Test",
          href = "http://google.com",
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
            image = "https://adminlte.io/themes/AdminLTE/dist/img/photo1.png",
            title = "Test",
            href = "http://google.com",
            "This is the content"
          )'
          ), 
          collapse = "\n"
        )
      ) 
    )
  ),
  
  
  # ################
  # demo progressBar()
  # ################
  
  br(),
  
  column(
    width = 12,
    align = "center",
    h1("progressBar()")
  ),
  
  br(),
  
  fluidRow(
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
        tags$img(src = "https://placehold.it/900x500/3c8dbc/ffffff&text=I+Love+Bootstrap")
      ),
      carouselItem(
        caption = "Item 2",
        tags$img(src = "https://placehold.it/900x500/39CCCC/ffffff&text=I+Love+Bootstrap")
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