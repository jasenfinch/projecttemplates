#' project templates
#' @description Generate a project template directory.
#' @param project_name project name/title
#' @param path target file path for project directory 
#' @param type project type
#' @param git TRUE/FALSE. Initialise a Git repository?
#' @param github TRUE/FALSE. Create a GitHub repository?
#' @param private TRUE/FALSE. Should the GitHub repository be private. Ignored if argument \code{github} is FALSE.
#' @param start TRUE/FALSE. Should the project be automatically activated?
#' @importFrom stringr str_c str_replace_all
#' @importFrom magrittr %>%
#' @importFrom rstudioapi isAvailable initializeProject openProject
#' @importFrom renv init
#' @importFrom callr r
#' @examples 
#' \dontrun{
#' template('A new project',type = 'report',start = FALSE)
#' }
#' @export

template <- function(project_name, path = '.', type = c('report','manuscript','presentation'), git = TRUE, github = TRUE, private = TRUE, start = TRUE){
  
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
  
  message('Adding drake infrastructure')
  
  invisible(file.copy(str_c(template_directory,'_drake.R',sep = '/'),project_directory))
  plan(project_directory,type)
  packages(project_directory,type)
  
  message('Adding output templates')
  output(project_name,project_directory,type)
  
  message('Initialising renv cache')
  invisible(r(function(project_directory){
    renv::init(project = project_directory)
  },
  args = list(project_directory = project_directory)))
  
  if (isTRUE(git)) {
    message('Initialising git')
   createGit(project_directory)
  }
  
  if (isTRUE(github)) {
    message('Creating GitHub repository')
   createGithub(project_name,path,private)
  }
  
  message(glue('Template output complete. See {project_directory}/README.md for details on how to get started.'))
  
  if (isTRUE(start) & isAvailable()) {
    message('Opening project in a new RStudio session')
    openProject(project_directory,newSession = TRUE)
  }
  
}