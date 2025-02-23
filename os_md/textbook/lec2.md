# **Lecture 2: System Calls (OSTEP Ch. 5 & 6)**  

This lecture covers **system calls**, which allow programs to interact with the **Operating System (OS)**. Topics include **process creation (fork, exec, wait)**, **I/O redirection and pipes**, and **how the OS virtualizes the CPU efficiently**.

---

## **1. What is a System Call?**
A **system call** is a mechanism that allows a user program to request services from the OS. Examples include:
- Creating and managing **processes** (`fork()`, `exec()`, `wait()`)
- Managing **files** (`open()`, `read()`, `write()`, `close()`)
- Allocating **memory** (`malloc()`, `mmap()`)
- Handling **I/O operations** (input/output redirection, pipes)

### **Why Do We Need System Calls?**
User programs run in **user mode**, meaning they cannot directly access system hardware or resources. **System calls provide controlled access** to these resources via the OS.

---

## **2. Process API: Creating and Managing Processes**
Processes are created and managed using the following system calls:

### **2.1 `fork()`: Creating a Child Process**
The `fork()` system call creates a **child process**, which is a **copy** of the parent process.

#### **Key Points:**
- The child starts execution **right after `fork()`**.
- It has its own **memory space**, **registers**, and **program counter**.
- The **parent receives the child’s Process ID (PID)**, while the child receives `0`.

#### **Example: `fork()` (p1.c)**
```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    printf("Hello world (pid:%d)\n", getpid());  // Print process ID
    int rc = fork();  // Create child process

    if (rc < 0) {  // Fork failed
        fprintf(stderr, "fork failed\n");
        exit(1);
    } else if (rc == 0) {  // Child process
        printf("Hello, I am child (pid:%d)\n", getpid());
    } else {  // Parent process
        printf("Hello, I am parent of %d (pid:%d)\n", rc, getpid());
    }
    return 0;
}
```
#### **Output (non-deterministic)**
```
Hello world (pid:29146)
Hello, I am child (pid:29147)
Hello, I am parent of 29147 (pid:29146)
```
Since parent and child execute **independently**, the order of outputs **varies**.

---

### **2.2 `wait()`: Synchronizing Parent and Child**
- After `fork()`, the child process runs **independently**.
- The `wait()` system call ensures the **parent waits** for the child to **finish** before proceeding.

#### **Example: `wait()` (p2.c)**
```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    printf("Hello world (pid:%d)\n", getpid());
    int rc = fork();

    if (rc < 0) {
        fprintf(stderr, "fork failed\n");
        exit(1);
    } else if (rc == 0) {
        printf("Hello, I am child (pid:%d)\n", getpid());
    } else {
        int rc_wait = wait(NULL);  // Parent waits for child
        printf("Hello, I am parent of %d (rc_wait:%d) (pid:%d)\n",
               rc, rc_wait, getpid());
    }
    return 0;
}
```
#### **Output (deterministic)**
```
Hello world (pid:29266)
Hello, I am child (pid:29267)
Hello, I am parent of 29267 (rc_wait:29267) (pid:29266)
```
Now, the **parent always prints after the child**.

---

### **2.3 `exec()`: Replacing the Process**
The `exec()` system call **replaces** the current process with a new program.

#### **Example: `exec()` (p3.c)**
```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

int main() {
    printf("Hello world (pid:%d)\n", getpid());
    int rc = fork();

    if (rc < 0) {
        fprintf(stderr, "fork failed\n");
        exit(1);
    } else if (rc == 0) {
        printf("Hello, I am child (pid:%d)\n", getpid());
        char *myargs[3];
        myargs[0] = strdup("wc");  // Program: word count
        myargs[1] = strdup("p3.c"); // File to count words in
        myargs[2] = NULL;
        execvp(myargs[0], myargs);  // Execute wc
        printf("this shouldn't print out");
    } else {
        int rc_wait = wait(NULL);
        printf("Hello, I am parent of %d (rc_wait:%d) (pid:%d)\n",
               rc, rc_wait, getpid());
    }
    return 0;
}
```
#### **Output**
```
Hello world (pid:29383)
Hello, I am child (pid:29384)
29 107 1030 p3.c
Hello, I am parent of 29384 (rc_wait:29384) (pid:29383)
```
- **The child process runs `wc p3.c` instead of continuing with the same program.**
- The `exec()` call **never returns** if successful.

---

## **3. I/O Redirection and Pipes**
### **3.1 I/O Redirection (`>` and `<`)**
- Redirecting output to a file (`>`):
  ```
  wc p3.c > output.txt
  ```
- Redirecting input from a file (`<`):
  ```
  sort < data.txt
  ```

#### **Example: Redirecting Output (p4.c)**
```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <sys/wait.h>

int main() {
    int rc = fork();
    if (rc < 0) {
        fprintf(stderr, "fork failed\n");
        exit(1);
    } else if (rc == 0) {
        close(STDOUT_FILENO);  // Close stdout
        open("output.txt", O_CREAT | O_WRONLY | O_TRUNC, S_IRWXU);
        char *myargs[3] = { "wc", "p4.c", NULL };
        execvp(myargs[0], myargs);
    } else {
        int rc_wait = wait(NULL);
    }
    return 0;
}
```
- The **output is redirected** to `output.txt`, instead of being printed on the screen.

---

### **3.2 Pipes (`|` for Process Communication)**
- A **pipe** connects the **output of one process** to the **input of another**.
- Example: Find the number of occurrences of "foo" in `file.txt`
  ```
  grep -o foo file.txt | wc -l
  ```
- Pipes **avoid using temporary files** and allow **parallel processing**.

---

## **4. CPU Virtualization & Process Control**
### **How the OS Controls Processes Efficiently**
1. **Direct Execution** → Run the program on the CPU.
2. **User Mode vs. Kernel Mode**:
   - **User Mode**: Limited access to hardware.
   - **Kernel Mode**: OS has full access.

### **System Calls for CPU Virtualization**
- A **trap (interrupt)** allows the OS to take control when:
  - A **system call** is made.
  - A **process runs too long** (preemptive scheduling).
- **Timer Interrupt**:
  - The OS **interrupts processes** to prevent monopolization of the CPU.

### **Context Switching**
- The OS **saves the state** of one process and **restores another**.
- A **scheduler** decides which process to run next.

---

## **5. Summary**
- **`fork()`** → Creates a child process.
- **`wait()`** → Ensures a parent waits for the child to finish.
- **`exec()`** → Runs a new program in a process.
- **I/O Redirection (`>`, `<`)** → Redirects input/output.
- **Pipes (`|`)** → Connects processes for communication.
- **CPU Virtualization** → The OS efficiently shares the CPU.
