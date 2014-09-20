run_analysis <- function(){

ori_dir = getwd() 														# save the current working directory
work_dir <- paste("C:/downloads/ML",dir,sep='') 									# create a path where the required files are contained
setwd(work_dir)															# goto the working directory
pmltrain <- read.csv("pml-training.csv")											# read the training file
quizset <- read.csv("pml-testing.csv")											# read the quiz set file
training <- cleanDF(pmltrain,0.9)												# select predictors by choosing only columns with non "NA" rows > threshold*total num of rows
set.seed(nrow(training))													# set seed using the number of rows 
inTrain = createDataPartition(training$classe, p = 0.75, list = FALSE)						# partition data into training set and test set with variable "Classe" as outcome and
trainset = training[ inTrain,]												# all other variables as preditors										
testset = training[-inTrain,]
modelfit = train(trainset$classe~.,model="rf",data=trainset,verbose=FALSE)					# fit a random forest model to the trainset
pred_cv <- predict(modelfit,testset)											# predict results on test set for cross validation purposes
sink(file="accuracy.txt")													# sends output of confusionmatirx to file											
confusionMatrix(pred_cv, testset$classe)											# check accuracy and related data using the confusionmatrix
sink(file=NULL)															# return output to console
pred_quiz <- predict(modelfit,quizset)											# predict 20 test cases on the quiz set		 						
write(as.character(predict_quiz),"predict_quiz.txt")		 							# writes the prediction to file
setwd(ori_dir)															# restore the original working directory

}

cleanDF <- function(DF,threshold) {
removeColumns <-nearZeroVar(DF) 												# generate a list of columns with zero variance for removal
DF <- DF[, -c(1:6,removeColumns)]												# removes the first 6 columns and columns with zero variance from data
v = apply(DF, 2, function(x) length(which(!is.na(x))))								# generate a list of the number of NA in each column
i = 1
retain = NULL
totcol = ncol(DF)
totrow = nrow(DF)
while(i <= totcol) {														# create a loop to loop through all remaining columns in data set
if ((v[i]/totrow) >= threshold) retain <- c(i,retain)									# retain only columns with % of non-NA >= threshold set
i =i+1
}
DF = DF[,as.numeric(retain)]													# retain only the columns that pass the threshold test
return(DF)
}


