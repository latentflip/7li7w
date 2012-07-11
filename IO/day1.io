header := method(header, "\n==" print; header print; "==" println)
note := method(comment, comment println)

header("IO Community")
note("Io community at: http://tech.groups.yahoo.com/group/iolanguage/")
note("Io irc at: irc.freenode.net#io")

sum := method(1 + "one")
//sum()

header("Typing")
note("Calling 1 + 'one' raises an exception")
note("but method(1 + 'one') doesn't")
note("So io is strongly, but dynamically typed")

header("Truthyness and Falsyness")
0==true then("0 is true" println)
0==false then("0 is false" println)

""==true then("empty string is true" println)
""==false then("empty string is false" println)

nil==true then("nil is true" println)
nil==false then("nil is false" println)


header("Objects")
note("we can list slots with the slotNames message: ")

Car := Object clone
Car color := "red"

note("The slots on my car object are: ")
Car slotNames println

header("=, :=, ::=")
note("= sets an existing slot")
note(":= sets an existing slot, or creates one if it doesn't exist")

Vehicle := Object clone
Vehicle fast := false

Jet := Vehicle clone
Jet fast := true
Jet color ::= "gray"
Jet color ::= "purple"

Jet setColor("blue")

(Jet color == "blue") then(note("::= sets an existing slot, or creates a new one, it also creates a setter"))
note("so `Jet color ::= \"red\"` adds a method like: `Jet setColor(\"purple\")`")
