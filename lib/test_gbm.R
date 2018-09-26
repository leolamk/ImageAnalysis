######################################################
### Fit the classification model with testing data ###
######################################################

### Author: Leo Lam
### Project 3
### ADS Spring 2018

test <- function(fit_train, dat_test){
  
  ### Fit the classfication model with testing data
  
  ### Input: 
  ###  - the fitted classification model using training data
  ###  -  processed features from testing images 
  ### Output: training model specification
  
  ### load libraries
  library("gbm")
  
#  dat_train$training_label <- label_train
#  train <- dat_train
  
  #pred <- predict(fit_train$fit, newdata=dat_test, 
  #                n.trees=fit_train$iter, type="response")
  
  pred<- predict.gbm(fit_train$gbm.fit, dat_test, n.trees = 600, type='response')
  result <- apply(pred,1,which.max)
  return(result)
}

