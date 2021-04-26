#' Project templates
#' @description Generate a project template directory.
#' @param project_name project name/title
#' @param path target file path for project directory 
#' @param type project type. Should be one returned by \code{projectTypes()}.
#' @param rebuild force rebuild of packages installed into project renv cache
#' @param docker TRUE/FALSE. Create project infrastructure for building a docker container to compile the project.
#' @param git TRUE/FALSE. Initialise a Git repository?
#' @param github TRUE/FALSE. Create a GitHub repository? Ignored if argument \code{git} is FALSE.
#' @param private TRUE/FALSE. Should the GitHub repository be private? Evaluated only if arguments \code{git} and \code{github} are TRUE.
#' @param github_actions TRUE/FALSE. Add Github actions infrastructure? Evaluated only if arguments \code{git}, \code{github} and \code{docker} are TRUE.
#' @param force force project creation if project directory already exists
#' @param start TRUE/FALSE. Should the project be automatically activated in a new RStudio session?
#' @importFrom rstudioapi openProject
#' @examples 
#' \dontrun{
#' template('A new project',type = 'report',start = FALSE)
#' }
#' @export

template <- function(project_name, 
                     path = '.', 
                     type = projectTypes(), 
                     rebuild = FALSE,
                     docker = TRUE, 
                     git = TRUE, 
                     github = TRUE, 
                     private = TRUE, 
                     github_actions = TRUE, 
                     force = FALSE,
                     start = TRUE){
  
  if (missing(type)) {
    type <- 'report'
  }
  
  type <- match.arg(type)
  
  project_directory <- projectDirectory(project_name,path)
  
  projectSkeleton(project_directory,force = force)
  
  readme(project_name,path,type)
  
  targets(project_directory,type)
  
  output(project_name,project_directory,type)
  
  renvInitialise(project_directory,rebuild = rebuild)
  
  if(isTRUE(docker)){
    docker(project_name,path) 
  }
  
  if (all(git,github,docker,github_actions)){
    githubActions(project_name,path)
  }
  
  if (isTRUE(git)) {
   createGit(project_directory,type)
  }
  
  if (all(git,github)) {
    createGithub(project_name,path,private)
  }
  
  message(glue('Template output complete. See {project_directory}/README.md for details on how to get started.'))
  
  if (isTRUE(start) & isAvailable()) {
    message('Opening project in a new RStudio session')
    openProject(project_directory,newSession = TRUE)
  }
  
}

#' Available project types
#' @description Available project types within the projecttemplates package
#' @examples 
#' projectTypes()
#' @export
projectTypes <- function(){
  c('report','manuscript','presentation')
}