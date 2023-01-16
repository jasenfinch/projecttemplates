#' Initialise renv infrastructure
#' @description Initialise renv infrastructure in a project directory.
#' @param project_directory the project directory file path
#' @param bioconductor The version of bioconductor to use with the project. Set to TRUE to use the default version of Bioconductor.
#' @param dependencies additional package dependencies to install into the cache upon initialisation
#' @examples 
#' \dontrun{
#' projectSkeleton(paste0(tempdir(),'/test_project'))
#' renvInitialise(paste0(tempdir(),'/test_project'))
#' }
#' @importFrom renv snapshot hydrate
#' @importFrom callr r_copycat
#' @export

renvInitialise <- function(project_directory,
                           bioconductor = FALSE,
                           dependencies = character()){
  message('Initialising renv cache')
  renv_init <- r_copycat(function(project_directory,bioconductor,dependencies){
    
    project_directory <- normalizePath(project_directory)
    
    renv::init(project = project_directory,
               bioconductor = bioconductor,
               bare = TRUE)
    
    if (length(dependencies) > 0) {
      renv::install(dependencies,project = project_directory)  
    }
    
    renv::hydrate(project = project_directory)
    
    renv::snapshot(project = project_directory,
                   prompt = FALSE)
    
  },
  args = list(project_directory = project_directory,
              bioconductor = bioconductor,
              dependencies = dependencies))
}
