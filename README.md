# WebAssembly Challenges
Tiny programming challenges designed as exercises for learning WebAssembly through writing your own [`.wat`](https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_text_format) files.

Run `./tests.mjs` to compile the text format files to WebAssembly and run the tests.

Requires [`node`](https://nodejs.org) and [`wabt`](https://github.com/WebAssembly/wabt).

- [ ] Design a simple allocator
- [ ] Implement a set data structure
- [ ] Hash function
- [ ] Sorting
- [ ] Cyclic redundancy check
- [ ] Run length encoding
- [ ] Checksum
- [ ] XOR cipher
- [ ] Manhattan distance
- [ ] Euclidean distance
- [ ] Vector add
- [ ] Vector magnitude
- [ ] IPv4 validation
- [ ] Roman numeral to int
- [ ] Pangram detector (contains each letter of the alphabet)
- [ ] UTF-8 string length checker
- [ ] Median, mode
- [ ] Simple calculator (op, lhs, rhs => res)
- [ ] Vowel checker

## Theme
It would be fun to give these exercises all a theme so that the whole thing felt a little bit more cohesive. Norse mythology? Robots?

## String Notes
Exercises that deal with strings will usually encode the strings as ASCII, where each character maps to exactly one byte.

## Poker Notes
The poker exercises require you to read values from five cards, which are stored in memory as pairs of `i32` values. The first is the _face value_ and the second is the _suit value_.

| Decimal Value | Face Value |
| ------------- | ---------- |
| `1`           | `A`        |
| `2`           | `2`        |
| `3`           | `3`        |
| ...           | ...        |
| `10`          | `10`       |
| `11`          | `J`        |
| `12`          | `Q`        |
| `13`          | `K`        |

| Decimal Value | Suit Value |
| ------------- | ---------- |
| `0`           | ♠ Spades   |
| `1`           | ♣ Clubs    |
| `2`           | ♥ Hearts   |
| `3`           | ♦ Diamonds |
