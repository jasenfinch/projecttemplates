#' Initialise renv infrastructure
#' @description Initialise renv infrastructure in a project directory.
#' @param project_directory the project directory file path
#' @param rebuild Force packages to be rebuilt, thereby bypassing any installed versions of the package available in the cache? This can either be a boolean (indicating that all installed packages should be rebuilt), or a vector of package names indicating which packages should be rebuilt.
#' @examples 
#' \dontrun{
#' projectSkeleton(paste0(tempdir(),'/test_project'))
#' renvInitialise(paste0(tempdir(),'/test_project'))
#' }
#' @importFrom renv hydrate snapshot activate restore
#' @importFrom callr r
#' @importFrom usethis proj_set
#' @export

renvInitialise <- function(project_directory,rebuild = FALSE){
  message('Initialising renv cache')
  r(function(project_directory){
    
    setwd(project_directory)
    
    renv::hydrate()
    renv::snapshot(prompt = FALSE)
  },
  args = list(project_directory = project_directory))
  
  message('Installing project dependencies')
  r(function(project_directory,rebuild){
    
    setwd(project_directory)
    
    renv::activate()
    renv::restore(rebuild = rebuild)
  },
  args = list(project_directory = project_directory,
              rebuild = rebuild))
}