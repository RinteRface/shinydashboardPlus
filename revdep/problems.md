# discoveR

<details>

* Version: 2.1.7
* Source code: https://github.com/cran/discoveR
* URL: https://www.promidat.com
* Date/Publication: 2021-01-27 22:10:09 UTC
* Number of recursive dependencies: 131

Run `revdep_details(,"discoveR")` for more info

</details>

## Newly broken

*   checking whether package 'discoveR' can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: replacing previous import 'shinydashboard::dashboardPage' by 'shinydashboardPlus::dashboardPage' when loading 'discoveR'
      Warning: replacing previous import 'shinydashboard::dashboardSidebar' by 'shinydashboardPlus::dashboardSidebar' when loading 'discoveR'
      Warning: replacing previous import 'shinydashboard::box' by 'shinydashboardPlus::box' when loading 'discoveR'
      Warning: replacing previous import 'shinydashboard::dashboardHeader' by 'shinydashboardPlus::dashboardHeader' when loading 'discoveR'
      Warning: replacing previous import 'shinydashboard::taskItem' by 'shinydashboardPlus::taskItem' when loading 'discoveR'
      Warning: replacing previous import 'shinydashboard::notificationItem' by 'shinydashboardPlus::notificationItem' when loading 'discoveR'
      Warning: replacing previous import 'shinydashboard::messageItem' by 'shinydashboardPlus::messageItem' when loading 'discoveR'
    See '/Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/checks.noindex/discoveR/new/discoveR.Rcheck/00install.out' for details.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Missing or unexported object: ‘shinydashboardPlus::dashboardPagePlus’
    ```

# Distributacalcul

<details>

* Version: 0.3.0
* Source code: https://github.com/cran/Distributacalcul
* URL: https://alec42.github.io/Distributacalcul_Package/
* BugReports: https://github.com/alec42/Distributacalcul_Package/issues
* Date/Publication: 2020-09-11 12:00:02 UTC
* Number of recursive dependencies: 106

Run `revdep_details(,"Distributacalcul")` for more info

</details>

## Newly broken

*   checking dependencies in R code ... NOTE
    ```
    Missing or unexported objects:
      ‘shinydashboardPlus::boxPlus’
      ‘shinydashboardPlus::dashboardHeaderPlus’
      ‘shinydashboardPlus::dashboardPagePlus’
    ```

# LDAShiny

<details>

* Version: 0.9.2
* Source code: https://github.com/cran/LDAShiny
* BugReports: https://github.com/JavierDeLaHoz/LDAShiny/issues
* Date/Publication: 2021-02-05 08:40:03 UTC
* Number of recursive dependencies: 147

Run `revdep_details(,"LDAShiny")` for more info

</details>

## Newly broken

*   checking whether package 'LDAShiny' can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: replacing previous import 'shinydashboard::dashboardPage' by 'shinydashboardPlus::dashboardPage' when loading 'LDAShiny'
      Warning: replacing previous import 'shinydashboard::dashboardSidebar' by 'shinydashboardPlus::dashboardSidebar' when loading 'LDAShiny'
      Warning: replacing previous import 'shinydashboard::box' by 'shinydashboardPlus::box' when loading 'LDAShiny'
      Warning: replacing previous import 'shinydashboard::dashboardHeader' by 'shinydashboardPlus::dashboardHeader' when loading 'LDAShiny'
      Warning: replacing previous import 'shinydashboard::taskItem' by 'shinydashboardPlus::taskItem' when loading 'LDAShiny'
      Warning: replacing previous import 'shinydashboard::notificationItem' by 'shinydashboardPlus::notificationItem' when loading 'LDAShiny'
      Warning: replacing previous import 'shinydashboard::messageItem' by 'shinydashboardPlus::messageItem' when loading 'LDAShiny'
    See '/Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/checks.noindex/LDAShiny/new/LDAShiny.Rcheck/00install.out' for details.
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘DT’ ‘SnowballC’ ‘beepr’ ‘broom’ ‘chinese.misc’ ‘dplyr’ ‘highcharter’
      ‘htmlwidgets’ ‘ldatuning’ ‘parallel’ ‘plotly’ ‘purrr’ ‘quanteda’
      ‘shinyBS’ ‘shinyWidgets’ ‘shinyalert’ ‘shinycssloaders’ ‘shinyjs’
      ‘stringr’ ‘textmineR’ ‘tidyr’ ‘tidytext’ ‘topicmodels’
      All declared Imports should be used.
    ```

