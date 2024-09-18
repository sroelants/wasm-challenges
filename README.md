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

## Debugging
Every challenge can import functions for logging debug values at runtime.

```wat
(module
  ;; Add any of the following imports to your .wat module
  (import "debug" "i32" (func $debug_i32 (param i32)))
  (import "debug" "i64" (func $debug_i64 (param i64)))
  (import "debug" "f32" (func $debug_f32 (param f32)))
  (import "debug" "f64" (func $debug_f64 (param f64)))
  (import "debug" "bool" (func $debug_bool (param i32)))
  (import "debug" "char" (func $debug_char (param i32)))

  ;; ...

  ;; Then call it with the appropriate value type in your program.
  (call $debug_f64 (f64.const 123.456))
)
```

## Poker Notes

The poker exercises require you to read values from five cards, which are stored in memory as pairs of `u8` values. The first is the _rank value_ and the second is the _suit value_.

| Decimal Value | Rank Value |
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

So the hand `A♠ 2♣️ 3♥ 4♦ 5♠️` would be stored in memory as:

| A     | ♠     | 2     | ♣️    | 3     | ♥     | 4     | ♦     | 5     | ♠ ️   |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| `0x1` | `0x0` | `0x2` | `0x1` | `0x3` | `0x2` | `0x4` | `0x3` | `0x5` | `0x0` |

## String Notes

The string challenges all work with [null-terminated](https://en.wikipedia.org/wiki/Null-terminated_string) [ASCII](https://en.wikipedia.org/wiki/ASCII) strings for simplicity, unless stated explicitly otherwise.

Compared to UTF-8 and other multi-byte encodings, ASCII is generally easier to work with, because every single character can be represented with a single byte in memory.

For example, the string `"Hello, world"` would be stored in memory as:

| `H`    | `e`    | `l`    | `l`    | `o`    | `,`    | ` `    | `w`    | `o`    | `r`    | `l`    | `d`    | END    |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| `0x48` | `0x65` | `0x6C` | `0x6C` | `0x6F` | `0x2C` | `0x20` | `0x77` | `0x6F` | `0x72` | `0x6C` | `0x64` | `0x00` |

The strings are null-terminated, which means they always end with a `NUL` byte (`0x00`).
