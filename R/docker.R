#' Add docker infrastructure
#' @description Add docker infrastructure to a project directory.
#' @param project_name project name/title
#' @param type project type. Should be one returned by \code{projectTypes()}.
#' @param path target file path for project directory
#' @param renv add infrastructure for renv package environment management
#' @examples 
#' \dontrun{
#' projectSkeleton(paste0(tempdir(),'/test_project'))
#' docker('test project',path = tempdir())
#' }
#' @export

docker <- function(project_name,type = 'report',path,renv = TRUE){
  message('Adding Docker infrastructure')
  
  type <- match.arg(type,
                    choices = projectTypes())
  
  project_name_directory <- project_name %>%
    str_replace_all(' ','_')
  
  project_directory <- projectDirectory(project_name,
                                        path)
  
  r_version <- str_c(R.Version()$major,'.',R.Version()$minor)
  
  if (type == 'manuscript'){
    texlive_install <-  '

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y apt-utils texlive'
  } else {
    texlive_install <- ''
  }
  
  if (isTRUE(renv)){
    
    package_install <- '

RUN Rscript -e "install.packages(c(\'renv\'), repos = c(CRAN = \'https://cloud.r-project.org\'))"'
    
    renv_text <- '
    
COPY renv.lock renv.lock

RUN Rscript -e "renv::consent(provided = TRUE); renv::restore(prompt = FALSE)"' 
  } else {
    package_install <- '
    
COPY R/utils.R utils.R
RUN Rscript -e "install.packages(\'pacman\')"
RUN Rscript utils.R
RUN rm utils.R'
    renv_text <- ''
  }
  
  glue('
{scriptHeader()}
FROM rocker/verse:{r_version}{texlive_install}{package_install}

WORKDIR /home/{project_name_directory}{renv_text}

ENTRYPOINT ["Rscript","run.R"]
       ') %>%
    writeLines(con = str_c(project_directory,'/Dockerfile'))
  
  glue("
  
## Docker

This project supports the use of [docker](https://www.docker.com/) containers for reproducible project compilation.
With docker installed, run the following from a terminal, within the project directory, to build the image.

``` sh
docker build . -t {str_to_lower(project_name_directory)}
````

The project can then be compiled using:

``` sh
docker run -v $(pwd):/home/{project_name_directory} {str_to_lower(project_name_directory)}
```
       ") %>%
    write(file = str_c(project_directory,'/README.md'),append = TRUE)
}