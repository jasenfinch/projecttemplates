#' @importFrom stringr str_c str_replace_all
#' @importFrom magrittr %>%
#' @importFrom rstudioapi isAvailable initializeProject
#' @importFrom renv init
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
  
  readme(project_name,project_directory)
  
  message('Adding drake infrasturture')
  
  invisible(file.copy(str_c(template_directory,'_drake.R',sep = '/'),project_directory))
  plan(project_directory,type)
  invisible(file.copy(str_c(template_directory,'packages.R',sep = '/'),str_c(project_directory,'R',sep = '/')))
  
  message('Adding output templates')
  output(project_name,project_directory,type)
  
  message('Initialising renv cache')
  wd <- getwd()
  setwd(project_directory)
  init(restart = start)
  setwd(wd)
}