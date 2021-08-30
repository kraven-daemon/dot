-- A fmt module for lua
-- https://github.com/starwing/lua-fmt

local fmt = require "fmt"

-- automatic indexed argument
print(fmt("{} {} {}", 1,2, 3)) --> "1 2 3"

-- manual indexed argument
print(fmt("{2}, {1}", "World", "Hello")) --> "Hello, World"

-- named indexed argument
print(fmt("{name} is {type}", { name = "foo", type = "bar" })) --> "foo is bar"
print(fmt("{t.name} is {t.type}", {t = { name = "foo", type = "bar" }})) --> "foo is bar"

-- format specifier
print(fmt("{:b}", 42)) --> "101010"


