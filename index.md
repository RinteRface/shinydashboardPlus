# shinydashboardPlus

[![R build status](https://github.com/RinteRface/shinydashboardPlus/workflows/R-CMD-check/badge.svg)](https://github.com/RinteRface/shinydashboardPlus/actions)
[![version](https://www.r-pkg.org/badges/version/shinydashboardPlus)](https://CRAN.R-project.org/package=shinydashboardPlus)
[![cranlogs](https://cranlogs.r-pkg.org/badges/shinydashboardPlus)](https://CRAN.R-project.org/package=shinydashboardPlus)
[![total](https://cranlogs.r-pkg.org/badges/grand-total/shinydashboardPlus)](https://www.rpackages.io/package/shinydashboardPlus)

> extensions for shinydashboard

```{r, eval=TRUE, echo=FALSE}
card(
  shiny::tags$iframe(
    class = "html-fill-item", 
    src = "https://shinylive.io/r/app/#h=0&code=NobwRAdghgtgpmAXGKAHVA6ASmANGAYwHsIAXOMpMAGwEsAjAJykYE8AKAZwAtaJWAlAB0IdJiw48+rACZQe9IixnDRDZmy69+chUsYyACtQCunVSKn8AgugAitRl1adyMDADNa1OOyFg4AA9YVB9Of1wAAlQoAgBrKABzOEiAXkj-K1l5bkVlYzN-AQEwAF8AXSA", 
    height = "800", 
    width = "100%", 
    style = "border: 1px solid rgba(0,0,0,0.175); border-radius: .375rem;", 
    allowfullscreen = "", 
    allow = "autoplay", 
    `data-external` = "1"
  ),
  full_screen = TRUE,
  style = "margin: 0 auto; float: none;"
)
```

## Installation

```r
# for the CRAN version
install.packages("shinydashboardPlus")
# for the latest version
devtools::install_github("RinteRface/shinydashboardPlus")
```

<br>

 <div style="text-align:center;"><a href="articles/shinydashboardPlus.html" class="btn btn-outline-secondary btn-lg">Go to Get Started</a></div>

## Motivations

shinydashboardPlus is based on the idea of [ygdashboard](https://github.com/gyang274/ygdashboard/tree/master/R), 
the latter not compatible with shinydashboard (you cannot use shinydashboard and ygdashboard at the same time). With shinydashboardPlus you can still work with the shinydashboard classic functions and enrich
your dashboard with all additional functions of shinydashboardPlus!

## Demo

See a demonstration [here](https://dgranjon.shinyapps.io/shinydashboardPlusDemo)
or run:
```r
library(shinydashboardPlus)
shinydashboardPlusGallery()
```

Below an example of application in medicine:

<img src="man/figures/shinydashPlus_demo.png" width="848" height="530">
<br>

<div class="marvel-device ipad black">
<div class="camera"></div>
<div class="screen">
<iframe width="100%" src="https://dgranjon.shinyapps.io/virtual_patient/" allowfullscreen="" frameborder="0" scrolling="yes" height="770px"></iframe>
</div>
<div class="home"></div>
</div>

## Acknowledgements

- The [adminLTE team](https://adminlte.io)
- [Victor Perrier](https://github.com/pvictor) from [Dream'R](https://www.dreamrs.fr)


## Code of Conduct
  
  Please note that the shinydashboardPlus project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.