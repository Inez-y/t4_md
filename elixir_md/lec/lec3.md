```elixir
vi lec3.ex
iex lec3.ex
pid = ArithmeticServer.start
ArithmeticServer.square(pid,10)
CounterServer.inc(pid)
```

# Generic Server
- OTP platform: open telecom platform, generic framework to implement servers


```elixir
vi arithmetic.ex
iex arithmetic.ex

Arithmetic.Worker.start
{:ok, pid} = v
Arithmetic.Worker.square(pid, 5)
```

arithmetic.ex is for avoiding chain server calling (takes longer time)


Remote shell
```elixir
iex --sname homer arithmetic.ex
iex --snmae bart --remsh 'homer@elixir'


# in homer
{:ok, pid} = Arithmetic.Worker.start
PID<0.133.0>

# in bart
pid = pid(0, 133, 0)

# after time set up, terminals take turn
```


let it crash if cannot handle failures
```elixir
vi counter.ex
iex coutter.ex
{:ok, pid} = Counter.Server.start
Counter.Server.inc(pid)
```

```elixir
mix new counter # source code in lib
# the counter.ex is just Hello World
rm lib/counter.ex # delete

vi lib/counter/server.ex

iex -S mix
```

in elixir and erlang, it is common to put server and client in one

# Streams in Elixir
```elixir
for {k, 1} <- [a:1, b:2, c:3], into: %{}, do: {k, val}
```