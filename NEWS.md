# shinydashboardPlus 2.0.4

## Minor change
- Fix [#181](https://github.com/RinteRface/shinydashboardPlus/issues/181).
- Update github actions.
- Icon [change](https://github.com/RinteRface/shinydashboardPlus/commit/0abe127a1ce0e7f8cb74883968c83b796cc9c73e) in `dashboardHeader()`. Thanks @zhanxw.
- Allow [hyperlink](https://github.com/RinteRface/shinydashboardPlus/commit/12fab3b92b2b5e459304b385e7ed7a94cb9dbd98) in User block. Thanks @robertkck.
- Fix multiple fontawesome icon issues (deprecated names in fontawesome 6).


# shinydashboardPlus 2.0.3
This release is a patch to fix an [issue](https://github.com/RinteRface/shinydashboardPlus/pull/151) preventing the release of 
Shiny 1.7.0. Thanks @wch.

## Minor change
- Internal change regarding the `{waiter}` package but no user impact. Thanks @JohnCoene. 

## Bug fix
- Fix #150: Warning when using controlbarMenu. 

# shinydashboardPlus 2.0.2

- Simple patch to fix wrong .Rbuildignore [rule](https://github.com/DivadNojnarg/outstanding-shiny-ui/issues/52).
- Update internal file structure. 
- Clean NOTE: https://cran.rstudio.com//web/checks/check_results_shinydashboardPlus.html

# shinydashboardPlus 2.0.1

This release is a patch without major changes.

## Minor change
- Fix #132: Option to disable the "scroll to top" button in `dashboardPage()`

## Bug fix
- Fix #127: `shiny::navlistPanel()` in `dashboardControlbar()` not behaving as expected. 
- Fix #112: `userBox()` is not working. Introduced in 2.0.0.


# shinydashboardPlus 2.0.0

This release is a major step for shinydashboardPlus. It is also a significant breaking
change compared to the latest CRAN version. Overall this release will simplify the transition from shinydashboard to shinydashboardPlus and bring more consistency, more interactivity between components. Below is the changelog.

## Breaking changes
- Change _maxstar_ and _grade_ in `starBlock()` to `max` and `value`.
- Remove _footerPadding_ from `boxPlus()` to align with `{bs4Dash}`
- Remove all sidebar related parameters from `boxPlus()`. This is now part of the new `boxPlusSidebar()`
- remove _dropdownIcon_ parameter from `boxPlus()`. It is now part of the `dropdownItemList()`
- Remove all label params from `boxPlus()`. This is to reduce the number of parameters of cards. Now part of `boxPlusLabel()`
- In `dropdownItemList()` _icon_ must be provided as `shiny::icon()` and not a simple string containing the icon name. This is to be consistent with {shinydashboard}
- Replace _left_text_ and _right_text_ by _left_ and _right_, respectively in `dashboardFooter()`
- Remove all sidebar related parameters of `dashboardPagePlus()`. They now belong to `dashboardSidebarPlus()` to Align with {shinydashboard}
- In `dashboardSidebarPlus()`: replace _rightSidebar_ by _controlbar_ (align with {bs4Dash}). Rename _enable_preloader_ to _preloader_ and _loading_duration_ to _duration_
- Rename `rightSidebar()` to `dashboardControlbar()` to align with {bs4Dash}
- Remove _enable_rightSidebar_ from `dashboardHeaderPlus()`. This is now part of `dashboardControlbar()` as _disable_ like in {shinydashboard}. _rightSidebarIcon_ becomes
_controlbarIcon_ that accepts `shiny::icon` instead of a simple string containing the icon name to be consistent with {shinydashboard}. _left_menu_ becomes _leftUi_ like in {bs4Dash}
- Remove `rightSiderbarMenu()`, `rightSidebarTablist()`, `rightSidebarTabItem()`, `rightSidebarPanel()` and `rightSidebarTabContent()`. They are now replaces by `dashboardControlbar()`, `controlbarMenu()` and `controlbarItem()`
- Remove `rightSidebarMenuItem()`, `menuIcon()` and `menuInfo()`
- Rename `boxPlus()` to `box()`, `dashboardPagePlus()` to `dashboardPage()` and
`dashboardHeaderPlus()` to `dashboardHeader()`
- `dropdownBlock()` _icon_ expects a `shiny::icon()` and not a simple string containing the icon name. This is to be consistent with {shinydashboard}
- In `gradientBox()` _icon_ expects a `shiny::icon()` and not a simple string containing the icon name. This is to be consistent with {shinydashboard}
- In `descriptionBlock()` _icon_ expects a `shiny::icon()` and not a simple string containing the icon name. This is to be consistent with {shinydashboard}
- Rework `navPillsItem()`: _pillName_ becomes _left_, _pillText_ becomes _right_,
_pillColor_ becomes _color_, _pillIcon_ becomes _icon_ and expects a `shiny::icon()`. Add _inputId_ so that the item behaves like an action button
- Rework `productListItem()`: _productTitle_ becomes _title_, _productPrice_ becomes _subtitle_, _priceColor_ becomes _color_
- In `timelineItem()`, `timelineStart()` and `timelineEnd()`, _icon_ expects a `shiny::icon()` and not a simple string containing the icon name. This is to be consistent with {shinydashboard}
- In `userListItem()`, _user_name_ becomes _title_, _description_ becomes _subtitle_
- `dropdownItemList()` becomes `boxDropdown()`. `dropdownItem()` becomes `boxDropdownItem()`
- `userPostToolItemList()` becomes `userPostTagItems()`. `userPostToolItem()` becomes `userPostTagItem()`
- Remove `boxProfileItemList()`. `boxProfile()` gets a new parameter _bordered_, inherited from the old `boxProfileItemList()`
- In `boxProfile()`, _title_ becomes mandatory
- _title_ and _description_ mandatory in `boxProfileItem()`
- In `boxComment()`: _src_ and _title_ are mandatory
- `widgetUserBox()` becomes `userBox()` for more naming consistency
- Remove `gradientBox()` for consistency with {bs4Dash}
- Add _icon_, _gradient_ and _boxToolSize_ to `box()`
- _title_ mandatory in `userBox()`. Remove _background_. Replace _backgroundUrl_ by _backgroundImage_. Reworked _type_ parameter
- Restore `accordion()` id. We should distinguish between TRUE inputs (sliderInput) and secondary inputs (that you can use for interactivity)...
- _color_ becomes _status_ in `accordionItem()`. This is to be consistent with AdminLTE2 classes and {shinydashboard}
- In `attachmentBlock()`: _src_ becomes _image_ and _titleUrl_ becomes _href_. _image_ is mandatory
- In `socialButton()`: _url_ becomes _href_ and _type_ becomes _icon_ (expect `shiny::icon`)
- In `productListItem()`: _src_ becomes _image_ to be consistent with {shinydashboard}
- In `timelineItemMedia()`: _src_ becomes _image_ to be consistent with {shinydashboard}
- In `userListItem()`: _src_ becomes _image_ to be consistent with {shinydashboard}
- In `userPost()`: _src_ becomes _image_ to be consistent with {shinydashboard}. _image_ and _author_ are mandatory
- In `userPostMedia()`: _src_ becomes _image_ to be consistent with {shinydashboard}. _image_ is mandatory
- Reworked `verticalProgress()` to `progressBar()`
- In `userMessage()`: _src_ becomes _image_ to be consistent with {shinydashboard}. _side_ becomes _type_ (semantic)
- In `dashboardUser()`: _src_ becomes _image_ to be consistent with {shinydashboard}
- In `userBox()`: _src_ becomes _image_ to be consistent with {shinydashboard}
- In `socialBox()`: _src_ becomes _image_ to be consistent with {shinydashboard}
- In `boxComment()`: _src_ becomes _image_ to be consistent with {shinydashboard}
- In `boxProfile()`: _src_ becomes _image_ to be consistent with {shinydashboard}
- In `boxDropdownItem()`: _url_ becomes _href_ to be consistent with {shinydashboard}.
_name_ is removed
- Rework preloader feature: remove _duration_ and _preloader_ now expects a list...
- In `navPillsItem()`: _active_ becomes _selected_

## New features
- Completely redesigned pkgdown website with much better documentation
- New `updateUserMessages()` function 
- New `updateAccordion()` to toggle `accordion()` on the client
- Automatic "scroll to top" feature to quickly go to the top of the dashboard
- Use `{waiter}` for custom preloaders
- Add _inputId_ to `taskItem()`, `notificationItem()` and `messageItem()`
- New _id_ and _icon_ to `boxDropdownItem()`, that behaves like an action button if passed
- New `updateNavPills()` to programmatically change the selected item in `navPills()`
- Add _freshTheme_ parameter to `dashboardPage()`. This allows to use the awsesome `{fresh}` package. See [here](https://dreamrs.github.io/fresh/articles/vars-shinydashboard.html) for more details.
- Add `skinSelector()` to allow dynamically change the dashboard skin on the client side.
- Add `updateControlbarMenu()` to programmatically change the selected controlbar item
- Add _id_ to `dashboardControlbar()` to be able to use `updateControlbar()`
- Add _id_ to `dashboardSidebar()` to be able to use `updateSidebar()`
- New `dashboardSidebar()` (reworked shinydashboard sidebar)
- New `boxLabel()` to add text labels in `box()`
- New `boxSidebar()`: access the status via input$id. Add `updateBoxSidebar()` to toggle the box sidebar
- new `options` parameter to `dashboardPage()`. See [here](https://adminlte.io/themes/AdminLTE/documentation/index.html#adminlte-options) for the
list of available options
- Toggle `box()` with `updateBox()` (see #10 and #69, @happyshows and @daatali)

## Minor change
- Add _headerBorder_ to `box()`
- add _width_ to `accordion()` (default to 12)
- Simplified dependencies code (No end-user impact)

## Bug fixes
- Fix #102: dashboardUser not displayed when using shinydashboard::sidebarMenuOutput. ensureActivatedTab was not
in the global scope, whereas it was needed by the output binding code 
- Fix #107: `collapsed = FALSE` not working for dashboardControlbar. 
- Fix #56: When controlbar is expanded/collapsed, a plot does not fit in body. 
- Fix #78: Menu Item with Sub Menu Item Arrow Not Rotating.
- Fix #105: box animation speed. Allow user defined options to prevail over internals.
- Fix #57: broken default `input$sidebarCollapsed`. 
- Fix #86: controlbar should also trigger a window resize, like the left
shinydashboard sidebar. Thanks @ajfisher83 
- Fix ugly layout of the box body (wrong padding and margins) when one puts a sidebar in `box()`...
- _title_ is mandatory in `accordionItem()` (Setting title to NULL would prevent the item
to be able to collapse ...)





# shinydashboardPlus 0.7.5

## Experimental
- New dark theme: midnight (still work in progress, some elements are missing)

## Breaking Changes
- `accordion()` id becomes inputId. `accordionItem()` id parameter is removed
- rework `appButton()` : this is a classic shiny actionButton, with improved styling.
- change title_url in titleUrl in `attachmentBlock()`
change number_color, number_icon, margin_bottom and rightBorder to camelcase params
in `descriptionBlock()`
- numberIcon in `descriptionBlock()` only need the name of the icon ('times') instead of the full class (like fa fa-times)
## New features
- add `userMessages()` and `userMessage()`
- add `dashboardBadge()`: use in elements like `appButton()`. This is different from 
`dashboardLabel()`

## Minor Change
- Fix #52: add collapsed arg to `widgetUserBox()`. Thanks @terpsrule
- Fix #40: add sidebar_icon argument to `boxPlus()`. Thanks @jmw86069 for the suggestion

## Bug Fixes
- Fix #61: uniqueness of `accordion()` id. Thanks @RegaCaska
- Fix #23: rework id arg in `flipBox()`. Thanks @vinpogo
- Add class btn-box-tool to close button in `widgetUserBox()`. 
Prevent from ugly rendering
- Fix #51: change card sidebar z-index so that it is not displayed on top of
 the page preloader. Thanks @leungi
- Fix #53: missing title in demo message card
- Fix #55: when no image is provided, no circle is displayed. Thanks @nschwamm
- Replace http links by https
- Fix #36: make sure that a `carousel()` item is displayed when it is generated via a shiny Output function. Thanks @daattali for the report


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
`rightSidebarPanel()` from the user interface. See [here](https://shinydashboardplus.rinterface.com/articles/controlbar#controlbar) to discover how to set up 
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