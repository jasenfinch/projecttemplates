% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/targets.R
\name{targetsScript}
\alias{targetsScript}
\title{Add a targets script}
\usage{
targetsScript(project_directory, type = projectTypes())
}
\arguments{
\item{project_directory}{the project directory file path}

\item{type}{project type. Should be one returned by \code{projectTypes()}}
}
\description{
Add a _targets.R script to a project directory
}
\examples{
\dontrun{
projectSkeleton(paste0(tempdir(),'/test_project'))
targetsPipeline(paste0(tempdir(),'/test_project'),type = 'report')
}
}
