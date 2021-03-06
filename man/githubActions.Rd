% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/actions.R
\name{githubActions}
\alias{githubActions}
\title{Add GitHub actions infrastructure}
\usage{
githubActions(project_name, path)
}
\arguments{
\item{project_name}{project name/title}

\item{path}{target file path for project directory}
}
\description{
Add GitHub actions infrastructure to a project directory.
}
\examples{
\dontrun{
projectSkeleton(paste0(tempdir(),'/test_project'))
githubActions('test project',path = tempdir())
}
}
