#Лабораторна робота № 5. Отримання та очистка даних.
  

#Ви повинні створити один R-скрипт, який називається run_analysis.R, який виконує наступні дії.
#1. Об’єднує навчальний та тестовий набори, щоб створити один набір даних.
#2. Витягує лише вимірювання середнього значення та стандартного відхилення (mean and standard deviation) для кожного вимірювання.
#3. Використовує описові назви діяльностей (activity) для найменування діяльностей у наборі даних.
#4. Відповідно присвоює змінним у наборі даних описові імена.
#5. З набору даних з кроку 4 створити другий незалежний акуратний набір даних (tidy dataset) із середнім значенням для кожної змінної для кожної діяльності та кожного суб’єкту (subject)


features <- read.table("UCI HAR Dataset/features.txt", colClasses = "character")[,2]

X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features, check.names = F)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c('activity'))
subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c('subject'))

X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features, check.names = F)
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt", col.names = c('activity'))
subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c('subject'))

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c('n','text'))

data_lab5 <- cbind(rbind(X_train, X_test),
                   rbind(y_train, Y_test), 
                   rbind(subject.train, subject.test))

all_data <- data_lab5[, !duplicated(colnames(data_lab5))]

install.packages("sos")
library(sos)
install.packages("dplyr")
library(dplyr)
two_param <- select(all_data,  matches("mean\\(\\)|std\\(\\)|subject|activity"))

descr <- within(two_param, activity <- factor(activity, labels = activity_labels[,2]))

descr_name <- aggregate(x = descr[, -c(67,68)], 
                        by = list(descr[,'subject'], descr[, 'activity']),
                        FUN = mean)

write.csv(descr_name, "tidy_dataset.csv", row.names=F)
setwd("/Users/Rudolf/Documents")
