
source('R/utils.R')

'R/functions/' %>%
  list.files(full.names = T) %>%
  walk(source)
