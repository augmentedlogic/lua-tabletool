local tabletool = require 'tabletool'

-- example tables
local t1 = { "hello1", "hello2", "world" , 1 , 2 }
local t2 = { 1 , 2, 3 , 4 , 2 }
local t3 = { 3 , 4 , 12, 2}
local t4 = { 4, 21, 8, 9}


print("-- table 1: original")
tabletool.dumptable(t1)



print("-- table 2: original")
tabletool.dumptable(t2)

print("-- table 2: unique")
tabletool.dumptable(tabletool.unique(t2))


print("-- checking if table 1 contains 'hello1'")
print(tabletool.contains(t1, "hello1"))


print("-- reversing table 1:")
tabletool.dumptable(tabletool.reverse(t1))


print("-- counting element 'hello1' in table 1")
print(tabletool.count_element(t1, "hello1"))


print("-- table sum")
print(tabletool.sum(t1))

print("-- table average")
print(tabletool.average(t2, 2))



print("--- merging table 1 and 2:")
tabletool.dumptable(tabletool.join(t1, t2))



print("--- get a random element from table 2, five times:")
for i=1, 5 do
  local e = tabletool.get_random_element(t2)
  print(e)
end


print("--- sorting table 4 DESC")
tabletool.dumptable(tabletool.sort_desc(t4))

print("--- sorting table 4 ASC")
tabletool.dumptable(tabletool.sort_asc(t4))

for i=1, 3 do
  print("--- shuffle table 4, round "..i)
  tabletool.dumptable(tabletool.shuffle(t4))
end

