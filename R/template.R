#' @importFrom stringr str_c str_replace_all
#' @importFrom magrittr %>%
#' @importFrom rstudioapi isAvailable initializeProject
#' @export

template <- function(project_name,path = '.'){
  
  project_name_directory <- project_name %>%
    str_replace_all(' ','_')
  
  project_directory <- path %>%
    path.expand() %>%
    str_c(project_name_directory,sep = '/')
  
  message(str_c('Creating project directory at ',project_directory))
  
  dir.create(project_directory)
  
  if (isAvailable()) {
    initializeProject(project_directory)
  }
  
  dir.create(str_c(project_directory,'R','functions',sep = '/'),recursive = TRUE)
  dir.create(str_c(project_directory,'report',sep = '/'))
  
  template_directory <- system.file('templates',package = 'projecttemplates')
  
  readme(project_name,project_directory)
  
  message('Adding drake infrasturture')
  invisible(file.copy(str_c(template_directory,'_drake.R',sep = '/'),project_directory))
  invisible(file.copy(str_c(template_directory,'plan.R',sep = '/'),str_c(project_directory,'R',sep = '/')))
}