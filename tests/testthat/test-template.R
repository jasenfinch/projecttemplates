
context('template')

test_that('report template works',{
  
  temp_path <- tempdir()
  
  template('report test',
           path = temp_path,
           type = 'report',
           renv = FALSE,
           git = FALSE,
           github = FALSE,
           start = FALSE)
  
  temp_dirs <- list.dirs(temp_path,recursive = FALSE)
  
  expect_true(TRUE %in% stringr::str_detect(temp_dirs,'report_test'))
})

test_that('presentation template works',{
  
  temp_path <- tempdir()
  
  template('presentation test',
           path = temp_path,
           type = 'presentation',
           renv = FALSE,
           git = FALSE,
           github = FALSE,
           start = FALSE)
  
  temp_dirs <- list.dirs(temp_path,recursive = FALSE)
  
  expect_true(TRUE %in% stringr::str_detect(temp_dirs,'presentation_test'))
})

test_that('manuscript template works',{
  
  temp_path <- tempdir()
  
  template('manuscript test',
           path = temp_path,
           type = 'manuscript',
           renv = FALSE,
           git = FALSE,
           github = FALSE,
           start = FALSE)
  
  temp_dirs <- list.dirs(temp_path,recursive = FALSE)
  
  expect_true(TRUE %in% stringr::str_detect(temp_dirs,'manuscript_test'))
})
