#' @importFrom renv hydrate snapshot activate restore
#' @importFrom callr r
#' @importFrom usethis proj_set

renvInitialise <- function(project_directory){
  message('Initialising renv cache')
  r(function(project_directory){
    
    setwd(project_directory)
    
    renv::hydrate()
    renv::snapshot(prompt = FALSE)
  },
  args = list(project_directory = project_directory))
  
  message('Installing project dependencies')
  r(function(project_directory){
    
    setwd(project_directory)
    
    renv::activate()
    renv::restore()
  },
  args = list(project_directory = project_directory))
}