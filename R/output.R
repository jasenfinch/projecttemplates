#' Add project outputs
#' @description Add project communication outputs to a project directory.
#' @param project_name project name/title
#' @param project_directory the project directory file path
#' @param type project type. Should be one returned by \code{projectTypes()}.
#' @examples
#' \dontrun{
#' projectSkeleton(paste0(tempdir(),'/test_project'))
#' output('test project',paste0(tempdir(),'/test_project'),type = 'report')
#' }
#' @importFrom lubridate month year
#' @importFrom utils installed.packages
#' @export

output <-  function(project_name,project_directory,type = projectTypes()){
  
  
  if (missing(type)) {
    type <- 'report'
  }
  
  type <- match.arg(type)
  
  message('Adding output templates')
  
  path <- str_c(project_directory,'/',type)
  
  dir.create(path)
  
  current_date <- Sys.Date()
  current_month <- current_date %>% 
    month(label = TRUE,abbr = FALSE) %>% 
    as.character()
  current_year <- current_date %>%
    year()
  
  templates <- list(
    report = glue('
---
title: "{project_name}"
output: html_document
bibliography: references.bib
---

{reportHeader()}

```{{r setup, include=FALSE}}
opts_chunk$set(echo = FALSE,message = FALSE,warning = FALSE)
```
'),
    presentation = glue('
---
output:
  xaringan::moon_reader:
    seal: false
    lib_dir: libs
    css: ["default","default-fonts", "custom-theme.css"]
    nature:
      highlightStyle: github
      highlightLines: true
      countIncrementalSlides: false
      self_contained: true
---

{reportHeader()}

```{{r setup, include=FALSE}}
opts_chunk$set(echo = FALSE,dpi = 300,message = FALSE)
options(htmltools.dir.version = FALSE)
```

class: inverse, center, middle, title-slide

# {project_name}

<br>

### {{Author names}}

### {{Event name}}

#### {current_month} {current_year}
'),
    manuscript = glue('---
output: 
  bookdown::word_document2:
    reference_docx: template.docx
  bookdown::pdf_document2:
    toc: false
fontsize: 12pt
header-includes:
  - \\linespread{{2}}
  - \\usepackage{{lineno}}
  - \\linenumbers
bibliography: references.bib
---

{reportHeader()}

```{{r setup, include=FALSE}}
opts_chunk$set(echo = FALSE,
                      warning = FALSE,
                      message = FALSE)
```

# **Title:** {project_name} {{-}}

**Authors:**

**Addresses:**

**Keywords:**

# Abstract {{-}}

# Introduction

# Materials and methods

# Results

# Discussion

# Conclusions

# Acknowlegements

```{{r check,comment="",cache=FALSE}}
manuscriptCheck("manuscript/manuscript.Rmd",checks = c("word count"))
```

# References

'),
    figures = '---
title: Figures
output: 
  pdf_document:
    keep_tex: false
---

{reportHeader()}

```{r setup, include=FALSE}
opts_chunk$set(echo = FALSE,
                      warning = FALSE,
                      message = FALSE)
```
',
    tables = '---
title: Tables
output: 
  pdf_document:
    includes:
header-includes:
  - \\usepackage{booktabs}
  - \\usepackage{longtable}
  - \\usepackage{array}
  - \\usepackage{multirow}
  - \\usepackage{wrapfig}
  - \\usepackage{float}
  - \\usepackage{colortbl}
  - \\usepackage{pdflscape}
  - \\usepackage{tabu}
  - \\usepackage{threeparttable}
  - \\usepackage{threeparttablex}
  - \\usepackage[normalem]{ulem}
  - \\usepackage{makecell}
  - \\usepackage{xcolor}
---

{reportHeader()}

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE,
                      warning = FALSE,
                      message = FALSE)
```
',
    supplementary = '---
title: Supplementary information
output: 
  pdf_document:
    keep_tex: false
header-includes:
  - \\usepackage{booktabs}
  - \\usepackage{longtable}
  - \\usepackage{array}
  - \\usepackage{multirow}
  - \\usepackage{wrapfig}
  - \\usepackage{float}
  - \\usepackage{colortbl}
  - \\usepackage{pdflscape}
  - \\usepackage{tabu}
  - \\usepackage{threeparttable}
  - \\usepackage{threeparttablex}
  - \\usepackage[normalem]{ulem}
  - \\usepackage{makecell}
  - \\usepackage{xcolor}
---

{reportHeader()}

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE,
                      warning = FALSE,
                      message = FALSE)
```
'
  )
  
  file.create(str_c(path,'/references.bib'))
  
  template_directory <- system.file('templates',package = 'projecttemplates')
  
  if (type == 'report') {
    writeLines(templates[[type]],str_c(path,'/',type,'.Rmd')) 
  } 
  
  if (type == 'presentation') {
    invisible(file.copy(str_c(template_directory,'custom-theme.css',sep = '/'),str_c(project_directory,type,sep = '/')))
    writeLines(templates[[type]],str_c(path,'/',type,'.Rmd')) 
  }
  
  if (type == 'manuscript') {
    invisible(file.copy(str_c(template_directory,'template.docx',sep = '/'),str_c(project_directory,type,sep = '/')))
    
    if (!('wordcountaddin' %in% rownames(installed.packages()))){
      stop("The manuscript template requires the wordcountaddin package. Install this using:\n\ndevtools::install_github('benmarwick/wordcountaddin')",call. = FALSE)
    }
    
    invisible(file.copy(str_c(template_directory,'manuscriptCheck.R',sep = '/'),str_c(project_directory,'R/functions',sep = '/')))
    writeLines(templates[[type]],str_c(path,'/',type,'.Rmd'))
    writeLines(templates[['figures']],str_c(path,'/','figures.Rmd'))
    writeLines(templates[['tables']],str_c(path,'/','tables.Rmd'))
    writeLines(templates[['supplementary']],str_c(path,'/','supplementary.Rmd'))
  }
}

#' @importFrom utils packageVersion

reportHeader <- function(){
  
  version <- packageVersion('projecttemplates') %>% 
    as.character()
  
  report_header <- glue('<!-- Generated by projecttemplates (https://jasenfinch.github.io/projecttemplates/) v{version} -->')
  
  return(report_header)
}