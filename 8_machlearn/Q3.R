# Quiz 3
# Q1
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
training <- segmentationOriginal[segmentationOriginal$Case == 'Train',]
testing <- segmentationOriginal[segmentationOriginal$Case == 'Test',]
set.seed(125)
system.time({
  CART <- train(Class ~ .,
                      data = training,
                      method=c("rpart"))
  })

# Test the model
predictions <- predict(CART, newdata = testing)
confusionMatrix(predictions, testing$Class)

TotalIntench2 = c(23000, 50000, 57000, NA)
FiberWidthCh1 = c(10, 10, 8, 8)
PerimStatusCh1 = c(2, NA, NA, 2)
VarIntenCh4 = c(NA, 100, 100, 100)

quizData = data.frame(TotalIntench2,FiberWidthCh1,PerimStatusCh1,VarIntenCh4)

quizData[0,]

str(quizData[1,])

cases <- predict(CART, newdata = quizData[1,])

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
