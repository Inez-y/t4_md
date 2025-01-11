`iex` interactive shell

```elixir
div(3, 2)
rem(3.2)
h String. #  tab
h # commands
```

good for unicode -> matter programing


dynamic and functional 
```elixir
is_ # tab -> get all help
h Enum # tab -> wow dedup 
```

lots of built-in functions!

# data type
boolean - true, false, nil


## data type - atom
atom = value itself = almost like literal
called symbol in other languages (ruby)
starts with `:`
use atom to tag something, error handling

```elixir
{:ok, 3} # tuple <- data structure
:error 
:hello 
:"hello hello" # space

:true # alias of true
:true == true # true

# Starting with an upper case 
Hello # atom
is_atom(Hello) # true
is_atom(H1) # true


```

## data type - list

```elixir
l = [1,2,3]
l # [1,2,3]
l = 1
l # 1
l = [1, "hi", :ok] # various element types
```

`=` is a match operator (not an assign)
```elixir
x = 1 # 1
x # 1 
2 = x # no match -> match error
1 = x # match, 1
```

pin operator
```elixir
x = 2 # rebound to 2
^x = 3 # match error 
```

head and tail
```elixir
[1,2,3] == [1 | [2 | [3| []]]] # true
[1,2] = [1 | [2]] # [1,2] 
[1,2,3] = [1 | [2, 3]] # [1,2,3]

[h|t] = [1,2,3,4] # [1,2,3,4]

h # 1 
t # [2,3,4]

[_, _, {_, x} | _ ] = [1,2,{:ok, "hello"},5,6,7]
x # hello

[_, x, {_, x} | _ ] = [1,2,{:ok, "hello"},5,6,7] # matching error x should be the same element
[_, x, {_, x} | _ ] = [1,2,{:ok, 2},5,6,7] 
x # 2
```


# Module and Function
```elixir
defmodule M do
    def fact(n) do 
        if n<=0 do 1
        else n * fact(n-1) 
        end
    end # function definition
end # module


{:module, M,
 <<70, 79, 82, 49, 0, 0, 6, 108, 66, 69, 65, 77, 65, 116, 85, 56, 0, 0, 0, 168,
   0, 0, 0, 19, 8, 69, 108, 105, 120, 105, 114, 46, 77, 8, 95, 95, 105, 110,
   102, 111, 95, 95, 10, 97, 116, 116, 114, ...>>, {:fact, 1}}


M.fact(1000)
```

```elixir
h apply

# def apply(module, function_name, args)    
# Invokes the given function from module with the list of arguments args.

apply(M, :fact, [100])


M == :"Elixir.M" # true
```

# Comparing different types

order types
```elixir
1 < :ok # true
:ok < {:error, 3} # true
```

# IO.puts
print elements and result
```elixir
# returns ok
IO.puts("hello") # hello # :ok

IO.puts"hello" # works but () gives me more clearity
```

# Anonymous function

```elixir
f = fn x -> 2 * x end

f.(1) # calling ano function with .

f = fn x, y -> x + y end
f.(1,2) # 3
```

capture operator `&` makes easier 

```elixir
h Enum.map 

def map(enumerable, fun)  
Returns a list where each element is the result of invoking fun on each
corresponding element of enumerable.

String.upcase("hello") # HELLO
Enum.map(["hello", "world"], fn s - > String.upcase s end) # ["HELLO", "WORLD"]


# Capture operator 
Enum.map(["hello", "world"], &String.upcase/1) # ["HELLO", "WORLD"]


Enum.map([1,2], fn x -> x * x end) # [1, 4]
Enum.map([1,2], &(&1 * &1)) # [1, 4]
add = &(&1 + &2) # &:erlang.+/2
add.(1,2) # 3
```

Pipe operator `|>`
becomes the first argument (ocaml: the last argument)
```elixir
[1,2,3] |> Enum.map(&(&1 * &1)) # [1,4,9]
[1,2,3] |> Enum.map(&(&1 * &1)) |> Enum.sum() # 14
```

# String
string = sequence of bytes = binary
```elixir
String.length("a") # 1

# binary
<<3, 2, 1>>

is_binary("hello") # true

<<_, x, _>> == <<3,2,1>>
x # 2
```

run script `.exs`
cp lec1.ex lab1.exs
vi lab1.exs
elixir lab1.exs


run file
vi lec1.ex
iex lec1.ex
