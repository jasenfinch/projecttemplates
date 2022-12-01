#' Project templates
#' @description Generate a project template directory.
#' @param project_name project name/title
#' @param path target file path for project directory 
#' @param type project type. Should be one returned by \code{projectTypes()}.
#' @param renv add renv infrastructure for reproducible a R package environment
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
#' template('A new project',
#'          type = 'report',
#'          github = FALSE,
#'          start = FALSE)
#' }
#' @export

template <- function(project_name, 
                     path = '.', 
                     type = projectTypes(), 
                     renv = TRUE,
                     docker = TRUE, 
                     git = TRUE, 
                     github = TRUE, 
                     private = TRUE, 
                     github_actions = TRUE, 
                     force = FALSE,
                     start = TRUE){
  
  type <- match.arg(type,
                    choices = projectTypes())
  
  project_directory <- projectDirectory(project_name,path)
  
  projectSkeleton(project_directory,force = force)
  
  readme(project_name,path,type,renv)
  
  targets(project_directory,
          type = type,
          renv = renv)
  
  Rprofile(project_directory,
           install = !renv,
           renv = renv)
  
  utils(str_c(project_directory,'/R'))
  
  output(project_name,project_directory,type)
  
  if(isTRUE(renv)){
    renvInitialise(project_directory,
                   github = githubPackages(type)) 
  }
  
  if(isTRUE(docker)){
    docker(project_name,type,path,renv) 
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

githubPackages <- function(type){
  switch(type,
         report = 'jasenfinch/jfmisc',
         presentation = 'jasenfinch/jfmisc',
         manuscript = 'jasenfinch/jfmisc')
}