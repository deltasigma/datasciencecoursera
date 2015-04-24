# Auxiliary exploratory analisys for project
library(ggplot2)
# Fixing factor variables
mtcars$am <- as.factor(mtcars$am)
levels(mtcars$am)[levels(mtcars$am)=="1"] <- "manual"
levels(mtcars$am)[levels(mtcars$am)=="0"] <- "automatic"

# Plot predictors
p <- qplot(am,mpg,color=cyl,data=mtcars)
p


par(mar=c(0,0,0,0))
pairs(mtcars, panel = panel.smooth, main = "Cars Performance")
pairs(mtcars[,c("mpg","cyl","disp")], panel = panel.smooth, main = "Cars Performance")

plot(mtcars$mpg ~ mtcars$am)


model <- lm(mpg ~ . , mtcars)


library("ggplot2")
carParameter <- ggplot(mtcars, aes(x = am, y = mpg, color=wt)) + geom_point(size=1)
carParameter <- carParameter + facet_grid(. ~ cyl)
carParameter


install.packages("corrplot")
library(corrplot)

# build the matrix
mcor<-cor(mtcars)

# Print mcor and round to 2 digits
round(mcor,digits=2)

# plot it
corrplot(mcor)
corrplot(mcor, method="shade", shade.col=NA)
corrplot(mcor,addCoef.col="black", method="shade", shade.col=NA)

require(graphics)
pairs(mtcars, main = "mtcars data")
