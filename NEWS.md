# shinydashboardPlus 0.7.0
## Breaking Changes
- remove all CSS functions, namely `setShadow()`, `setPulse()`, `setShake()` and
`setZoom()`, since they are contained in [shinyEffects](https://github.com/RinteRface/shinyEffects)

## New features
- 6 new color statuses for `boxPlus()` headers: navy, teal, orange, maroon, black and purple 
- add new argument .items to `rightSidebar()`: useful if we do not want to 
embed elements in tabs. 
- add `dashboardFooter()`
- add `dashboardUser()`, `dashboardUserItem()`, `renderUser()` and `userOutput()`
- add `carousel()` and `carouselItem()`
- new argument to dashboardPagePlus: sidebar_fullCollapse enable the
sidebar to be fully collapsed as in shinydashboard. Fix #24, thanks @serkserk
- by default, opening the right sidebar shifts the body content to the left,
similarly as the left sidebar

## major changes
- shindashboardPlus is now moved on [RinteRface](https://github.com/RinteRface/shinydashboardPlus)

## Minor changes
- new hex icons
- update gallery
- update vignettes (RinteRface)

## Fixes
- fix issue when the `dashboardHeaderPlus()` title was NULL
- fix #22 thanks to @trallard (missing licence)

# shinydashboardPlus 0.6.0
## New features
- add new `flipBox()`
- new sidebar in the `boxPlus()` function: set up with the following arguments
"enable_sidebar", "sidebar_content", "sidebar_width", "sidebar_background" and
"sidebar_start_open"
- new "left_menu" argument in the `dashboardHeaderPlus()` to include elements
in the left part of the navbar. (In addition to what you can already do in the
right part with shinydashboard)
- new `dropdownBlock()` to include shiny input elements in a navbar left menu 
(optimized for all screen sizes)
- new "fixed" argument to the navbar (`dashboardHeaderPlus()`). 
If TRUE, the navbar is fixed-top. (static-top by default)
- new `setZoom()` function (similar as `setShadow()`)
- new `setPulse()` function
- new `setShake()` function
- add "enable_preloader" and "loading_duration" to `dashboardPagePlus()` (custom preloader)
- update the `shinydashboardPlusGallery()`
- add a "style" argument to `dashboardLabel()`
- change the website images
- add "collapsed argument" to `userPost()` to show or hide comments when the
application starts.
## Bug fixes
- now `appButton()` open a new window when clicked
- now `socialButton()` open a new window when clicked
- do not show comments when there are no comments in `socialBox()`
- do not show the footer when it is NULL in `socialBox()`
- add style overflow-y auto to `socialBox()` in case there are more than 2 comments (avoid "infinite" height boxes)
- on mobiles (or small screens), navbar left menu items display inline, instead of column...
- disable `timelineItem()` footer when NULL
- center images in `userPostMedia()`
- fix #8 thanks to @scottyraymond (`dropdownBlock()` icon not displaying)


# shinydashboardPlus 0.5.0
## Bug fixes
- Fix an important issue in the `rightSidebar()`. When the function was called without
any element, it triggered an error because the number of items was 0
- clicking on `starBlock()`, `navPillsItem()` and the `socialBlock()` title does not reload 
or redirect at the top of the page
- clicking on the `attachmentBlock()` link open a new page in a new tab (target = "_blank")
- correct vignettes title (https://cran.r-project.org/package=shinydashboardPlus)
## Breaking changes
- change argument name in `dropdownItem()` (`boxPlus()`): "target" is replaced by "url".
- Widely simplify the `rightSidebar()` function: remove `rightSidebarTabList()`, `rightSidebarTabItem()` and
`rightSidebarPanel()` from the user interface. See [here](https://rinterface.github.io/shinydashboardPlus/articles/rightSidebar.html) to discover how to set up 
a new `rightSidebar()`
## Major changes
- add a "width" argument to the `rightSidebar()` (set to 230 pixels by default) to 
improve customization. 
- new function `setShadow()` to set shadow and hover effects on any elements
- add an "active" argument to `rightSidebarTabContent()`: see [#4](https://github.com/RinteRface/shinydashboardPlus/issues/4)
- add a "sidebar_background" argument to `dashboardPagePlus()`
- new `verticalProgress()` bars!
- new functions in the `rightSidebar()`: `rightSidebarMenu()`, `rightSidebarMenuItem()`, `menuIcon()`
and `menuInfo()` (see `shinydashboardPlusGallery()`)
- new dropdown menu for `boxPlus()`: add `dropdownItemList()`, `dropdownItem()` and `dropdownDivider()` functions (see          `shinydashboardPlusGallery()`)
- add "width" and "height" args to `timelineItemMedia()` and `userPostMedia()`
- remove useless content
## New Side content
- add a pkgdown website
- add cran downloads to readme


# shinydashboardPlus 0.2.0
- new timelines: `timeLineBlock()` either inside or outside a box
- new userPost function: `userPostToolItemList()`, `userPostToolItem()`, `userPostMedia()`, 
`userPostToolItem()` 
- new boxProfile function: `boxProfileItemList()`, `boxProfileItem()`
- update `shinydashboardPlusGallery()`
- add `shinydashboardPlusGallery()`
- update all examples 
- some minor fixes
- NOTE: mailForm is not working at the moment!


# shinydashboardPlus 0.1.0
- new right sidebar: `rightSidebar()`
- improved classic boxes: `boxPlus()`
- new boxes: `gradientBox()`, `widgetUserBox()`, `socialBox()`
- new box elements: `boxPad()`, `attachmentBlock()`, `descriptionBlock()`, `productList()`,
`navPills()`, `todoList()`, `userList()`, `boxComment()`
- new buttons: `appButton()` and `socialButton()` (NOTE: these are not inputButtons!)
- additional elements: `starBlock()`, `loadingState()`, `blockQuote()`, `dashboardLabel()`
- switch between shinydashboard and shinydashboardPlus: `dashboardHeaderPlus()`,
`dashboardPagePlus()`