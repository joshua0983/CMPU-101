use context essentials2021
include gdrive-sheets
include data-source

include shared-gdrive("dcic-2021",
  "1wyQZj_L0qqV9Ekgr9au6RX2iqt2Ga8Ep")


ssid = "11oNNFtLb0IYQaJghXSb-monu2YL2JGKK8w7Ux-zDOkM"  # Put the ID of your spreadsheet here
data-sheet = load-spreadsheet(ssid)

student-data =
  load-table:
    timestamp, house, stem-level, sleep-hours,
    schoolwork-hours, student-athlete, extracurricular-hours
    source: data-sheet.sheet-by-name("Responses", true)
    sanitize student-athlete using string-sanitizer
  end

student-data

# Part 1
#Exercice 1.1 ------------------------------
student-data-sanitized = 
  load-table: timestamp, house, stem-level, sleep-hours, schoolwork-hours, student-athlete, extracurricular-hours
    source: data-sheet.sheet-by-name("Cleaned Data", true)
    sanitize timestamp using string-sanitizer
    sanitize house using string-sanitizer
    sanitize stem-level using num-sanitizer
    sanitize sleep-hours using num-sanitizer
    sanitize schoolwork-hours using num-sanitizer
    sanitize student-athlete using string-sanitizer
    sanitize extracurricular-hours using num-sanitizer
  end

#|
   Question 1.1
   - I changed the ones that said 1-2 to 1.5 and 4-5 to 4.5, removed "hours" 
   - Changed N/A to 0 
   - I agree with the edits and it looks same as mine
|#

# Exercise 1.2 ----------------------------------

fun normalize-house(h:: String) -> String:
  doc: "Return 'OTHER' if it's not one of the houses"
  if (h == "Main Building (1861)") or
      (h == "Strong House (1893)") or
        (h == "Raymond House (1897)") or
      (h == "Lathrop House (1901)") or
    (h  == "Davison House (1902)") or
    (h == "Jewett House (1907)") or
    (h == "Josselyn House (1912)") or
    (h == "Cushing House (1927)") or
    (h == "Noyes House (1958)"):
    h
  else: "OTHER"
  end
end

student-data-sanitized-new = 
  transform-column(student-data-sanitized, "house", normalize-house)

count(student-data-sanitized-new, "house")

# Exercise 1.3 ---------------------------------

fun upper-case(s :: String) -> String:
  doc: "Return all-caps version"
  if s == "":
    "NO"
  else:
    string-to-upper(s)
  end
end

student-data-sanitized-new1 = 
  transform-column(student-data-sanitized-new, "student-athlete", upper-case)

fun to-boolean(st :: String) -> Boolean:
  doc: "Returns boolean answers"
  st == "YES"
end

student-data-sanitized-final = 
  transform-column(student-data-sanitized-new1, "student-athlete", to-boolean)

# Part 2
# Exercise 2.1 --------------------------------

count(student-data-sanitized-final, "student-athlete")
count(student-data-sanitized-final, "house")

#|
   There are 13/37 = 35% athletes
   Jewett house has the most survey students
|#

# Exercise 2.2 ---------------------------------

scatter-plot(student-data-sanitized-final, "stem-level", "schoolwork-hours")
histogram(student-data-sanitized-final, "sleep-hours", 1)

# Exercise 2.3 ---------------------------------

# relation between stem level and extracurricular-hours
scatter-plot(student-data-sanitized-final, "stem-level", "extracurricular-hours")

# wanted to know correlation between the two
