# create a function

rainbow_unicorn=function(N, effect_size, sd=2)
{
  power_test = power.t.test(n = N, delta = effect_size, sd=sd, sig.level = 0.05, power = NULL,
                            type = "two.sample",
                            alternative = "one.sided")

  return(power_test$power)
}

power = NULL
effect_size = NULL
for(effect in seq(0.01, 0.35, 0.02)){ #seq : to loop but not on every value. it creates a vector
  for(N in 5:100){
    temp = c(power, rainbow_unicorn(N, effect))
    power = temp
  }
  effect_size = c(effect_size, rep(effect, 96))
}



library(ggplot2)

db=data.frame(power, N=5:100, effect_size)

ggplot(db, aes(x=N, y=power, col=as.factor(effect_size)))+geom_line()


a = function () { return(2) }
