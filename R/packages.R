
packages <- function(project_directory,type){
  
  packs <- c('drake','conflicted','rmarkdown',
             'callr','magrittr','purrr','progress')
  
  custom_packs <- list(
    report = character(),
    presentation = c('xaringan'),
    manuscript = c('bookdown')
  )
  
  packs <- packs %>%
    c(.,custom_packs[[type]]) %>%
    str_c(collapse = ',')
  
  script <- glue('
## Restore package cache
renv::restore()

## Load dependant CRAN libraries
pacman::p_load({packs})

## Load dependant GitHub libraries
# pacman::p_load_gh()

## Resolve conflicts
# conflict_prefer(quiet = T)

')
  writeLines(script,str_c(project_directory,'/R/packages.R'))
}
