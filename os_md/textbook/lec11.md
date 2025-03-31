# Lecture 11. Concurrency II
**OSTEP Chapters 30 & 32** and the slides/images you uploaded on **Concurrency II**, including **Condition Variables**, the **Producer-Consumer Problem**, and **Deadlock**.

---

## 🧵 Concurrency II Study Notes  
*(OSTEP Chapters 30 & 32)*  

---

### 🔹 **1. Condition Variables**

#### ✅ Motivation:
- Used when a thread must **wait until a condition becomes true**.
- Example: A parent waits until a child completes execution (`join`).

#### 🧪 Problem with Busy Waiting:
```c
while (done == 0); // spin — wastes CPU cycles
```

---

#### ✅ Correct Approach: Using `Condition Variables`
- Requires three things:
  - A **lock (mutex)**
  - A **condition variable**
  - A **shared state variable**

```c
pthread_mutex_t m = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t c = PTHREAD_COND_INITIALIZER;
int done = 0;
```

---

#### ✅ Pattern: Parent waits, child signals

```c
// Thread join
void thr_join() {
  pthread_mutex_lock(&m);
  while (done == 0)
    pthread_cond_wait(&c, &m);
  pthread_mutex_unlock(&m);
}

// Thread exit
void thr_exit() {
  pthread_mutex_lock(&m);
  done = 1;
  pthread_cond_signal(&c);
  pthread_mutex_unlock(&m);
}
```

- **Always use `while`**, not `if`, to recheck the condition.

---

### 🚨 Pitfalls with Condition Variables

| Problem | Why it's bad |
|--------|--------------|
| 🔴 No state variable | If signal comes before wait, the waiting thread may sleep forever. |
| 🔴 No lock | Causes race conditions. Condition variable can't work correctly without atomic release/sleep. |
| 🔴 Use `if` instead of `while` | Spurious wakeups or wrong assumptions lead to bugs. |

---

### 🧵 **2. Producer–Consumer Problem**

#### ✅ Simple Version (v1)
- One producer, one consumer.
- Shared buffer with `count` variable (0 = empty, 1 = full).

```c
int buffer;
int count = 0;

void put(int val) { assert(count == 0); buffer = val; count = 1; }
int get() { assert(count == 1); count = 0; return buffer; }
```

---

### ❌ Broken Solutions

- **Single CV + `if`** causes:
  - **Race Conditions**: consumer wakes but another consumer grabs data → state incorrect.
  - **Consumer wakes another consumer**: leads to empty buffer error.

🧪 **Mesa Semantics**:
- Woken thread doesn't run **immediately**.
- Must always recheck shared state after being signaled.

---

### ✅ Working Solution (Single Buffer)

#### ✅ Use:
- **Two condition variables**:
  - `empty` → wait when buffer is full
  - `fill` → wait when buffer is empty
- `while` loops to re-check condition.

```c
cond_t empty, fill;
mutex_t mutex;

void *producer(void *arg) {
  for (...) {
    pthread_mutex_lock(&mutex);
    while (count == 1)
      pthread_cond_wait(&empty, &mutex);
    put(i);
    pthread_cond_signal(&fill);
    pthread_mutex_unlock(&mutex);
  }
}

void *consumer(void *arg) {
  for (...) {
    pthread_mutex_lock(&mutex);
    while (count == 0)
      pthread_cond_wait(&fill, &mutex);
    int tmp = get();
    pthread_cond_signal(&empty);
    pthread_mutex_unlock(&mutex);
    printf("%d\n", tmp);
  }
}
```

---

### 📦 Correct Bounded Buffer

```c
int buffer[MAX];
int fill_ptr = 0, use_ptr = 0, count = 0;

void put(int val) {
  buffer[fill_ptr] = val;
  fill_ptr = (fill_ptr + 1) % MAX;
  count++;
}

int get() {
  int tmp = buffer[use_ptr];
  use_ptr = (use_ptr + 1) % MAX;
  count--;
  return tmp;
}
```

---

### 🔃 Covering Conditions

- Multiple threads may be waiting for different sizes.
- `pthread_cond_signal()` may wake the wrong thread.
- **Solution**: Use `pthread_cond_broadcast()`.

---

## ⚠️ Concurrency Problems (Ch. 32)

---

### 🔸 1. **Atomicity Violation**
- Intended atomic regions are **not protected**.
- Fix: Wrap access in a lock.

```c
pthread_mutex_lock(&lock);
// read or write shared variable
pthread_mutex_unlock(&lock);
```

---

### 🔸 2. **Order Violation**
- Code **assumes** A runs before B.
- Fix: Use **condition variables** to enforce ordering.

```c
pthread_mutex_lock(&lock);
while (!ready)
  pthread_cond_wait(&cond, &lock);
pthread_mutex_unlock(&lock);
```

---

### 🔸 3. **Deadlock**

#### Deadlock Conditions:
1. **Mutual Exclusion** – resources are non-shareable.
2. **Hold and Wait** – threads hold while waiting.
3. **No Preemption** – resources can't be forcibly taken.
4. **Circular Wait** – cyclic dependency exists.

---

### 🔧 Deadlock Prevention

| Method | Description |
|--------|-------------|
| **Lock Ordering** | Always acquire locks in a consistent global order |
| **Atomic Lock Acquisition** | Grab all locks at once using extra mutex |
| **Try Locking** | Use `pthread_mutex_trylock()` and retry if failed |
| **Random Delays** | Prevent livelocks caused by two threads retrying together |

---

### 🔁 Deadlock Avoidance by Scheduling

#### Example:
- Threads T1 and T2 both need L1 and L2.
- T3 and T4 need only L2.
- Don’t schedule T1 and T2 at the same time.

🧠 **Smart Scheduler** avoids deadlock by analyzing lock needs.

---

### 🧹 Deadlock Detection and Recovery

- Build a **resource graph**.
- Check for **cycles** (deadlock).
- Recover by:
  - Restarting system.
  - Killing one or more threads.
  - Rolling back transactions.

---

### 🛠 Lock-Free Programming

- **Compare-And-Swap (CAS)**:
```c
int CompareAndSwap(int *addr, int expected, int new) {
  if (*addr == expected) {
    *addr = new;
    return 1;
  }
  return 0;
}
```

- Used to build **wait-free** structures like atomic insert, counters, etc.

---

## ✅ Final Summary

| Concept | Description |
|--------|-------------|
| **Condition Variable** | Lets threads sleep/wake based on conditions |
| **Mesa Semantics** | Woken thread doesn't run immediately |
| **Covering Condition** | Broadcast when unclear which thread to wake |
| **Atomicity Bug** | Critical section not properly protected |
| **Order Bug** | Wrong execution order |
| **Deadlock** | Four conditions: ME, HW, NP, CW |
| **Avoid Deadlock** | Lock ordering, atomic acquisition, trylock |
| **Detect Deadlock** | Graph + cycle detection |
| **Fix Deadlock** | Recovery or prevention |
| **CAS** | Low-level atomic operation for lock-free design |
