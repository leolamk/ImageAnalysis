#########################################################
### Train a classification model with training images ###
#########################################################

### Author: Leo Lam
### Project 3
### ADS Spring 2018


train <- function(dat_train, label_train, par=NULL){
  
  ### Train a Gradient Boosting Model (GBM) using processed features from training images

  ### Input: 
  ###  -  processed features from images 
  ###  -  class labels for training images
  ### Output: training model specification
  
  ### load libraries
  library("gbm")
  
  # data merging
  dat_train$training_label <- label_train

  #best parameters from CV: shrinkage = 0.03, n.trees = 600
  gbm<- gbm(training_label~., data=dat_train, interaction.depth=3,
            shrinkage=0.03, n.trees=600, distribution='multinomial')
  return(list(gbm.fit = gbm))
}

