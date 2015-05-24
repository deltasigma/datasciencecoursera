# Q3
setwd("~/Work/DSCoursera/datasciencecoursera/8_machlearn")

# q2
library(AppliedPredictiveModeling)
library("Hmisc")
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

training$index <- 1:length(training$CompressiveStrength)

for (i in 1:8) {
  training[i] <- cut2(training[,i], g = 6)
}

plot(training$CompressiveStrength, )

# q3
histogram(training$Superplasticizer)
histogram(log(training$Superplasticizer+1))

# q4
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

p = preProcess(training[,grep("^IL_", colnames(training))],
           method="pca", thresh=0.9)

# Q5
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors[,grep("^IL_", colnames(predictors))])
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

nonPCA = train(diagnosis ~ .,
               data = training,
               method="glm")

PCA = train(diagnosis ~ .,
            data = training,
            preProcess="pca",
            trControl = trainControl(preProcOptions = list(thresh = 0.8)),
            method="glm")

cmnonPCA = confusionMatrix(testing$diagnosis,predict(nonPCA,testing))

cmPCA = confusionMatrix(testing$diagnosis,predict(PCA,testing))

