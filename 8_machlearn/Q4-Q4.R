# Quiz 3

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