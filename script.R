## 1
activity <- read.csv("./activity/activity.csv", header=TRUE, na.strings="NA")
activity$date <- as.Date(activity$date)

## 2
install.packages("dplyr")
library(dplyr)
days <- group_by(activity,date)
sumdays <- summarize (days, sum = sum(steps, na.rm=TRUE))
hist(sumdays$sum, xlab="Total number of steps per day")

mean_median <- summarize(sumdays, mean=mean(sum), median=median(sum))
mean_median

sumdays <- tapply(activity$steps, activity$date, sum, na.rm=TRUE)
hist(sumdays, xlab="Total number of steps per day")

mean(sumdays)
median(sumdays)

## 3
install.packages("dplyr")
library(dplyr)
int <- group_by(activity, interval)
steps <- summarize(int, mean=mean(steps, na.rm=TRUE))
install.packages("ggplot2")
library(ggplot2)
plot <- ggplot(steps, aes(interval, mean))
plot + geom_line()+
  labs(x="Interval", y="Average steps taken")

x <- max(steps$mean)
y <- match(x,steps$mean)
steps[y,1]

## 4
sum(is.na(activity))

mean <- aggregate(steps~date, activity, mean, na.rm=TRUE)
days <- group_by(activity,date)
sumdays <- summarize (days, median = median(steps, na.omit=TRUE))
