# shinydashboardPlus 0.3.0.9000
## Breaking changes
- change argument name in `dropdownItem()` (`boxPlus()`): "target" is replaced by "url".
- Widely simplify the `rightSidebar()` function: remove `rightSidebarTabList()`, `rightSidebarTabItem()` and
`rightSidebarPanel()` from the user interface. See [here](https://divadnojnarg.github.io/shinydashboardPlus/articles/rightSidebar.html) to discover how to set up 
a new `rightSidebar()`
## Major changes
- add a "width" argument to the `rightSidebar()` (set to 230 pixels by default) to 
improve customization. 
- new function `setShadow()` to set shadow and hover effects on any elements
- add an "active" argument to `rightSidebarTabContent()`: see [#4](https://github.com/DivadNojnarg/shinydashboardPlus/issues/4)
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