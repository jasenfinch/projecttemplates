#' project templates
#' @description Generate a project template directory.
#' @param project_name project name/title
#' @param path target file path for project directory 
#' @param type project type
#' @param start TRUE/FALSE should the project be automatically activated
#' @importFrom stringr str_c str_replace_all
#' @importFrom magrittr %>%
#' @importFrom rstudioapi isAvailable initializeProject
#' @importFrom renv init
#' @examples 
#' \dontrun{
#' template('A new project',type = 'report',start = FALSE)
#' }
#' @export

template <- function(project_name, path = '.', type = c('report','manuscript','presentation'), start = TRUE){
  
  if (missing(type)) {
    type <- 'report'
  }
  
  type <- match.arg(type)
  
  project_name_directory <- project_name %>%
    str_replace_all(' ','_')
  
  project_directory <- path %>%
    path.expand() %>%
    str_c(project_name_directory,sep = '/')
  
  if (dir.exists(project_directory)) {
    stop('Project directory already exists',call. = FALSE)
  }
  
  message(str_c('Creating project directory at ',project_directory))
  
  dir.create(project_directory)
  
  if (isAvailable()) {
    initializeProject(project_directory)
  }
  
  dir.create(str_c(project_directory,'R','functions',sep = '/'),recursive = TRUE)
  
  template_directory <- system.file('templates',package = 'projecttemplates')
  
  readme(project_name,project_directory,type)
  
  message('Adding drake infrasturture')
  
  invisible(file.copy(str_c(template_directory,'_drake.R',sep = '/'),project_directory))
  plan(project_directory,type)
  packages(project_directory,type)
  
  message('Adding output templates')
  output(project_name,project_directory,type)
  
  message('Initialising renv cache')
  wd <- getwd()
  setwd(project_directory)
  init(restart = start)
  setwd(wd)
}