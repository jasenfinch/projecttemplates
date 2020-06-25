#' @importFrom git2r init add commit 

createGit <- function(project_directory){
  git2r::init(project_directory)
  writeLines('.Rproj.user',con = str_c(project_directory,'/.gitignore'))
  add(project_directory,'*',force = TRUE)
  commit(project_directory,all = TRUE,message = 'Initial commit')
}