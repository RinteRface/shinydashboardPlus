box_elements_tab <- tabItem(
  tabName = "boxelements",
  br(),

  # ################ #
  # demo box Sidebar #
  # ################ #

  column(
    width = 12,
    align = "center",
    h1("Create box with sidebar")
  ),
  br(),
  fluidRow(
    # element
    column(
      width = 6,
      box(
        id = "mybox",
        width = 12,
        title = "boxPlus with sidebar",
        closable = TRUE,
        status = "warning",
        solidHeader = FALSE,
        collapsible = TRUE,
        sidebar = boxSidebar(
          id = "boxsidebar",
          width = 25,
          startOpen = TRUE,
          checkboxInput("somevalue", "Some value", FALSE),
          verbatimTextOutput("value"),
          sliderInput(
            "slider_boxsidebar",
            "Number of observations:",
            min = 0,
            max = 1000,
            value = 500
          )
        ),
        plotOutput("boxSidebarPlot")
      )
    ),
    # code editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "400px",
        outputId = "boxPlus-sidebar_code",
        readOnly = TRUE,
        value = paste(box_sidebar, collapse = "\n")
      )
    )
  ),

  # ##################### #
  # demo descriptionBlock #
  # ##################### #

  column(
    width = 12,
    align = "center",
    h1("descriptionBlock()")
  ),
  br(),
  fluidRow(
    column(
      width = 6,
      # descriptionBlock demo in footer
      eval(parse(text = description_block))
    ),
    # code editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "450px",
        outputId = "descriptionblock_code",
        readOnly = TRUE,
        value = paste(description_block, collapse = "\n")
      )
    )
  ),

  # ##################### #
  #   demo boxPad         #
  # ##################### #

  br(),
  column(
    width = 12,
    align = "center",
    h1("boxPad()")
  ),
  br(),
  fluidRow(
    # descriptionBlock demo in box side
    column(
      width = 6,
      eval(parse(text = box_pad1))
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "450px",
        outputId = "boxPad1_code",
        readOnly = TRUE,
        value = paste(box_pad1, collapse = "\n")
      )
    )
  ),
  fluidRow(
    # element
    column(
      width = 6,
      eval(parse(text = box_pad2))
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "650px",
        outputId = "boxPad2_code",
        readOnly = TRUE,
        value = paste(box_pad2, collapse = "\n")
      )
    )
  ),

  # ##################### #
  #   demo userList()     #
  # ##################### #

  br(),
  column(
    width = 12,
    align = "center",
    h1("userList()")
  ),
  br(),
  fluidRow(
    # userList examples
    column(
      width = 6,
      eval(parse(text = user_list))
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "550px",
        outputId = "userlist_code",
        readOnly = TRUE,
        value = paste(user_list, collapse = "\n")
      )
    )
  ),

  # ##################### #
  #   demo navPills()     #
  # ##################### #

  br(),
  column(
    width = 12,
    align = "center",
    h1("navPills()")
  ),
  br(),
  fluidRow(
    # navPills demo
    column(
      width = 6,
      eval(parse(text = nav_pills))
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "350px",
        outputId = "navpills_code",
        readOnly = TRUE,
        value = paste(nav_pills, collapse = "\n")
      )
    )
  ),

  # ##################### #
  #   demo productList()  #
  # ##################### #

  br(),
  column(
    width = 12,
    align = "center",
    h1("productList()")
  ),
  br(),
  fluidRow(
    # product list demo
    column(
      width = 6,
      eval(parse(text = product_list))
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "350px",
        outputId = "productlist_code",
        readOnly = TRUE,
        value = paste(product_list, collapse = "\n")
      )
    )
  ),

  # ##################### #
  #   demo accordion()    #
  # ##################### #

  br(),
  column(
    width = 12,
    align = "center",
    h1("accordion()")
  ),
  br(),
  fluidRow(
    # demo accordion
    column(
      width = 6,
      eval(parse(text = accordion))
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "420px",
        outputId = "accordion_code",
        readOnly = TRUE,
        value = paste(accordion, collapse = "\n")
      )
    )
  ),

  # ##################### #
  #   demo todoList()    #
  # ##################### #

  br(),
  column(
    width = 12,
    align = "center",
    h1("todoList()")
  ),
  br(),
  fluidRow(
    # element
    column(
      width = 6,
      eval(parse(text = todo_list1))
    ),
    # code editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "320px",
        outputId = "todolist1_code",
        readOnly = TRUE,
        value = paste(todo_list1, collapse = "\n")
      )
    ),

    # element
    column(
      width = 6,
      eval(parse(text = todo_list2))
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "350px",
        outputId = "todolist2_code",
        readOnly = TRUE,
        value = paste(todo_list2, collapse = "\n")
      )
    )
  ),

  # ##################### #
  # demo timelineBlock()  #
  # ##################### #

  br(),
  column(
    width = 12,
    align = "center",
    h1("timelineBlock()")
  ),
  br(),
  fluidRow(
    # element
    column(
      width = 6,
      eval(parse(text = timeline1))
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "500px",
        outputId = "timelineBlock1_code",
        readOnly = TRUE,
        value = paste(timeline1, collapse = "\n")
      )
    )
  ),
  fluidRow(
    h3("Timeline non reversed: ideal to include oustide of a box"),
    column(
      width = 6,
      # element
      eval(parse(text = timeline2))
    ),
    # code editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "400px",
        outputId = "timelineBlock2_code",
        readOnly = TRUE,
        value = paste(timeline2, collapse = "\n")
      )
    )
  ),

  # ##################### #
  #   demo boxProfile()   #
  # ##################### #

  br(),
  column(
    width = 12,
    align = "center",
    h1("boxProfile()")
  ),
  br(),
  fluidRow(
    # element
    column(
      width = 6,
      eval(parse(text = box_profile))
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "370px",
        outputId = "boxProfile_code",
        readOnly = TRUE,
        value = paste(box_profile, collapse = "\n")
      )
    )
  ),

  # ##################### #
  #   demo userPost()   #
  # ##################### #

  br(),
  column(
    width = 12,
    align = "center",
    h1("userPost()")
  ),
  br(),
  fluidRow(
    # element
    column(
      width = 6,
      eval(parse(text = user_post))
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "500px",
        outputId = "userPost_code",
        readOnly = TRUE,
        value = paste(user_post, collapse = "\n")
      )
    )
  ),


  # ##################### #
  #   demo userMessages()   #
  # ##################### #

  br(),
  column(
    width = 12,
    align = "center",
    h1("userMessages()")
  ),
  br(),
  fluidRow(
    # element
    column(
      width = 6,
      eval(parse(text = user_messages))
    ),
    # ace editor
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "400px",
        outputId = "userMessages_code",
        readOnly = TRUE,
        value = paste(user_messages, collapse = "\n")
      )
    )
  )
)
