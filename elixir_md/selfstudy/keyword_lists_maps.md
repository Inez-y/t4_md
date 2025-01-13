In Elixir, we have two main associative data structures: keyword `lists` and `maps`.

# Keyword Lists
Keyword lists are a data-structure used to **pass options to functions**. Let's see a scenario where they may be useful.

keyword lists are mostly used as optional arguments to functions.

```elixir
String.split("1 2 3", " ") # ["1", "2", "3"]
String.split("1  2  3", " ") # ["1", "", "2", "", "3"]
String.split("1  2  3", " ", [trim: true]) # ["1", "2", "3"]
String.split("1  2  3", " ", [trim: true, parts: 2])
# ["1", "2  3"]
```

keyword lists are simply lists. In particular, they are lists consisting of **2-item tuples** where the first element (the key) is an atom and the second element can be any value. Both representations are the same:

```elixir
# {atom, any value}
[{:trim, true}, {:parts, 2}] == [trim: true, parts: 2] # true
```

Keyword lists are important because they have three special characteristics:

- Keys must be atoms.
- Keys are ordered, as specified by the developer.
- Keys can be given more than once.

hat keys can be repeated when importing functions in Elixir:

```elixir
import String, only: [split: 1, split: 2] # String
split("hello world") # ["hello", "world"]
```

`split/1` and `split/2` from the String module, allowing us to invoke them without typing the module name. We used a keyword list to list the functions to import.

Since keyword lists are lists, we can use all operations available to lists. For example, we can use ++ to add new values to a keyword list:

```elixir
list = [a: 1, b: 2] # [a: 1, b: 2]
list ++ [c: 3] # [a: 1, b: 2, c: 3]
[a: 0] ++ list # [a: 0, a: 1, b: 2]
```

You can read the value of a keyword list using the brackets syntax, which will return the value of the *first matching key*. This is also known as the **access syntax**, as it is defined by the `Access` module:

```elixir
list[:a] # 1
list[:b] # 2
```

Although we can pattern match on keyword lists, it is not done in practice since pattern matching on lists requires the number of items and their order to match:

```elixir
[a: a] = [a: 1] # [a: 1]
a # 1
[a: a] = [a: 1, b: 2]
# ** (MatchError) no match of right hand side value: [a: 1, b: 2]
[b: b, a: a] = [a: 1, b: 2]
# ** (MatchError) no match of right hand side value: [a: 1, b: 2]
```

do not pattern match on keyword lists.

Elixir provides the `Keyword` module. 
Remember, though, keyword lists are simply lists, and as such they provide the same linear performance characteristics: the longer the list, the longer it will take to find a key, to count the number of items, and so on. If you need to store a large amount of keys in a key-value data structure, Elixir offers maps, which we will soon learn.

# `do` blocks and keywords

`if/2` macro:
```elixir
if true do
  "This will be seen"
else
  "This won't"
end
"This will be seen"

# same
if true, do: "This will be seen", else: "This won't"
"This will be seen"
```

The block syntax is equivalent to keywords means we only need few data structures to represent the language, 

# Maps as key-value pairs
Whenever you need to store key-value pairs, maps are the "go to" data structure in Elixir. A map is created using the `%{}` syntax:

```elixir
map = %{:a => 1, 2 => :b} # %{2 => :b, :a => 1}
map[:a] # 1
map[2] # :b
map[:c] # nil
```

Compared to keyword lists, we can already see two differences:

- Maps allow any value as a key.
- Maps have their own internal ordering, which is not guaranteed to be the same across different maps, even if they have the same keys

In contrast to keyword lists, maps are very useful with pattern matching. When a map is used in a pattern, it will always match on a subset of the given value:

```elixir
%{} = %{:a => 1, 2 => :b} # %{2 => :b, :a => 1}
%{:a => a} = %{:a => 1, 2 => :b} # %{2 => :b, :a => 1}
a # 1
%{:c => c} = %{:a => 1, 2 => :b}
# ** (MatchError) no match of right hand side value: %{2 => :b, :a => 1}
```

an empty map matches all maps.

The `Map` module provides a very similar API to the `Keyword` module with convenience functions to add, remove, and update maps keys:

```elixir
Map.get(%{:a => 1, 2 => :b}, :a) # 1
Map.put(%{:a => 1, 2 => :b}, :c, 3) # %{2 => :b, :a => 1, :c => 3}
Map.to_list(%{:a => 1, 2 => :b}) # [{2, :b}, {:a, 1}]
```

# Maps of Predefined Keys
Maps with predefined keys values may be updated, but new keys are never added nor removed. This is useful when we know the shape of the data we are working with and, if we get a different key, it likely means a mistake was done elsewhere. In such cases, the keys are most often atoms:

```elixir
map = %{:name => "John", :age => 23} # %{name: "John", age: 23}

map = %{name: "John", age: 23} # %{name: "John", age: 23}
```

When a key is an atom, we can also access them using the `map.key` syntax:

```elixir
map.name # "John"
map.agee
# ** (KeyError) key :agee not found in: %{name: "John", age: 23}
```

updating keys
```elixir
%{map | name: "Mary"} # %{name: "Mary", age: 23}
%{map | agee: 27}
# ** (KeyError) key :agee not found in: %{name: "John", age: 23}
```

Elixir developers typically prefer to use the `map.key` syntax and pattern matching instead of the functions in the `Map` module when working with maps because they lead to an assertive style of programming.

# Nested Data Structures
 Elixir provides conveniences for manipulating nested data structures via the `get_in/1`, `put_in/2`, `update_in/2`, and other macros giving the same conveniences you would find in imperative languages while keeping the immutable properties of the language.

```elixir
users = [
  john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
  mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
]
# [ john: %{age: 27, languages: ["Erlang", "Ruby", "Elixir"], name: "John"}, mary: %{age: 29, languages: ["Elixir", "F#", "Clojure"], name: "Mary"} ]
```

We have a keyword list of users where each value is a map containing the name, age and a list of programming languages each user likes. If we wanted to access the age for john, we could write:

```elixir
users[:john].age
27
```