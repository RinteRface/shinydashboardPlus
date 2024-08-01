
# shinydashboardPlus

[![R build
status](https://github.com/RinteRface/shinydashboardPlus/workflows/R-CMD-check/badge.svg)](https://github.com/RinteRface/shinydashboardPlus/actions)
[![version](https://www.r-pkg.org/badges/version/shinydashboardPlus)](https://CRAN.R-project.org/package=shinydashboardPlus)
[![cranlogs](https://cranlogs.r-pkg.org/badges/shinydashboardPlus)](https://CRAN.R-project.org/package=shinydashboardPlus)
[![total](https://cranlogs.r-pkg.org/badges/grand-total/shinydashboardPlus)](https://www.rpackages.io/package/shinydashboardPlus)

> extensions for shinydashboard

<div class="card bslib-card bslib-mb-spacing html-fill-item html-fill-container" data-bslib-card-init data-full-screen="false" data-require-bs-caller="card()" data-require-bs-version="5" id="bslib-card-1999" style="margin: 0 auto; float: none;">
<div class="card-body bslib-gap-spacing html-fill-item html-fill-container" style="margin-top:auto;margin-bottom:auto;flex:1 1 auto;">
<iframe class="html-fill-item" src="https://shinylive.io/r/app/#h=0&amp;code=NobwRAdghgtgpmAXGKAHVA6ASmANGAYwHsIAXOMpMAGwEsAjAJykYE8AKAZwAtaJWAlAB0IdJiw48+rACZQe9IixnDRDZmy69+chUsYyACtQCunVSKn8AgugAitRl1adyMDADNa1OOyFg4AA9YVB9Of1wAAlQoAgBrKABzOEiAXkj-K1l5bkVlYzN-AQEwAF8AXSA" height="800" width="100%" style="border: 1px solid rgba(0,0,0,0.175); border-radius: .375rem;" allowfullscreen="" allow="autoplay" data-external="1"></iframe>
</div>
<bslib-tooltip placement="auto" bsOptions="[]" data-require-bs-version="5" data-require-bs-caller="tooltip()">
<template>Expand</template>
<button aria-expanded="false" aria-label="Expand card" class="bslib-full-screen-enter badge rounded-pill"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" style="height:1em;width:1em;fill:currentColor;" aria-hidden="true" role="img"><path d="M20 5C20 4.4 19.6 4 19 4H13C12.4 4 12 3.6 12 3C12 2.4 12.4 2 13 2H21C21.6 2 22 2.4 22 3V11C22 11.6 21.6 12 21 12C20.4 12 20 11.6 20 11V5ZM4 19C4 19.6 4.4 20 5 20H11C11.6 20 12 20.4 12 21C12 21.6 11.6 22 11 22H3C2.4 22 2 21.6 2 21V13C2 12.4 2.4 12 3 12C3.6 12 4 12.4 4 13V19Z"/></svg></button>
</bslib-tooltip>
<script data-bslib-card-init>bslib.Card.initializeAllCards();</script>
</div>

## Installation

``` r
# for the CRAN version
install.packages("shinydashboardPlus")
# for the latest version
devtools::install_github("RinteRface/shinydashboardPlus")
```

<br>

<div style="text-align:center;">

<a href="articles/shinydashboardPlus.html" class="btn btn-outline-secondary btn-lg">Go
to Get Started</a>

</div>

## Motivations

shinydashboardPlus is based on the idea of
[ygdashboard](https://github.com/gyang274/ygdashboard/tree/master/R),
the latter not compatible with shinydashboard (you cannot use
shinydashboard and ygdashboard at the same time). With
shinydashboardPlus you can still work with the shinydashboard classic
functions and enrich your dashboard with all additional functions of
shinydashboardPlus!

## Demo

See a demonstration
[here](https://shinylive.io/r/editor/#h=0&code=NobwRAdghgtgpmAXGKAHVA6ASmANGAYwHsIAXOMpMAGwEsAjAJykYE8AKAZwAtaJWAlAB0IdJiw48+rACZQe9IixnDRDZmy69+chUsYyACtQCunVSKn8AgugAitRl1adyMDADNa1OOyFg4AA9YVB9Of1wAAlQoAgBrKABzOEiAXkj-K1l5bkVlYzN-AQEwAF8AXSA)
or run:

``` r
library(shinydashboardPlus)
shinydashboardPlusGallery()
```

Below an example of application in medicine:

<img src="man/figures/shinydashPlus_demo.png" width="848" height="530">
<br>

<div class="marvel-device ipad black">

<div class="camera">

</div>

<div class="screen">

<iframe width="100%" src="https://dgranjon.shinyapps.io/virtual_patient/" allowfullscreen frameborder="0" scrolling="yes" height="770px">
</iframe>

</div>

<div class="home">

</div>

</div>

## Acknowledgements

- The [adminLTE team](https://adminlte.io)
- [Victor Perrier](https://github.com/pvictor) from
  [Dream’R](https://www.dreamrs.fr)

## Code of Conduct

Please note that the shinydashboardPlus project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
