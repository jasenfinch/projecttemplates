#' @importFrom gert git_init git_add git_commit

createGit <- function(project_directory,type){
  message('Initialising git')
  
  ignore <- c('.Rhistory','.Rproj.user','.drake')
  
  if (type %in% c('report','presentation')){
    ignore <- c(ignore,'*.html')  
  }
  
  if (type == 'manuscript') {
    ignore <- c(ignore,'*.pdf')
  }
  
  git_init(project_directory)
  writeLines(ignore,con = str_c(project_directory,'/.gitignore'))
  git_add('.*',repo = project_directory)
  git_add('*',repo = project_directory)
  git_commit('Initial commit',repo = project_directory)
}