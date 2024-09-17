// @ts-check

import { equal } from "node:assert";
import {
  challenge,
  expectFunc,
  expectMemory,
  parseBitboard,
  setMemoryFloat32,
  setMemoryInt32,
  setMemoryStringAscii,
  todo,
} from "./utils.mjs";

challenge("increment", (wasm) => {
  const increment = expectFunc(wasm.instance.exports.increment);
  equal(increment(0), 1);
  equal(increment(2), 3);
  equal(increment(10), 11);
  equal(increment(-4), -3);
});

challenge("double", (wasm) => {
  const double = expectFunc(wasm.instance.exports.double);
  equal(double(0), 0);
  equal(double(2), 4);
  equal(double(10), 20);
  equal(double(-4), -8);
});

challenge("read_from_memory", (wasm) => {
  const load = expectFunc(wasm.instance.exports.load);
  const memory = expectMemory(wasm.instance.exports.memory);
  setMemoryInt32(memory, [11, 22, 33]);
  equal(load(0), 11);
  equal(load(1), 22);
  equal(load(2), 33);
});

challenge("write_to_memory", (wasm) => {
  const store = expectFunc(wasm.instance.exports.store);
  const memory = expectMemory(wasm.instance.exports.memory);
  const view = new DataView(memory.buffer);
  store(0, 11);
  store(1, 22);
  store(2, 33);
  equal(view.getInt32(0, true), 11);
  equal(view.getInt32(4, true), 22);
  equal(view.getInt32(8, true), 33);
});

challenge("triangle_numbers", (wasm) => {
  const triangular = expectFunc(wasm.instance.exports.triangular);
  equal(triangular(0), 0);
  equal(triangular(1), 1);
  equal(triangular(2), 3);
  equal(triangular(3), 6);
  equal(triangular(10), 55);
  equal(triangular(20), 210);
});

challenge("sum_array", (wasm) => {
  const sum = expectFunc(wasm.instance.exports.sum);
  const memory = expectMemory(wasm.instance.exports.memory);
  setMemoryInt32(memory, [1, 2, 3, 4, 5, 6]);
  equal(sum(1), 1);
  equal(sum(2), 3);
  equal(sum(3), 6);
  equal(sum(4), 10);
  equal(sum(0), 0); // zero is a bit of an edge case
});

challenge("max", (wasm) => {
  const max = expectFunc(wasm.instance.exports.max);
  equal(max(1, 10), 10);
  equal(max(10, 1), 10);
  equal(max(0, 1), 1);
  equal(max(100, 99), 100);
  equal(max(0, 0), 0);
});

challenge("mean", (wasm) => {
  const mean = expectFunc(wasm.instance.exports.mean);
  const memory = expectMemory(wasm.instance.exports.memory);

  setMemoryFloat32(memory, [1, 2, 3, 4, 5, 6]);
  equal(mean(6), 3.5);

  setMemoryFloat32(memory, [5, 5, 5]);
  equal(mean(3), 5);

  setMemoryFloat32(memory, [5, 10, 15]);
  equal(mean(3), 10);

  setMemoryFloat32(memory, [0, 0, 0, 0]);
  equal(mean(4), 0);

  setMemoryFloat32(memory, [0, 0, 0, 10]);
  equal(mean(4), 2.5);

  equal(mean(0), 0); // zero is a bit of an edge case
});

challenge("powers", (wasm) => {
  const pow = expectFunc(wasm.instance.exports.pow);
  equal(pow(0, 0), 1);
  equal(pow(10, 0), 1);
  equal(pow(1, 1), 1);
  equal(pow(2, 1), 2);
  equal(pow(2, 2), 4);
  equal(pow(2, 3), 8);
  equal(pow(2, 4), 16);
  equal(pow(5, 5), 3125);
  equal(pow(10, 2), 100);
});

challenge("rgb", (wasm) => {
  const rgb = expectFunc(wasm.instance.exports.rgb);
  const hex = (n) => "0x" + n.toString(16);
  equal(hex(rgb(0x00, 0x00, 0x00)), hex(0x000000));
  equal(hex(rgb(0x11, 0x22, 0x33)), hex(0x112233));
  equal(hex(rgb(0xff, 0x00, 0x00)), hex(0xff0000));
  equal(hex(rgb(0x00, 0xff, 0x00)), hex(0x00ff00));
  equal(hex(rgb(0x00, 0x00, 0xff)), hex(0x0000ff));
});

challenge("swizzle", (wasm) => {
  const swizzle = expectFunc(wasm.instance.exports.swizzle);
  const hex = (n) => "0x" + n.toString(16);
  equal(hex(swizzle(0x000000)), hex(0x000000));
  equal(hex(swizzle(0x112233)), hex(0x332211));
  equal(hex(swizzle(0xff0000)), hex(0x0000ff));
  equal(hex(swizzle(0x00ff00)), hex(0x00ff00));
  equal(hex(swizzle(0x0000ff)), hex(0xff0000));
});

