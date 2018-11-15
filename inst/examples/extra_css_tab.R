extra_css_tab <- tabItem(
  tabName = "extracss",
  
  br(),
  
  column(
    width = 12,
    align = "center",
    h1("Add shadows to any dashboard element: setShadow()")
  ),
  br(),
  
  fluidRow(
    column(
      width = 6,
      setShadow("box"),
      box(
        width = 12,
        background = "light-blue",
        p("This is content. The background color is set to light-blue")
      )
    ),
    
    column(
      width = 6,
      aceEditor(
        theme = "dracula",
        mode = "r",
        height = "100px",
        outputId = "box-shadow_code",
        readOnly = TRUE,
        value = paste(
          style_text(
            'setShadow("box")
             box(
               width = 12,
               background = "light-blue",
               p("This is content. The background color is set to light-blue")
             )'
          ), 
          collapse = "\n"
        )
      )
    )
  )
)