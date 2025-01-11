When you install Elixir, you will have three new command line executables: `iex`, `elixir` and `elixirc`.

For now, let's start by running `iex` (or `iex.bat` if you are on Windows PowerShell, where iex is a PowerShell command) which stands for Interactive Elixir. In interactive mode, we can type any Elixir expression and get its result. Let's warm up with some basic expressions.

Open up `iex` and type the following expressions:

```elixir
Erlang/OTP 26 [64-bit] [smp:2:2] [...]

Interactive Elixir - press Ctrl+C to exit
40 + 2
42
"hello" <> " world"
"hello world"
```

By executing the code above, you should evaluate expressions and see their results. To exit iex press `Ctrl+C` twice.

---

# Running scripts

After getting familiar with the basics of the language you may want to try writing simple programs. This can be accomplished by putting the following Elixir code into a file:

```elixir
IO.puts("Hello world from Elixir")
```

Save it as `simple.exs` and execute it with `elixir`:

```
$elixir simple.exs
Hello world from Elixir
```

---

# Basic Types

```elixir
1          # integer
0x1F       # integer
1.0        # float
true       # boolean
:atom      # atom / symbol
"elixir"   # string
[1, 2, 3]  # list
{1, 2, 3}  # tuple
```

# Basic Arithmetic

the operator `/` always returns a float. If you want to do integer division or get the division remainder, you can invoke the `div` and `rem`functions:

```elixir
div(10, 2)
5
div 10, 2
5
rem 10, 3
1
```

Notice that Elixir allows you to drop the parentheses when invoking functions that expect one or more arguments. This feature gives a cleaner syntax when writing declarations and control-flow constructs. However, Elixir developers generally prefer to _use parentheses_.

Elixir also supports shortcut notations for entering binary, octal, and hexadecimal numbers:

```elixir
0b1010 #10 ... 0b-1010
0o777 #511 ... 0o-777
0x1F #31 ... 0x-1f
```

Float numbers require a dot followed by at least one digit and also support `e`for scientific notation:

```elixir
1.0
1.0e-10
```

Floats in Elixir are 64-bit precision.

You can invoke the `round` function to get the closest integer to a given float, or the `trunc` function to get the integer part of a float.

```elixir
round(3.58) #4
trunc(3.58) #3
```

Finally, we work with different data types, we will learn Elixir provides several predicate functions to check for the type of a value. For example, `is_integer` can be used to check if a value is an integer or not:

```elixir
is_integer(1) #true
is_integer(2.0) #false
```

You can also use `is_float` or `is_number` to check, respectively, if an argument is a float, or either an integer or float.

# Booleans and `nil`

Elixir supports true and false as booleans:

```elixir
true # true
true == false # false
```

Elixir also provides three boolean operators: `or`, `and`, and `not`. These operators are strict in the sense that they expect something that evaluates to a boolean (true or false) as their first argument:

```elixir
true and true #true
false or is_boolean(true) # true
```

Providing a non-boolean will raise an exception:

```elixir
1 and true
** (BadBooleanError) expected a boolean on left-side of "and", got: 1
```

`or` and `and` are short-circuit operators. They only execute the right side if the left side is not enough to determine the result:

```elixir
false and raise("This error will never be raised") # false
true or raise("This error will never be raised") # true
```

Elixir also provides the concept of `nil`, to indicate the absence of a value, and a set of logical operators that also manipulate `nil`: `||/2`, `&&/2`, and `!/1`. For these operators, `false` and `nil` are considered "falsy", all other values are considered "truthy":

- Falsy values:
  Only false and nil are considered falsy in Elixir.
  This means that any conditional test will evaluate to false if the value being tested is either false or nil.

- Truthy values:
  Every other value in Elixir, including numbers, strings, lists, atoms (like :ok), and empty data structures (like [] or {}), is considered truthy.

1. `||/2` (or operator)

- The `||` operator returns the first truthy value it encounters, or the second operand if the first is falsy.

```elixir
nil || true   #=> true
false || nil  #=> nil
nil || "hello" #=> "hello"
```

2. `&&/2` (and operator)

- The `&&` operator returns the second value if the first is truthy; otherwise, it returns the first value.

```elixir
true && "world"  #=> "world"
nil && true      #=> nil
false && "hello" #=> false
```

3. !/1 (not operator)

- The `!` operator negates the truthiness of a value.

```elixir
!true   #=> false
!nil    #=> true
!false  #=> true
```

Similarly, values like `0` and `""`, which some other programming languages consider to be "falsy", are also "truthy" in Elixir.

As a rule of thumb, use `and`, `or` and `not` _when you are expecting booleans_. If any of the arguments are **non-boolean**, use `&&`, `||` and `!`.

# Atoms
An atom is a constant whose value is its own name. Some other languages call these _symbols_. They are often useful to enumerate over distinct values, such as:

