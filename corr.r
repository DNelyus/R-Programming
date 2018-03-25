library(readr)
library(dplyr)

corr <- function(directory, threshold = 0) {
  
  data <- lapply(dir(directory,pattern = "*.csv", full.names = TRUE),read_csv,col_types = list(col_date(),col_double(),col_double(),col_integer()))
  my_corr <- vector("numeric", length = length(data))
  d <- 0
  
  for(i in 1:length(data)) {
    compl.cases <- complete.cases(data[[i]])
    total_comp <- sum(compl.cases)
    if (total_comp > threshold) {
      nitrates <- pull(data[[i]][compl.cases,], var = nitrate)
      sulfates <- pull(data[[i]][compl.cases,], var = sulfate)
      d <- d + 1
      my_corr[d] <- cor(nitrates, sulfates)
    } 
  }
  my_corr[0:d]
}

