## Test environments
* local OS X install, R 3.4.4
* ubuntu 14.04 (on travis-ci), R 3.5.0 (2017-01-27)
* Windows (via devtools::build_win(), R-devel)

[![Build Status](https://travis-ci.org/DivadNojnarg/shinydashboardPlus.svg?branch=master)](https://travis-ci.org/DivadNojnarg/shinydashboardPlus)

## R CMD check results
There were no ERRORs or WARNINGs or NOTEs


## Reverse dependencies:
using `devtools::revdep()` and R CMD check shinyWidgets

I made a [pull request](https://github.com/dreamRs/shinyWidgets/commit/186a0306371a6bb2bc60ed1e4247640de7b8f8f5) 
so that shinyWidgets is ready for the next version of shinydashboardPlus and
the check was successfull for shinyWidget, there were no ERRORs or WARNINGs or NOTES

## Resubmission
I fixed previous NOTES:
- regarding the _pkgdown.yml file
- cross reference with shinydashboard in the documentation

According to Uwe Ligges comments:

- I added an external link to the AdminLTE2 library in the description file
- I changed http to https in my links in the readme.md 