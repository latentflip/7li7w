a := Object clone
b := Object clone
c := Object clone

myvar := "foo"

set := method(myvar = "bar")

a set := method(
  writeln(myvar)
  Lobby myvar = "a changed myvar"
)

b set := method(
  writeln(myvar)
  self myvar = "b changed myvar"
)

c set := method(
  nonexistantSlot = "foo"
  writeln(nonexistantSlot)
)

myvar println
set
a set
b set
c set
myvar println

