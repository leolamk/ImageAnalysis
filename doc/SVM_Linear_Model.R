require(e1071)
require(data.table)

train.label <- read.csv("label_train.csv", header = T, as.is = T)
train.label <- train.label[,-1]

SIFT_feature <- read.csv("SIFT_train.csv", header = F, as.is = T)
RGB.feature  <- read.csv("rgb_feature1_0.csv", header = T, as.is = T)
HOG.feature  <- read.csv("hog.csv", header = T, as.is = T)
LBP.feature  <- read.csv("LBP.csv", header = F)


tune.svm.l <- function(train.data,label){
  
  set.seed(8076)
  label    <- as.factor(label)
  
  #using package e1071 tune function to find best parameter of linear kernel SVM(10-fold)
  output   <- tune.svm(train.data,label, kernel="linear", cost=c(1e-1,5e-1,5e1,5e2,5e3,1e4,5e4,1e5) )
  
  #best performance parameters
  params <- as.list(output$best.parameters)[1]
  
  #running time calculating
  running.time <- round(system.time(svm.linear <- svm(train.data,label, scale= F,params= params, kernel="linear"))[1],4)
  
  #make summary table for output
  cat("Summary table for SVM model(linear kernel): " )
  
  summary <- data.table(Model = "SVM with linear kernel",
                        Param.1 = paste("cost =", params$cost),
                        Param.2 = NA, 
                        Error = output$best.performance,
                        Running.time.per.train(s) = paste(running.time))
  
  return(summary)
}

#OUTPUT

tune.svm.l(SIFT_feature[,2:2001], train.label$label)
#Output of SIFT
#Summary table for SVM model(linear kernel):  
#Model                      Param.1               Param.2    Error       Running.time.per.train(s)
#1: SVM with linear kernel  cost = 5000           NA         0.3286667   60.14 

tune.svm.l(RGB.feature, train.label$label)
#Output of RGB
#Summary table for SVM model(linear kernel):  
#Model                      Param.1               Param.2    Error       Running.time.per.train(s)
#1: SVM with linear kernel  cost = 5000           NA         0.273       43.24 


tune.svm.l(HOG.feature, train.label$label)
#Output of RGB
#Summary table for SVM model(linear kernel):  
#Model                      Param.1               Param.2    Error       Running.time.per.train(s)
#1: SVM with linear kernel  cost = 5000           NA         0.269       32.66 
tune.svm.l(LBP.feature, train.label$label)
#Output of RGB
#Summary table for SVM model(linear kernel):  
#Model                      Param.1               Param.2    Error       Running.time.per.train(s)
#1: SVM with linear kernel  cost = 5000           NA         0.39578       37.83

#Function For Cross Validation
cross.vali <- function(data, label, K){
  
  n <- length(label)
  num.fold <- floor(n/K)
  s <- sample(rep(1:K, c(rep(num.fold, K-1), n-(K-1)*num.fold)))  
  
  cv.error <- rep(NA, K)
  time.calc<-c()
  
  for (i in 1:K){
    
    train       <- data[s != i,]
    train.label <- label[s != i]
    CV.train    <- data.frame(x=train, y=as.factor(train.label))
    
    test        <- data[s == i,]
    test.label  <- label[s == i]
    CV.test     <- data.frame(x=test, y=as.factor(test.label))
    
    
    t           <-proc.time()
    set.seed(11)
    CV.svm.model<-svm(y~.,data=CV.train, kernel="linear",cost=5000)
    
    time.calc  <- (proc.time() - t)[3]
    ypred      <-predict(CV.svm.model, CV.test)
    class.pred <-table(predict=ypred, true= CV.test$y)
    cv.error[i]<-1-sum(diag(class.pred))/sum(class.pred)
    
    
  }  		
  return(c(mean(1-cv.error),mean(time.calc)))
}

cross.vali(HOG.feature, train.label$label,10)
#[1]  0.7346667 21.2400000*10

cross.vali(SIFT_feature[,2:2001], train.label$label,10)
#[1]  0.6686667 51.8620000*10

cross.vali(RGB.feature,train.label$label,10)
#[1]   0.729    25.122*10

cross.vali(LBP.feature,train.label$label,10)
#[1]   0.63574   23.134*10