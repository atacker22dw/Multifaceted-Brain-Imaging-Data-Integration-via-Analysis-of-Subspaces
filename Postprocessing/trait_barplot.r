#install rmatio
library(rmatio)
library(ggplot2)


#frank mask trait vector
y<-read.mat(file.choose())
y<-unlist(y)
x<-c("Num Correct Responses (Penn)", "Total Skipped Items (Penn) (-)", 
     "Median Reaction Time (Penn) (-)" , "Oral Reading Recognition Unadjusted", 
     "Oral Reading Recognition Age Adjusted", "Picture Vocab Unadjusted", 
     "Picture Vocab Age Adjusted", "Penn Word Memory Test Total Correct", 
     "Penn Word Memory Test Median Reaction Time Correct (-)","Pattern Processing Speed Unadj (-)", 
     "Pattern Processing Speed Age Adjusted (-)", "DD 200 at 1 month", 
     "DD 200 at 6 months", "DD 200 1 year", "DD 200 at 3 years",
     "DD 200 5 years", "DD 200 at 10 years", 
     "DD 40k at 6 months", "DD 40k at 1 year", "DD 40k at 3 years",
     "DD 40k at 5 years", "DD 40k at 10 years", "DD AUC 200",
     "DD AUC 40k", "Total Correct Line Orientation", "Median Time Line Orientation (-)",
     "Total Positions Off Line Orientation (-)",
     "TP (short penn)", "TN", "FP (-)", "FN (-)", 
     "Median Response Time for TP (-)", "Sensitivity (Short Penn)",
     "Specificity (Short Penn)", "Longest Run of Non-Responses (Short Penn) (-)"
     ,  "Working Memory Age Adjusted",
     "Working Memory Unadjusted", "Picture Sequence Memory Age Adjusted", 
     "Picture Sequence Memory Unadjusted"
     ,"Education", "Income",
     "Card sort Unadjusted", "Card Sort Adjusted", "Flanker Task Unadjusted", "Flanker Task Adjusted" )

col<-c("coral3", "coral3", "coral3", "chartreuse3", "chartreuse3",
       "blueviolet","blueviolet", "gold2", "gold2", "deepskyblue3",
       "deepskyblue3", "gray38" , "gray38", "gray38", "gray38",
       "gray38", "gray38", "gray38", "gray38", "gray38", "gray38",
       "gray38", "gray38", "gray38", "orangered1", "orangered1",
       "orangered1", "ivory3", "ivory3", "ivory3", "ivory3", 
       "ivory3", "ivory3", "ivory3", "ivory3", "navy", "navy", "tomato2",
       "tomato2","black", "black", "springgreen2", "springgreen2", "snow3",
       "snow3")
cov<-factor(x, levels = x[order(x)])
df<-data.frame(x,y)

#flip inversely coded
inverse_indices <- c(2:3, 9:11, 26:27, 30:32, 35)
df[inverse_indices,2]=-df[inverse_indices,2]
alpha_values <- rep(0.2, 45)
sig <- c(1, 3:9, 11:18, 21:27, 29:30)
alpha_values[sig]<-1 

#p<- ggplot(df,aes(cov,y))+geom_bar(stat="identity", fill = col)+coord_flip()
#if instead you want bars still in order but descending order at that use the following 
p<- ggplot(df,aes(x = reorder(cov, +y), y = y))+geom_bar(stat="identity", fill = col)+coord_flip()
#changing transparency according to jackstraw significant features
p<- ggplot(df,aes(x = reorder(cov, +y), y = y))+geom_bar(stat="identity", fill = col, aes(alpha = alpha_values))+coord_flip()
#manipulate this title as needed
p + ggtitle("Cognition Loadings in Shared Space with FC (Dir 6)") +
   xlab("Cognition Covariates") + ylab("Loadings")
#increse the font size for zhengwu proposal
p + ggtitle("Cognition Loadings in Shared Space with 
          FC/SC on 1058 Subjects") +
   xlab("Cognition Covariates") + ylab("Loadings")+theme_gray(base_size = 15)



Y<-read.mat(file.choose())
Y<-unlist(Y)
X<-c("Number of Dependence Criteria Met", "Yes/No Alcohol Abuse", "Number of Symptoms Met for Abuse", "Yes/No Dependent", 
     "Drinks Per Day (past 12 months)", "Frequency of Alcohol Use (past 12 months) (-)", "Frequency of Drinking 5+ (past 12 months) (-)", "Frequency Drunk (past 12 months) (-)", "Max Drinks (past 12 months) ", "Age of First Drink (-)", 
     "Drinks Per Day (all time)",
     "Frequency of Alcohol Use (all time) (-)", "Frequency of Drinking 5+ (all time) (-)", "Frequency Drunk (all time) (-)", 
     "Max Drinks (all time)", 
     "Age First Smoked (-)","Difficulty Quitting", "Most Cig Smoked in a Day", "Regular Cigs Per Day", "Years Smoked",
     "Yes/No Still Smoking", "Times Used Tobacco Today", "Average Weekend Tobacco Use",
     "Total Cigar Use", "Average Weekend Cigar Use", "Number of Days Used Any Tobacco",
     "Times Used Illicit Drugs", "Times Used Cocaine", "Times Used Hallucinogens",
     "Times Used Opiates", "Times Used Sedatives", "Times Used Stimulants", "Marijuana Use Yes/No",
     "Marijuana Dependence", "Age First Used Marijuana (-)", "Marijuana Times Used")
vec <- c(1:15, 21:34, 36)
X <- X[vec]
     
COL<-c("coral3", "coral3", "coral3", "coral3",
       "deepskyblue3", "blueviolet" , "blueviolet" , "blueviolet", "deepskyblue3",
       "gray38" , "deepskyblue3", "blueviolet" , "blueviolet", "blueviolet", "deepskyblue3",
      "green", "green", "pink", "black", "green", "pink", "pink", "pink", "pink", "pink",
      "pink", "red", "red", "red", "red", "red", "red", "gold2", "gold2", "gold2", "gold2")
COL <- COL[vec]

COV<-factor(X, levels = X[order(X)])
DF<-data.frame(X,Y)

#flipping inversely coded covariates
inverse_indices <- c(6:8, 10, 12:14)
DF[inverse_indices,2]=-DF[inverse_indices,2]
alpha_values <- rep(0.1, 30)
sig <- c(1:15, 22:30)
alpha_values[sig]<-1 

sd <- rep(0.5, 30)


P<- ggplot(DF,aes(COV,Y))+geom_bar(stat="identity", fill = COL)+coord_flip()
#descending order
p<- ggplot(DF,aes(x = reorder(COV, +Y), y = Y))+geom_bar(stat="identity", fill = COL)+coord_flip()
#changing transparency
p<- ggplot(DF,aes(x = reorder(COV, +Y), y = Y))+geom_bar(stat="identity", fill = COL, aes(alpha = alpha_values))+coord_flip()
#adding error bars
p<- ggplot(DF,aes(x = reorder(COV, +Y), y = Y))+geom_bar(stat="identity", fill = COL, aes(alpha = alpha_values))+coord_flip()+geom_errorbar(
   aes(ymin = Y-sd, ymax = Y+sd), data = DF, 
   width = 0.2, position = position_dodge(0.8)
)

p + ggtitle("Use Loadings in Shared Space with FC/SC") +
   xlab("Use Covariates") + ylab("Loadings")





