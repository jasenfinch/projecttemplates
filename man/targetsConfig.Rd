% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/targets.R
\name{targetsConfig}
\alias{targetsConfig}
\title{Add a targets configuration file to a project directory}
\usage{
targetsConfig(
  project_directory,
  targets_config = list(main = list(reporter_make = "timestamp_positives"))
)
}
\arguments{
\item{project_directory}{the project directory file path}

\item{targets_config}{a list containing the targets configuration to be written to YAML format}
}
\description{
Add a _targets\code{.yaml} configuration file to a project directory.
}
\examples{
\dontrun{
projectSkeleton(paste0(tempdir(),'/test_project'))
targetsConfig(paste0(tempdir(),'/test_project'))
}
}
