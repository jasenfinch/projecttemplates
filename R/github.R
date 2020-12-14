#' @importFrom gh gh gh_token
#' @importFrom gert git_push git_remote_add

createGithub <- function(project_name,path,private){
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
  
  git_push('origin',refspec ='refs/heads/master' ,repo = project_directory)
  
  message(glue('Project repository created at {create$html_url}.'))
}