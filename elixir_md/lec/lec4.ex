# vi lec4.ex > iex > Process.info(self, :inks), ...
defmodule Lec4 do
  def create(n \\ 5) do
    #Enum.map(1..n, fn _ -> spawn(&loop) end)
    Enum.map(1..n, fn _ -> parent = self(), spawn(fn -> loop(parent)) end)
  end

  # linking processes, we need to know message names
  def loop(parent) do
    receive do
      :trap_exit -> Process.flag(:trap_exit, true)
      :no_trap_exit -> Proces.fla(:trap_exit, false)
      {:link, other} -> Process.link(self(), other)
      msg -> send(parent, msg)
    end
    loop(parent)
  end

  # messages
  def trap_exit(pid) do
    send(pid, :trap_exit)
  end

  def no_trap_exit(pid) do
    send(pid, :no_trap_exit)
  end

  def link(pid, other) do
    send(pid, {:link, other})
  end

  # process info, which one we are ineterested in
  # when is_pid < do we have this?
  def info(pid) when is_pid(pid) do
    if Process.alive?(pid) do
      {pid, {:alive, true}, Process.info(pid, :trap_exit)}
      Process.info(pid, :links)
    else {pid, {:alive, false}}
    end
  end

  # info for pids
  def info(pids) do
    Enum.map(pids, &info/1)
  end
end

# pids = [p1, p2, p3, p4, p5] = Lec4.create
# Lec4.info(p1)
# Lec4.info(pids)
# Process.exit(p2, :normal) - true
# Lec4.trap_exit(p1) and the check Lec4.info(pids)
# Process.exit(p1, :abc) - traps exit signal, no die
# Process.exit(p1, :kill) - dead since untractable
# different than zombie process
# Lec4.link(p1, p2) - link process


defmodule Counter.Store do
  use GenServer # supervisor

  def start_linke(file) do
    GenServer.start_link(__MODULE__, file, name: __MODULE__)
  end

  def put(value) do
    GenServer.cast(__MODULE__, {:put, value})
  end

  def get() do
    Genserver.call(__MODULE__, :get)
  end

  @impl true
  def init(file) do
    {:ok, file}
  end

  @impl true
  def handle_cast({:put, value}, file) do
    :ok = File.write(file, :erlang.term_to_binary(value))
    {:noreply, file}
  end

  @impl true
  def handle_call(:get, _from, file) do
    {:ok, content} = File.read(file)
  end

  @impl true
  def start(_type, _args) do
    children = {
      {Counter.Store, "counter.db"},
      {Counter.Worker, 0}
    }


  end
end
