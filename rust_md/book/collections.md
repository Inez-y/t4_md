Rust’s standard library includes a number of very useful data structures called `collections`. Most other data types represent one specific value, but collections can contain multiple values. Unlike the built-in array and tuple types, the data these collections point to is stored on the heap, which means **the amount of data does not need to be known at compile time and can grow or shrink as the program runs.**

- A vector allows you to store a variable number of values next to each other.
- A string is a collection of characters. We’ve mentioned the String type previously, but in this chapter we’ll talk about it in depth.
- A hash map allows you to associate a value with a specific key. It’s a particular implementation of the more general data structure called a map.

# 8.1 Storing Lists of Vlues with Vectors
Vectors allow you to store more than one value in a single data structure that puts all the values next to each other in memory. Vectors can only store values of the same type. They are useful when you have a list of items, such as the lines of text in a file or the prices of items in a shopping cart.

```rust
let v: Vec<i32> = Vec::new();

let v = vec![1, 2, 3];

// update value
let mut v = Vec::new();

v.push(5);
v.push(6);
v.push(7);
v.push(8);
```

```rust
let v = vec![1, 2, 3, 4, 5];

let third: &i32 = &v[2];
println!("The third element is {third}");

let third: Option<&i32> = v.get(2);
match third {
    Some(third) => println!("The third element is {third}"),
    None => println!("There is no third element."),
}
```

## Iterating Over the Values in a Vector
```rust
let v = vec![100, 32, 57];
for i in &v {
    println!("{i}");
}
```

## Using an Enum to Store Multiple Types
```rust
enum SpreadsheetCell {
    Int(i32),
    Float(f64),
    Text(String),
}

let row = vec![
    SpreadsheetCell::Int(3),
    SpreadsheetCell::Text(String::from("blue")),
    SpreadsheetCell::Float(10.12),
];
```

# 8.2 Storing UTF-8 Encoded Text with Strings
```rust
let mut s = String::new();

let data = "initial contents";

let s = data.to_string();

// the method also works on a literal directly:
let s = "initial contents".to_string();
let s = String::from("initial contents");
```
## Update a String
```rust
let mut s1 = String::from("foo");
let s2 = "bar";
s1.push_str(s2);
println!("s2 is {s2}");

let mut s = String::from("lo");
s.push('l');
```

```rust
let s1 = String::from("Hello, ");
let s2 = String::from("world!");
let s3 = s1 + &s2; // note s1 has been moved here and can no longer be used
let s = s1 + "-" + &s2 + "-" + &s3;
```

```rust
let s1 = String::from("tic");
let s2 = String::from("tac");
let s3 = String::from("toe");

let s = format!("{s1}-{s2}-{s3}");
```

**Rust strings don’t support indexing**

## Internal Representation
A String is a wrapper over a Vec<u8>. Let’s look at some of our properly encoded UTF-8 example strings from Listing 8-14.
```rust
let hello = String::from("Hola"); // len = 4
let hello = String::from("Здравствуйте"); // len 12
```

## Slicing Strings
Indexing into a string is often a bad idea because it’s not clear what the return type of the string-indexing operation should be: a byte value, a character, a grapheme cluster, or a string slice. If you really need to use indices to create string slices, therefore, Rust asks you to be more specific.

Rather than indexing using [] with a single number, you can use [] with a range to create a string slice containing particular bytes:

```rust
let hello = "Здравствуйте";

let s = &hello[0..4];
```
You should use caution when creating string slices with ranges, because doing so can crash your program.

## Methods for Iterating Over Strings
```rust
for c in "Зд".chars() {
    println!("{c}");
}
```

# 8.3 Storing Keys with Associated Values in Hash Maps
Hash maps are useful when you want to look up data not by using an index, as you can with vectors, but by using a key that can be of any type. 

## Creating a New Hash Map
```rust
use std::collections::HashMap;

let mut scores = HashMap::new();

scores.insert(String::from("Blue"), 10);
scores.insert(String::from("Yellow"), 50);
```

## Accessing Values in a Hash Map
```rust
use std::collections::HashMap;

let mut scores = HashMap::new();

scores.insert(String::from("Blue"), 10);
scores.insert(String::from("Yellow"), 50);

let team_name = String::from("Blue");
// get method returns an Option<&V>; if there’s no value for that key in the hash map, get will return None
// Option by calling copied to get an Option<i32> rather than an Option<&i32>
// unwrap_or to set score to zero if scores doesn’t have an entry for the key.
let score = scores.get(&team_name).copied().unwrap_or(0);
```

```rust
use std::collections::HashMap;

let mut scores = HashMap::new();

scores.insert(String::from("Blue"), 10);
scores.insert(String::from("Yellow"), 50);

for (key, value) in &scores {
    println!("{key}: {value}");
}
```

## Hash Maps and Ownership
```rust
use std::collections::HashMap;

let field_name = String::from("Favorite color");
let field_value = String::from("Blue");

let mut map = HashMap::new();
map.insert(field_name, field_value);
// field_name and field_value are invalid at this point, try using them and
// see what compiler error you get!
```
We aren’t able to use the variables field_name and field_value after they’ve been moved into the hash map with the call to insert.
If we insert references to values into the hash map, the values won’t be moved into the hash map. The values that the references point to must be valid for at least as long as the hash map is valid.

## Updating a Hash Map 
- Overwriting a Value

```rust
use std::collections::HashMap;

let mut scores = HashMap::new();

scores.insert(String::from("Blue"), 10);
scores.insert(String::from("Blue"), 25);

println!("{scores:?}"); // This code will print {"Blue": 25}. The original value of 10 has been overwritten.
```

- Adding a Key and Value Only If a Key isn't Present
```rust
use std::collections::HashMap;

let mut scores = HashMap::new();
scores.insert(String::from("Blue"), 10);

scores.entry(String::from("Yellow")).or_insert(50); // entry method is an enum called Entry that represents a value that might or might not exist. 
scores.entry(String::from("Blue")).or_insert(50);

println!("{scores:?}");
```

- Updating a Value Based on the Old Value
```rust
use std::collections::HashMap;

let text = "hello world wonderful world";

let mut map = HashMap::new();

for word in text.split_whitespace() {
    let count = map.entry(word).or_insert(0);
    *count += 1;
}

println!("{map:?}");
```