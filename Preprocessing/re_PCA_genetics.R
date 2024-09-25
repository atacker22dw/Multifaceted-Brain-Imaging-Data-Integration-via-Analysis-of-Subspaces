#new genetic preprocessing 

#read in original subjects
library(rmatio)
library(R.matlab)
library(ggplot2)


#original subjects
orig<-read.mat(file.choose())
orgi<-unlist(orig)

#read in validation subjects
valid<-read.mat(file.choose())
valid<-unlist(valid)

#concatenate subjects
conc_indices <- append(orig, valid)
conc_indices <- unlist(conc_indices)
#read in RAW data (finalSNPr.data) and SUBSET on above concatenation
new_raw <- fimpute[conc_indices,]
#now do SVD on this and take the scores
pcasnp=prcomp(new_raw, scale = TRUE)
SNPprinp=pcasnp$x

#first rows 375 are original subjects
#last 377 are validation

save(SNPprinp,file='SNPprinp_rePCA.rdata')
writeMat("rePCA.mat", SNPprinp=SNPprinp)
#save()
