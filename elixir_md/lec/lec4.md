# Error Handling
link processies and if child dies supervisor gives exit signals, and spawn another process


# File
seriarizable in java
```elixir
File.write("abc", "hello")
File.read("abc") # {:ok, "hello"}


:erlang.term_to_binary([1, "hello", :hi, {:ok 5}])
bin = v
:erlang.binary_to_term(bin) # [1, "hello", :hi, {:ok 5}]
```
store.ex


# Struct
student.
```elixir
defmodule Name do 
    defstruct [:first, :last]

    def new(firstname, lastname) do
        %Name{first: firstname, last: lastname}
    end
end

defmodule Student do
    defstruct [id: "", name: %Name{}, scores: %{}]

    def new(id, firstname, lastname, scores \\ %{}) do
        %Student{id: id, name: Name.new(firstname, lastname), scores: scores}
    end

    def parse(data) do
        case String.split(data) do
        [id, firstname, lastname | rest] -> 
            scores = for [c, s] <- Enum.chunk_every(rest, 2), into: %{}. do: {c, String.to_integer(s, 10)}
        {:ok, Student.new(id, firstname, lastname, scores)}
        _ -> :error
    end

    def read_file(path) do
        {:ok, content} = File.read(path)
        # split the content
        Enum.map(String.split(content, "\n"), &parse/1) |> 
        Enum.filter(&(&1 != :error)) |>
        Enum.map(fn {_, x} -> x end)
    end
end
```