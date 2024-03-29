% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/template.R
\name{template}
\alias{template}
\title{Project templates}
\usage{
template(
  project_name,
  path = ".",
  type = projectTypes(),
  renv = TRUE,
  docker = TRUE,
  git = TRUE,
  github = FALSE,
  private = FALSE,
  github_actions = FALSE,
  force = FALSE,
  start = TRUE
)
}
\arguments{
\item{project_name}{project name/title}

\item{path}{target file path for project directory}

\item{type}{project type. Should be one returned by \code{projectTypes()}.}

\item{renv}{add renv infrastructure for reproducible a R package environment}

\item{docker}{TRUE/FALSE. Create project infrastructure for building a docker container to compile the project.}

\item{git}{TRUE/FALSE. Initialise a Git repository?}

\item{github}{TRUE/FALSE. Create a GitHub repository? Ignored if argument \code{git} is FALSE.}

\item{private}{TRUE/FALSE. Should the GitHub repository be private? Evaluated only if arguments \code{git} and \code{github} are TRUE.}

\item{github_actions}{TRUE/FALSE. Add Github actions infrastructure? Evaluated only if arguments \code{git}, \code{github} and \code{docker} are TRUE.}

\item{force}{force project creation if project directory already exists}

\item{start}{TRUE/FALSE. Should the project be automatically activated in a new RStudio session?}
}
\description{
Generate a project template directory.
}
\examples{
\dontrun{
template('A new project',
         type = 'report',
         github = FALSE,
         start = FALSE)
}
}
