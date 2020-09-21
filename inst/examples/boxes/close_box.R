close_box <- 'box(
  title = "Closable Box with dropdown", 
  closable = TRUE,
  width = 12,
  status = "warning", 
  solidHeader = FALSE, 
  collapsible = TRUE,
  dropdownMenu = boxDropdown(
    boxDropdownItem("Link to google", href = "https://www.google.com"),
    boxDropdownItem( "item 2"),
    dropdownDivider(),
    boxDropdownItem("item 3")
  ),
  p("Box Content")
)'