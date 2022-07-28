todo_list1 <- 'box(
  "Sortable todo list demo",
  status = "warning",
  width = 12,
  todoList(
    todoListItem(
      label = "Design a nice theme",
      "Some text here"
    ),
    todoListItem(
      label = "Make the theme responsive",
      "Some text here"
    ),
    todoListItem(
      checked = TRUE,
      label = "Let theme shine like a star"
    )
  )
)'


todo_list2 <- 'box(
  "Simple todo list demo",
  status = "warning",
  width = NULL,
  todoList(
    sortable = FALSE,
    todoListItem(
      label = "Design a nice theme",
      "Some text here"
    ),
    todoListItem(
      label = "Make the theme responsive",
      "Some text here"
    ),
    todoListItem(
      checked = TRUE,
      label = "Let theme shine like a star"
    )
  )
)'
