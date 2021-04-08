#' Project directory
#' @description Convert a project name to a directory path.
#' @param project_name the project name/title
#' @param path target file path for project directory
#' @examples 
#' projectDirectory('test project',getwd())
#' @importFrom stringr str_c str_replace_all
#' @importFrom magrittr %>%
#' @export 

projectDirectory <- function(project_name,path){
  project_name_directory <- project_name %>%
    str_replace_all(' ','_')
  
  project_directory <- path %>%
    path.expand() %>%
    str_c(project_name_directory,sep = '/')
  
  return(project_directory)
}

#' Project skeleton
#' @description Initialise the basic project directories and files.
#' @param project_directory the project directory file path
#' @examples 
#' projectSkeleton(paste0(getwd(),'/test_project'))
#' @importFrom rstudioapi isAvailable initializeProject
#' @export

projectSkeleton <- function(project_directory){
  
  if (dir.exists(project_directory)) {
    stop('Project directory already exists',call. = FALSE)
  }
  
  message(str_c('Creating project directory at ',project_directory))
  
  dir.create(project_directory)
  
  if (isAvailable()) {
    initializeProject(project_directory)
  }
  
  dir.create(str_c(project_directory,'R','functions',sep = '/'),recursive = TRUE)
  
  dir.create(str_c(project_directory,'data',sep = '/'))
  
  dir.create(str_c(project_directory,'misc',sep = '/'))
  
}