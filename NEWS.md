# projecttemplates 0.5.3

* Added [`pacman`]( https://CRAN.R-project.org/package=pacman) as an import to ensure that it is installed incase `renv = FALSE` is used.

# projecttemplates 0.5.2

* Removed `rstudio` from the project path in the Dockerfile.

# projecttemplates 0.5.1

* An initial commit is only made in `createGit()` if a valid git signature is found.

* The value of the `install` argument of [`pacman`]( https://CRAN.R-project.org/package=pacman) loading functions can now be set in `utils()`.

* In `template()`, the [`pacman`]( https://CRAN.R-project.org/package=pacman) `install` argument in `utils()` is now dependant on the value of the `renv` argument.

* The installation of project package dependencies is now added to the docker file when the `renv` argument is `FALSE`.

# projecttemplates 0.5.0

* `renv::restore()` moved from `utils.R` to `run.R`.

* The generation of `renv` infrastructure is now optional in `template()`.

* The project Dockerfile is now generated with the in-use R version.

* The project Dockerfile is now specific to the project type.

* The package version and URL now added to all generated files.

# projecttemplates 0.4.6

* Added `ignore` argument to `createGit()` to enable the customisation of files and directories ignored by git.

* `_targets`,`data` and `exports` folders ignored by git by default.

# projecttemplates 0.4.5

* `renvInitialise()` now initialises the project library to ensure that Bioconductor and GitHub dependency packages are installed correctly.

# projecttemplates 0.4.4

* Added `exports` directory to the template skeleton.

* Removed the use of `BiocManager::install()` for installing Bioconductor packages, instead using `renv::install()`.

* The `rebuild` argument has been removed from `template()` and `renvInitialise()`.

* Template project analysis outputs now directed to the `exports` directory.

# projecttemplates 0.4.3

* `renv` R package cache infrastructure is now initiated using `renv::init()`.

# projecttemplates 0.4.2

* CRAN, Bioconductor and GitHub R packages can now be specified in `utils()`.

* Bioconductor and GitHub R packages can now be installed upon `renv` cache initialisation in `renvInitialise()`.

# projecttemplates 0.4.1

* `projecttemplates::targetsScript()` function now exported.

* A `run.R` script now added to a project directory for executing a `targets` analysis through `projecttemplates::targetsRun()`.

* Project creation can be forced using the `force` argument of `projecttemplate::template()`.

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
