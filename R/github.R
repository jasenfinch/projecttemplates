#' @importFrom git2r init add commit push remote_add branch_set_upstream repository_head repository
#' @importFrom usethis github_token git_credentials
#' @importFrom gh gh

createGithub <- function(project_name,path,private){
  message('Creating GitHub repository')
  
  project_name_directory <- project_name %>%
    str_replace_all(' ','_')
  
  project_directory <- path %>%
    path.expand() %>%
    str_c(project_name_directory,sep = '/')
  
  repo <- repository(project_directory)
  
  create <- gh(
    "POST /user/repos",
    name = project_name_directory,
    description = project_name,
    private = private,
    .token = github_token()
  )
  
  remote_add(repo, "origin", create$ssh_url)
  push(repo, "origin", "refs/heads/master", credentials = git_credentials('ssh',auth_token = github_token()))
  branch_set_upstream(repository_head(repo), "origin/master")
  
  message(glue('Project repository created at {create$html_url}.'))
}