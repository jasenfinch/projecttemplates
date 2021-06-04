#' Project README
#' @description Export a README to a project directory
#' @param project_name project name/title
#' @param path target file path for project directory 
#' @param type project type. Should be one returned by \code{projectTypes()}.
#' @param renv add text for renv support
#' @examples 
#' \dontrun{
#' readme('test project',getwd(),'report')
#' }
#' @export

readme <- function(project_name,path,type = projectTypes(),renv = TRUE){
  
  project_directory <- projectDirectory(project_name,path)
  
  if (isTRUE(renv)){
    renv_text <- ' and [renv](https://rstudio.github.io/renv/index.html) package for `R` environment reproducibility' 
  } else {
    renv_text <- ''
  }
  
  header <- glue('# {project_name}

This project is powered the [targets](https://docs.ropensci.org/targets/) package for workflow management{renv_text}.

## Getting started

Add analysis targets to `R/targets.R`, scripts containing functions to the `R/functions` directory, data files to the `data` directory, additional miscellaneous scripts to `misc` and communicate your results in `{type}/{type}.Rmd`.
To run the analysis, either execute `targets::tar_make()` in an `R` session loaded from within the project directory or run the `run.R` script.
')
  
  writeLines(header,str_c(project_directory,'/README.md'))
}