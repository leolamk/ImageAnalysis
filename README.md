# Image Analysis - Dog, Muffin, and Fried Chicken
Term: Spring 2018

+ **Team Members:**
	+ Peifeng Hong
	+ Leo Lam 
	+ Shiyu Liu
	+ Qianli Zhu
	+ Sitong Chen

	
## Introduction:

In this project, we aimed to construct a classification model to distinguish among images of dog, muffin, and fried chicken. As they often look very similar, it is crucial to build an robust model to accurately classify each image. We compared 5 different classification algorithms, including SVM - Linear, SVM - RBF, GBM, XGBoost, and Random Forest with 4 different feature extraction methods, including RGB, SIFT, HOG, and LBP. The combination of XGBoost algorithm with RGB feature extraction outperformed other models with accuracy 90.1% using 173 seconds.


## What is the Business Problem Solved:

The goal of classification is to identify a set of categories that an observation belongs to, which in our study, the goal is to build a model to classify dog, muffin, and chicken. The mainstream classification algorithms include logistic regression, K-NN, decision tree, random forest, SVM, XGBoost, GBM, and CNN. Yet, although CNN is widely accepted as the most accurate model, it is very a computational expensive and complex model. K-NN is a nonparametric model that is hard to interpret. Logistic regression tends to perform relatively poor compared to the other models. Therefore, in this study, we focused on random forest, GBM, SVM, and XGBoost. As mentioned, some of the accurate algorithms required deep understanding of data science and machine learning, which are often very difficult for users without a strong foundation in statistics and computer science. Therefore, in this study, we aimed to construct a image predictive model that is user-friendly and easy to implement for users without a strong background in machine learning. Our target customers are small/middle size companies and individual users that are interested in image analysis but without strong knowledge of data science.


+ **Key Componant:**
	+ Which is the most accurate classification algorithms among SVM, Random Forest, XGBoost, and GBM?
	+ Which is the most accurate feature extraction methods among RGB, SIFT, HOG, and LBP?
	+ Which is the most time efficient classification algorithms among the five models?
	+ Which is the most time efficient feature extraction algorithms among the four methods?
	
+ **Our Finding:**
	+ **Most Accurate Model**
	XGBoost and Random Forest have the highest accuracy:
	 	+ Random Forest has an average 80.6% accuracy with respect to four feature extraction methods
		+ XGBoost has an average 79.8% accuracy with respect to four feature extraction methods
	+ **Most Accurate Feature Extraction Method** 	
	 	+ RGB has the highest average accuracy with 82.5% with respect to five models
	+ **Most Efficient Model** 
	 	+ GBM is the most efficient model with average 109.72s with respect to four feature extraction methods
	+ **Most Efficient Feature Extraction Method**
	 	+ LBP is the most efficient method with average 141.89s with respect to five models
	+ **Best Combination**
		+ XGBoost with RGB feature extraction method has highest accuracy with 90.1% using 173.11s

	
+ **Our Method:**
	+ **Feature Extraction**
		+ Feature extraction was performed on the training images
	+ **Cross Validation**
	    + Extracted features were performed with all five classification models
	    + Cross validation was performed to obtain the optimal parameters
	+ **Best Model** 
	 	+ Each model was run with respect to its best parameter
	 	+ Time used and accuracy of each model were recorded

+ **Result:**
![Accuracy](output/Accuracy.png)
![unemploy](output/Time.png)

	


## Data Sources:

+ 3,000 images were provided by instructor


## Contribution statement: 

Team members: Sitong Chen, Qianli Zhu, Shiyu Liu, Leo Lam, Peifeng Hong


All team members contributed equally in all stages of this project. All team members approve our work presented in this GitHub repository including this contributions statement. 
	+ Leo Lam: Implementation and research of RGB feature extraction and GBM classification algorithm (Presenter)
	+ Peifeng Hong: Implementation and research of HOG feature extraction and Random Forest classification algorithm
	+ Shiyu Liu: Implementation and research of LBP feature extraction and XGBoost classification algorithm
	+ Qianli Zhu: Implementation and research of SVM(RBF) classification algorithm; organization of Github repository 
	+ Sitong Chen: Implementation and research of SVM(Linear) classification algorithm; construction of main file
	
Following [suggestions](https://github.com/TZstatsADS/Spring2018-Project3-Group5). This folder is organized as follows.

```
proj/
├── data/
├── doc/
├── figs/
├── lib/
└── output/


```

Please see each subfolder for a README file.