# modchart

<details>

* Version: 0.4
* Source code: https://github.com/cran/modchart
* Date/Publication: 2020-07-13 10:00:03 UTC
* Number of recursive dependencies: 117

Run `revdep_details(,"modchart")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    + 				callModule(chart, 'server', g)
    + 				chartUI('server', g)
    + 				}
    + 			})
    + 		output$sidemenu<- renderMenu({
    + 			m1<- menuItem( "Upload Excel", menuSubItem("Excel", tabName="xltab"))
    + 			m2<- menuItem( "Create Chart", menuSubItem("Chart", tabName="charttab"))
    + 			sidebarMenu(m1,m2)
    + 			})
    + 
    + 		output$mainbody<- renderUI({
    + 			t1<- list(); t1[[1]]<- tabItem(tabName="xltab", uiOutput("xl"))
    + 			t2<- list(); t2[[1]]<- tabItem(tabName="charttab", uiOutput("charts"))
    + 			do.call(tabItems, c(t1,t2))
    + 			})
    + 		})
    + 	)
    Error in dashboardPagePlus(skin = "purple", sidebar_fullCollapse = TRUE,  : 
      could not find function "dashboardPagePlus"
    Calls: shinyApp -> uiHttpHandler -> force -> shinyUI
    Execution halted
    ```

*   checking whether package 'modchart' can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: replacing previous import 'shinydashboard::dashboardPage' by 'shinydashboardPlus::dashboardPage' when loading 'modchart'
      Warning: replacing previous import 'shinydashboard::dashboardSidebar' by 'shinydashboardPlus::dashboardSidebar' when loading 'modchart'
      Warning: replacing previous import 'shinydashboard::box' by 'shinydashboardPlus::box' when loading 'modchart'
      Warning: replacing previous import 'shinydashboard::dashboardHeader' by 'shinydashboardPlus::dashboardHeader' when loading 'modchart'
      Warning: replacing previous import 'shinydashboard::taskItem' by 'shinydashboardPlus::taskItem' when loading 'modchart'
      Warning: replacing previous import 'shinyWidgets::progressBar' by 'shinydashboardPlus::progressBar' when loading 'modchart'
      Warning: replacing previous import 'shinydashboard::notificationItem' by 'shinydashboardPlus::notificationItem' when loading 'modchart'
      Warning: replacing previous import 'shinydashboard::messageItem' by 'shinydashboardPlus::messageItem' when loading 'modchart'
    See '/Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/checks.noindex/modchart/new/modchart.Rcheck/00install.out' for details.
    ```

*   checking R code for possible problems ... NOTE
    ```
    ctreeUI: no visible global function definition for ‘boxPlus’
    dtblUI: no visible global function definition for ‘boxPlus’
    dygUI: no visible global function definition for ‘boxPlus’
    mapUI: no visible global function definition for ‘boxPlus’
    plotlyUI: no visible global function definition for ‘boxPlus’
    skyUI: no visible global function definition for ‘boxPlus’
    sunbUI: no visible global function definition for ‘boxPlus’
    treeUI: no visible global function definition for ‘boxPlus’
    Undefined global functions or variables:
      boxPlus
    ```

## In both

*   checking installed package size ... NOTE
    ```
      installed size is  6.7Mb
      sub-directories of 1Mb or more:
        R         2.0Mb
        extdata   4.6Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      ‘lubridate’ ‘xts’
      All declared Imports should be used.
    ```

# periscope

<details>

* Version: 0.5.4
* Source code: https://github.com/cran/periscope
* URL: https://github.com/cb4ds/periscope, http://periscopeapps.org:3838, https://www.canvasxpress.org
* BugReports: https://github.com/cb4ds/periscope/issues
* Date/Publication: 2021-01-12 09:40:10 UTC
* Number of recursive dependencies: 89

Run `revdep_details(,"periscope")` for more info

</details>

## Newly broken

*   checking package dependencies ... ERROR
    ```
    Package required and available but unsuitable version: 'shinydashboardPlus'
    
    See section 'The DESCRIPTION file' in the 'Writing R Extensions'
    manual.
    ```

# polished

<details>

* Version: 0.2.0
* Source code: https://github.com/cran/polished
* URL: https://github.com/tychobra/polished, https://polished.tech
* BugReports: https://github.com/tychobra/polished/issues
* Date/Publication: 2020-09-29 06:50:02 UTC
* Number of recursive dependencies: 71

Run `revdep_details(,"polished")` for more info

</details>

## Newly broken

*   checking whether package 'polished' can be installed ... ERROR
    ```
    Installation failed.
    See '/Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/checks.noindex/polished/new/polished.Rcheck/00install.out' for details.
    ```

## Installation

### Devel

```
Using libraries at paths:
- /Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/library.noindex/shinydashboardPlus/new
- /Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/library.noindex/polished
- /Library/Frameworks/R.framework/Versions/3.6/Resources/library
Working for open source
* installing *source* package 'polished' ...
** package 'polished' successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
Using libraries at paths:
- /Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/library.noindex/shinydashboardPlus/new
- /Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/library.noindex/polished
- /Library/Frameworks/R.framework/Versions/3.6/Resources/library
Working for open source
Error: object 'dashboardHeaderPlus' is not exported by 'namespace:shinydashboardPlus'
Execution halted
ERROR: lazy loading failed for package 'polished'
* removing '/Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/checks.noindex/polished/new/polished.Rcheck/polished'

