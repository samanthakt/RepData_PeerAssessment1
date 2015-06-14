---
title: "Reproducible Research: Peer Assessment 1"
output:
  html_document:
    keep_md: true
---
### Necessary packages
- dplyr
- ggplot2



## Loading and preprocessing the data

```r
activity <- read.csv("./activity/activity.csv", header=TRUE, na.strings="NA")
activity$date <- as.Date(activity$date)
```

## What is mean total number of steps taken per day?
Histogram of the total number of steps taken per day

```r
sumdays <- tapply(activity$steps, activity$date, sum, na.rm=TRUE)
hist(sumdays, xlab="Total number of steps per day")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png) 

Mean and median of the total number of steps taken per day

```r
mean(sumdays)
```

```
## [1] 9354.23
```

```r
median(sumdays)
```

```
## [1] 10395
```

## What is the average daily activity pattern?
Plot of the average number of steps takens across all days in eack 5-minutes interval

```r
int <- group_by(activity, interval)
steps <- summarize(int, mean=mean(steps, na.rm=TRUE))
plot <- ggplot(steps, aes(interval, mean))
plot + geom_line()+
  labs(x="Interval", y="Average steps taken")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png) 

The 5-minutes interval that contains the maximum number of steps

```r
x <- max(steps$mean)
y <- match(x,steps$mean)
steps[y,1]
```

```
## Source: local data frame [1 x 1]
## 
##   interval
## 1      835
```

## Imputing missing values
Number of missing values in the dataset

```r
sum(is.na(activity))
```

```
## [1] 2304
```

Filling all the missing values with the steps mean considering all days

```r
activity$steps[is.na(activity$steps)]<-mean(activity$steps, na.rm=TRUE)
```

Histogram of the total number of steps taken per day

```r
sumdays <- tapply(activity$steps, activity$date, sum, na.rm=TRUE)
hist(sumdays, xlab="Total number of steps per day")
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8-1.png) 

Mean and median of the total number of steps taken per day

```r
mean(sumdays)
```

```
## [1] 10766.19
```

```r
median(sumdays)
```

```
## [1] 10766.19
```

## Are there differences in activity patterns between weekdays and weekends?

```r
activity <- mutate(activity, weekdays=weekdays(activity$date))
activity <- mutate(activity, weekdays2=factor(1*(weekdays=="sábado"|weekdays=="domingo"), labels=c("weekday","weekend")))
int <- group_by(activity, weekdays2, interval)
steps <- summarize(int, mean=mean(steps, na.rm=TRUE))
plot <- ggplot(steps, aes(interval, mean))
plot + geom_line()+
  facet_grid(weekdays2~.)+
  labs(x="Interval", y="Average steps taken")
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10-1.png) 
