
context('template')

test_that('template works',{
  temp_path <- tempdir()
  
  template('report test',path = temp_path,type = 'report',start = FALSE)
  template('manuscript test',path = temp_path,type = 'manuscript',start = FALSE)
  template('presentation test',path = temp_path,type = 'presentation',start = FALSE)
  
  temp_dirs <- list.dirs(temp_path,recursive = FALSE)
  
  expect_true(TRUE %in% stringr::str_detect(temp_dirs,'report_test'))
  expect_true(TRUE %in% stringr::str_detect(temp_dirs,'manuscript_test'))
  expect_true(TRUE %in% stringr::str_detect(temp_dirs,'presentation_test'))
})