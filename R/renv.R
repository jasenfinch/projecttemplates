#' Initialise renv infrastructure
#' @description Initialise renv infrastructure in a project directory.
#' @param project_directory the project directory file path
#' @param github GitHub packages to install into the cache upon initialisation
#' @examples 
#' \dontrun{
#' projectSkeleton(paste0(tempdir(),'/test_project'))
#' renvInitialise(paste0(tempdir(),'/test_project'))
#' }
#' @importFrom renv snapshot hydrate
#' @importFrom callr r_copycat
#' @export

renvInitialise <- function(project_directory,
                           github = character()){
  message('Initialising renv cache')
  renv_init <- r_copycat(function(project_directory,bioc,github){
    
    project_directory <- normalizePath(project_directory)
    
    bioconductor <- ifelse(isTrue(bioc),TRUE,FALSE)
    renv::init(project = project_directory,
               bioconductor = bioconductor)
    
    if (length(github) > 0) {
      renv::install(github,project = project_directory)  
    }
    
    renv::snapshot(project = project_directory)
    
  },
  args = list(project_directory = project_directory,
              bioc = bioc,
              github = github))
}