challenge("even_number", (wasm) => {
  const even = expectFunc(wasm.instance.exports.even);
  equal(even(0), 0);
  equal(even(1), 1);
  equal(even(2), 0);
  equal(even(2), 0);
  equal(even(9), 1);
  equal(even(-3), 1);
  equal(even(-2), 0);
});

challenge("inside_range", (wasm) => {
  const inside = expectFunc(wasm.instance.exports.inside);

  // TODO: Make sure range changes in tests so that wasm can't hardcode it.
  equal(inside(0, 10, 0), 1);
  equal(inside(0, 10, -1), 0);
  equal(inside(0, 10, 11), 0);
  equal(inside(0, 10, 5), 1);
  equal(inside(0, 10, 9), 1);
  equal(inside(0, 10, 10), 0);
  equal(inside(0, 0, 0), 0); // Can't be inside an empty range
});

challenge("inside_loose_range", (wasm) => {
  const inside = expectFunc(wasm.instance.exports.inside);

  // TODO: Make sure range changes in tests so that wasm can't hardcode it.
  equal(inside(0, 10, 0), 1);
  equal(inside(0, 10, -1), 0);
  equal(inside(0, 10, 11), 0);
  equal(inside(0, 10, 5), 1);
  equal(inside(0, 10, 9), 1);
  equal(inside(0, 10, 10), 0);

  // Invert the ranges to make sure tests still pass
  equal(inside(10, 0, 0), 1);
  equal(inside(10, 0, -1), 0);
  equal(inside(10, 0, 11), 0);
  equal(inside(10, 0, 5), 1);
  equal(inside(10, 0, 9), 1);
  equal(inside(10, 0, 10), 0);

  equal(inside(0, 0, 0), 0); // Can't be inside an empty range
});

challenge("lerp", (wasm) => {
  const lerp = expectFunc(wasm.instance.exports.lerp);
  equal(lerp(0, 0, 0), 0);
  equal(lerp(0, 10, 0), 0);
  equal(lerp(0, 10, 1), 10);
  equal(lerp(0, 10, 0.5), 5);
  equal(lerp(0, 100, 0.5), 50);
  equal(lerp(0, 100, 0.345), 34.5);
  equal(lerp(0, 100, 1.23), 123);
  equal(lerp(100, 0, 0.1), 90);
});

challenge("bitboard", (wasm) => {
  const lookup = expectFunc(wasm.instance.exports.lookup);

  // prettier-ignore
  const board = parseBitboard(
   // 0  1  2  3  4
      1, 0, 1, 1, 1, // 0
      0, 0, 0, 0, 0, // 1
      0, 0, 1, 0, 0, // 2
      0, 0, 0, 0, 0, // 3
      0, 0, 0, 0, 1, // 4
  );

  // Check out-of-bounds bits
  equal(lookup(board, -1, 0), -1);
  equal(lookup(board, 0, -1), -1);
  equal(lookup(board, 5, 0), -1);
  equal(lookup(board, 0, 5), -1);

  // Check up some in-bounds bits
  equal(lookup(board, 0, 0), 1);
  equal(lookup(board, 1, 0), 0);
  equal(lookup(board, 2, 0), 1);
  equal(lookup(board, 2, 2), 1);
  equal(lookup(board, 1, 2), 0);
  equal(lookup(board, 3, 2), 0);
  equal(lookup(board, 4, 4), 1);
});

todo("bitboard64", (wasm) => {
  const lookup = expectFunc(wasm.instance.exports.lookup);

  // Can't use parseBitboard here because we need a bigint to store 8x8 bits and
  // bigints don't work with bitwise operators or parsing from a binary string.
  // The only other option I can think of is just to hardcode the literal and
  // accept that it will be backwards.
  const board =
    0b1000010000_000000000_0010000100_00000000_1110111101_1000010000_000000000_0010000100_00000000_1110111101n;

  // Check out-of-bounds bits
  equal(lookup(board, -1n, 0n), -1n);
  equal(lookup(board, 0n, -1n), -1n);
  equal(lookup(board, 5n, 0n), -1n);
  equal(lookup(board, 0n, 5n), -1n);

  // Check up some in-bounds bits
  equal(lookup(board, 0n, 0n), 1n);
  equal(lookup(board, 1n, 0n), 0n);
  equal(lookup(board, 2n, 0n), 1n);
  equal(lookup(board, 2n, 2n), 1n);
  equal(lookup(board, 1n, 2n), 0n);
  equal(lookup(board, 3n, 2n), 0n);
  equal(lookup(board, 4n, 4n), 1n);
});

