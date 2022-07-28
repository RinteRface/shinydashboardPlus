user_messages <- 'box(
  width = 12,
  title = "Box with messages",
  solidheader = TRUE,
  status = "warning",
  userMessages(
    width = 12,
    status = "success",
    userMessage(
      author = "Alexander Pierce",
      date = "20 Jan 2:00 pm",
      image = "https://adminlte.io/themes/AdminLTE/dist/img/user1-128x128.jpg",
      type = "received",
      "Is this template really for free? That iss unbelievable!"
    ),
    userMessage(
      author = "Sarah Bullock",
      date = "23 Jan 2:05 pm",
      image = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
      type = "sent",
      "You better believe it!"
    )
  )
)'
