Anonymous functions allow us to store and pass executable code around as if it was an integer or a string. Let's learn more.

# Identifying Functions and Documentation
Before we move on to discuss anonymous functions, let's talk about how Elixir identifies named functions.

Functions in Elixir are identified by both their **name** and their **arity**. 

The arity of a function describes the *number of arguments* that the function takes. From this point on we will use both the function name and its arity to describe functions throughout the documentation. 

`trunc/1` identifies the function which is named `trunc` and takes `1` argument, whereas `trunc/2` identifies a different (nonexistent) function with the same name but with an `arity of 2`.

We can also use this syntax to access documentation. The Elixir shell defines the `h` function, which you can use to access documentation for any function. For example, typing `h trunc/1` is going to print the documentation for the trunc/1 function:

```elixir
h trunc/1


                    def trunc(number)                                

  @spec trunc(number()) :: integer()

guard: true

Returns the integer part of number.

Allowed in guard tests. Inlined by the compiler.

## Examples

    iex> trunc(5.4)
    5
    
    iex> trunc(-5.99)
    -5
    
    iex> trunc(-5)
    -5

```

`h trunc/1` works because it is defined in the **Kernel module**. All functions in the Kernel module are automatically imported into our namespace. Most often you will also include the module name when looking up the documentation for a given function:

```elixir
h Kernel.trunc/1
```

You can use the module+function to lookup for anything, including operators (try `h Kernel.+/2`). Invoking `h` without arguments displays the documentation for `IEx.Helpers`, which is where `h` and other functionalities are defined.

# Defining Anonymous Functions
Anonymous functions in Elixir are delimited by the keywords `fn` and `end`:

```elixir
add = fn a, b -> a + b end
#Function<12.71889879/2 in :erl_eval.expr/5>
```

In the example above, we defined an anonymous function that receives two arguments, `a` and `b`, and returns the result of `a + b`. The arguments are always on the left-hand side of `->` and the code to be executed on the right-hand side. The anonymous function is stored in the variable `add`. You can see it returns a value represented by `#Function<...>`. While its representation is opaque, the `:erl_eval.expr` bit tells us the function was defined in the shell (during evaluation).

We can invoke anonymous functions by passing arguments to it, using a dot (`.`) between the variable and the opening parenthesis:

```elixir
add.(1,2) # 3
```

The dot makes it clear when you are calling an anonymous function, stored in the variable `add`, opposed to a function named `add/2`. 

For example, if you have an anonymous function stored in the variable `is_atom`, there is no ambiguity between `is_atom.(:foo)` and `is_atom(:foo)`. If both used the same `is_atom(:foo)` syntax, the only way to know the actual behavior `of is_atom(:foo)` would be by scanning all code thus far for a possible definition of the `is_atom` variable. This scanning hurts maintainability as it requires developers to track additional context in their head when reading and writing code.

Anonymous functions in Elixir are also identified by the number of arguments they receive. We can check if a value is function using `is_function/1` and also check its arity by using `is_function/2`:

```elixir
is_function(add) # true
# check if add is a function that expects exactly 2 arguments
is_function(add, 2) # true
# check if add is a function that expects exactly 1 argument
is_fun ction(add, 1) # false
```

# Closures

Anonymous functions can also access variables that are in scope when the function is defined. This is typically referred to as closures, as they close over their scope. Let's define a new anonymous function that uses the add anonymous function we have previously defined: