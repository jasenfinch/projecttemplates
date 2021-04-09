#' Add package utilities
#' @description Add package utilites to a project directory.
#' @param project_directory the project directory file path
#' @param type project type. Should be one returned by \code{projectTypes()}.
#' @examples
#' \dontrun{
#' projectSkeleton(paste0(tempdir(),'/test_project'))
#' utils(paste0(tempdir(),'/test_project'),type = 'report')
#' }
#' @export

utils <- function(project_directory,type){
  
  packs <- c('targets',
             'tarchetypes',
             'conflicted',
             'magrittr',
             'purrr',
             'knitr')
  
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
# conflict_prefer(quiet = TRUE)

')
  writeLines(script,str_c(project_directory,'/R/utils.R'))
}
