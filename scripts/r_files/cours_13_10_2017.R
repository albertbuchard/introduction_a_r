# SCRIPT COURS 13/10/2017

sumAlbert = function (param1, param2) {

  return(param1+param2)
}

apple_colors <- c('green','green','yellow','red','red','red','green')

color_factor = factor(apple_colors)

print(color_factor)

levels(color_factor) = c("green", "blue", "yellow")

levels(color_factor)

size <- c('very few','few', 'few', 'few', 'few', 'ok','a lot','too much')

size = factor(size, ordered = T, levels = c('very few','few','ok','a lot','too much'))


first_names = c("Melissa", "Sibylle", "Zoe", "Maria")
ages = c(23, 22, 24, 25)

df = data.frame(first_name = first_names,
                age = ages,
                subject = c("Activity", "Motivation", "Fluid Intelligence", NA))

a = 12
if ((a != 13) && (a != 12)) {
  print("TRUE")
} else if (a==12) {
  print("12")
} else if (a==11) {
  print("11")
} else {
  print("else")
}

first_names
first_names2 = c("Kengo", "Hannah", "Albert", "Souhail")

comparison_vector = (first_names == first_names2)
comparison_vector == F

for (i in 1:NROW(df)) {
  person = df[i,]
  print(paste0(person$first_name, person$age))
}


for (i in c(1,2,3,4,10)) {
  print(i)
}

# create a dataframe
df = data.frame(firstcolumn = 1:40, secondcolumn = 2:41)

# define a function
name_of_the_function = function (argument_1) {
  # argument_1 has to be a data.frame
  if (class(argument_1) == 'data.frame') {
    # initializing the results
    results = NULL
    # iterate on the column or use apply() or sapply()
    for (i in 1:NCOL(df)) {
      # get the mean of the column
      newvalue = mean(df[[i]])
      # concatenate the results
      results = c(results, newvalue)
    }

    # return results
    return(results)
  } else {
    return(NULL)
  }
}

# call the function you just defined
name_of_the_function(df)
