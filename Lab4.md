***Лабораторна робота № 4. Зчитування даних з реляційних баз даних.***

**Для роботи з базою даних SQLite в R можна використовувати бібліотекі DBI та 
RSQLite.
Спочатку необхідно створити з’єдання з базою даних**

```
install.packages("DBI")
install.packages("odbc")
install.packages("RSQLite")
library(odbc)

conn <- dbConnect(RSQLite::SQLite(), "database.sqlite")
```

**В результаті виконання лабораторної роботи необхідно створити фрейми даних:**

**1. Назва статті (Title), тип виступу (EventType). Необхідно вибрати тільки статті 
с типом виступу Spotlight. Сортування по назві статті.**
```
task1 <- dbSendQuery(conn, "SELECT Title, EventType 
                              FROM Papers 
                             WHERE EventType = 'Spotlight' 
                          ORDER BY Title")
df <- dbFetch(task1, n=10)

Результат:

                                                                                          Title EventType
1  A Tractable Approximation to Optimal Point Process Filtering: Application to Neural Encoding Spotlight
2                                    Accelerated Mirror Descent in Continuous and Discrete Time Spotlight
3                        Action-Conditional Video Prediction using Deep Networks in Atari Games Spotlight
4                                                                      Adaptive Online Learning Spotlight
5                          Asynchronous Parallel Stochastic Gradient for Nonconvex Optimization Spotlight
6                                                 Attention-Based Models for Speech Recognition Spotlight
7                                                       Automatic Variational Inference in Stan Spotlight
8                                   Backpropagation for Energy-Efficient Neuromorphic Computing Spotlight
9                       Bandit Smooth Convex Optimization: Improving the Bias-Variance Tradeoff Spotlight
10                         Biologically Inspired Dynamic Textures for Probing Motion Perception Spotlight
```
**2. Ім’я автора (Name), Назва статті (Title). Необхідно вивести всі назви статей 
для автора «Josh Tenenbaum». Сортування по назві статті.**
```
task2 <- dbSendQuery(conn, "select t2.Name, t1.Title 
                              from Papers t1
                        inner join PaperAuthors t3 ON t1.Id=t3.PaperId 
                        inner join Authors t2 ON t3.AuthorId=t2.Id 
                             where t2.Name='Josh Tenenbaum' 
                          order by t1.Title") 
df <- dbFetch(task2)
df

Результат:
            Name                                                                                             Title
1 Josh Tenenbaum                                                       Deep Convolutional Inverse Graphics Network
2 Josh Tenenbaum Galileo: Perceiving Physical Object Properties by Integrating a Physics Engine with Deep Learning
3 Josh Tenenbaum                                                Softstar: Heuristic-Guided Probabilistic Inference
4 Josh Tenenbaum                                                        Unsupervised Learning by Program Synthesis
```

**3. Вибрати всі назви статей (Title), в яких є слово «statistical». Сортування по 
назві статті.**
```
Результат:
```
**4. Ім’я автору (Name), кількість статей по кожному автору (NumPapers). 
Сортування по кількості статей від більшої кількості до меньшої.**
```
Результат:
```
