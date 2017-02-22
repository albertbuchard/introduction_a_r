name = "albert"

if (name == 2) {
  print("Im happy!")
} else {
  print("Sad it can be everything I dont know who I am")
}

ages =c(12,13,14,15,13)

moyenne = mean(ages)

if (moyenne > 20) {
  ages = ages + 20
}

print(ages)

a = 13*(2+4)
((name == "albert")||(moyenne == 13))

a = c(FALSE,F,F,TRUE)

b = NULL
b[1] = F
b[2] = F
b[3] = F
b[4] = T


if ( ((a[1] == F)||(a[2])) ||(a[3])||(a[4])) {
  print("first")
} else {
  print("invalid")
}

a = 0
for (i in 1:NROW(data$age)) {
  if (data$age[i] > 50) {
    data$weirdScore2[i] = 30
  }
  # data$age + data$IQ
}

i = 0
while(i <= 10) {
  print(i)
  i = i + 1
}
print(a)



sommeFunction = function  (x =1, y =3, z = 40) {
  # Do some action on the parameters
  sum = x+y


  # Return to sender the result of your computation
  return(sum>z)
}

sum3 = sommeFunction(1,4)
print(sum3)