challenge("xorshift32", (wasm) => {
  const xorshift32 = expectFunc(wasm.instance.exports.xorshift32);
  const seed = expectFunc(wasm.instance.exports.seed);
  const fix3 = (val) => Math.floor(val * 1000) / 1000;

  seed(0xbad);
  equal(fix3(xorshift32()), 0.186);
  equal(fix3(xorshift32()), 0.911);
  equal(fix3(xorshift32()), 0.298);

  seed(0xdead);
  equal(fix3(xorshift32()), 0.38);
  equal(fix3(xorshift32()), 0.265);
  equal(fix3(xorshift32()), 0.573);
});

challenge("abs_i32", (wasm) => {
  const abs = expectFunc(wasm.instance.exports.abs);
  equal(abs(0), 0);
  equal(abs(10), 10);
  equal(abs(-5), 5);
  equal(abs(-100), 100);
});

challenge("vowels", (wasm) => {
  const isVowel = expectFunc(wasm.instance.exports.isVowel);
  const u8 = (char) => char.charCodeAt(0);

  equal(isVowel(u8("a")), 1);
  equal(isVowel(u8("e")), 1);
  equal(isVowel(u8("i")), 1);
  equal(isVowel(u8("o")), 1);
  equal(isVowel(u8("u")), 1);

  equal(isVowel(u8("A")), 1);
  equal(isVowel(u8("E")), 1);
  equal(isVowel(u8("I")), 1);
  equal(isVowel(u8("O")), 1);
  equal(isVowel(u8("U")), 1);

  equal(isVowel(u8(" ")), 0);
  equal(isVowel(u8("b")), 0);
  equal(isVowel(u8("C")), 0);
  equal(isVowel(u8("z")), 0);
  equal(isVowel(u8("-")), 0);
  equal(isVowel(u8("+")), 0);
});

challenge("chess_king_moves", (wasm) => {
  const king = expectFunc(wasm.instance.exports.king);

  // All valid moves from 0, 0
  equal(king(0, 0, 0, 1), 1); // north
  equal(king(0, 0, 1, 1), 1); // north east
  equal(king(0, 0, 1, 0), 1); // east
  equal(king(0, 0, 1, -1), 1); // south east
  equal(king(0, 0, 0, -1), 1); // south
  equal(king(0, 0, -1, -1), 1); // south west
  equal(king(0, 0, -1, 0), 1); // west
  equal(king(0, 0, -1, 1), 1); // north west

  // Not moving at all is not a legal move
  equal(king(0, 0, 0, 0), 0);

  // Moving by two tiles is not legal either
  equal(king(0, 0, 0, 2), 0); // north
  equal(king(0, 0, 2, 2), 0); // north east
  equal(king(0, 0, 2, 0), 0); // east
  equal(king(0, 0, 2, -2), 0); // south east
  equal(king(0, 0, 0, -2), 0); // south
  equal(king(0, 0, -2, -2), 0); // south west
  equal(king(0, 0, -2, 0), 0); // west
  equal(king(0, 0, -2, 2), 0); // north west

  // Random moves
  equal(king(0, 0, 1, 1), 1);
  equal(king(0, 0, 2, 0), 0);
  equal(king(0, 0, 0, 2), 0);
  equal(king(5, 2, 0, 2), 0);
  equal(king(5, 1, 5, 2), 1);
  equal(king(3, 3, 2, 3), 1);
  equal(king(3, 3, 3, 2), 1);
});

todo("chess_knight_moves", (wasm) => {
  const knight = expectFunc(wasm.instance.exports.knight);

  // All valid moves from 0, 0
  equal(knight(0, 0, 1, -2), 1);
  equal(knight(0, 0, 2, -1), 1);
  equal(knight(0, 0, 2, 1), 1);
  equal(knight(0, 0, 1, 2), 1);
  equal(knight(0, 0, -1, 2), 1);
  equal(knight(0, 0, -2, 1), 1);
  equal(knight(0, 0, -2, -1), 1);
  equal(knight(0, 0, -1, -2), 1);

  // Not moving at all is not a legal move
  equal(knight(0, 0, 0, 0), 0);

  // Moving by two tiles is not legal either
  equal(knight(0, 0, 0, 2), 0);
  equal(knight(0, 0, 2, 2), 0);
  equal(knight(0, 0, 2, 0), 0);
  equal(knight(0, 0, 2, -2), 0);
  equal(knight(0, 0, 0, -2), 0);
  equal(knight(0, 0, -2, -2), 0);
  equal(knight(0, 0, -2, 0), 0);
  equal(knight(0, 0, -2, 2), 0);

  // Moving by three tiles is not legal either
  equal(knight(0, 0, 0, 3), 0);
  equal(knight(0, 0, 3, 3), 0);
  equal(knight(0, 0, 3, 0), 0);
  equal(knight(0, 0, 3, -3), 0);
  equal(knight(0, 0, 0, -3), 0);
  equal(knight(0, 0, -3, -3), 0);
  equal(knight(0, 0, -3, 0), 0);
  equal(knight(0, 0, -3, 3), 0);
});
todo("chess_castle_moves", (wasm) => {});
todo("chess_pawn_moves", (wasm) => {});
todo("chess_bishop_moves", (wasm) => {});
todo("chess_queen_moves", (wasm) => {});

