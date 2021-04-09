#' Add targets infrastructure
#' @description Add targets infrastructure to a project directory
#' @param project_directory the project directory file path
#' @param type project type. Should be one returned by \code{projectTypes()}.
#' @examples
#' \dontrun{
#' projectSkeleton(paste0(tempdir(),'/test_project'))
#' targets(paste0(tempdir(),'/test_project'),type = 'report') 
#' }
#' @export

targets <- function(project_directory,type = projectTypes()){
  
  if (missing(type)) {
    type <- 'report'
  }
  
  type <- match.arg(type)
  
  message('Adding targets infrastructure')
  
  targetsScript(project_directory,type)
  targetsPipeline(project_directory,type)
  utils(project_directory,type)
}

targetsScript <- function(project_directory,type = projectTypes()){
  if (missing(type)) {
    type <- 'report'
  }
  
  type <- match.arg(type)
  
  template_directory <- system.file('templates',package = 'projecttemplates')
  
  invisible(file.copy(str_c(template_directory,'_targets.R',sep = '/'),project_directory))
}

#' Add a targets pipeline
#' @description Add a targets pipeline to a project directory.
#' @param project_directory the project directory file path
#' @param type project type. Should be one returned by \code{projectTypes()}.
#' @examples
#' \dontrun{
#' projectSkeleton(paste0(tempdir(),'/test_project'))
#' targetsPipeline(paste0(tempdir(),'/test_project'),type = 'report')
#' }
#' @importFrom glue glue
#' @export

targetsPipeline <- function(project_directory,type = projectTypes()){
  
  if (missing(type)) {
    type <- 'report'
  }
  
  type <- match.arg(type)
  
  if (type == 'manuscript') {
    formats <- ',output_format = "all"'
  } else {
    formats <- ''
  }
  
  cmd <- glue('
  ## render {type}
  tar_render(
              {type},
              "{type}/{type}.Rmd",
              quiet = TRUE{formats}
  )
              ')
  
  if (type == 'manuscript') {
    cmd <- str_c('
  ## render tables
  tar_render(tables,
             "manuscript/tables.Rmd"),
             quiet = TRUE),
  
  ## render figures
  tar_render(figures,
             "manuscript/figures.Rmd",
             quiet = TRUE),
  
  ## render supplementary information
  tar_render(supplementary,
             "manuscript/supplementary.Rmd",
             quiet = TRUE),
                 ',
                 cmd)
  }
  
  p <- glue('
  list(
  {cmd}
  )
  ') %>%
    writeLines(con = str_c(project_directory,'/R/targets.R'))
}
