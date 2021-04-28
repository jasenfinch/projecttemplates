#' Add R package loading utilities
#' @description Add package utilites to a project directory.
#' @param project_directory the project directory file path
#' @param cran character vector of cran R package dependencies
#' @param bioc character vector of bioconductor R package dependencies
#' @param ghithub character vector of GitHub R package dependencies in the form `repository/package_name`
#' @examples
#' \dontrun{
#' utils(paste0(tempdir(),'/test_project'),cran = 'tidyverse')
#' }
#' @export

utils <- function(project_directory = '.',
                  cran = character(),
                  bioc = character(),
                  github = character()){
  
    cran_bioc <- c(cran,bioc) %>% 
      str_c(collapse = ',') 
  
    if (length(github) > 0){
      github <- github %>% 
        str_c('"',.,'"') %>% 
        str_c(collapse = ',')
    } else {
      github <- ''
    }
    
  
  if (nchar(cran_bioc) > 0) {
    cran_bioc <- glue('pacman::p_load({cran_bioc},install = FALSE)')
  } else {
    cran_bioc <- glue('#pacman::p_load(install = FALSE)')
  }
    
  if (nchar(github) > 0){
    github <- glue('pacman::p_load_gh({github},install = FALSE)')
  } else {
    github <- glue('#pacman::p_load_gh(install = FALSE)')
  }
  
  script <- glue('
## Restore package cache
renv::restore()

## Load CRAN or Bioconductor package dependencies
{cran_bioc}

## Load dependant GitHub package dependencies
{github}

## Resolve conflicts
# conflict_prefer(quiet = TRUE)

')
  writeLines(script,glue('{project_directory}/utils.R'))
}

cranPackages <- function(type){
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
    c(.,custom_packs_cran[[type]])
  
  return(packs_cran)
}

githubPackages <- function(type){
  custom_packs_gh <- list(
    report = character(),
    presentation = character(),
    manuscript = c("benmarwick/wordcountaddin")
  )
  
  packs_gh <- c() %>%
    c(.,custom_packs_gh[[type]])
  
  return(packs_gh)
}