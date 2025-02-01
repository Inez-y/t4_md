# Processes
In Elixir, **all code runs inside processes**.** 

Processes are isolated from each other, run concurrent to one another and **communicate via message passing**. 

Processes are not only the basis for concurrency in Elixir, but they also provide the means for building distributed and fault-tolerant programs.

Elixir's processes should not be confused with operating system processes. Processes in Elixir are extremely lightweight in terms of memory and CPU (even compared to threads as used in many other programming languages). Because of this, it is not uncommon to have tens or even hundreds of thousands of processes running simultaneously.

In this chapter, we will learn about the basic constructs for spawning new processes, as well as sending and receiving messages between processes.


## Spawning Processes

The basic mechanism for spawning new processes is the auto-imported `spawn/1` function(takes a function which it will execute in another process.):
```elixir
spawn(fn -> 1 + 2 end)
#PID<0.43.0> - Process Idenifier
```

At this point, the process you spawned is very likely dead. The spawned process will execute the given function and exit after the function is done:

```elixir
pid = spawn(fn -> 1 + 2 end)
#PID<0.44.0>
Process.alive?(pid)
# false
```

We can retrieve the PID of the current process by calling `self/0`:
```elixir
self()
#PID<0.41.0>
Process.alive?(self())
# true
```

## Sending and Receiving Messages
```elixir
send(self(), {:hello, "world"}) # process, details
receive do
    {:hello, msg} -> msg
    {:world, _msg} -> "won't match"
end
# "world"
```
When a message is sent to a process, the message is stored in the *process mailbox*. The `receive/1` block goes through the current process mailbox searching for a message that matches any of the given patterns. `receive/1` supports guards and many clauses, exactly as `case/2`.


The process that sends the message does not block on `send/2`, it puts the message in the recipient's mailbox and continues. In particular, a process can send messages to itself.

If there is no message in the mailbox matching any of the patterns, *the current process will wait until a matching message arrives*. A timeout can also be specified:

```elixir
receive do
  {:hello, msg}  -> msg
after
  1_000 -> "nothing after 1s" # timeout
end
"nothing after 1s"
```
A timeout of 0 can be given when you already expect the message to be in the mailbox.

Let's put it all together and send messages between processes:

```elixir
parent = self()
#PID<0.41.0>
spawn(fn -> send(parent, {:hello, self()}) end)
#PID<0.48.0>
receive do
  {:hello, pid} -> "Got hello from #{inspect pid}"
end
# "Got hello from #PID<0.48.0>"
```

The `inspect/1` function is used to convert a data structure's internal representation into a string, typically for printing. Notice that when the receive block gets executed the sender process we have spawned may already be dead, as its only instruction was to send a message.

While in the shell, you may find the helper `flush/0` quite useful. It flushes and prints all the messages in the mailbox.
```elixir
send(self(), :hello)
:hello
flush()
# :hello
# :ok
```

## Links
The majority of times we spawn processes in Elixir, we spawn them as linked processes. Before we show an example with `spawn_link/1`, let's see what happens when a process started with `spawn/1` fails:
```elixir
spawn(fn -> raise "oops" end)
#PID<0.58.0>

[error] Process #PID<0.58.00> raised an exception
** (RuntimeError) oops
    (stdlib) erl_eval.erl:668: :erl_eval.do_apply/6
```

It merely logged an error but the parent process is still running. That's because processes are isolated. If we want the failure in one process to propagate to another one, we should link them. This can be done with `spawn_link/1`:

```elixir
self()
#PID<0.41.0>
spawn_link(fn -> raise "oops" end)

#** (EXIT from #PID<0.41.0>) evaluator process exited with reason: an exception was raised:
#    ** (RuntimeError) oops
#        (stdlib) erl_eval.erl:668: :erl_eval.do_apply/6

#[error] Process #PID<0.289.0> raised an exception
#** (RuntimeError) oops
#    (stdlib) erl_eval.erl:668: :erl_eval.do_apply/6
```

Because processes are linked, we now see a message saying the parent process, which is the shell process, has received an EXIT signal from another process causing the shell to terminate. IEx detects this situation and starts a new shell session.

Linking can also be done manually by calling `Process.link/1`. We recommend that you take a look at the `Process` module for other functionality provided by processes.

Processes and links play an important role when building fault-tolerant systems. Elixir processes are isolated and don't share anything by default. Therefore, a failure in a process will never crash or corrupt the state of another process. Links, however, allow processes to establish a relationship in case of failure. We often link our processes to supervisors which will detect when a process dies and start a new process in its place.

While other languages would require us to catch/handle exceptions, in Elixir we are actually fine with letting processes fail because we expect supervisors to properly restart our systems. "Failing fast" (sometimes referred as "let it crash") is a common philosophy when writing Elixir software!

`spawn/1` and `spawn_link/1` are the basic primitives for creating processes in Elixir. Although we have used them exclusively so far, most of the time we are going to use abstractions that build on top of them. Let's see the most common one, called tasks.


## Tasks

