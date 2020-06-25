
drakeInfrastructure <- function(project_directory,type){
  message('Adding drake infrastructure')
  
  template_directory <- system.file('templates',package = 'projecttemplates')
  
  invisible(file.copy(str_c(template_directory,'_drake.R',sep = '/'),project_directory))
  plan(project_directory,type)
  packages(project_directory,type)
}