#' Add project .Rprofile
#' @description Add a template .Rprofile file to a project directory.
#' @param project_directory the project directory file path
#' @param renv add infrastructure for renv package environment management
#' @examples 
#' \dontrun{
#' projectSkeleton(paste0(tempdir(),'/test_project'))
#' Rprofile(paste0(tempdir(),'/test_project'))
#' }
#' @export

Rprofile <- function(project_directory,
                     renv = TRUE){
  
  if (isTRUE(renv)){
    renv_restore <- 'renv::restore()'
  } else {
    renv_restore <- ''
  }
  
  script <- glue('
{scriptHeader()}
{renv_restore}
library(targets)
library(jfmisc,include.only = "%>%")
                 ')
  
  write(script,file = paste0(project_directory,'/.Rprofile'))
}
