#' @importFrom glue glue

plan <- function(project_directory,type){
  
  if (type == 'manuscript') {
    formats <- ',output_format = "all"'
  } else {
    formats <- ''
  }
  
  cmd <- glue('
  ## render {type}
  {type} = render(knitr_in("{type}/{type}.Rmd"),quiet = TRUE{formats})
              ')
  
  if (type == 'manuscript') {
    cmd <- str_c('
  ## render tables
  tables = render(knitr_in("manuscript/tables.Rmd"),quiet = TRUE),
  
  ## render figures
  figures = render(knitr_in("manuscript/figures.Rmd"),quiet = TRUE),
  
  ## render supplementary information
  supplementary = render(knitr_in("manuscript/supplementary.Rmd"),quiet = TRUE),
                 ',
                 cmd)
  }
  
  p <- glue('
  plan <- drake_plan(
  {cmd}
  )
  ') %>%
    writeLines(con = str_c(project_directory,'/R/plan.R'))
}