# Quiz 3
# Q1
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
training <- segmentationOriginal[segmentationOriginal$Case == 'Train',]
testing <- segmentationOriginal[segmentationOriginal$Case == 'Test',]

# Remove columns not used
drops <- c('Cell','Case')
training <- training[,!(names(training) %in% drops)]


set.seed(125)
system.time({
  # CART <- train(Class ~ .,
  CART <- train(Class ~ TotalIntenCh2+FiberWidthCh1+PerimStatusCh1+VarIntenCh4,
                      data = training,
                      method=c("rpart"))
  })

# Test the model
predictions <- predict(CART, newdata = testing)
confusionMatrix(predictions, testing$Class)

TotalIntenCh2 = c(23000, 50000, 57000, NA)
FiberWidthCh1 = c(10, 10, 8, 8)
PerimStatusCh1 = c(2, NA, NA, 2)
VarIntenCh4 = c(NA, 100, 100, 100)

quizData = data.frame(TotalIntenCh2,FiberWidthCh1,PerimStatusCh1,VarIntenCh4)

newData <- segmentationOriginal[-(1:2019),]
newData[1:4,] <- rep(rep(NA,119),4)

for(i in 1:4) {
  newData$TotalIntenCh2[i] <- quizData$TotalIntenCh2[i]
  newData$FiberWidthCh1[i] <- quizData$FiberWidthCh1[i]
  newData$PerimStatusCh1[i] <- quizData$PerimStatusCh1[i]
  newData$VarIntenCh4[i] <- quizData$VarIntenCh4[i]
}

# Remove columns not used
newData <- newData[,!(names(newData) %in% drops)]

predict(CART, newdata = newData[4,])

cases <- predict(CART, newdata = newData)

# Q4
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

library(caret)

model <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl,
               data = trainSA, method="glm", family="binomial")

predictions <- predict(model,testSA)

confusionMatrix(predictions,testSA$chd)

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
