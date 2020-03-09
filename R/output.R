
output <-  function(project_name,project_directory,type){
  path <- str_c(project_directory,'/',type)
  
  dir.create(path)
  
  templates <- list(
    report = ' ',
    presentation = ' ',
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

```{{r setup, include=FALSE}}
knitr::opts_chunk$set(echo = FALSE,
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
manuscript_check(checks = c("word count"))
```

# References

'),
    figures = '---
title: Figures
output: 
  pdf_document:
    keep_tex: false
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE,
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
  - \\usepackagenormalem]{ulem}
  - \\usepackage{makecell}
  - \\usepackage{xcolor}
---

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

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE,
                      warning = FALSE,
                      message = FALSE)
```
'
  )
  
  file.create(str_c(path,'/references.bib'))
  
  template_directory <- system.file('templates',package = 'projecttemplates')
  
  if (type != 'manuscript') {
    writeLines(templates[[type]],str_c(path,'/',type,'.Rmd')) 
  } else {
    invisible(file.copy(str_c(template_directory,'template.docx',sep = '/'),str_c(project_directory,type,sep = '/')))
    invisible(file.copy(str_c(template_directory,'manuscriptCheck.R',sep = '/'),str_c(project_directory,'R',sep = '/')))
    writeLines(templates[[type]],str_c(path,'/',type,'.Rmd'))
    writeLines(templates[['figures']],str_c(path,'/','figures.Rmd'))
    writeLines(templates[['tables']],str_c(path,'/','tables.Rmd'))
    writeLines(templates[['supplementary']],str_c(path,'/','supplementary.Rmd'))
  }
}