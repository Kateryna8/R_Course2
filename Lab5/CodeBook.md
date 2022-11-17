***Code book***
___
Code book створений для опису змінних, даних та будь-яких перетворень або роботи, яка виконується для очищення даних
___

Завантажено дані другої колонки, оскілька перша містить нумерацію:
```
features <- read.table("UCI HAR Dataset/features.txt", colClasses = "character")[,2]
```
Завантажено навчальний та тестовий набори, до кожного набору присвоєно назву колонки з features.
```
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features, check.names = F)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c('activity'))
subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c('subject'))

X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features, check.names = F)
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt", col.names = c('activity'))
subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c('subject'))

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c('n','text'))
```
Створення одного набору даних з унікальними значеннями, шляхом об'єднання навчального та тестового наборів
```
data_lab5 <- cbind(rbind(X_train, X_test),
                   rbind(y_train, Y_test), 
                   rbind(subject.train, subject.test))

all_data <- data_lab5[, !duplicated(colnames(data_lab5))]
```
Витяг mean and standard deviation для кожного вимірювання:
```
install.packages("sos")
library(sos)
install.packages("dplyr")
library(dplyr)
two_param <- select(all_data,  matches("mean\\(\\)|std\\(\\)|subject|activity"))
```
