#' Initialise renv infrastructure
#' @description Initialise renv infrastructure in a project directory.
#' @param project_directory the project directory file path
#' @param bioc bioconductor packages to install into the cache upon initialisation
#' @param github GitHub packages to install into the cache upon initialisation
#' @param rebuild Force packages to be rebuilt, thereby bypassing any installed versions of the package available in the cache? This can either be a boolean (indicating that all installed packages should be rebuilt), or a vector of package names indicating which packages should be rebuilt.
#' @examples 
#' \dontrun{
#' projectSkeleton(paste0(tempdir(),'/test_project'))
#' renvInitialise(paste0(tempdir(),'/test_project'))
#' }
#' @importFrom renv hydrate snapshot activate restore
#' @importFrom callr r
#' @importFrom usethis proj_set
#' @importFrom BiocManager install
#' @export

renvInitialise <- function(project_directory,
                           bioc = character(),
                           github = character(),
                           rebuild = FALSE){
  message('Initialising renv cache')
  renv_init <- r(function(project_directory,bioc,github){
    
    setwd(project_directory)
    
    renv::hydrate()
    
    if (length(bioc) > 0) {
      BiocManager::install(bioc)
    }
    
    if (length(github) > 0) {
      renv::install(github)  
    }
    
    renv::snapshot(prompt = FALSE)
  },
  args = list(project_directory = project_directory,
              bioc = bioc,
              github = github))
  
  message('Installing project dependencies')
  renv_install_deps <- r(function(project_directory,rebuild){
    
    setwd(project_directory)
    
    renv::activate()
    renv::restore(rebuild = rebuild)
  },
  args = list(project_directory = project_directory,
              rebuild = rebuild))
}