```elixir
:apple # :apple
```

Atoms are equal if their names are equal.

```elixir
:apple == :apple # true
:apple == :orange # false
```

Often they are used to express the state of an operation, by using values such as `:ok` and `:error`.

The booleans `true` and `false` are also atoms:

```elixir
true == :true # true
is_atom(false) # true
is_boolean(:false) # true
```

Elixir allows you to skip the leading `:` for the atoms `false`, `true` and `nil`.

# Strings
Strings in Elixir are delimited by double quotes, and they are encoded in UTF-8:

You can concatenate two strings with the `<>` operator:

```elixir
"hello " <> "world!" # "hello world!"
```

Elixir also supports string interpolation:
```elixir
string = "world"
"hello #{string}!" # "hello world!"
```

String concatenation requires both sides to be strings but interpolation supports any data type that may be converted to a string:

```elixir
number = 42
"i am #{number} years old?" # i am 42 years old?
```

```elixir
"hello
world" # "hello\nworld"
"hello\nworld" # "hello\nworld"
```

You can print a string using the `IO.puts` function from the `IO` module:

```elixir
IO.puts("hello\nworld")
# hello
# world
# :ok
```

Notice that the IO.puts function returns the atom :ok after printing.

Strings in Elixir are represented internally by contiguous sequences of bytes known as binaries:

```elixir 
is_binary("hellö") # true
byte_size("hellö") # 6
```
Notice that the number of bytes in that string is 6, even though it has 5 graphemes. That's because the grapheme "ö" takes 2 bytes to be represented in UTF-8. We can get the actual length of the string, based on the number of graphemes, by using the `String.length` function:

```elixir
String.length("hellö") # 5
```

The `String` module contains a bunch of functions that operate on strings as defined in the Unicode standard:

```elixir
String.upcase("hellö") # "HELLÖ"
```

# Structural Comparison
Elixir also provides `==`, `!=`, `<=`, `>=`, `<`and `>` as comparison operators. We can compare numbers: 

But also atoms, strings, booleans, etc: 

Integers and floats compare the same if they have the same value:


```elixir
"foo" == "foo" # true
"foo" == "bar" # false
1 != 2 # true
1 < 2 # true
1 == 1.0 # true
```

However, you can use the strict comparison operator `===` and !== if you want to distinguish between integers and floats:

```elixir
1.0 === 1 # false
```

The comparison operators in Elixir can compare across any data type. We say these operators perform structural comparison. For more information, you can read our documentation on Structural vs Semantic comparisons.

---
# Lists and Tuples

Elixir uses square brackets to specify a list of values. Values can be of any type:

```elixir
[1, 2, true, 3]
length([1, 2, 3]) # 3
```

Two lists can be concatenated or subtracted using the `++` and `--` operators respectively:

```elixir
[1, 2, 3] ++ [4, 5, 6] # [1, 2, 3, 4, 5, 6]
[1, true, 2, false, 3, true] -- [true, false] # [1, 2, 3, true]
```

List operators never modify the existing list. Concatenating to or removing elements from a list returns a new list. We say that **Elixir data structures are immutable**. One advantage of immutability is that it leads to clearer code. You can freely pass the data around with the guarantee no one will mutate it in memory - only transform it.

Throughout the tutorial, we will talk a lot about the head and tail of a list. The head is the first element of a list and the tail is the remainder of the list. They can be retrieved with the functions hd and tl. Let's assign a list to a variable and retrieve its head and tail:

```elixir
list = [1, 2, 3]
hd(list) # 1
tl(list) # [2, 3]
```

Getting the head or the tail of an empty list throws an error:
```elixir
hd([])
** (ArgumentError) argument error
```

Sometimes you will create a list and it will return a quoted value preceded by `~c`. For example:

```elixir
[6] # [6]
[7] # ~c"\a"
[11, 12, 13] # ~c"\v\f\r"
[104, 101, 108, 108, 111] # ~c"hello"
```

When Elixir sees a list of printable ASCII numbers, Elixir will print that as a charlist (literally a list of characters). Charlists are quite common when interfacing with existing Erlang code. Whenever you see a value in IEx and you are not quite sure what it is, you can use i to retrieve information about it:

```elixir
iex(..)>i ~c"hello" # info about the charlist "hello"
Term
  ~c"hello"
Data type
  List
Description
  This is a list of integers that is printed using the `~c` sigil syntax,
  defined by the `Kernel.sigil_c/2` macro, because all the integers in it
  represent printable ASCII characters. Conventionally, a list of Unicode
  code points is known as a charlist and a list of ASCII characters is a
  subset of it.
Raw representation
  [104, 101, 108, 108, 111]
Reference modules
  List
Implemented protocols
  Collectable, Enumerable, IEx.Info, Inspect, JSON.Encoder, List.Chars, String.Chars
```
We will talk more about charlists in the "Binaries, strings, and charlists" chapter.

