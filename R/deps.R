# Add dashboard dependencies to a tag object
addDeps <- function(tag, md, options) {
  
  # always use minified files (https://www.minifier.org)
  adminLTE_js <- if (getOption("shiny.minified", TRUE)) {
    "js/app.min.js"
  } else {
    "js/app.js"
  }
  shinydashboardPlus_js <- if (getOption("shiny.minified", TRUE)) {
    "js/shinydashboardPlus.min.js"
  } else {
    "js/shinydashboardPlus.js"
  }
  adminLTE_css <- c("css/AdminLTE.min.css", "css/_all-skins.min.css")
  custom_css <- ("css/custom.css")
  
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
  
  pkg_version <- as.character(utils::packageVersion("shinydashboardPlus"))
  
  dashboardDeps <- list(
    # additional options (this needs to be loaded before shinydashboardPlus deps)
    htmltools::htmlDependency(
      "options",
      pkg_version,
      src = c(file = system.file(sprintf("shinydashboardPlus-%s", pkg_version), package = "shinydashboardPlus")),
      head = if (!is.null(options)) {
        paste0(
          "<script>var AdminLTEOptions = ", 
          jsonlite::toJSON(
            options, 
            auto_unbox = TRUE,
            pretty = TRUE
          ),
          ";</script>"
        )
      }
    ),
    # custom adminLTE js and css for shinydashboardPlus
    htmltools::htmlDependency(
      "shinydashboardPlus",
      pkg_version,
      c(file = system.file(sprintf("shinydashboardPlus-%s", pkg_version), package = "shinydashboardPlus")),
      script = c(adminLTE_js, shinydashboardPlus_js),
      stylesheet = c(adminLTE_css, custom_css)
    ),
    # shinydashboard css and js deps
    htmltools::htmlDependency(
      "shinydashboard",
      pkg_version,
      c(file = system.file(package = "shinydashboard")),
      stylesheet = "shinydashboard.css"
    ),
    # material design deps
    if (md) {
      htmltools::htmlDependency(
        "materialDesign",
        pkg_version,
        c(file = system.file("materialDesign-1.0", package = "shinydashboardPlus")),
        script = c(md_js, ripples_js, md_init_js),
        stylesheet = c(md_bootstrap_css, ripples_css, md_adminLTE_css, md_skins_css)
      )
    }
  )
  
  shiny::tagList(tag, dashboardDeps)
}