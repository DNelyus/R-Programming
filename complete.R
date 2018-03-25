library(stringr)
library(readr)
library(dplyr)

complete <- function(directory, ind = 1:332) {

  for(i in 1:length(ind)) {
    # build file name from received id, padded with zeros to match file names in specdata
    filename <- file.path(directory,paste0(str_pad(ind[i], 3, pad = "0"),".csv"))
    # read file content
    tmp <- read_csv(filename, col_types = list(col_date(),col_double(),col_double(),col_integer()))
    good <- complete.cases(tmp)
    tot.good <- sum(good)
    comp.cases <- rbind(comp.cases, data.frame(id = ind[i], nobs = tot.good))
  }
  comp.cases
}

cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)
?data.frame
cc <- complete("specdata", 54)
print(cc$nobs)

set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])
