"/* Enhanced builder */" println
Builder := Object clone

Builder indent := -1

Builder createIndent := method(
  str := ""
  indent repeat(str = str asMutable .. "  " )
  str
)

Builder forward := method(
  indent = indent + 1
  spacer := createIndent
  writeln(spacer,"<", call message name, ">")

  call message arguments foreach(arg,
    content := self doMessage(arg);
    if(content type == "Sequence",
      writeln(spacer, "  ", content))
  )

  indent = indent - 1
  writeln(spacer,"</", call message name, ">")
)

Builder ul(
  li("Io")
  li("Lua")
  li("JavaScript")
  li(
    ul(
      li("Nested")
      li("and")
      li("more")
    )
  )
)
Builder indent println


"/* List Syntax */" println

squareBrackets := method(
  thelist := list()
  call message arguments foreach(arg,
    thelist append(arg)
  )
  thelist
)

nicelist := [
  "foo", 2
]

nicelist println


"/* Extended XML */" println

OperatorTable addAssignOperator(":", "atPutAttr")
curlyBrackets := method(
  r := Map clone
  call message arguments foreach(arg,
    r doMessage(arg)
  )
  r
)

Map atPutAttr := method(
  self atPut(
    call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\"")
    call evalArgAt(1)
  )
)

Builder forward := method(
  indent = indent + 1
  spacer := createIndent

  arguments := call message arguments
  attrs := doMessage(call message argAt(0))
  attrString := ""

  if(attrs type == "Map",
    arguments remove(arguments at(0))
    attrString = attrString .. " "
    attrs foreach(key,val,
      attrString = attrString .. key .. "=\"" .. val .. "\" "
    )
  )

  attrString = attrString exSlice(0,-1)

  writeln(spacer,"<", call message name, attrString, ">")

  call message arguments foreach(arg,
    content := self doMessage(arg);
    if(content type == "Sequence",
      writeln(spacer, "  ", content)
      indent = indent - 1)
  )

  writeln(spacer,"</", call message name, ">")
)

bar := Builder doString("
  ul({ \"class\" : \"foo\"},
    li(\"boo\"),
    li(\"bar\")
  )
")
