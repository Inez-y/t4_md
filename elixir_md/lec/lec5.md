<!-- This is from Feb 7 during applied programming -->
# Metaprogramming
Metaprogramming is the process of using code to write code. 

In Elixir this gives us the ability to extend the language to fit our needs and dynamically change the code. We’ll start by looking at how Elixir is represented under the hood, then how to modify it, and finally we can use this knowledge to extend it.

A word of caution: Metaprogramming is tricky and should only be used when necessary Overuse will almost certainly lead to complex code that is difficult to understand and debug.

`AST`, `lexing`, `parsing`

## Quote
The first step to metaprogramming is understanding how expressions are represented. 

In Elixir the abstract syntax tree `AST`, the internal representation of our code, is composed of **tuples**. 

These tuples contain three parts: *function name, metadata, and function arguments*

In order to see these internal structures, Elixir supplies us with the `quote/2` function. Using `quote/2` we can convert Elixir code into its underlying representation:

```elixir
quote do: 42 # 42
quote do: "Hello" # "Hello"
quote do: :world # :world
quote do: 1 + 2 # {:+, [context: Elixir, import: Kernel], [1, 2]}

# function name : if 
# meta data : [context: Elixir, import: Kernel]
# function arguments (result) : [{:value, [], Elixir}, [do: "True", else: "False"]]
quote do: 
if value, do: "True", else: "False"
# {:if, [context: Elixir, import: Kernel],
# [{:value, [], Elixir}, [do: "True", else: "False"]]}
```

Notice the first three don’t return tuples? There are five literals that return themselves when quoted:

1. `:atom`
2. `string`
3. `numbers`
4. `lists`
5. `2 element tuples`

## Unquote
