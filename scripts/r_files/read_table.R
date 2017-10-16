Input =("
 Speaker  Likert
 Pooh      3
 Pooh      5
 Pooh      4
 Pooh      4
 Pooh      4
 Pooh      4
 Pooh      4
 Pooh      4
 Pooh      5
 Pooh      5
 Piglet    2
 Piglet    4
 Piglet    2
 Piglet    2
 Piglet    1
 Piglet    2
 Piglet    3
 Piglet    2
 Piglet    2
 Piglet    3
 Tigger    4
 Tigger    4
 Tigger    4
 Tigger    4
 Tigger    5
 Tigger    3
 Tigger    5
 Tigger    4
 Tigger    4
 Tigger    3
")

Data = read.table(textConnection(Input),header=TRUE)

Data$Speaker = factor(Data$Speaker,
                      levels=unique(Data$Speaker))


Data$Likert.f = factor(Data$Likert,
                       ordered = TRUE)


library(psych)

headTail(Data)

str(Data)

summary(Data)

rm(Input)


xtabs( ~ Speaker + Likert.f,
       data = Data)


XT = xtabs( ~ Speaker + Likert.f,
            data = Data)

prop.table(XT,
           margin = 1)

library(lattice)

histogram(~ Likert.f | Speaker,
          data=Data,
          layout=c(1,3)      #  columns and rows of individual plots
)

library(FSA)
Summarize(Likert ~ Speaker,
          data=Data,
          digits=3)

