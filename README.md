CourseProject
=============

Predictive Machine Learning Course Project

This function read in the training set and quiz set in csv format by read.csv function in r. We clean up the data by deleting the following:-
1) Columns with zero variance;
2) Columns with NA and blank spaces more than a threshold selected by the user; 
3) columns 1-6 as the name of users row numbers, time stamps etc should have no bearing to the prediction.
This has resulted in a clean up data set with 54 columns with classe as the outcome and the rest being predictive variables/features
The clean up data is then randomly divided into a training set and a validation/test set to predict the outcome variable "classe" with all the rest of the columns/features as predictors. 
The train set and validation/test set have the following dimensions
> dim(trainset)
[1] 14718    54
> dim(testset)
[1] 4904   54

As this is a classification problem which works best with regularized logistic regression or random forest models, the random forest model of the caret package is use for prediction purposes. 
After training the model on the train set, it is ran on the test set for cross validation to test for accuracy using the confusionmatrix.
Results of the confusionmatrix function for the test/validation set is as follows:-

Confusion Matrix and Statistics

          Reference
Prediction    A    B    C    D    E
         A 1395    2    0    0    0
         B    0  945    4    0    0
         C    0    1  850    1    0
         D    0    1    1  803    2
         E    0    0    0    0  899

Overall Statistics
                                          
               Accuracy : 0.9976          
                 95% CI : (0.9957, 0.9987)
    No Information Rate : 0.2845          
    P-Value [Acc > NIR] : < 2.2e-16       
                                          
                  Kappa : 0.9969          
 Mcnemar's Test P-Value : NA              

Statistics by Class:

                     Class: A Class: B Class: C Class: D Class: E
Sensitivity            1.0000   0.9958   0.9942   0.9988   0.9978
Specificity            0.9994   0.9990   0.9995   0.9990   1.0000
Pos Pred Value         0.9986   0.9958   0.9977   0.9950   1.0000
Neg Pred Value         1.0000   0.9990   0.9988   0.9998   0.9995
Prevalence             0.2845   0.1935   0.1743   0.1639   0.1837
Detection Rate         0.2845   0.1927   0.1733   0.1637   0.1833
Detection Prevalence   0.2849   0.1935   0.1737   0.1646   0.1833
Balanced Accuracy      0.9997   0.9974   0.9968   0.9989   0.9989

The final model is then use to predict the classe variable in 20 cases of the quiz set (pml-testing) with the following results
[1] "B" "A" "B" "A" "A" "E" "D" "B" "A" "A" "B" "C" "B" "A" "E" "E" "A" "B" "B"
[20] "B"
