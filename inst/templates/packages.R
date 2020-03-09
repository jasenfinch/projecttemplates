## Restore package cache
renv::restore()

## Load dependant CRAN libraries
pacman::p_load(drake,conflicted,rmarkdown,
               callr,magrittr,purrr,progress)

## Load dependant GitHub libraries
# pacman::p_load_gh()

## Resolve conflicts
# conflict_prefer('map','purrr',quiet = T)
