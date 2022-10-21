
use context essentials2021
#Part 1 ----------------------------------------
#|
  product([list: 5, 2, 3]):
   f is 5
   r is [list: 2, 3]
   return value is 30

   it calls product([list:   2, 3])
    f is 2
    r is ([list: 3])
    return value is 6

    it calls product([list:     3])
      f is 3
      r is [list:     ])
      return value is 3

      it calls product(empty)
        return value is 1
|#

#Part 2 ----------------------------------------

fun sum-of-cubes(lst :: List<Number>) -> Number:
  doc: "Return the sum of the cube of each number in the list"
  cases (List) lst:
    | empty => 0
    | link(f, r) => (f * f * f) + sum-of-cubes(r)
  end
where:
  sum-of-cubes([list: 1, 2, 3]) is 36 because (1 * 1 * 1) + sum-of-cubes([list: 2, 3])
  sum-of-cubes([list:    2, 3]) is 35 because (2 * 2 * 2) + sum-of-cubes([list: 3])
  sum-of-cubes([list:       3]) is 27 because (3 * 3 * 3) + sum-of-cubes([list: ])
  sum-of-cubes([list:        ]) is  0
end

#Part 3 ----------------------------------------

fun max-pos-num(lst :: List<Number>) -> Number:
  doc: "Return the maximum element of a list of positive numbers; if the list is empty, return -1. Assume that the input list does not have any negative numbers"
  cases (List) lst:
    | empty => -1
    | link(f, r) => num-max(f, max-pos-num(r))
  end
where:
  max-pos-num([list: ]) is -1
  max-pos-num([list: 3, 5, 1, 4]) is 5
end

#Part 4 ---------------------------------------

fun bar-chart(lst :: List<Number>) -> Image:
  doc: "Return an image of bars of the given heights next to each other"
  fun num-to-rect(num :: Number) -> Image:
    doc: "Returns image from the number"
    rectangle(30, num, "outline", "white")
  end
  cases (List) lst:
    | empty => empty-image
    | link(f,r) => beside-align("bottom", num-to-rect(f), bar-chart(r))
  end
end

#Part 5 --------------------------------------

fun long-strings(lst :: List<String>, len :: Number) -> List<String>:
  doc: "Return a list consisting of those elements of lst that are longer than len"
  cases (List) lst:
    | empty => empty
    | link(f, r) =>
      if string-length(f) > len:
        link(f, long-strings(r, len))
      else:
        long-strings(r, len)
      end
  end
where:
  long-strings([list: ], 0) is empty
  long-strings([list: "the", "quick", "brown", "fox"], 5)
    is empty
  long-strings([list: "the", "quick", "brown", "fox"], 4)
    is [list: "quick", "brown"]
  long-strings([list: "the", "quick", "brown", "fox"], 2)
    is [list: "the", "quick", "brown", "fox"]
end
