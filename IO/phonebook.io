OperatorTable addAssignOperator(":", "atPutNumber")

curlyBrackets := method(
  r := Map clone
  call message arguments foreach(arg,
    r doMessage(arg)
  )
  
  r
)

Map atPutNumber := method(
  self atPut(
    call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""),
    call evalArgAt(1))
)

phonenumbers := {
  "Bob" : "1234",
  "Cob" : "123"
}

phonenumbers keys println
phonenumbers values println


