
packages <- function(project_directory,type){
  
  packs <- c('drake','conflicted','rmarkdown',
             'callr','magrittr','purrr','progress','knitr')
  
  custom_packs_cran <- list(
    report = character(),
    presentation = c('xaringan'),
    manuscript = c('bookdown')
  )
  
  packs_cran <- packs %>%
    c(.,custom_packs_cran[[type]]) %>%
    str_c(collapse = ',')
  
  custom_packs_gh <- list(
    report = character(),
    presentation = character(),
    manuscript = c('"benmarwick/wordcountaddin"')
  )
  
  packs_gh <- c() %>%
    c(.,custom_packs_gh[[type]]) %>%
    str_c(collapse = ',')
  
  if (type != 'manuscript'){
    packs_gh <- glue('#pacman::p_load_gh(install = FALSE)')
  } else {
    packs_gh <- glue('pacman::p_load_gh({packs_gh},install = FALSE)')
  }
  
  script <- glue('
## Restore package cache
renv::restore()

## Load dependant CRAN libraries
pacman::p_load({packs_cran},install = FALSE)

## Load dependant GitHub libraries
{packs_gh}

## Resolve conflicts
# conflict_prefer(quiet = T)

')
  writeLines(script,str_c(project_directory,'/R/packages.R'))
}
