## Test environments
* Local OS X install, R 3.6.1
* `rhub::check_for_cran()`
* Github actions
* win-builder (devel and release)

## R CMD check results
  - 0 error, 0 warnings, 0 Notes.

## Notes
- Removed `'LazyData' is specified without a 'data' directory` NOTE by removing `LazyData: True` from DESCRIPTION.
- Move `{lifecycle}` to `Suggests`.

## Reverse dependencies:
using `devtools::revdep()` 
