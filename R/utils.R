#' Add R package settings
#' @description Add project utilities to a project directory such as package settings.
#' @param project_directory the project directory file path
#' @examples
#' \dontrun{
#' utils(paste0(tempdir(),'/test_project'))
#' }
#' @export

utils <- function(project_directory = '.'){
  
  script <- glue('
{scriptHeader()}

## Resolve conflicts
# conflicted::conflict_prefer(quiet = TRUE)

## Targets options
tar_option_set(error = "continue")

')
  writeLines(script,glue('{project_directory}/utils.R'))
}
