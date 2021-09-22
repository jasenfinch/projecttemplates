#' Add git infrastructure
#' @description Add git infrastructure to a project directory.
#' @param project_directory the project directory file path
#' @param type project type. Should be one returned by \code{projectTypes()}.
#' @param ignore a character vector of files or directories for git to add to the .gitignore of the created git repository.
#' @examples
#' \dontrun{
#' projectSkeleton(paste0(tempdir(),'/test_project'))
#' createGit(paste0(tempdir(),'/test_project'),type = 'report')
#' }
#' @importFrom gert git_init git_add git_commit git_signature_default
#' @export

createGit <- function(project_directory,type,ignore = c('.Rhistory','.Rproj.user','_targets','data','exports')){
  message('Initialising git')
  
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
  
  git_signature_status <- try(git_signature_default(),silent = TRUE)
  
  if (class(git_signature_status) == 'character') {
    git_commit('Initial commit',repo = project_directory) 
  }
}