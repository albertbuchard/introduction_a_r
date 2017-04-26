# create a function

rainbow_unicorn=function(N, effect_size, sd=2)
{
  power_test = power.t.test(n = N, delta = effect_size, sd=sd, sig.level = 0.05, power = NULL,
                            type = "two.sample",
                            alternative = "one.sided")

  return(power_test$power)
  }

store = rainbow_unicorn(N=100, effect_size=0.7)

store = NULL
for(N in 5:100){
  temp = c(store, rainbow_unicorn(N, effect_size=0.7))
  store = temp


}
library(ggplot2)

db=data.frame(store, N=5:100)

ggplot(db, aes(x=N, y=store))+geom_line(col=5)
