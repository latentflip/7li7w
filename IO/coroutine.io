vizz := Object clone

vizz talk := method(
  "Fezz ar there rocks ahead?" println
  yield
  "No more rhymes, i mean it." println
  yield
)

fezz := Object clone
fezz rhyme := method(
  yield
  "If there are, we're dead" println
  yield
  "Peanut?" println
)

vizz @@talk
fezz @@rhyme

Coroutine currentCoroutine pause
