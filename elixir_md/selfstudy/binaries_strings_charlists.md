In "Basic types", we learned a bit about strings and we used the `is_binary/1` function for checks:

```elixir
string = "hello" # "hello"
is_binary(string) # true
```

In this chapter, we will gain clarity on what exactly binaries are and how they relate to strings.
We will also learn about **charlists**, `~c"like this"`, which are often used for interoperability with Erlang.

# Unicode and Code Points
In order to facilitate meaningful communication between computers across multiple languages, a standard is required so that the ones and zeros on one machine mean the same thing when they are transmitted to another. 

*The Unicode Standard* acts as an official registry of virtually all the characters we know: this includes characters from classical and historical texts, emoji, and formatting and control characters as well.

Unicode organizes all of the characters in its repertoire into code charts, and each character is given a unique numerical index. This numerical index is known as a `Code Point`.

In Elixir you can use a `?` in front of a character literal to **reveal its code point**:

```elixir
?a # 97
?ł # 322
```

Note that most Unicode code charts will refer to a code point by its hexadecimal (hex) representation, e.g. 97 translates to 0061 in hex, and we can represent any Unicode character in an Elixir string by using the \uXXXX notation and the hex representation of its code point number:

```elixir
"\u0061" == "a" # true
0x0061 = 97 = ?a # 97
```

# UTF-8 and Encodings
Now that we understand what the Unicode standard is and what code points are, we can finally talk about encodings. 
Whereas the code point is what we store, an **encoding deals with how we store it**: encoding is an implementation. 
In other words, we need a mechanism to convert the code point numbers into bytes so they can be stored in memory, written to disk, etc.

```elixir
string = "héllo" # "héllo"
String.length(string) # 5
byte_size(string) # 6
```

Although the string above has 5 characters, it uses 6 bytes, as two bytes are used to represent the character é.

Besides defining characters, UTF-8 also provides a notion of graphemes. Graphemes may consist of multiple characters that are often perceived as one. 

```elixir
String.codepoints("👩‍🚒") # ["👩", "‍", "🚒"]
String.graphemes("👩‍🚒") # ["👩‍🚒"]
String.length("👩‍🚒") # 1
```

UTF-8 encoded documents are everywhere. This page itself is encoded in UTF-8. The encoding information is given to your browser which then knows how to render all of the bytes, characters, and graphemes accordingly.

If you want to see the exact bytes that a string would be stored in a file, a common trick is to concatenate the null byte `<<0>>` to it or `IP.inspeect/2`:

```elixir
"hełło" <> <<0>> # <<104, 101, 197, 130, 197, 130, 111, 0>>

IO.inspect("hełło", binaries: :as_binaries)
# <<104, 101, 197, 130, 197, 130, 111>>
```

# Bitstrings
A bitstring is a fundamental data type in Elixir, denoted with the `<<>>` syntax. **A bitstring is a contiguous sequence of bits in memory**.

By default, 8 bits (i.e. 1 byte) is used to store each number in a bitstring, but you can manually specify the number of bits via a `::n` modifier to denote the size in `n` bits, or you can use the more verbose declaration `::size(n)`:

```elixir
<<42>> == <<42::8>> # true
<<3::4>> # <<3::size(4)>>
```

For example, the decimal number 3 when represented with 4 bits in base 2 would be 0011, which is equivalent to the values 0, 0, 1, 1, each stored using 1 bit:

```elixir
# decimal number 3 with 4 bits (in base 2)
<<0::1, 0::1, 1::1, 1::1>> == <<3::4>> # true
```

Any value that exceeds what can be stored by the number of bits provisioned is truncated:

```elixir
# 257 in base 2 would be represented as 100000001
# left-most bit is ignored and the value becomes truncated to 00000001, which is 1 in decimal
<<1>> == <<257>> # true
```

# Binaries
**A binary is a bitstring where the number of bits is divisible by 8.** 

That means that every binary is a bitstring, but not every bitstring is a binary. We can use the `is_bitstring/1` and `is_binary/1` functions to demonstrate this.

```elixir
# decimal number 3 with 4 bits - 0011
is_bitstring(<<3::4>>) # true
is_binary(<<3::4>>) # false

# 0: 00000000, 255: 11111111, 42: 00101010
is_bitstring(<<0, 255, 42>>) # true
is_binary(<<0, 255, 42>>) # true

# decimal number 3 with 16 bits - 0000000000000003
is_binary(<<42::16>>) # true
```

