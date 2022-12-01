#' Add project .Rprofile
#' @description Add a template .Rprofile file to a project directory.
#' @param project_directory the project directory file path
#' @param packages character vector R packages to load
#' @param install value to set install argument of `pacman` package loading functions
#' @param renv add infrastructure for renv package environment management
#' @examples 
#' \dontrun{
#' projectSkeleton(paste0(tempdir(),'/test_project'))
#' Rprofile(paste0(tempdir(),'/test_project'))
#' }
#' @export

Rprofile <- function(project_directory,
                     packages = c('magrittr',
                                  'targets',
                                  'conflicted'),
                     install = FALSE,
                     renv = TRUE){
  
  if (isTRUE(renv)){
    renv_restore <- 'renv::restore()'
  } else {
    renv_restore <- ''
  }
  
  if (length(packages) > 0){
    packages <- paste(packages,collapse = ',')
    
    package_load <- glue('
## Load packages
pacman::p_load({packages},install = {install})
                         ')
  }
  
  script <- glue('
{scriptHeader()}

{renv_restore}
library(targets)
library(jfmisc,include.only = "%>%")
                 ')
  
  write(script,file = paste0(project_directory,'/.Rprofile'))
}
