# Intro to Operation Systems
a running program does one very simple thing: it executes instructions.

the processor **fetches an instruction** from memory, **decodes** it (i.e., figures out which instruction this is), and **executes** it (i.e., it does the thing that it is supposed to do, like add two numbers together, access memory, check a condition, jump to a function, and so forth).

After it is done with this instruction, the processor moves on to the next instruction, and so on, and so on, until the program finally completes

Will learn what's happening whil a program runs, with the primary goal of making the system **easy to use**

That body of software which is reponsible for making it easy to run programs is called the **operating system (OS)**
, which is in charge of making sure the system operates correctly and efficiently in an easy-to-use manne

How OS make the system works correctly and efficiently?
`Virtualization`
OS takes a physical resource (such as the processor, or memory, or a disk) and transforms it into a more gen- eral, powerful, and easy-to-use virtual form of itself

- virtual machine
- some interfaces (APIs) that you can call
- exports a few hundred system calls that are available to applications
- OS provides a standard library to applications

OS is sometimes known as a **resource manager** because virtualization allow many programs to run (with individual instructions and data - sharing memory) and many programs to access devices (sharing disks)

resource: each of cpu, memory, disk...

## 2.1 Virtualizing the CPU
allowing many programs to seemingly run at once is what we call **virtualizing the CPU**

to run programs, there need to be some APIs (interfaces) to communicate your desire to the OS