# Tuples
Elixir uses curly brackets to define tuples. Like lists, tuples can hold any value:

Tuples store elements contiguously in memory. This means accessing a tuple element by index or getting the tuple size is a fast operation. Indexes start from zero:

```elixir
tuple = {:ok, "hello"} # {:ok, "hello"}
elem(tuple, 1) # "hello"
tuple_size(tuple) # 2
```
It is also possible to put an element at a particular index in a tuple with `put_elem`:

```elixir
# continuously
put_elem(tuple, 1, "world") # {:ok, "world"}
tuple # {:ok, "hello"}
```

Notice that **`put_elem` returned a new tuple**. The original tuple stored in the tuple variable was not modified. Like lists, tuples are also immutable. Every operation on a tuple returns a new tuple, it never changes the given one.

# List or Tuples?
What is the difference between lists and tuples?

**Lists** are stored in memory as linked lists, meaning that each element in a list holds its value and points to the following element until the end of the list is reached. This means accessing the length of a list is a linear operation: we need to *traverse the whole list in order to figure out its size*.

Similarly, the performance of list concatenation depends on the length of the left-hand list:

```elixir
list = [1, 2, 3] # [1, 2, 3]

# This is fast as we only need to traverse `[0]` to prepend to `list`
[0] ++ list # [0, 1, 2, 3]

# This is slow as we need to traverse `list` to append 4
list ++ [4] # [1, 2, 3, 4]
```

Tuples, on the other hand, are stored contiguously in memory. This means getting the **tuple size or accessing an element by index is fast**. On the other hand, **updating or adding elements to tuples is expensive** because it requires creating a new tuple in memory:

```elixir
tuple = {:a, :b, :c, :d} # {:a, :b, :c, :d}
put_elem(tuple, 2, :e) # slow
# {:a, :b, :e, :d}
```

Note, however, the elements themselves are not copied. When you update a tuple, all **entries are shared** between the old and the new tuple, except for the entry that has been replaced. This rule applies to most data structures in Elixir. This reduces the amount of memory allocation the language needs to perform and is only possible thanks to the immutable semantics of the language.

Those performance characteristics dictate the usage of those data structures. In a nutshell, lists are used when the number of elements returned may vary. Tuples have a fixed size. Let's see two examples from the `String` module:

```elixir
String.split("hello world") # ["hello", "world"]
String.split("hello beautiful world") # ["hello", "beautiful", "world"]
```

The `String.split` function breaks a string into a list of strings on every whitespace character. Since the amount of elements returned depends on the input, we use a list.

On the other hand,` String.split_at` splits a string in two parts at a given position. Since it always returns two entries, regardless of the input size, it returns tuples:

```elixir
String.split_at("hello world", 3) # {"hel", "lo world"}
String.split_at("hello world", -4) # {"hello w", "orld"}
```

It is also very common to use tuples and atoms to create "tagged tuples", which is a handy return value when an operation may succeed or fail. For example, `File.read` reads the contents of a file at a given path, which may or may not exist. It returns tagged tuples:

```elixir
File.read("path/to/existing/file") # {:ok, "... contents ..."}
File.read("path/to/unknown/file") # {:error, :enoent}
```

If the path given to `File.read` exists, it returns a tuple with the atom `:ok` as the first element and the file contents as the second. Otherwise, it returns a tuple with `:error` and the error description. As we will soon learn, Elixir allows us to pattern match on tagged tuples and effortlessly handle both success and failure cases.

Given Elixir consistently follows those rules, the choice between lists and tuples get clearer as you learn and use the language. Elixir often guides you to do the right thing. For example, there is an `elem` function to access a tuple item:

```elixir
tuple = {:ok, "hello"} # {:ok, "hello"}
elem(tuple, 1) # "hello"
```

However, given you often don't know the number of elements in a list, there is no built-in equivalent for accessing arbitrary entries in a lists, apart from its head.

# Size or Length

When counting the elements in a data structure, Elixir also abides by a simple rule: the function is named `size` if the operation is in **constant time** (the value is pre-calculated) or length if the operation is **linear** (calculating the length gets slower as the input grows). As a mnemonic, both "length" and "linear" start with "l".

For example, we have used 4 counting functions so far: byte_size (for the number of bytes in a string), tuple_size (for tuple size), length (for list length) and String.length (for the number of graphemes in a string). We use byte_size to get the number of bytes in a string, which is a cheap operation. Retrieving the number of Unicode graphemes, on the other hand, uses String.length, and may be expensive as it relies on a traversal of the entire string.

Now that we are familiar with the basic data-types in the language, let's learn important constructs for writing code, before we discuss more complex data structures.