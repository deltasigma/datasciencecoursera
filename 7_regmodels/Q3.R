# Q1
mtcars$cyl <- as.factor(mtcars$cyl) 
model <- lm(mpg ~ cyl + wt, data=mtcars)
model$coefficients[3]

# Q2
modelPlain <- lm(mpg ~ cyl, data=mtcars)
modelPlain

# Q3
modelInteraction <- lm(mpg ~ cyl*wt, data = mtcars)
summary(modelInteraction)
summary(model)
anova(model,modelInteraction)

# Q4
model <- lm(mpg ~ I(wt * 0.5) + cyl, data = mtcars)
summary(model)

# Q5
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
plot(y,x)
model <- lm(y ~ x)

# Q6
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
plot(y,x)
model <- lm(y ~ x)
dfbetas(model)