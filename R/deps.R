# Add an html dependency, without overwriting existing ones
appendDependencies <- function(x, value) {
  if (inherits(value, "html_dependency"))
    value <- list(value)
  
  old <- attr(x, "html_dependencies", TRUE)
  
  htmltools::htmlDependencies(x) <- c(old, value)
  x
}

# Add dashboard dependencies to a tag object
addDeps <- function(x, md) {
  
  # always use minified files (https://www.minifier.org)
  adminLTE_js <- "js/app.min.js"
  custom_js <- "js/custom.js"
  shinydashboard_js <- "shinydashboard.js"
  adminLTE_css <- c("css/AdminLTE.min.css", "css/_all-skins.min.css")
  
  # material design deps
  if (md) {
    # CSS
    md_bootstrap_css <- "css/bootstrap-material-design.min.css"
    ripples_css <- "css/ripples.min.css"
    md_adminLTE_css <- "css/MaterialAdminLTE.min.css"
    md_skins_css <- "css/all-md-skins.min.css"
    # JS
    md_js <- "js/material.min.js"
    ripples_js <- "js/ripples.min.js"
    md_init_js <- "js/init.js"
  }
  
  dashboardDeps <- list(
    # custom adminLTE js and css for shinydashboardPlus
    htmltools::htmlDependency(
      "shinydashboardPlus",
      as.character(utils::packageVersion("shinydashboardPlus")),
      c(file = system.file("shinydashboardPlus-0.6.0", package = "shinydashboardPlus")),
      script = c(adminLTE_js, custom_js),
      stylesheet = adminLTE_css
    ),
    # shinydashboard css and js deps
    htmltools::htmlDependency(
      "shinydashboard",
      as.character(utils::packageVersion("shinydashboard")),
      c(file = system.file(package = "shinydashboard")),
      script = shinydashboard_js,
      stylesheet = "shinydashboard.css"
    ),
    # material design deps
    if (md) {
      htmltools::htmlDependency(
        "materialDesign",
        as.character(utils::packageVersion("shinydashboardPlus")),
        c(file = system.file("materialDesign-1.0", package = "shinydashboardPlus")),
        script = c(md_js, ripples_js, md_init_js),
        stylesheet = c(md_bootstrap_css, ripples_css, md_adminLTE_css, md_skins_css)
      )
    }
  )
  
  appendDependencies(x, dashboardDeps)
}