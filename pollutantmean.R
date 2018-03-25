library(stringr)
library(readr)
library(dplyr)

pollutantmean <- function(directory, pollutant = " ", id = 1:332) {
  data <- NULL
  for(i in 1:length(id)) {
  # build file name from received id, padded with zeros to match file names in input folder 'directory'
  filename <- file.path(directory,paste0(str_pad(id[i], 3, pad = "0"),".csv"))
  # read file content
  tmp <- read_csv(filename, col_types = list(col_date(),col_double(),col_double(),col_integer()))
  if(is.null(data)) {
    data <- tmp
  } else {
    # combine rows to previously read files
    data <- rbind(data, tmp)
    }
  }
  # calculate mean of non-na values of input column 'pollutant'
  mean(data[[pollutant]], na.rm = TRUE)
}
