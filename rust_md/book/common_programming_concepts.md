# 3.1 Variables and Mutability
By default, **variables are immutable.** When a variable is immutable, once a value is bound to a name, you can’t change that value. 

`cargo new variables`
`cargo run`

immutability error
`cannot assign twice to immutable variable `x``
```rust
fn main() {
    let x = 5;
    println!("The value of x is: {x}");
    x = 6;
    println!("The value of x is: {x}");
}
```

with `mut`
```rust
fn main() {
    let mut x = 5;
    println!("The value of x is: {x}");
    x = 6;
    println!("The value of x is: {x}");
}
```


`Constants` are values that are bound to a name and are not allowed to change, but there are a few differences between constants and variables.

Constants always **immutable** - cannot go with `mut`
Declare constants using the `const` keyword instead of the `let` keyword

Constants can be declared in any scope, including the global scope, which makes them useful for values that many parts of code need to know about.

The last difference is that constants may be set only to a constant expression, not the result of a value that could only be computed at runtime.

```rust
const THREE_HOURS_IN_SECONDS: u32 = 60 * 60 * 3;
```