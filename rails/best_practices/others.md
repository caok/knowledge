```
# before
sum = 0
numbers.each do |number|
  sum += number
end
sum

# after
numbers.inject(:+)
```

```
# before
anagrams = []
candidates.each do |candidate|
  if anagram_of?(subject, candidate)
    anagrams << candidate
  end
end
anagrams

# after
candidates.select do |candidate|
  anagram_of?(subject, candidate)
end
```

```
# before
mutations = 0
(0...strand1.length).each do |i|
  if strand1[i] != strand2[i]
    mutations += 1
  end
end
mutations

# after
(0...strand1.length).count {|i| strand1[i] != strand2[i]}
```

```
# before
oldest = ""
highest = 0
kids.each do |kid|
  if kid.age > highest
    oldest = kid.name
    highest = age
  end
end
oldest

# after
kids.sort_by {|kid| kid.age}.last.name

# even more after
kids.max_by {|kid| kid.age}.name
```

```
# before
words.inject([]) do |censured, word|
  censured << word if word.size == 4
  censured
end

# after
words.select {|word| word.size == 4}
```
