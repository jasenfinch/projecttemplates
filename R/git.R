#' @importFrom git2r init add commit 

createGit <- function(project_directory){
  message('Initialising git')
  
  init(project_directory)
  writeLines('.Rproj.user',con = str_c(project_directory,'/.gitignore'))
  add(project_directory,'.*')
  add(project_directory,'*')
  commit(project_directory,all = TRUE,message = 'Initial commit')
}