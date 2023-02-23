# projecttemplates

<!-- badges: start -->
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![R-CMD-check](https://github.com/jasenfinch/projecttemplates/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jasenfinch/projecttemplates/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/jasenfinch/projecttemplates/branch/master/graph/badge.svg)](https://codecov.io/gh/jasenfinch/projecttemplates?branch=master)
[![license](https://img.shields.io/badge/license-GNU%20GPL%20v3.0-blue.svg)](https://github.com/jasenfinch/projecttemplates/blob/master/DESCRIPTION)
[![GitHub release](https://img.shields.io/github/release/jasenfinch/projecttemplates.svg)](https://GitHub.com/jasenfinch/projecttemplates/releases/)
<!-- badges: end -->

Quick and simple generation of [targets](https://docs.ropensci.org/targets/)  and [renv](https://rstudio.github.io/renv/index.html) powered project templates for reproducible research and analyses.

### Installation

Install from github using `devtools`:

```r
devtools::install_github('jasenfinch/projecttemplates')
```

### Quick start

Templates include **report**, **manuscript** and **presentation**.
The following will generate a template report project in the current working directory:

```r
projecttemplates::template(
  'A project title',
  path = '.',
  type = 'report',
  start = FALSE
)
```

### Learn more

The package documentation can be browsed online at <https://jasenfinch.github.io/projecttemplates/>. 

If you believe you've found a bug in `mzAnnotation`, please file a bug (and, if
possible, a [reproducible example](https://reprex.tidyverse.org)) at
<https://github.com/jasenfinch/projecttemplates/issues>.
