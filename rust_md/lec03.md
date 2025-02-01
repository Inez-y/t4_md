# One More Example of IO
from read_line

```rust
fn lines -> io::Result<Vec<String>> {
    io::stdin().lines().collect() // no Ok - colelct() already returns the result type
}
```


rustc words.rs
./words

# Enum
vi shape.rs
rusts shape.rs
./shape

# Generics
Origin
```rust
fn sum(s: &[i32]) -> i32 {
    let mut sum = 0;

    for x in s {
        sum += *x;
    }

    sum
}
```

Generic
```rust
fn sum<T: AddAssign + Copy>(s: &[T]) -> T {
    // no default value
    let mut sum = s[0];

    // why we skip the first?
    for x in s.into_iter().skip(1) {
        sum += *x; // moves the value
    }

    sum
}

fn main() {
    let a = [1.1, 2.2];
    println!("{}", sum(&a));
}
```


```rust
fn find<T> (s: &[T], f: fn(&T) -> bool) -> Option<&T> {
    for x in s {
        if f(x) {
            return Some(x);
        }
    }
    None
}

fn main() {
    fn is_even(x: &i32) -> bool { x % 2 == 0 }
    if let Some(x) = find(&v, is_even) {
        println!("{x}");
    }

    // n is_divisible(x: &i32) -> bool { x % } it doens't work. need closure

    // closure
    let is_visible = |x: i32| x % n == 0;
    // not compiled - doenst take closure
    let _ = find(&v, is_divisible);
}
```

# Closure
each closure has unique type
```rust
fn main() {
    let v = vec![1,2,3,4];
    // c captures v
    let c = || printlns!("{v:?}"); // borrowing or transferring ownerships
    printlns!("{v:?}");
    c();
    c();

    let mut v = vec![1,2,3,4];
    let mut c = || v.push(-1); // mutably borrow v
    // printlns!("{v:?}"); - cannot borrow v again as long as c is alive!
    c();
}
```

# Iterator
```rust
struct VecIter {
    v: Vec<i32>,
    l: usize,
}

impl Iterator for VecIter {
    type Item = i32;
    fn next()
}
```