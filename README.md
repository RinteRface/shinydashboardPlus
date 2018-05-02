# shinydashboardPlus
extensions for shinydashboard.

## Installation

```
devtools::install_github("DivadNojnarg/shinydashboardPlus")
```

## Motivations

shinydashboardPlus is based on the idea of [ygdashboard](https://github.com/gyang274/ygdashboard/tree/master/R), 
the later not compatible with shinydashboard (you cannot use shinydashboard and ygdashboard at the same time),
and not updated. With shinydashboardPlus you can still work with the shinydashboard classic functions!
At any moment you can switch to shinydashboardPlus. 

## Main features

### The rightSidebar()

The most interesting feature of this package is the **rightSidebar**. This concept was
not implemented (in R) in ygdashboard (pure HTML), that's why I translated 
the corresponding HTML code to R. To use it, you will have to replace **dashboardPage**
by **dashboardPagePlus** and **dashboardHeader** by **dashboardHeaderPlus**. Creating this
two additional functions let you choose whether you want to use this extra sidebar or not.


```
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
shinyApp(
  ui = dashboardPagePlus(
    header = dashboardHeaderPlus(
     enable_rightsidebar = TRUE,
     rightSidebarIcon = "gears"
    ),
    sidebar = dashboardSidebar(),
    body = dashboardBody(),
    rightsidebar = rightSidebar(),
    title = "DashboardPage"
  ),
  server = function(input, output) { }
)
```

The rightSidebar function takes the following arguments:

- background: you can display it either in light or dark mode
- rightSidebarTabList() will create a menu for your tabPanels. Populate it with
rightSidebarTabItem(), with a **unique id** and icons
- rightSidebarPanel is the body of your panels. Fill it with rightSidebarTabContent(),
which id should be the same as in the rightSidebarTabItem(). You can include inputs,
text or custom HTML elements.
- in the **dashboardHeaderPlus()** function, you can customize the sidebar trigger.

```
rightSidebar(
 background = "dark",
  rightSidebarTabList(
   rightSidebarTabItem(
    id = 1,
    icon = "desktop"
   ),
   rightSidebarTabItem(
    id = 2
   ),
   rightSidebarTabItem(
    id = 3,
    icon = "paint-brush"
   )
  ),
  rigthSidebarPanel(
   rightSidebarTabContent(
    id = 1,
    title = "Tab 1",
    sliderInput(
     "obs", 
     "Number of observations:",
      min = 0, max = 1000, value = 500
     )
   ),
   rightSidebarTabContent(
    id = 2,
    title = "Tab 2",
    textInput("caption", "Caption", "Data Summary")
   ),
   rightSidebarTabContent(
    id = 3,
    title = "Tab 3",
    numericInput("obs", "Observations:", 10, min = 1, max = 100)
   )
  )
)
```

## Other components

Coming soon, see the demo

## Demo

See a demonstration [here](http://130.60.24.205/shinydashboardPlus/)
or run 
```
shinydashboardPlusGallery()
```