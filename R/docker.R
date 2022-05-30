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
  
  dir.create(str_c(project_directory,'/misc/docker'))
  
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

RUN Rscript -e "renv::restore()"' 
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

ENTRYPOINT ["Rscript","misc/run.R"]
       ') %>%
    writeLines(con = str_c(project_directory,'/misc/docker/Dockerfile'))
  
  glue("
  
## Docker

This project supports the use of [docker](https://docs.docker.com/get-started/overview/) containers for reproducible project compilation.
Utility scripts can be found in the directory `misc/docker` to both build the image and run the container which can be executed using `bash misc/build_project.R` in a linux terminal.

       ") %>%
    write(file = str_c(project_directory,'/README.md'),append = TRUE)
  
  dockerIgnore(project_directory,
               renv)
  dockerBuild(project_directory,project_name_directory)
  dockerRun(project_directory,project_name_directory)
  dockerRunProject(project_directory)
}

dockerIgnore <- function(project_directory,renv = TRUE){
  
  ignores <- c('_targets',
               'data',
               'exports')
  
  if (isTRUE(renv)){
    ignores <- c(ignores,
                 'renv')
  }
 
  ignores %>% 
    write(file = str_c(project_directory,'/.dockerignore'))
}

dockerBuild <- function(project_directory,project_name_directory){
  glue('
docker build . -f misc/Dockerfile -t {str_to_lower(project_name_directory)}
                 ') %>% 
    writeLines(con = str_c(project_directory,'/misc/docker/build_image.sh'))
}

dockerRun <- function(project_directory,project_name_directory){
  glue('
docker run -v ${{pwd}}:/home/{project_name_directory} {str_to_lower(project_name_directory)}
                 ') %>% 
    writeLines(con = str_c(project_directory,'/misc/docker/run_container.sh'))
  
}

dockerRunProject <- function(project_directory){
   glue('
bash misc/docker/build_image.sh
bash misc/docker/run_container.sh
        ') %>% 
    writeLines(con = str_c(project_directory,'/misc/build_project.sh'))
    
}