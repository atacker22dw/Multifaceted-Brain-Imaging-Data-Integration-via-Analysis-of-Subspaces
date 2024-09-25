library(rmatio)
library(R.matlab)

#restricted.csv
data = read.csv(file.choose())

#sharedvals orig
orig<-read.mat(file.choose())
original<-as.integer(unlist(orig))

#sharedvals valid
valid<-read.mat(file.choose())
validation<-as.integer(unlist(valid))


orig_subset = data[data$Subject %in% original,6]
valid_subset = data[data$Subject %in% validation,6]

matches = orig_subset %in% valid_subset
sum(matches)
#326 