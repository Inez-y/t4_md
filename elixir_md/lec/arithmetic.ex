# for lengthy calculation
defmodule Arithmetic.Worker do
  use GenServer # provides call and cast

  # client
  def start() do
    GenServer.start(__MODULE__, nil)
  end

  def square(pid, x) do
    GenServer.call(pid, {:square, x}, 1000000)
  end

  def sqrt(pid, x) do
    GenServer.call(pid, {:sqrt, x}, 1000000)
  end


  # server (implementation
  @impl true # tell compiler to check the GenServer
  def init(arg) do
    {:ok, arg}
  end

  @impl true
  def handle_call({:square, x}, _from, state) do # _from is not always used
    {:reply, x * x, state}
  end

  @impl true
  def handle_call({{:sqrt}, x}, _From, state) do
    Process.sleep(10000) # 10 secs -> times out in 5 secs -> need to put time in functions
    reply = if x >= 0, do: :math.sqrt(x), else: :error
    {:reply, reply, state}
  end
end
