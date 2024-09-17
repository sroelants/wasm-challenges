# WASM Challenges
Tiny programming challenges designed for learning about WebAssembly by writing your own [`.wat`](https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_text_format) files.

Each challenge has a `.wat` file where you'll need to implement a WebAssembly module to pass tests in `tests.mjs`.

Run `node tests.mjs` to run the tests.

## Dependencies
- [`node`](https://nodejs.org)
- [`wabt`](https://github.com/WebAssembly/wabt)

## Resources
- [Understanding WebAssembly text format](https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_text_format)
- [WebAssembly instruction reference](https://developer.mozilla.org/en-US/docs/WebAssembly/Reference)
- [WebAssembly specification](https://webassembly.github.io/spec/core/)
- [WebAssembly core test suite](https://github.com/WebAssembly/spec/tree/main/test/core)

## Ideas

- [ ] Bump allocator
- [ ] Implement a set data structure
- [ ] Hash function
- [ ] Sorting
- [ ] Cyclic redundancy check
- [ ] Run length encoding
- [ ] Checksum
- [ ] XOR cipher
- [ ] Substitution cipher
- [ ] Rot13 cipher
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
- [ ] Battlebits (battleships but each ship is a bit)
- [ ] Turtle (interpret instructions for a turtle on an infinite grid)
- [ ] Word guess (word in memory, have the player guess the chars one at a time, -1 for a miss, 0 for a hit, 1 for a win)

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
