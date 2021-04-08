#' Project README
#' @description Export a README to a project directory
#' @param project_name project name/title
#' @param path target file path for project directory 
#' @param type project type
#' @examples 
#' readme('test project',getwd(),'report')
#' @export

readme <- function(project_name,path,type){
  
  project_directory <- projectDirectory(project_name,path)
  
  header <- glue('# {project_name}

This project is powered the [targets](https://docs.ropensci.org/targets/) package for workflow management and
[renv](https://rstudio.github.io/renv/index.html) package for `R` environment reproducibility.

## Getting started

Add analysis targets to `R/targets.R`, scripts containing functions to the `R/functions` directory, data files to the `data` directory, additional miscellaneous scripts to `misc` and communicate your results in `{type}/{type}.Rmd`.
To run the analysis, execute `targets::tar_make()` in an `R` session loaded from within the project directory.
')
  
  writeLines(header,str_c(project_directory,'/README.md'))
}