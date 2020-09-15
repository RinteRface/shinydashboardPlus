adminLTEToggle <- function(inputId) {
  tags$div(
    class = "btn-group",
    `data-toggle` = "btn-toggle",
    tags$button(
      type = "button",
      class = "btn btn-default btn-sm active",
      tags$i(class = "fa fa-square text-green")
    ),
    tags$button(
      type = "button",
      class = "btn btn-default btn-sm",
      tags$i(class = "fa fa-square text-red")
    )
  )
}