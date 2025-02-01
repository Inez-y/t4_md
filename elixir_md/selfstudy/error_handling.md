# Errors
You can also define your own errors by creating a module and using the `defexception/1` construct inside it. 

```elixir
defmodule MyError do
    defexception message: "HAHA"
end
raise MyError // ** (MyError) default message
raise MyError, message: "Another message" // ** (MyError) custom message
```

Errors can be **rescued** useing `try/rescue` construct:

```elixir
try do
  raise "Oopsy"
rescue
  e in RuntimeError -> e
end
# %RuntimeError{message: "Oopsy"}
```

The example above rescues the runtime error and returns the exception itself, which is then printed in the iex session.

```elixir
try do
  raise "Oopsy"
rescue
  RuntimeError -> "ERROR"
end # "ERROR"
```

In practice, Elixir developers rarely use the `try/rescue` construct. For example, many languages would force you to rescue an error when a file cannot be opened successfully. Elixir instead provides a `File.read/1` function which **returns a tuple containing information** about whether the file was opened successfully:

```elixir
File.read("hello") # {:error, :enoent}
File.write("hello", "world") # :ok
File.read("hello") # {:ok, "world"}
```

There is no `try/rescue` here. In case you want to handle multiple outcomes of opening a file, you can use pattern matching using the case construct:

```elixir
case File.read("hello") do
  {:ok, body} -> IO.puts("Success: #{body}")
  {:error, reason} -> IO.puts("Error: #{reason}")
end
```

For the cases where you do expect a file to exist (and the lack of that file is truly an error) you may use `File.read!/1`:
```elixir
File.read!("unknown")
** (File.Error) could not read file "unknown": no such file or directory
    (elixir) lib/file.ex:272: File.read!/1
```

## Fail fast / Let it crash
he idea behind let it crash is that, in case something unexpected happens, it is best to **let the exception happen**, without rescuing it.

All Elixir code runs inside processes that are isolated and don't share anything by default. Therefore, an unhandled exception in a process will never crash or corrupt the state of another process.

## Reraise
While we generally avoid using `try/rescue` in Elixir, one situation where we may want to use such constructs is for observability/monitoring. Imagine you want to log that something went wrong, you could do:

```elixir
try do
  ... some code ...
rescue
  e ->
    Logger.error(Exception.format(:error, e, __STACKTRACE__)) 
    #  we rescued the exception, logged it, and then re-raised it. 
    reraise e, __STACKTRACE__
end
```

We use the `__STACKTRACE__` construct both when formatting the exception and when re-raising. This ensures we reraise the exception as is, without changing value or its origin.

Generally speaking, we take errors in Elixir literally: they are reserved for unexpected and/or exceptional situations, never for controlling the flow of our code. In case you actually need flow control constructs, throws should be used. That's what we are going to see next.

## Throws
In Elixir, a value can be thrown and later be caught. throw and catch are reserved for situations where it is not possible to retrieve a value unless by using throw and catch.

Those situations are quite uncommon in practice except when interfacing with libraries that do not provide a proper API. For example, let's imagine the Enum module did not provide any API for finding a value and that we needed to find the first multiple of 13 in a list of numbers:

```elixir
try do
  Enum.each(-50..50, fn x ->
    if rem(x, 13) == 0, do: throw(x)
  end)
  "Got nothing"
catch
  x -> "Got #{x}"
end
# "Got -39"
```

Since Enum does provide a proper API, in practice Enum.find/2 is the way to go:
```elixir
Enum.find(-50..50, &(rem(&1, 13) == 0))
# -39
```

## Exits
All Elixir code runs inside processes that communicate with each other. When a process dies of "natural causes" (e.g., unhandled exceptions), it sends an `exit` signal. A process can also die by explicitly sending an `exit` signal:

```elixir
spawn_link(fn -> exit(1) end)
# ** (EXIT from #PID<0.56.0>) shell process exited with reason: 1
# the linked process died by sending an exit signal with a value of 1. The Elixir shell automatically handles those messages and prints them to the terminal.
```

exit can also be "caught" using `try/catch`:

```elixir

try do
  exit("I am exiting")
catch
  :exit, _ -> "not really"
end
# "not really"
```

`catch` can also be used within a function body without a matching `try`

```elixir
defmodule Example do
  def matched_catch do
    exit(:timeout)
  catch
    :exit, :timeout ->
      {:error, :timeout}
  end

  def mismatched_catch do
    exit(:timeout)
  catch
    # Since no clause matches, this catch will have no effect
    :exit, :explosion ->
      {:error, :explosion}
  end
end
```

`exit` signals are an important part of the fault tolerant system provided by the Erlang VM. Processes usually run under supervision trees which are themselves processes that listen to `exit` signals from the supervised processes. Once an `exit` signal is received, the supervision strategy kicks in and the supervised process is restarted.

t is exactly this supervision system that makes constructs like `try/catch` and `try/rescue` so uncommon in Elixir. Instead of rescuing an error, we'd rather "fail fast" since the supervision tree will guarantee our application will go back to a known initial state after the error.

## After
Sometimes it's necessary to ensure that a resource is cleaned up after some action that could potentially raise an error. The `try/after` construct allows you to do that. For example, we can open a file and use an `after` clause to close it—even if something goes wrong:

```elixir
{:ok, file} = File.open("sample", [:utf8, :write])
try do
  IO.write(file, "olá")
  raise "oops, something went wrong"
after # The after clause will be executed regardless of whether or not the tried block succeeds.
  File.close(file)
end
# ** (RuntimeError) oops, something went wrong
```

The after clause will be executed regardless of whether or not the tried block succeeds. Note, however, that if a linked process exits, this process will exit and the after clause will not get run. Thus after provides only a soft guarantee. Luckily, files in Elixir are also linked to the current processes and therefore they will always get closed if the current process crashes, independent of the after clause. You will find the same to be true for other resources like ETS tables, sockets, ports and more.

Sometimes you may want to wrap the entire body of a function in a `try` construct, often to guarantee some code will be executed afterwards. In such cases, Elixir allows you to omit the `try` line:
```elixir
defmodule RunAfter do
  def without_even_trying do
    raise "oops"
  after
    IO.puts("cleaning up!")
  end
end
RunAfter.without_even_trying
cleaning up!
# ** (RuntimeError) oops
```

## Else
If an `else` block is present, it will match on the results of the `try` block whenever the `try` block finishes without a throw or an error.

```elixir
x = 2
2
try do
  1 / x
rescue
  ArithmeticError ->
    :infinity
else
# Exceptions in the else block are not caught. If no pattern inside the else block matches, an exception will be raised; this exception is not caught by the current try/catch/rescue/after block.
  y when y < 1 and y > -1 ->
    :small
  _ ->
    :large
end
:small
```

## Variable Scope
Similar to `case`, `cond`, `if` and other constructs in Elixir, variables defined inside `try/catch/rescue/after` blocks do not leak to the outer context. In other words, this code is invalid:

```elixir
try do
  raise "fail"
  what_happened = :did_not_raise
rescue
  _ -> what_happened = :rescued
end
what_happened
# ** (CompileError) undefined variable "what_happened"
```

Instead, return the value of the `try` expressions:

```elixir
hat_happened =
  try do
    raise "fail"
    :did_not_raise
  rescue
    _ -> :rescued
  end
what_happened
# :rescued
```

