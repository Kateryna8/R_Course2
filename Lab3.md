***Лабораторна робота № 3. Зчитування даних з WEB.***

**Необхідно створити data.frame «movies» з наступними даними: 
номер фільму (rank_data), назва фільму (title_data), тривалість (runtime_data).**

```
install.packages('rvest')
library(rvest)

data_lab3 <- read_html("http://www.imdb.com/search/title?count=100&release_date=2017,2017&title_type=feature") 

rank_data <- as.numeric(html_text(html_nodes(data_lab3,'.text-primary')))

title_data <- html_text(html_nodes(data_lab3,'.lister-item-header a'))

runtime_data_html <- html_nodes(data_lab3,'.text-muted .runtime') 

runtime_data <- html_text(html_nodes(data_lab3,'.text-muted .runtime'))
runtime_data <- as.numeric(gsub("min", "", runtime_data))

movies <- data.frame(Rank = rank_data, Title = title_data, Runtime = runtime_data, stringsAsFactors = FALSE)
```

**1. Виведіть перші 6 назв фільмів дата фрейму.**

```
head(movies$Title)
  
Результат:
[1] "Воно"                         "Пастка"                       "Той, хто біжить по лезу 2049"
[4] "Вітряна ріка"                 "Дюнкерк"                      "Найвеличніший шоумен"   
```

**2. Виведіть всі назви фільмів с тривалістю більше 120 хв.**
```
movies$Title[movies$Runtime > 120]

Результат:
 [1] "Воно"                                     "Той, хто біжить по лезу 2049"            
 [3] "Назви мене своїм ім'ям"                   "Джон Вік 2"                              
 [5] "Мати!"                                    "Kingsman: Золоте кільце"                 
 [7] "Форма води"                               "Вартові Галактики 2"                     
 [9] "Красуня і Чудовисько"                     "Вбивство священного оленя"               
[11] "Квадрат"                                  "Тор: Раґнарок"                           
[13] "Пірати Карибського моря: Помста Салазара" "Диво-жінка"                              
[15] "Людина-павук: Повернення додому"          "Логан: Росомаха"                         
[17] "Зоряні війни: Епізод 8 - Останні Джедаї"  "Roman J. Israel, Esq."                   
[19] "Гра Моллі"                                "Темні часи"                              
[21] "Чужий: Заповіт"                           "Валеріан і місто тисячі планет"          
[23] "Метелик"                                  "Примарна нитка"                          
[25] "Король Артур: Легенда меча"               "Трансформери: Останній лицар"            
[27] "Saban's Могутні рейнджери"                "Вороги"                                  
[29] "Форсаж 8"                                 "Сім сестер"                              
[31] "Постріл в безодню"                        "The Glass Castle"                        
[33] "Вогнеборці"                               "Війна за планету мавп"         
```
**3. Скільки фільмів мають тривалість менше 100 хв.**
```
sum(movies$Runtime < 100)

Результат:
[1] 14
```
