#############################################################
### Construct visual features for training/testing images ###
#############################################################

### Authors: Leo Lam / Peifeng Hong
### Project 3
### ADS Spring 2017


feature <- function(img_dir, set_name, data_name="data", export=T){
  
  ### Construct process features for training/testing images
  ### Sample simple feature: Extract row average raw pixel values as features
  
  ### Input: a directory that contains images ready for processing
  ### Output: an .RData file contains processed features for the images
  
  
  ### RGB - required libraries
  if(!require(EBImage)){
    source('http://bioconductor.org/biocLite.R')
    biocLite('EBImage')
    library('EBImage')
  }
  #information of image data
  dir_names <- list.files(img_dir)
  num_files <- length(list.files(img_dir))
  
  ### RGB - model
  freq_RGB<- list()
  ima<- list()
  R <- 6; G <- 10; B <- 10
  bin_r<- seq(0, 1, length.out=R); bin_g<- seq(0, 1, length.out=G); bin_b<- seq(0, 1, length.out=B)
  
  
  ft<- matrix(nrow=num_files, ncol = R * G * B)
  
  for(i in 1:num_files){
    ima<- imageData(readImage(paste0(img_dir, dir_names[i])))
    ima_RGB <- array(c(ima, ima, ima), dim =c(nrow(ima), ncol(ima), 3))
    freq_RGB[[i]]<- as.data.frame(table(factor(findInterval(ima_RGB[, , 1], bin_r), levels=1:R), 
                                        factor(findInterval(ima_RGB[, , 2], bin_g), levels=1:G), 
                                        factor(findInterval(ima_RGB[, , 3], bin_b), levels=1:B)))
    ft[i, ] <- as.numeric(freq_RGB[[i]]$Freq) / (ncol(ima) * nrow(ima))
  }
  
  ft <- data.frame(ft)
  
  label_train<- read.csv("~/Documents/GitHub/Spring2018-Project3-Group5/output/label_train.csv")
  names(label_train)<-c('ind','img','y')
  ft$y<- label_train[1:num_files,3]
  
  dat <- ft
  
  ### output constructed features
  if(export){
    saveRDS(dat, file=paste0("~/Documents/GitHub/Spring2018-Project3-Group5/output/feature_", data_name, "_", set_name, ".RData"))
  }
  return(dat)
}
