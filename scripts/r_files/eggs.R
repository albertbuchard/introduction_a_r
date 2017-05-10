is_it_broken = function (floor) {
  floor_at_which_it_breaks = 32
  return(floor>=floor_at_which_it_breaks)
}

floor = 1
is_it_broken(floor)

# write code that finds floor_at_which_it_breaks without knowing it
floor_broken = NULL
for (floor in seq (0,100,10)){
  if(is_it_broken(floor)){
    floor_broken = floor
    break()
  }
}

for (floor in (floor_broken-9):(floor_broken-1)){
  if(is_it_broken(floor)){
    floor_broken = floor
    break()
  }

}
