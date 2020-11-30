#reading in data
happiness.data<-read.csv(file="/Users/noahgallagher1/Documents/FALL 2020/STAT 410/Project Data/2019.csv",
                         header=TRUE, sep=",")

#plotting histogram with fitted normal dist
library(rcompanion)
plotNormalHistogram(happiness.data$Score)

#normality check
shapiro.test(happiness.data$Score)

#Renaming the variables
Economy <- happiness.data$GDP.per.capita
Family <- happiness.data$Social.support
Health <- happiness.data$Healthy.life.expectancy
Freedom <- happiness.data$Freedom.to.make.life.choices
Trust <- happiness.data$Perceptions.of.corruption
Generosity <- happiness.data$Generosity

#fitting general linear model
summary(fitted.model<- glm(Score~ Economy + Family + Health + Freedom + Trust + Generosity,data = happiness.data, family=gaussian(link=identity)))

#outputting estimated sigma
sigma(fitted.model)

#checking model fit 
null.model<- glm(Score ~ 1, data = happiness.data,family = gaussian(link=identity))
print(deviance<- -2*(logLik(null.model)-logLik(fitted.model)))
print(p.value<- pchisq(deviance, df=7, lower.tail=FALSE))
