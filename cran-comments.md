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
- this is a fix for the 0.3.0 release. The function rightSidebar was not working 
when no argument was provided.  