# projecttemplates

[![R build status](https://github.com/jasenfinch/projecttemplates/workflows/R-CMD-check/badge.svg)](https://github.com/jasenfinch/projecttemplates/actions)
[![Codecov test coverage](https://codecov.io/gh/jasenfinch/projecttemplates/branch/master/graph/badge.svg)](https://codecov.io/gh/jasenfinch/projecttemplates?branch=master)
[![license](https://img.shields.io/badge/license-GNU%20GPL%20v3.0-blue.svg)](https://github.com/jasenfinch/projecttemplates/blob/master/DESCRIPTION)
[![GitHub release](https://img.shields.io/github/release/jasenfinch/projecttemplates.svg)](https://GitHub.com/jasenfinch/projecttemplates/releases/)

Quick and simple generation of [targets](https://docs.ropensci.org/targets/)  and [renv](https://rstudio.github.io/renv/index.html) powered project templates for reproducible research and analyses.

### Installation

Install from github using `devtools`:

```
devtools::install_github('jasenfinch/projecttemplates')
```

### Quick start

Templates include **report**, **manuscript** and **presentation**.
The following will generate a template report project in the current working directory:

```
projecttemplates::template('A project title',path = '.',type = 'report',start = FALSE)
```
