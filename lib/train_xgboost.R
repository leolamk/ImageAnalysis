library(xgboost)

#Find the parameter of the Xgboost model
xgboost_para <- function(dat_train,label_train,K){
  dtrain = xgb.DMatrix(data=data.matrix(dat_train),label=label_train)
  max_depth<-c(3,5,7)
  eta<-c(0.1,0.3,0.5)
  best_params <- list()
  best_err <- Inf 
  para_mat = matrix(nrow=3, ncol=3)
  
  for (i in 1:3){
    for (j in 1:3){
      my.params <- list(max_depth = max_depth[i], eta = eta[j])
      set.seed(11)
      cv.output <- xgb.cv(data=dtrain, params=my.params, 
                          nrounds = 100, gamma = 0, subsample = 0.5,
                          objective = "multi:softprob", num_class = 3,
                          nfold = K, nthread = 2, early_stopping_rounds = 5, 
                          verbose = 0, maximize = F, prediction = T)
      
      min_err <- min(cv.output$evaluation_log$test_merror_mean)
      para_mat[i,j] <- min_err
      
      if (min_err < best_err){
        best_params <- my.params
        best_err <- min_err
      }
    }
  }
  best_params$num_class <- 3
  return(list(para_mat, best_params, best_err))
}


# Choose the default parameter
best_para<-list(max_depth = 3, eta = 0.3, nrounds = 100, gamma = 0,
                nthread = 2, subsample = 0.5,
                objective = "multi:softprob", num_class = 3)

# Do the cross validation and find the average time spending and error
xgboost_cv.function <- function(X.train, y.train, K){
  
  n <- length(y.train)
  n.fold <- floor(n/K)
  s <- sample(rep(1:K, c(rep(n.fold, K-1), n-(K-1)*n.fold)))  
  cv.error <- rep(NA, K)
  train_time <- rep(NA, K)
  
  for (i in 1:K){
    train.data <- X.train[s != i,]
    train.label <- y.train[s != i]
    test.data <- X.train[s == i,]
    test.label <- y.train[s == i]
    
    t = proc.time()
    bst <- xgboost_train(train.data, train.label, best_para)
    train_time[i] = (proc.time() - t)[3]
    
    pred_label <- xgboost_test(bst, test.data)
    cv.error[i] <- sum(pred_label != test.label)/length(test.label)
  }			
  return(c(mean(1-cv.error),mean(train_time)))
}

# Train the Model
xgboost_train<- function(x, y, params){
  set.seed(1000)
  train = xgb.DMatrix(data=data.matrix(x),label=y)
  model_x <- xgb.train(data=train, params = params, nrounds = 100)
  return(model_x)
}