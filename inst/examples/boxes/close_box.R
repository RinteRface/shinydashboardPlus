close_box <- 'boxPlus(
  title = "Closable Box with dropdown", 
  closable = TRUE, 
  width = NULL,
  status = "warning", 
  solidHeader = FALSE, 
  collapsible = TRUE,
  enable_dropdown = TRUE,
  dropdown_icon = "wrench",
  dropdown_menu = dropdownItemList(
    dropdownItem(url = "http://www.google.com", name = "Link to google"),
    dropdownItem(url = "#", name = "item 2"),
    dropdownDivider(),
    dropdownItem(url = "#", name = "item 3")
  ),
  p("Box Content")
)'