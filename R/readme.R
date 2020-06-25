
readme <- function(project_name,project_directory,type){
  
  
  header <- glue('# {project_name}

This project is powered the [drake](https://docs.ropensci.org/drake/) package for workflow management and
[renv](https://rstudio.github.io/renv/index.html)) package for `R` environment reproducibility.

Add analysis code to `R/plan.R`, and communicate your results in `{type}/{type}.Rmd`.
To run the analysis execute `drake::r_make()` in an `R` session loaded from within the project directory.
')
  
  writeLines(header,str_c(project_directory,'/README.md'))
}