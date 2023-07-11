#' Create a project GitHub repository
#' @description Create a GitHub repository for the project.
#' @param project_name project name/title
#' @param path target file path for project directory 
#' @param private TRUE/FALSE. Should the GitHub repository be private? Evaluated only if arguments \code{git} and \code{github} are TRUE.
#' @importFrom gh gh gh_token
#' @importFrom gert git_push git_remote_add git_branch
#' @export

createGithub <- function(project_name,path,private = TRUE){
  message('Creating GitHub repository')
  
  project_name_directory <- project_name %>%
    str_replace_all(' ','_')
  
  project_directory <- path %>%
    path.expand() %>%
    str_c(project_name_directory,sep = '/')
  
  create <- gh(
    "POST /user/repos",
    name = project_name_directory,
    description = project_name,
    private = private,
    .token = gh_token()
  )
  
  branch_ref <- git_branch(repo = project_directory) %>% 
    paste0('refs/heads/',.)
    
  git_remote_add(url = create$ssh_url,repo = project_directory)
  git_push('origin',refspec = branch_ref ,repo = project_directory)
  
  message(glue('Project repository created at {create$html_url}.'))
}