#' project templates
#' @description Generate a project template directory.
#' @param project_name project name/title
#' @param path target file path for project directory 
#' @param type project type
#' @param docker TRUE/FALSE. Create project infrastructure for building a docker container to compile the project.
#' @param git TRUE/FALSE. Initialise a Git repository?
#' @param github TRUE/FALSE. Create a GitHub repository? Ignored if argument \code{git} is FALSE.
#' @param private TRUE/FALSE. Should the GitHub repository be private. Ignored if argument \code{github} is FALSE.
#' @param start TRUE/FALSE. Should the project be automatically activated?
#' @importFrom stringr str_c str_replace_all
#' @importFrom magrittr %>%
#' @importFrom rstudioapi isAvailable initializeProject openProject
#' @examples 
#' \dontrun{
#' template('A new project',type = 'report',start = FALSE)
#' }
#' @export

template <- function(project_name, path = '.', type = c('report','manuscript','presentation'), docker = TRUE, git = TRUE, github = TRUE, private = TRUE, start = TRUE){
  
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
  
  readme(project_name,project_directory,type)
  
  drakeInfrastructure(project_directory,type)
  
  output(project_name,project_directory,type)
  
  renvInitialise(project_directory)
  
  docker(project_name,path)
  
  if (isTRUE(git)) {
   createGit(project_directory)
    
    if (isTRUE(github)) {
      createGithub(project_name,path,private)
    }
  }
  
  message(glue('Template output complete. See {project_directory}/README.md for details on how to get started.'))
  
  if (isTRUE(start) & isAvailable()) {
    message('Opening project in a new RStudio session')
    openProject(project_directory,newSession = TRUE)
  }
  
}