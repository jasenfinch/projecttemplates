#' Add docker infrastructure
#' @description Add docker infrastructure to a project directory.
#' @param project_name project name/title
#' @param path target file path for project directory
#' @examples 
#' \dontrun{
#' projectSkeleton(paste0(tempdir(),'/test_project'))
#' docker('test project',path = tempdir())
#' }
#' @export

docker <- function(project_name,path){
  message('Adding Docker infrastructure')
  
  project_name_directory <- project_name %>%
    str_replace_all(' ','_')
  
  project_directory <- projectDirectory(project_name,
                                        path)
  
  r_version <- str_c(R.Version()$major,'.',R.Version()$minor)
  
  glue('
{scriptHeader()}
FROM rocker/verse:{r_version}

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get install -y apt-utils texlive-base

RUN apt-get install -y texlive

RUN Rscript -e "install.packages(c(\'renv\'), repos = c(CRAN = \'https://cloud.r-project.org\'))"

WORKDIR /home/rstudio/{project_name_directory}

COPY renv.lock renv.lock

RUN Rscript -e "renv::consent(provided = TRUE); renv::restore(prompt = FALSE)"

ENTRYPOINT ["Rscript","-e","renv::activate(); renv::hydrate(); targets::tar_make()"]
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
docker run -v $(pwd):/home/rstudio/{project_name_directory} {str_to_lower(project_name_directory)}
```
       ") %>%
    write(file = str_c(project_directory,'/README.md'),append = TRUE)
}