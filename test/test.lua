package.path = package.path..";../src/?.lua"

local tabletool = require 'tabletool'

-- example tables
local t1 = { "hello1", "hello2", "world" , 1 , 2 }
local t2 = { 1 , 2, 3 , 4 , 5 }
local t3 = { 3 , 4 , 12, 2}
local t4 = { 4, 21, 8, 9}
local t5 = { 0, 20, 80 , 100}


print("-- table 1: original table 1 dumped")
tabletool.dumptable(t1)

print("-- table 2: original table 2 dumped")
tabletool.dumptable(t2)


print("-- table 2: unique")
tabletool.dumptable(tabletool.unique(t2))

print("-- checking if table 1 contains 'hello1'")
print(tabletool.contains(t2, "hello1"))

print("-- reversing table 1:")
tabletool.dumptable(tabletool.reverse(t1))

print("-- counting the occurance of element 'hello1' in table 1")
print(tabletool.count_element(t2, 2))


print("-- table sum")
print(tabletool.sum(t2))

print("-- table average")
print(tabletool.average(t2, 2))

print("--- merging table 1 and 2:")
tabletool.dumptable(tabletool.join(t2, t3))


print("--- get a random element from table 2, five times:")
for i=1, 5 do
  local e = tabletool.get_random_element(t2)
  print(e)
end


print("--- sorting table 4 DESC")
tabletool.dumptable(tabletool.sort_desc(t2))

print("--- sorting table 4 ASC")
tabletool.dumptable(tabletool.sort_asc(t2))

for i=1, 3 do
  print("--- shuffle table 4, round "..i)
  tabletool.dumptable(tabletool.shuffle(t4))
end

print("--- table slice")
tabletool.dumptable(tabletool.slice(t1, 0, 2))

print("--- normalize table 5 values between 0 and 1")
local t7 = tabletool.normalize(t5)
tabletool.dumptable(t7)

print("--- denormalize table values between 0 and 100")
tabletool.dumptable(tabletool.denormalize(t7, 0, 100))

