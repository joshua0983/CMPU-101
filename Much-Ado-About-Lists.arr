use context essentials2021
include shared-gdrive("dcic-2021",
  "1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")

include shared-gdrive("shakespeare-text.arr",
  "1-XGIpbC13ItjxCh7WY14cCjfygk5wz5x")

book-text

split-text = string-split-all(book-text, " ")

#Part 1 -----------------------------------------------------

fun find-characters(words :: List<String>) -> List<String>:
  doc: "Return the names with all caps"
  fun caps(c :: String) -> Boolean:
    doc: "Return true if its all caps"
    exclude = (c == "A") or (c == "I") or (c == "O")
    (c == string-to-upper(c)) and not(exclude)
end

  distinct(filter(caps, words))
  
where:
  find-characters([list: "a", "TEST"]) is [list: "TEST"]
end

named-characters = find-characters(split-text)
named-characters
#Part 2 -----------------------------------------------------

fun characters-table(char-names :: List<String>, play-text :: List<String>) -> Table:
  doc: "Returns a table with number of lines of each character"
  fun counting(name :: String, list-word :: List<String>) -> Number:
    doc: "Returns the amount of times the name appears"
    cases (List) list-word:
  | empty => 0
  | link(f,r) =>
    if name == f:
      counting(name, r) + 1
        else:
      counting(name, r) + 0
    end
  end
  end
  fun name-counter(name :: String) -> Number:
    doc: "Returns the amount of times the name appears from the previous function"
    counting(name, play-text)
  where:
    counting("BEATRICE", named-characters) is 1
   
end
  
  new-table = create-table-with-col("name", char-names) 
  counted-list = map(name-counter, char-names)
  add-col(new-table, "count", counted-list)
  
  
end

named-characters-table = characters-table(named-characters, split-text)
named-characters-table

#Part 3 --------------------------------------------------------
fun reduce(lt :: List<Number>) -> List<Number>:
  doc:" "
  cases (List) lt:
    | empty => [list: ]
    | link(f,r) => 
      cases (List) r:
        |empty => [list: ]
        |link(fr,rr) => (r)
    end
  end
where: 
  reduce([list: 4, 5, 9]) is [list: 5, 9]
end

#|
   [list: 4, 5, 9]
   4 + [list: 5, 9]
   4 + 5 + [list: 9]
   ((4 + 5  9) / 3)
   This is harder to do because we are considering the lenth of the list
|#

#|
   Go thourgh all the string and find the sum then divide it by the length of the sting
   
|#

fun average-word-length(list-of-words :: List<String>) -> Number:
  doc: "Returns the average length from the list"
  fun sum-of-length(listed-word :: List<String>) -> Number:
    doc: "Finds the sum from the list"
    cases (List) listed-word:
      | empty => 0
      | link(f,r) => string-length(f) + sum-of-length(r)
    end
end
  if list-of-words.length() > 0:
    num-round(sum-of-length(list-of-words) / list-of-words.length())
  else: 
    raise("none")
  end
where:
  average-word-length([list: "this", "is", "a", "test"]) is 3
end

#Part 4 ---------------------------------------------------


fun find-waldo(text-string :: String) -> String:
  doc: "Returns the word that occurs immediately after the first Waldo in that text."
  fun next-to-waldo(the-list :: List<String>, waldo :: Boolean) -> String:
    doc: "Returns the one after waldo"
    cases (List) the-list:
      | empty => empty
      | link(f,r) =>
        if waldo: f
        else if (f) == "Waldo":
        next-to-waldo(r, true)
      else: next-to-waldo(r, false)
end
    end
  end
  
  next-to-waldo(string-split-all(text-string, " "), false)
  
where:
  find-waldo("somewhere here there is Waldo found") is "found"
end

find-waldo("the evening breeze rustled the Waldo leaves on the balcony")
