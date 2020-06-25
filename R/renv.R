#' @importFrom renv init
#' @importFrom callr r

renvInitialise <- function(project_directory){
  message('Initialising renv cache')
  invisible(r(function(project_directory){
    renv::init(project = project_directory)
  },
  args = list(project_directory = project_directory)))
  
}