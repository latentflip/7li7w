/* What is the operator table doing?

as far as I can tell

OperatorTable addOperator("xor", 11)
true xor := method(bool, if(bool, false, true))
false xor := method(bool, if(bool, true, false))

is no different to just

true my_xor := method(bool, if(bool, false, true))
false my_xor := method(bool, if(bool, true, false))

What's the difference then? Precedence?

*/


/*Fibonacci*/

loopyfib := method(n,
        numbers := list(1,1)
        while(numbers size <= n,
            numbers append (numbers at(-1) + numbers at(-2))

        )
        numbers at(n-1)
      )
            
recursivefib := method(n, lst,
                  if(lst not,
                    lst = list(1,1),
                    lst append (lst at(-1) + lst at(-2))
                  )

                  if(lst size >= n,
                    lst at(n-1),
                    recursivefib(n,lst)
                  )
                )

if(loopyfib(8) == 21, "woo loopy fibonacci" println, Exception raise("Loopy fib fail: #{loopyfib(8)} is not 21" interpolate))
if(recursivefib(8) == 21, "woo recursive fibonacci" println, Exception raise("Recursive fib fail: #{recursivefib(8)} is not 21" interpolate))


/* Changing / */

origDiv := Number getSlot("/")
Number / = method(other, if(other == 0, 0, self origDiv(other)))


if((4/2) == 2, "woo div 2" println, Exception raise("div 2 fail :("))
if((1/0) == 0, "woo div 0" println, Exception raise("div 0 fail :("))



/* Add up 2D */

myArray := list(
  list(1,2,3),
  list(2,3,4),
  list(4,5,6)
)
sum2d := method(array,
          sum := 0
          array foreach(a, sum = sum + a sum)
          sum
        )

if( sum2d(myArray) == 30, "woo 2d sums" println, Exception raise("sum2d fail: #{sum2d(myArray)} should be 30" interpolate))



/* myAverage */
myArray := list(1,3,5,6)
myEmptyArray := list()

MyEmptyArrayError := Exception clone

List myAverage := method(
  if(self size > 0,
    (self sum) / self size,
    MyEmptyArrayError raise
  )
)

if( (myArray myAverage) == 3.75, "woo myAverage" println, Exception raise("myAverage fail: #{myArray myAverage} should be 3.75" interpolate))

e := try(
  myEmptyArray myAverage
)

e catch(MyEmptyArrayError,
  "Woo successfully caught the correct MyEmptyArrayError exception" println
) pass

if(e == nil, Exception raise("Didn't catch the MyEmptyArrayError exception when I should have"))



/* 2d list */

List2D := Object clone

List2D dim := method(x,y,
                self thelist := list()

                for(i, 1, y,
                  self thelist append(list())
                  
                  for(j, 1, x,
                    self thelist last append(nil)
                  )
                )
              )

List2D set := method(x,y,value,

                self thelist at(y) atPut(x, value)
              )
List2D get := method(x,y,
                self thelist at(y) at(x)
              )


my2DList := List2D clone
my2DList dim(3,5)
my2DList set(2,3,"hi")

if((my2DList get(2,3) == "hi"), "Woo 2d lists" println, Exception raise "Fuck")


/* Transpose */

List2D transpose := method(
                      newList := list()

                      self thelist foreach(rown, row,
                        row foreach(celln, cell,
                          if(newList at(celln) not, newList append(list()))
                          newList at(celln) append(cell)
                        )
                      )
                      self thelist = newList
                      self
                  )
              
if((my2DList transpose get(3,2) == "hi"), "Woo transposed 2d lists" println, Exception raise "Fuck")

          
/* Write to a file */

List2D foreachRowAndCell := method(rowstartfn, cellfn, rowendfn,
                              self thelist foreach(rown, row,
                                rowstartfn call(rown, row)
                                row foreach(celln, cell,
                                  cellfn call(celln, cell)
                                )
                                rowendfn call(rown, row)
                              )
                            )

List2D marshall := method(filename,
                      f := File with(filename)
                      f remove
                      f openForUpdating
                      self foreachRowAndCell(
                            block(rown, row, ""),
                            block(celln, cell,
                              if(cell type == "Sequence") then(f write("\"#{cell}\"," interpolate)) elseif(cell type == "Number") then(f write("#{cell}," interpolate)) else(f write("#{cell}," interpolate))
                            ),

                            block(rown, row, f write("\n"))
                          )
                      f close
                    )

my2DList set(1,1,3)
my2DList set(1,2,true)
my2DList set(2,2,nil)
my2DList marshall("marshalledList.data")


/* Reading from a file */

List2D unmarshall := method(filename,
                      f := File with(filename)
                      f openForReading
                      rows := f contents split("\n")

                      rows foreach(rown, row,
                        cells := row split(",")
                        cells foreach(celln, cell,
                          if(rown==0 and celln==0,
                            self dim(cells size, rows size)
                          )

                          if(cell at(0) == 34,
                            self set(celln,rown,cell slice(1,-1)),

                            if(cell asNumber and cell asNumber isNan not,
                              self set(celln, rown, cell asNumber),

                              if(cell == "true",
                                self set(celln, rown, true))
                              if(cell == "false",
                                self set(celln, rown, false))
                              if(cell == "nil",
                                self set(celln, rown, nil))
                            )
                          )
                        )
                      )
                    )

loadedList := List2D clone
loadedList unmarshall("marshalledList.data")

if((loadedList get(3,2) == "hi"), "Woo loaded 2d list" println, Exception raise "Fuck")
if((loadedList get(1,1) == 3), "Woo loaded 2d list" println, Exception raise "Fuck")
if((loadedList get(1,2) == true), "Woo loaded 2d list" println, Exception raise "Fuck")
if((loadedList get(2,2) == nil), "Woo loaded 2d list" println, Exception raise "Fuck")


/* Guesses */
secret := (Random value(99) + 1) floor
standardIO := File standardInput
previousGuess := false

"Guess a number between 1 and 100" println

10 repeat(

  guess := standardIO readLine asNumber
  
  if(guess == secret,
    "Woop, it was #{secret}!" interpolate println
    break
  )

  if(previousGuess,
    if((secret - guess) abs <= (secret - previousGuess) abs,
      "Getting warmer" println,
      "Getting colder" println
    ),
    "Nah" println
  )
  previousGuess = guess
)
"Secret was #{secret}" interpolate println
