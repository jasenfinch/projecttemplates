
context('template')

test_that('report template works',{
  
  # skip_on_ci()
  
  temp_path <- tempdir()
  
  template('report test',path = temp_path,type = 'report',github = FALSE,start = FALSE)
  
  temp_dirs <- list.dirs(temp_path,recursive = FALSE)
  
  expect_true(TRUE %in% stringr::str_detect(temp_dirs,'report_test'))
})

test_that('presentation template works',{
  
  # skip_on_ci()
  
  temp_path <- tempdir()
  
  template('presentation test',path = temp_path,type = 'presentation',github = FALSE,start = FALSE)
  
  temp_dirs <- list.dirs(temp_path,recursive = FALSE)
  
  expect_true(TRUE %in% stringr::str_detect(temp_dirs,'presentation_test'))
})

test_that('manuscript template works',{
  
  # skip_on_ci()
  
  if (!('wordcountaddin' %in% rownames(installed.packages()))){
    devtools::install_github('benmarwick/wordcountaddin')
  }
  
  temp_path <- tempdir()
  
  template('manuscript test',path = temp_path,type = 'manuscript',github = FALSE,start = FALSE)
  
  temp_dirs <- list.dirs(temp_path,recursive = FALSE)
  
  expect_true(TRUE %in% stringr::str_detect(temp_dirs,'manuscript_test'))
})