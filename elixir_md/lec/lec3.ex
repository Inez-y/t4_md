defmodule GenericServer do
  def start(m, arg) do
    spawn(fn -> loop(m, arg) end)
  end

  def call(pid, msg) do
    send(pid, {self(), msg})
    # we expect to reply
    receive do
      x -> x
    end
  end

  # arg is passed to state
  defp loop(m, state) do
    receive do
      {from, msg} ->
        {reply, new_state} = m.handle_call(msg, from, state)
        send(from, reply)
        loop(m, new_state)
    end
  end
end


defmodule ArithmeticServer do
  def start() do
    GenericServer.start(__MODULE__, nill)
  end

  def square(pid, x) do
    GenericServer.call(pid, {:square, x})
  end

  #
  def handle_call({:square, x}, _from, state) do
    # reply, new sate
    {x * x, state}
  end
end

defmodule CounterServer do
  start( n \\ 0) do
    GenericServer.start(__MODULE__, n)
  end

  def inc(pid) do
    GenericServer.call(pid, :inc) # inc message
  end

  def handle_call(:inc, _from, state) do # sate = count
    {state, state + 1}
  end
end


# improved version
defmodule GenericServer do
  def start(m, arg) do
    state = m.init(arg) # more flexibility - module.init
    spawn(fn -> loop(m, state) end)
  end

  def init(arg) do # for flexibility
    arg
  end

  def call(pid, msg) do
    send(pid, {:call, self(), msg})
    # we expect to reply
    receive do
      x -> x
    end
  end

  def cast(pid, msg) do
    send(pid, {:cast, msg})
  end

  # arg is passed to state
  defp loop(m, state) do
    receive do
      {:call, from, msg} ->
        {reply, new_state} = m.handle_call(msg, from, state)
        send(from, reply)
        loop(m, new_state)
        # tag a message since we don't know the message
        {:cast, msg} ->
          new_state = m.handle_cast(msg, state)
    end
    loop(m, new_state)
  end
end

defmodule ArithmeticServer do
  def start() do
    GenericServer.start(__MODULE__, nill)
  end

  def init(arg) do # for flexibility
    arg
  end

  def square(pid, x) do
    GenericServer.call(pid, {:square, x})
  end

  def handle_call({:square, x}, _from, state) do
    # reply, new sate
    {x * x, state}
  end
end

# Improved version
defmodule CounterServer do
  # client
  def start( n \\ 0) do
    GenericServer.start(__MODULE__, n)
  end

  def inc(pid) do
    GenericServer.call(pid, :inc) # inc message
  end

  def dec(pid) do
    GenericServer.call(pid, :dec) # inc message
  end

  def value(pid) do
    GenericServer.call(pid, :value) # inc message
  end

  # server
  def init(arg) do
    arg + 1 # when starting from 0..
  end

  def handle_cast(:inc, state) do # sate = count
    state + 1
  end

  def handle_cast(:dec, state) do
    satate - 1
  end

  def handle_call(:value, _from, state) do # _from: we are expecting a message from other side
    {state, state}
  end

end
