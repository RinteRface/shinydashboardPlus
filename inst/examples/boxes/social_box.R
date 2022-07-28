social_box <- 'socialBox(
  width = 12,
  title = userBlock(
    image = "https://adminlte.io/themes/AdminLTE/dist/img/user4-128x128.jpg",
    title = "Social Box",
    subtitle = "example-01.05.2018"
  ),
  "Some text here!",
  attachmentBlock(
    image = "https://adminlte.io/themes/AdminLTE/dist/img/photo1.png",
    title = "Test",
    href = "https://google.com",
    "This is the content"
  ),
  lapply(X = 1:10, FUN = function(i) {
    boxComment(
      image = "https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg",
      title = paste("Comment", i),
      date = "01.05.2018",
      paste0("The ", i, "-th comment")
    )
  }),
  footer = "The footer here!"
)'
