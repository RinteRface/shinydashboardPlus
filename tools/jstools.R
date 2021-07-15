# Packages ----------------------------------------------------------------

library(jstools)
pkg_version <- as.character(utils::packageVersion("shinydashboardPlus"))
# Validate ----------------------------------------------------------------

shinydashboardPlusJS <- list.files(
  path = sprintf("srcjs/shinydashboardPlus-%s", pkg_version),
  recursive = TRUE,
  full.names = TRUE
)

# jshint_file(input = shinydashboardPlusJS, options = jshint_options(jquery = TRUE, globals = list("Shiny", "app")))

outputDir <- sprintf("inst/shinydashboardPlus-%s/js", pkg_version)

# Concat -----------------------------------------------------------------

# This just aggregates all srcjs files into one big .js file. There is no minifications, ... See next step for terser
system(sprintf("cat %s > %s/shinydashboardPlus.js", paste(shinydashboardPlusJS, collapse = " "), outputDir))

# Concat + Compress + source maps ----------------------------------------------------------------

terser_file(
  input = shinydashboardPlusJS,
  output = sprintf("%s/shinydashboardPlus.min.js", outputDir),
  options = terser_options(
    sourceMap = list(
      root = "../../shinydashboardPlus-build",
      filename = "shinydashboardPlus.min.js",
      url = "shinydashboardPlus.min.js.map",
      includeSources = TRUE
    )
  )
)