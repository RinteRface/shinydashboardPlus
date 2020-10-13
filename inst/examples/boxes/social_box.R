social_box <- 'socialBox(
  title = "Social Box",
  width = 12,
  subtitle = "example-01.05.2018",
  image = "https://adminlte.io/themes/AdminLTE/dist/img/user4-128x128.jpg",
  "Some text here!",
  attachmentBlock(
    image = "https://adminlte.io/themes/AdminLTE/dist/img/photo1.png",
    title = "Test",
    href = "https://google.com",
    "This is the content"
  ),
  comments = tagList(
    lapply(3:5, function(i) {
      boxComment(
        image = sprintf("https://adminlte.io/themes/AdminLTE/dist/img/user%s-128x128.jpg", i),
        title = sprintf("Comment %s", i),
        date = "01.05.2018",
        "The first comment"
      )
    })
  ),
  footer = "The footer here!"
)'