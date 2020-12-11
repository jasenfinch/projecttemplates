#' @importFrom git2r init add commit 

createGit <- function(project_directory,type){
  message('Initialising git')
  
  ignore <- c('.Rhistory','.Rproj.user','.drake')
  
  if (type %in% c('report','presentation')){
    ignore <- c(ignore,'*.html')  
  }
  
  if (type == 'manuscript') {
    ignore <- c(ignore,'*.pdf')
  }
  
  init(project_directory)
  writeLines(ignore,con = str_c(project_directory,'/.gitignore'))
  add(project_directory,'.*')
  add(project_directory,'*')
  commit(project_directory,all = TRUE,message = 'Initial commit')
}