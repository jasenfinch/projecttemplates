#' Add git infrastructure
#' @description Add git infrastructure to a project directory.
#' @param project_directory the project directory file path
#' @param type project type. Should be one returned by \code{projectTypes()}.
#' @examples
#' \dontrun{
#' projectSkeleton(paste0(tempdir(),'/test_project'))
#' createGit(paste0(tempdir(),'/test_project'),type = 'report')
#' }
#' @importFrom gert git_init git_add git_commit
#' @export

createGit <- function(project_directory,type){
  message('Initialising git')
  
  ignore <- c('.Rhistory','.Rproj.user','.targets')
  
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