```
### CRAN

```
Using libraries at paths:
- /Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/library.noindex/shinydashboardPlus/old
- /Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/library.noindex/polished
- /Library/Frameworks/R.framework/Versions/3.6/Resources/library
Working for open source
* installing *source* package 'polished' ...
** package 'polished' successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
Using libraries at paths:
- /Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/library.noindex/shinydashboardPlus/old
- /Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/library.noindex/polished
- /Library/Frameworks/R.framework/Versions/3.6/Resources/library
Working for open source
** help
*** installing help indices
** building package indices
** installing vignettes
** testing if installed package can be loaded from temporary location
Using libraries at paths:
- /Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/library.noindex/shinydashboardPlus/old
- /Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/library.noindex/polished
- /Library/Frameworks/R.framework/Versions/3.6/Resources/library
Working for open source
** testing if installed package can be loaded from final location
Using libraries at paths:
- /Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/library.noindex/shinydashboardPlus/old
- /Users/granjda1/Documents/RinteRface/shinydashboardPlus/revdep/library.noindex/polished
- /Library/Frameworks/R.framework/Versions/3.6/Resources/library
Working for open source
** testing if installed package keeps a record of temporary installation path
* DONE (polished)

```
# shinyWidgets

<details>

* Version: 0.5.7
* Source code: https://github.com/cran/shinyWidgets
* URL: https://github.com/dreamRs/shinyWidgets
* BugReports: https://github.com/dreamRs/shinyWidgets/issues
* Date/Publication: 2021-02-03 17:40:03 UTC
* Number of recursive dependencies: 92

Run `revdep_details(,"shinyWidgets")` for more info

</details>

## Newly broken

*   checking dependencies in R code ... NOTE
    ```
    Missing or unexported objects:
      ‘shinydashboardPlus::dashboardHeaderPlus’
      ‘shinydashboardPlus::dashboardPagePlus’
    ```

