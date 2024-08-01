## Test environments
* Local OS X install, R 4.4.0
* `rhub::check_for_cran()`
* Github actions
* win-builder (devel and release)

## R CMD check results
  - 0 error, 0 warnings, 0 Notes.

## Notes
- Fix NOTES in older release:

Version: 2.0.4
Check: Rd cross-references
Result: NOTE 
  Found the following Rd file(s) with Rd \link{} targets missing package
  anchors:
    sidebar.Rd: sidebarMenu, sidebarSearchForm
  Please provide package anchors for all Rd \link{} targets not in the
  package itself and the base packages.
Flavors: r-devel-linux-x86_64-debian-gcc, r-devel-windows-x86_64
