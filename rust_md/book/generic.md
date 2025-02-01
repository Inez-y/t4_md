# 10.1 Generic Data Types
## Removing Duplication by Extracting a Function for Memory Efficiency

Although this code works, duplicating code is tedious and error prone. We also have to remember to update the code in multiple places when we want to change it.

```rust
fn main() {
    let number_list = vec![34, 50, 25, 100, 65];

    let mut largest = &number_list[0]; // reference of 34

    for number in &number_list {
        if number > largest {
            largest = number; // at the end, largest = 100
        }
    }

    println!("The largest number is {largest}");

    let number_list = vec![102, 34, 6000, 89, 54, 2, 43, 8];

    let mut largest = &number_list[0];

    for number in &number_list {
        if number > largest {
            largest = number;
        }
    }

    println!("The largest number is {largest}");
}
```
To eliminate this duplication, we’ll create an abstraction by defining a function that operates on any list of integers passed in as a parameter.

```rust
// cleaed version
fn largest(list: &[i32]) -> &i32 {
    let mut largest = &list[0];

    for item in list {
        if item > largest {
            largest = item;
        }
    }

    largest
}

fn main() {
    let number_list = vec![34, 50, 25, 100, 65];

    let result = largest(&number_list);
    println!("The largest number is {result}");

    let number_list = vec![102, 34, 6000, 89, 54, 2, 43, 8];

    let result = largest(&number_list);
    println!("The largest number is {result}");
}
```

## In Function Definitions
When defining a function that uses generics, we place the generics in the signature of the function where we would usually specify the data types of the parameters and return value. Doing so makes our code more flexible and provides more functionality to callers of our function while preventing code duplication.


```rust
fn largest<T>(list: &[T]) -> &T {...} // the function largest is generic over some type T.
```

## In Struct Definitions
```rust
struct Point<T> {
    x: T,
    y: T,
}

fn main() {
    let integer = Point { x: 5, y: 10 };
    let float = Point { x: 1.0, y: 4.0 };
}

// x, y both generics but could have different types
struct Point<T, U> {
    x: T,
    y: U,
}

fn main() {
    let both_integer = Point { x: 5, y: 10 };
    let both_float = Point { x: 1.0, y: 4.0 };
    let integer_and_float = Point { x: 5, y: 4.0 };
}
```

## In Enum Definitions
```rust
enum Option<T> {
    Some(T),
    None,
}

// Enums can use multiple generic types as well. 
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

## In Method Definitions
```rust
struct Point<T> {
    x: T,
    y: T,
}

impl<T> Point<T> {
    fn x(&self) -> &T {
        &self.x
    }
}

fn main() {
    let p = Point { x: 5, y: 10 };

    println!("p.x = {}", p.x());
}
```

We can also specify constraints on generic types when defining methods on the type
```rust
impl Point<f32> {
    fn distance_from_origin(&self) -> f32 {
        (self.x.powi(2) + self.y.powi(2)).sqrt()
    }
}
```

The purpose of this example is to demonstrate a situation in which some generic parameters are declared with impl and some are declared with the method definition. Here, the generic parameters X1 and Y1 are declared after impl because they go with the struct definition. The generic parameters X2 and Y2 are declared after fn mixup because they’re only relevant to the method.

```rust
struct Point<X1, Y1> {
    x: X1,
    y: Y1,
}

impl<X1, Y1> Point<X1, Y1> {
    fn mixup<X2, Y2>(self, other: Point<X2, Y2>) -> Point<X1, Y2> {
        Point {
            x: self.x,
            y: other.y,
        }
    }
}

fn main() {
    let p1 = Point { x: 5, y: 10.4 }; // i32, i64 // mixup
    let p2 = Point { x: "Hello", y: 'c' }; // point struct

    let p3 = p1.mixup(p2);

    println!("p3.x = {}, p3.y = {}", p3.x, p3.y); // p3.x = 5, p3.y = c.
}
```

## Performance of Code Using Generics
Rust accomplishes this by performing monomorphization of the code using generics at compile time. `Monomorphization` is the process of turning generic code into specific code by filling in the concrete types that are used when compiled. 

```rust
// Let’s look at how this works by using the standard library’s generic Option<T> enum:
let integer = Some(5);
let float = Some(5.0);
```

When Rust compiles this code, it performs monomorphization. During that process, the compiler reads the values that have been used in `Option<T>` instances and identifies two kinds of `Option<T>`: `i32`, `f64`

The monomorphized version of the code looks similar to the following (the compiler uses different names than what we’re using here for illustration):

```rust
enum Option_i32 {
    Some(i32),
    None,
}

enum Option_f64 {
    Some(f64),
    None,
}

