
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
manuscript_check(checks = c("word count")) # ,"spelling"
```

# References

    '),
    figures = ' ',
    tables = ' ',
    supplementary = ' '
  )
  
  file.create(str_c(path,'/references.bib'))
  
  template_directory <- system.file('templates',package = 'projecttemplates')
  
  if (type != 'manuscript') {
    writeLines(templates[[type]],str_c(path,'/',type,'.Rmd')) 
  } else {
    invisible(file.copy(str_c(template_directory,'template.docx',sep = '/'),str_c(project_directory,type,sep = '/')))
    writeLines(templates[[type]],str_c(path,'/',type,'.Rmd'))
    writeLines(templates[['figures']],str_c(path,'/','figures.Rmd'))
    writeLines(templates[['tables']],str_c(path,'/','tables.Rmd'))
    writeLines(templates[['supplementary']],str_c(path,'/','supplementary.Rmd'))
  }
}