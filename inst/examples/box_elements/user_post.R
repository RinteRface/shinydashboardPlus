user_post <- 'box(
  title = "Box with user comment",
  status = "primary",
  width = 12,
  userPost(
    id = 1,
    image = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
    author = "Jonathan Burke Jr.",
    description = "Shared publicly - 7:30 PM today",
    collapsible = FALSE,
    "Lorem ipsum represents a long-held tradition for designers, 
    typographers and the like. Some people hate it and argue for 
    its demise, but others ignore the hate as they create awesome 
    tools to help create filler text for everyone from bacon 
    lovers to Charlie Sheen fans.",
    userPostTagItems(
      userPostTagItem(dashboardLabel("item 1", status = "primary")),
      userPostTagItem(dashboardLabel("item 2", status = "danger"), side = "right")
    )
  ),
  userPost(
    id = 2,
    image = "https://adminlte.io/themes/AdminLTE/dist/img/user6-128x128.jpg",
    author = "Adam Jones",
    description = "Shared publicly - 5 days ago",
    userPostMedia(image = "https://adminlte.io/themes/AdminLTE/dist/img/photo2.png"),
    userPostTagItems(
      userPostTagItem(dashboardLabel("item 1", status = "warning")),
      userPostTagItem(dashboardLabel("item 2", status = "danger"), side = "right")
    )
  )
)'