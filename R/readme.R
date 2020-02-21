
readme <- function(project_name,path){
  header <- str_c('# ',project_name)
  
  writeLines(header,str_c(path,'README.md',sep = '/'))
}