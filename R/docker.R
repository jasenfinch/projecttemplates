
docker <- function(project_name,path){
  message('Adding Docker infrastructure')
  
  project_name_directory <- project_name %>%
    str_replace_all(' ','_')
  
  project_directory <- path %>%
    path.expand() %>%
    str_c(project_name_directory,sep = '/')
  
  glue('
FROM rocker/verse:4.0.0

ARG DEBIAN_FRONTEND=noninteractive

RUN Rscript -e "install.packages(c(\'renv\'), repos = c(CRAN = \'https://cloud.r-project.org\'))"

WORKDIR /home/rstudio/{project_name_directory}

COPY renv.lock renv.lock

RUN Rscript -e "renv::consent(provided = TRUE); renv::restore(prompt = FALSE)"

ENTRYPOINT ["Rscript","-e","renv::activate(); renv::hydrate(); drake::r_make()"]
       ') %>%
    writeLines(con = str_c(project_directory,'/Dockerfile'))
  
  glue("
  
## Docker

This project supports the use of [docker](https://www.docker.com/) containers for reproducible project compilation.
With docker installed, run the following from a terminal, within the project directory, to build the image.

``` sh
docker build . -t {project_name_directory}
````

The project can then be compiled using:

``` sh
docker run -v $(pwd):/home/rstudio/{project_name_directory} {project_name_directory}
```
       ") %>%
    write(file = str_c(project_directory,'/README.md'),append = TRUE)
}