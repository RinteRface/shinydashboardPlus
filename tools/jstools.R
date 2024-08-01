# Packages ----------------------------------------------------------------

library(jstools)
devtools::install()
pkg_version <- as.character(utils::packageVersion("shinydashboardPlus"))

# Rename srcjs folder in case pkg version changes
tmp_old_version <- list.dirs("srcjs", full.names = FALSE, recursive = FALSE)
old_version <- strsplit(tmp_old_version, "-")[[1]][2]
new_srcjs_folder_name <- sprintf("srcjs/shinydashboardPlus-%s", pkg_version)

if (old_version != pkg_version) {
  file.rename(
    file.path("srcjs", tmp_old_version),
    new_srcjs_folder_name
  )
}
# Validate ----------------------------------------------------------------

shinydashboardPlusJS <- list.files(
  path = new_srcjs_folder_name,
  recursive = TRUE,
  full.names = TRUE
)

# jshint_file(input = shinydashboardPlusJS, options = jshint_options(jquery = TRUE, globals = list("Shiny", "app")))
outputDir <- sprintf("inst/shinydashboardPlus-%s", pkg_version)
if (!dir.exists(outputDir)) dir.create(outputDir)

jsDir <- sprintf("%s/js", outputDir)
cssDir <- sprintf("%s/css", outputDir)
if (!dir.exists(jsDir)) {
  dir.create(jsDir)
  dir.create(cssDir)
}

# Concat -----------------------------------------------------------------

# This just aggregates all srcjs files into one big .js file. There is no minifications, ... See next step for terser
system(sprintf("cat %s > %s/shinydashboardPlus.js", paste(shinydashboardPlusJS, collapse = " "), jsDir))

# Concat + Compress + source maps ----------------------------------------------------------------

terser_file(
  input = shinydashboardPlusJS,
  output = sprintf("%s/shinydashboardPlus.min.js", jsDir),
  options = terser_options(
    sourceMap = list(
      root = "../../shinydashboardPlus-build",
      filename = "shinydashboardPlus.min.js",
      url = "shinydashboardPlus.min.js.map",
      includeSources = TRUE
    )
  )
)