const SPADES = 0;
const CLUBS = 1;
const HEARTS = 2;
const DIAMONDS = 3;
const J = 11;
const Q = 12;
const K = 13;
const A = 1;

todo("poker_high_card", (wasm) => {
  const highCard = expectFunc(wasm.instance.exports.high_card);
  const memory = expectMemory(wasm.instance.exports.hand);

  // prettier-ignore
  setMemoryInt32(memory, [
    5, DIAMONDS,
    10, SPADES, // <---- High
    3, CLUBS,
    4, HEARTS,
  ]);
  equal(highCard(), 10);

  // prettier-ignore
  setMemoryInt32(memory, [
    10, SPADES,
    5, DIAMONDS,
    3, CLUBS,
    A, HEARTS, // <---- high
  ]);
  equal(highCard(), A);
});

todo("poker_pair", (wasm) => {});
todo("poker_three_of_a_kind", (wasm) => {});
todo("poker_flush", (wasm) => {});
todo("poker_straight", (wasm) => {});
todo("poker_full_house", (wasm) => {});

todo("char_search_ascii", (wasm) => {
  const search = expectFunc(wasm.instance.exports.search);
  const memory = expectMemory(wasm.instance.exports.memory);

  setMemoryStringAscii(memory, "Hello, world");
  equal(search("H"), 0);
  equal(search("e"), 1);
  equal(search("l"), 2);
  equal(search("Z"), -1);
  equal(search(","), 5);
});

challenge("bracket_matching", (wasm) => {
  const _matching = expectFunc(wasm.instance.exports.matching);
  const memory = expectMemory(wasm.instance.exports.memory);

  /** @param {string} string */
  const matching = (string) => {
    setMemoryStringAscii(memory, string);
    return _matching();
  };

  equal(matching(""), 1);
  equal(matching("[]"), 1);
  equal(matching("[abc]"), 1);
  equal(matching("a[b]c"), 1);
  equal(matching("a[]c"), 1);
  equal(matching("["), 0);
  equal(matching("]"), 0);
  equal(matching("a["), 0);
  equal(matching("a]"), 0);
  equal(matching("[c"), 0);
  equal(matching("]c"), 0);
  equal(matching("[c"), 0);
  equal(matching("]c["), 0);
  equal(matching("[[]"), 0);
  equal(matching("[]]"), 0);
  equal(matching("[[]]"), 1);
  equal(matching("[a[b]c]"), 1);
  equal(matching("[][][]"), 1);
  equal(matching("[][[]][]"), 1);
  equal(matching("[][][]["), 0);
});

todo("char_search"); // Search for the index of a character within a string
todo("string_search"); // Search for the index of a substring
todo("brainfuck"); // Brainfuck interpreter
todo("life32"); // Game of life using a 5x5 board encoded as an i32
todo("life"); // Game of life using a 100x100 board in memory
todo("bump_allocator"); // Implement a simple bump allocator
todo("hash_djb2"); // djb2 hash function
todo("run_length_encoding"); // Run-length encoding
todo("rot13_cipher"); // Rot13 cipher
todo("xor_cipher"); // XOR Cipher with a key
todo("substitution_cipher"); // Cipher with a custom alphabet
todo("checksum"); // Adler-32 checksum
todo("manhattan_distance"); // Find manhattan distance between points
todo("euclidean_distance"); // Find euclidean distance between points
todo("ipv4_validation"); // Validate an ipv4 address
todo("ipv6_validation"); // Validate an ipv6 address
todo("pangrams"); // Check whether a string contains every letter of the alphabet
todo("utf8_length"); // Find the length of a utf8 string
todo("simple_calculator"); // calc(op, lhs, rhs)
todo("median"); // Find the median from a list of i32s
todo("mode"); // Find the mode from a list of i32s
todo("battlebits"); // Battleships where each ship is a single bit
todo("turtle_movement"); // Interpreting turtle movement commands
todo("turtle_drawing"); // Interpreting turtle drawing commands
todo("multiple_turtles"); // Allowing multiple turtles in parallel
todo("guess_the_word"); // Simple hangman/wordle where 

