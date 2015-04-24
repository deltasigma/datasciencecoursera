# Function to evaluate statistics over regressions
cstat <- function(x = NULL, y = NULL) {
        # Fit linear model
        fit <- lm(y ~ x)
        
        # Beta0 and Beta1 from linear model
        beta0 <- fit$coefficients[1]
        beta1 <- fit$coefficients[2]
        
        # Get n for the sample
        n <- length(y)
        
        # Variance for estimated residuals
        sigma <- sqrt(sum(fit$residuals^2)/(n-2))
        
        # Sum of squared Xs
        ssx <- sum((x - mean(x))^2)
        
        # Std Error for intercept
        seBeta0 <- (1/n + mean(x)^2 / ssx) ^ 0.5 * sigma
        
        # Std Error for slope
        seBeta1 <- sigma / sqrt(ssx)
        
        # T distribution for Beta0 and Beta1
        tBeta0 <- beta0 / seBeta0
        tBeta1 <- beta1 / seBeta1
        
        # p values for coefficients
        pBeta0 <- 2 * pt(abs(tBeta0), df = n - 2, lower.tail = F)
        pBeta1 <- 2 * pt(abs(tBeta1), df = n - 2, lower.tail = F)
        
        # Table with estimators
        coefTable <- rbind(c(beta0, seBeta0, tBeta0, pBeta0),
                           c(beta1, seBeta1, tBeta1, pBeta1))
        
        # Setting appropriated names
        colnames(coefTable) <- c("Estimate", "Std. Error", "t value", "P(>|T|)")
        rownames(coefTable) <- c("(Intercept)", "x")
        
        coefTable
}

confInterval <- function(x = NULL, y = NULL) {
        fit <- lm(y ~ x)
        sumCoef <- summary(fit)$coefficients
        
        # bottom and top intercept
        bi <- sumCoef[1,1] - 1 * qt(.975, df = fit$df) * sumCoef[1,2]
        ti <- sumCoef[1,1] + 1 * qt(.975, df = fit$df) * sumCoef[1,2]
        
        # botton and top slope
        bs <- sumCoef[2,1] - 1 * qt(.975, df = fit$df) * sumCoef[2,2]
        ts <- sumCoef[2,1] + 1 * qt(.975, df = fit$df) * sumCoef[2,2]
        
        # prepare response
        r <- rbind(c(bi,ti),c(bs,ts))
        colnames(r) <- c("Top", "Bottom")
        rownames(r) <- c("Intercept", "Slope")
        
        r
}

pred <- function(x = NULL, y = NULL, predictor = NULL) {
        fit <- lm(y ~ x)
        
        prediction <- predictor * fit$coefficients[2] + fit$coefficients[1]
        
        prediction
}

# Q2 - Regression Models
carModel <- lm(mtcars$mpg ~ mtcars$wt)
n <- length(mtcars$mpg)
sigma <- sqrt(sum(carModel$residuals^2)/(n-2))