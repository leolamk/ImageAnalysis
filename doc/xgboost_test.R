  library(xgboost)



# The test functon called by cross-validation
xgboost_test<- function(model, x){
  pred <- predict(model, as.matrix(x))
  pred <- matrix(pred, ncol=3, byrow=TRUE)
  pred_labels <- max.col(pred) - 1
  return(pred_labels)
}

# Give the prediction result.
xgboost_test_result<-function(model, x){
  pred<-predict(model, as.matrix(x))
  return(pred)
}