We can pattern match on binaries / bitstrings:
```elixir
<<0, 1, x>> = <<0, 1, 2>> # <<0, 1, 2>>
x # 2
<<0, 1, x>> = <<0, 1, 2, 3>>
# ** (MatchError) no match of right hand side value: <<0, 1, 2, 3>>
```

Note that unless you explicitly use `::` modifiers, each entry in the binary pattern is expected to match a single byte (exactly 8 bits). If we want to match on a binary of unknown size, we can use the `binary` modifier at the end of the pattern:

```elixir
<<0, 1, x::binary>> = <<0, 1, 2, 3>> # <<0, 1, 2, 3>>
x # <<2, 3>>
```

There are a couple other modifiers that can be useful when doing pattern matches on binaries. The `binary-size(n)` modifier will match `n` bytes in a binary:

```elixir
<<head::binary-size(2), rest::binary>> = <<0, 1, 2, 3>> # <<0, 1, 2, 3>>
head # <<0, 1>>
rest # <<2, 3>>
```

***A string is a UTF-8 encoded binary***, where the code point for each character is encoded using 1 to 4 bytes. Thus every string is a binary, but due to the UTF-8 standard encoding rules, not every binary is a valid string.

```elixir
is_binary("hello") # true
is_binary(<<239, 191, 19>>) # true

# String.valid? - Checks whether string contains only valid characters
```

Valid UTF-8 sequences follow specific patterns:

- Single-byte characters: `0xxxxxxx` (0-127)

- Multi-byte characters start with specific prefixes like `110xxxxx (2-byte)`, `1110xxxx (3-byte)`, or `11110xxx (4-byte)`

- Continuation bytes: `10xxxxxx` -> not string

```elixir
# 11101111, 10111111, 00010011
String.valid?(<<239, 191, 19>>) # false
```

The string concatenation operator `<>` is actually a binary concatenation operator:

```elixir
"a" <> "ha" # "aha"
<<0, 1>> <> <<2, 3>> # <<0, 1, 2, 3>>

<<head, rest::binary>> = "banana" # "banana"
head == ?b # true
rest # "anana"
```

However, remember that binary pattern matching works on bytes, so matching on the string like "`über`" with multibyte characters won't match on the character, it will match on the first byte of that character:

```elixir
"ü" <> <<0>> # <<195, 188, 0>>
<<x, rest::binary>> = "über" # "über"
x == ?ü # false
rest # <<188, 98, 101, 114>>
```
Above, x matched on only the first byte of the multibyte ü character.

Therefore, when pattern matching on strings, it is important to use the utf8 modifier:

```elixir
<<x::utf8, rest::binary>> = "über" # "über"
x == ?ü # true
rest # "ber"
```

# Charlists
**A charlist is a list of integers where all the integers are valid code points.** 

In practice, you will not come across them often, only in specific scenarios such as interfacing with older Erlang libraries that do not accept binaries as arguments.

```elixir
~c"hello" # ~c"hello"
[?h, ?e, ?l, ?l, ?o] # ~c"hello"
```

The `~c`sigil indicates the fact that we are dealing with a charlist and not a regular string.

Instead of containing bytes, **a charlist contains integer code points**. However, the list is only printed as a sigil if all code points are within the ASCII range:

```elixir
~c"hełło" # [104, 101, 322, 322, 111]
is_list(~c"hełło") # true
```

if you are storing a list of integers that happen to range between 0 and 127, by default IEx will interpret this as a charlist and it will display the corresponding ASCII characters.
You can always force charlists to be printed in their list representation by calling the `inspect/2` function:

```elixir
heartbeats_per_minute = [99, 97, 116] # ~c"cat"
inspect(heartbeats_per_minute, charlists: :as_list) # "[99, 97, 116]"
```

Furthermore, you can convert a charlist to a string and back by using the `to_string/1` and `to_charlist/1`:
```elixir
to_charlist("hełło") # [104, 101, 322, 322, 111]
to_string(~c"hełło") # "hełło"
to_string(:hello) # "hello"
to_string(1) # "1"
```

The functions above are polymorphic, in other words, they accept many shapes: not only do they convert charlists to strings (and vice-versa), they can also convert integers, atoms, and so on.

String (binary) concatenation uses the `<>` operator but charlists, being lists, use the list concatenation operator `++`:
```elixir
~c"this " ++ ~c"works" # ~c"this works"
"he" <> "llo" # "hello"

~c"this " <> ~c"fails" # ** (ArgumentError)
```