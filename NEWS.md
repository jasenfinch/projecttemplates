# projecttemplates 0.4.1

* `projecttemplates::targetsScript()` function now exported.

* A `run.R` script now added to a project directory for executing a `targets` analysis through `projecttemplates::targetsRun()`.

# projecttemplates 0.4.0

* `docker` argument in `projecttemplates::template()` now works correctly.

* The project templates now use the [`targets`](https://docs.ropensci.org/targets/) package for workflow management.

* Intermediate helper functions are now exported.

* Added a `pkgdown` site available [here](https://jasenfinch.github.io/projecttemplates/).

# projecttemplates 0.3.5

* Re-added the addition of the remote URL during GitHub repo setup.

# projecttemplates 0.3.4

* Removed use of the now defunct `usethis::git_credentials()` and `usethis::github_token()`.

* All git interaction now uses the `gert` package instead of `git2r`.

# projecttemplates 0.3.3

* Added a `NEWS.md` file to track changes to the package.

* Added `rebuild` argument to `projecttemplates::template()` to force the rebuild of packages on installation into the project `renv` package cache.

* .Rhistory now ignored by git.
