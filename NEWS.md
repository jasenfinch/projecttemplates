# projecttemplates 0.6.1

* Added the `sandbox` argument to `renvInitialise()` to allow the selection of whether sandboxing is used during [`renv`](https://rstudio.github.io/renv/index.html) initialisation.

# projecttemplates 0.6.0

* The template `run.R` script now outputs to `misc/run.R`. The template `README.md` has now been updated to reflect this.

* The template `misc/run.R` script now outputs a message to the console upon completion.

* The [`tarchetypes`](https://docs.ropensci.org/tarchetypes/) package is now referenced directly in template targets scripts.

* The template docker infrastructure now outputs to the directory `misc/docker` and now includes an image build script (`/misc/docker/build_image.sh`) and a container run script (`/misc/docker/run_container.sh`).

* [`jfmisc::writingChecks()`](https://jasenfinch.github.io/jfmisc/reference/writingChecks.html) now replaces the `manuscriptChecks()` function in the `manuscript` template.

* The `renv::restore()` command has now been moved to the template `.Rprofile`.

* The [`targets`](https://docs.ropensci.org/targets/) package and the magrittr `%>%` are now loaded via the template `.Rprofile`.

* The `bioconductor` argument replaces the `bioc` argument in `renvInitialise()` to stipulate the Bioconductor version to use.

* Added the `targetsConfig()` function to add a `_targets.yaml` to a project directory. This file is added automatically by the `template()` function.

* Fixed incorrect outputs in the figures, tables and supplementary output Rmarkdown files in the `manuscript` template.

* [`knitr`](https://yihui.org/knitr/) is now referenced directly in function calls in output template Rmarkdown files.

# projecttemplates 0.5.8

* The `renv` directory is now included in the generated `.dockerignore` file if argument `renv = TRUE`.

* The RStudio project file is now created even if the project template is generated outside of RStudio.

* Errors encountered during the retrieval of the git signature are now reported during git initialisation.

# projecttemplates 0.5.7

* Script header added to generated `R/utils.R` file.

* `data` and `exports` directories added to the the generated `.dockerignore` file.

* The generated `_targets.R` file is now formatted using the [`styler`](https://styler.r-lib.org/) package. 

# projecttemplates 0.5.6

* `.dockerignore` file is now added to output project to ignore the `_targets` directory if present.

* Target build time and object size are now added to the output pipeline graph in `run.R`.

* `targets` package options set by `tar_options_set()` now moved to `utils.R`.

# projecttemplates 0.5.5

* Fixed the use of user `renv` settings during initialisation to ensure that the user cache is used.

* Simplified the `renv` cache restore term in the generated project Dockerfile.

# projecttemplates 0.5.4

* Fixed warning that is returned when directories in the project `path` do not exist prior to template generation.

# projecttemplates 0.5.3

* Added [`pacman`](https://CRAN.R-project.org/package=pacman) as an import to ensure that it is installed in case `renv = FALSE` is used.

* Project templates targets error [option](https://docs.ropensci.org/targets/reference/tar_option_set.html) now set to `"continue"` to enable the pipeline to continue if an error is encountered.

* The pipeline network graph generation added to the generated run script.

# projecttemplates 0.5.2

* Removed `rstudio` from the project path in the Dockerfile.

# projecttemplates 0.5.1

* An initial commit is only made in `createGit()` if a valid git signature is found.

* The value of the `install` argument of [`pacman`]( https://CRAN.R-project.org/package=pacman) loading functions can now be set in `utils()`.

* In `template()`, the [`pacman`](https://CRAN.R-project.org/package=pacman) `install` argument in `utils()` is now dependant on the value of the `renv` argument.

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

* Re-added the addition of the remote URL during GitHub repo set-up.

# projecttemplates 0.3.4

* Removed use of the now defunct `usethis::git_credentials()` and `usethis::github_token()`.

* All git interaction now uses the `gert` package instead of `git2r`.

# projecttemplates 0.3.3

* Added a `NEWS.md` file to track changes to the package.

* Added `rebuild` argument to `projecttemplates::template()` to force the rebuild of packages on installation into the project `renv` package cache.

* .Rhistory now ignored by git.
