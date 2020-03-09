#' @importFrom glue glue

plan <- function(project_directory,type){
  
  if (type == 'manuscript') {
    formats <- ',output_format = "all"'
  } else {
    formats <- ''
  }
  
  cmd <- glue('\t{type} = render("{type}/{type}.Rmd",quiet = TRUE{formats})')
  
  p <- glue('
  plan <- drake_plan(
  {cmd}
  )
  ')
  writeLines(p,str_c(project_directory,'/R/plan.R'))
}