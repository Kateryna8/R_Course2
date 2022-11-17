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
task3 <- dbSendQuery(conn, "select title
                              from papers
                             where title like '%statistical%'
                          order by title")
df <- dbFetch(task3, n=10)
df

Результат:
                                                                                 Title
1 Adaptive Primal-Dual Splitting Methods for Statistical Learning and Image Processing
2                                Evaluating the statistical significance of biclusters
3                  Fast Randomized Kernel Ridge Regression with Statistical Guarantees
4     High Dimensional EM Algorithm: Statistical Optimization and Asymptotic Normality
5                Non-convex Statistical Optimization for Sparse Tensor Graphical Model
6            Regularized EM Algorithms: A Unified Framework and Statistical Guarantees
7                            Statistical Model Criticism using Kernel Two Sample Tests
8                         Statistical Topological Data Analysis - A Kernel Perspective
```
**4. Ім’я автору (Name), кількість статей по кожному автору (NumPapers). 
Сортування по кількості статей від більшої кількості до меньшої.**
```
task4 <- dbSendQuery(conn, "select t2.Name, count(t1.Title) as NumPapers
                              from Papers t1
                        inner join PaperAuthors t3 ON t1.Id=t3.PaperId 
                        inner join Authors t2 ON t3.AuthorId=t2.Id 
                          group by t2.Name
                          order by NumPapers desc") 
df <- dbFetch(task4, n=10)
df

Результат:
                   Name NumPapers
1  Pradeep K. Ravikumar         7
2        Lawrence Carin         6
3               Han Liu         6
4     Zoubin Ghahramani         5
5               Le Song         5
6   Inderjit S. Dhillon         5
7          Zhaoran Wang         4
8         Yoshua Bengio         4
9  Simon Lacoste-Julien         4
10          Shie Mannor         4
```
