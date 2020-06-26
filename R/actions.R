#' @importFrom stringr str_to_lower
#' @importFrom gh gh_whoami

githubActions <- function(project_name,path){
  message('Adding Github Actions workflow')
  
  project_name_directory <- project_name %>%
    str_replace_all(' ','_')
  
  project_directory <- path %>%
    path.expand() %>%
    str_c(project_name_directory,sep = '/')
  
  dir.create(str_c(project_directory,'/.github/workflows'),recursive = TRUE)
  
  glue('
name: Docker

on:
  push:
    # Publish `master` as Docker `latest` image.
    branches:
      - master

    # Publish `v1.2.3` tags as releases.
    tags:
      - v*

  # Run tests for any PRs.
  pull_request:

env:
  # TODO: Change variable to your image\'s name.
  IMAGE_NAME: {project_name_directory}
       
jobs:
  # Run tests.
  # See also https://docs.docker.com/docker-hub/builds/automated-testing/
  test:
    runs-on: ubuntu-18.04
       
    steps:
      - uses: actions/checkout@v2
       
      - name: Build image
        run: | 
            docker build . --file Dockerfile  -t {project_name_directory}
       
      - name: Run test
        env:
          GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}
        run: |
          docker run -e GITHUB_PAT -v $(pwd):/home/rstudio/{project_name_directory} {project_name_directory}
       
       
  # Push image to GitHub Packages.
  # See also https://docs.docker.com/docker-hub/builds/
  push:
    # Ensure test job passes before pushing image.
    needs: test
       
    runs-on: ubuntu-18.04
    if: github.event_name == \'push\'
       
    steps:
      - uses: actions/checkout@v2
      - name: Build image
        run: docker build . --file Dockerfile --tag image
       
      - name: Log into registry
        run: echo "${{{{ secrets.GITHUB_TOKEN }}}}" | docker login docker.pkg.github.com -u ${{{{ github.actor }}}} --password-stdin
       
      - name: Push image
        run: |
          IMAGE_ID=docker.pkg.github.com/${{{{ github.repository }}}}/$IMAGE_NAME
       
          # Change all uppercase to lowercase
          IMAGE_ID=$(echo $IMAGE_ID | tr "[A-Z]" "[a-z]")
          # Strip git ref prefix from version
          VERSION=$(echo "${{{{ github.ref }}}}" | sed -e "s,.*/\\(.*\\),\\1,")
          # Strip "v" prefix from tag name
          [[ "${{{{ github.ref }}}}" == "refs/tags/"* ]] && VERSION=$(echo $VERSION | sed -e "s/^v//")
          # Use Docker `latest` tag convention
          [ "$VERSION" == "master" ] && VERSION=latest
          echo IMAGE_ID=$IMAGE_ID
          echo VERSION=$VERSION
          docker tag image $IMAGE_ID:$VERSION
          docker push $IMAGE_ID:$VERSION
       ') %>%
    writeLines(con = str_c(project_directory,'/.github/workflows/dockerpublish.yml'))
  
  glue("

Alternatively, the project can be compiled with a pre-built docker image directly from GitHub.
Run:

``` sh
docker run -v $(pwd):/home/rstudio/{project_name_directory} docker.pkg.github.com/jasenfinch/{str_to_lower(project_name_directory)}/{project_name_directory}:latest
```
       ") %>%
    write(file = str_c(project_directory,'/README.md'),append = TRUE)
  
  credentials <- gh_whoami()
  
  'README.md' %>%
    str_c(project_directory,'/',.) %>%
    readLines() %>%
    {
      c(.[1:2],
        glue('
      [![Docker](https://github.com/{credentials$login}/{project_name_directory}/workflows/Docker/badge.svg)](https://github.com/{credentials$login}/{project_name_directory}/actions)
      
      '),
        .[3:length(.)])  
    } %>%
    writeLines(con = str_c(project_directory,'/README.md'))
    
}