fn main() {
    let integer = Option_i32::Some(5);
    let float = Option_f64::Some(5.0);
}
```
The generic `Option<T>` is replaced with the specific definitions created by the compiler. Because Rust compiles generic code into code that specifies the type in each instance, we pay no runtime cost for using generics. 

# 10.2 Traits: Defining Shared Behavior
- A `trait` defines the functionality a particular type has and can share with other types.
    - We can use traits to **define shared behavior in an abstract way.**
    - We can use `trait bounds` to specify that a generic type can be any type that has certain behavior.
    - Note: Traits are similar to a feature often called *interfaces* in other languages, although with some differences.

## Defining a Trait
A type’s behavior consists of the methods we can call on that type. Different types share the same behavior if we can call the same methods on all of those types.

Trait definitions are a way to group method signatures together to define a set of behaviors necessary to accomplish some purpose.

```rust
// A Summary trait that consists of the behavior provided by a summarize method
pub trait Summary {
    fn summarize(&self) -> String;
}
```
Each type implementing this trait must provide its own custom behavior for the body of the method. The compiler will enforce that any type that has the `Summary` trait will have the method `summarize` defined with this signature exactly.

A trait can have multiple methods in its body: the method signatures are listed one per line, and each line ends in a semicolon.

## Implementing a Trait on a Type
```rust
pub struct NewsArticle {
    pub headline: String,
    pub location: String,
    pub author: String,
    pub content: String,
}

impl Summary for NewsArticle {
    fn summarize(&self) -> String {
        format!("{}, by {} ({})", self.headline, self.author, self.location)
    }
}

pub struct Tweet {
    pub username: String,
    pub content: String,
    pub reply: bool,
    pub retweet: bool,
}

impl Summary for Tweet {
    fn summarize(&self) -> String {
        format!("{}: {}", self.username, self.content)
    }
}
```

```rust
use aggregator::{Summary, Tweet};

fn main() {
    let tweet = Tweet {
        username: String::from("horse_ebooks"),
        content: String::from(
            "of course, as you probably already know, people",
        ),
        reply: false,
        retweet: false,
    };

    println!("1 new tweet: {}", tweet.summarize());
}
// 1 new tweet: horse_ebooks: of course, as you probably already know, people
```

## Default Implementations
```rust
pub trait Summary {
    fn summarize(&self) -> String {
        String::from("(Read more...)")
    }
}
```
To use a default implementation to summarize instances of NewsArticle, we specify an empty `impl` block with `impl Summary for NewsArticle {}`.

Even though we’re no longer defining the `summarize` method on `NewsArticle` directly, we’ve provided a default implementation and specified that NewsArticle implements the Summary trait. As a result, we can still call the summarize method on an instance of NewsArticle, like this

```rust
let article = NewsArticle {
    headline: String::from("Penguins win the Stanley Cup Championship!"),
    location: String::from("Pittsburgh, PA, USA"),
    author: String::from("Iceburgh"),
    content: String::from(
        "The Pittsburgh Penguins once again are the best \
            hockey team in the NHL.",
    ),
};

println!("New article available! {}", article.summarize());
// New article available! (Read more...)
```

Default implementations can call other methods in the same trait, even if those other methods don’t have a default implementation. In this way, a trait can provide a lot of useful functionality and only require implementors to specify a small part of it. 

```rust
pub trait Summary {
    fn summarize_author(&self) -> String;

    fn summarize(&self) -> String {
        format!("(Read more from {}...)", self.summarize_author())
    }
}

impl Summary for Tweet {
    fn summarize_author(&self) -> String {
        format!("@{}", self.username)
    }
}

let tweet = Tweet {
    username: String::from("horse_ebooks"),
    content: String::from(
        "of course, as you probably already know, people",
    ),
    reply: false,
    retweet: false,
};

println!("1 new tweet: {}", tweet.summarize());
// 1 new tweet: (Read more from @horse_ebooks...)
```

Note that it isn’t possible to call the default implementation from an overriding implementation of that same method.

## Traits as Parameters
```rust
// Instead of a concrete type for the item parameter, we specify the impl keyword and the trait name. This parameter accepts any type that implements the specified trait.
pub fn notify(item: &impl Summary) {
    println!("Breaking news! {}", item.summarize());
}
```

## Trait Bound Syntax
```rust
pub fn notify<T: Summary>(item: &T) {
    println!("Breaking news! {}", item.summarize());
}

pub fn notify(item1: &impl Summary, item2: &impl Summary) {...}
pub fn notify<T: Summary>(item1: &T, item2: &T) {...}
```

## Specifying Multiple Trait Bounds with the `+` Syntax
```rust
pub fn notify(item: &(impl Summary + Display)) {...}

pub fn notify<T: Summary + Display>(item: &T) {...}
```

## Clearer Trait Bounds with `where` Clauses
```rust
fn some_function<T: Display + Clone, U: Clone + Debug>(t: &T, u: &U) -> i32 {...}

// can be improved like this with less trait bounds
fn some_function<T, U>(t: &T, u: &U) -> i32
where
    T: Display + Clone,
    U: Clone + Debug,
{...}
```

## Returning Tpes that Implements Traits
```rust
fn returns_summarizable() -> impl Summary {
    Tweet {
        username: String::from("horse_ebooks"),
        content: String::from(
            "of course, as you probably already know, people",
        ),
        reply: false,
        retweet: false,
    }
}
```

## Using Trait Bounds to Condtionally Implement Methods
By using a trait bound with an impl block that uses generic type parameters, we can implement methods conditionally for types that implement the specified traits. 


# 10.3 Validating References with Lifetimes