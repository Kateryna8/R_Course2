***Лабораторна робота № 1. Завантаження та зчитування даних.***

**1. За допомогою download.file() завантажте любий excel файл з порталу http://data.gov.ua та зчитайте його (xls, xlsx – бінарні формати, тому встановить mode = “wb”. Виведіть перші 6 строк отриманого фрейму даних.**

```
file<-tempfile(fileext=".xlsx")
download.file(url="https://data.gov.ua/dataset/c5a2ab4e-e5f7-452e-9c20-2636dec670d1/resource/5f3b7081-b8e4-4c4a-98a8-eff645ad113d/download/reyestr_licenziativ_30_12_2021.xlsx",destfile=file,mode="wb")

data1=read_xlsx(file)
head(data1)
```
Результат:
```
# A tibble: 6 x 15
  ИНН      Назва  `Орган ліцензу~` `Вид господарс~` `Місцезнаходже~` `Місце провадж~` `Операції у сф~`
  <chr>    <chr>  <chr>            <chr>            <chr>            <chr>            <chr>           
1 36427583 ТОВ «~ Міндовкілля    ~ Поводження з не~ "10003, Житомир~ "12440, Житомир~ "Збирання, утил~
2 43438035 ТОВ «~ Міндовкілля    ~ Поводження з не~ "\r\n81220, Льв~ "\r\n81220, Льв~ "Збирання, збер~
3 41115811 ТОВ «~ Міндовкілля    ~ Поводження з не~ "01133, місто К~ "Київська обл.,~ "Збирання\r\nЗб~
4 42129998 ТОВ «~ Міндовкілля    ~ Поводження з не~ "49087, Дніпроп~ "49055, Дніпроп~ "Збирання, збер~
5 42747947 ТОВ «~ Міндовкілля    ~ Поводження з не~ "03148, м. Київ~ "51900, Дніпроп~ "Збирання\r\nЗб~
6 36738796 ПП «П~ Міндовкілля    ~ Поводження з не~ "03115, м. Київ~ "49022, м. Дніп~ "збирання,\r\nз~
# ... with 8 more variables:
#   `Перелік видів небезпечних відходів, на поводження з якими видана ліцензія` <chr>,
#   `Дата і номер рішення про видачу ліцензії` <chr>, `Термін дії ліцензії` <chr>,
#   `Відомості щодо розширення або звуження ліцензії` <chr>,
#   `Відомості про переоформлення, про зупинення дії  ліцензії  повністю або частково та про віновлення дії  ліцензії повністю або частково` <chr>,
#   `Відомості щодо розпоряджень спеціально уповноваженого органу з питань ліцензування` <chr>,
#   `Відомості щодо судових рішень` <lgl>, ...
```

**2. За допомогою download.file() завантажте файл getdata_data_ss06hid.csv за посиланням https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv та завантажте дані в R. Code book, що пояснює значення змінних знаходиться за посиланням https://www.dropbox.com/s/dijv0rlwo4mryv5/PUMSDataDict06.pdf?dl=0 Необхідно знайти, скільки property мають value $1000000+**
```
file<-tempfile(fileext=".csv")
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile=file)

data2=read.csv(file)
head(data2)

sum(data2$VAL == 24, na.rm = TRUE)
```

Результат:
___
[1] 53
___


**3.Зчитайте xml файл за посиланням http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml Скільки ресторанів мають zipcode 21231?**

```
install.packages("XML")
library(XML)

Url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
data3 <- xmlTreeParse(Url, useInternal = TRUE )
Data <- xmlRoot(data3)
xmlName(Data)
zip <- xpathSApply(Data, "//zipcode", xmlValue)
sum(zip == 21231, na.rm = TRUE)
```

Результат:
___
[1] 127
___
