#' Initialise renv infrastructure
#' @description Initialise renv infrastructure in a project directory.
#' @param project_directory the project directory file path
#' @param bioc bioconductor packages to install into the cache upon initialisation
#' @param github GitHub packages to install into the cache upon initialisation
#' @examples 
#' \dontrun{
#' projectSkeleton(paste0(tempdir(),'/test_project'))
#' renvInitialise(paste0(tempdir(),'/test_project'))
#' }
#' @importFrom renv init
#' @importFrom callr r
#' @export

renvInitialise <- function(project_directory,
                           bioc = character(),
                           github = character()){
  message('Initialising renv cache')
  renv_init <- r(function(project_directory,bioc,github){
    
    if (length(bioc) > 0) {
      renv::install(glue::glue('bioc::{bioc}'))
    }
    
    if (length(github) > 0) {
      renv::install(github)  
    }
    
    renv::init(project = project_directory)
  },
  args = list(project_directory = project_directory,
              bioc = bioc,
              github = github))
}