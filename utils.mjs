// @ts-check

import { readFileSync } from "node:fs";
import { ok } from "node:assert";
import { execSync } from "node:child_process";
import test from "node:test";

/**
 * Defines a challenge.
 * @param {string} name
 * @param {(source: WebAssembly.WebAssemblyInstantiatedSource) => void} callback
 */
export async function challenge(name, callback) {
  return test(name, async () => {
    // Compile to /tmp to keep the directory a bit cleaner
    execSync(`wat2wasm ${name}.wat -o /tmp/${name}.wasm`);
    const buffer = readFileSync(`/tmp/${name}.wasm`);
    const imports = { console: { log: console.log } };
    const wasm = await WebAssembly.instantiate(buffer, imports);
    callback(wasm);
  });
}

/**
 * A challenge that hasn't been written or solved yet.
 * @param {string} name
 * @param {(source: WebAssembly.WebAssemblyInstantiatedSource) => void} [callback]
 */
export function todo(name, callback) {
  // Do nothing!
  test.todo(name);
}

/**
 * Check that the value of the web assembly export is a function and return it.
 * @param {WebAssembly.ExportValue} exportValue
 * @returns {Function}
 */
export function expectFunc(exportValue) {
  ok(
    typeof exportValue === "function",
    "Expected export to be a WebAssembly function!",
  );
  return exportValue;
}

/**
 * @param {WebAssembly.ExportValue} exportValue
 * @returns {WebAssembly.Memory}
 */
export function expectMemory(exportValue) {
  ok(
    exportValue instanceof WebAssembly.Memory,
    "Expected export to be WebAssembly memory!",
  );
  return exportValue;
}

/**
 * Reset memory to zeros.
 * @param {WebAssembly.Memory} memory
 */
export function resetMemory(memory) {
  new Uint8Array(memory.buffer).fill(0);
}

/**
 * @param {WebAssembly.Memory} memory
 * @param {ArrayLike<number>} values
 */
export function setMemoryInt32(memory, values) {
  const view = new DataView(memory.buffer);

  for (let i = 0; i < values.length; i++) {
    view.setInt32(i * 4, values[i], true);
  }
}

/**
 * @param {WebAssembly.Memory} memory
 * @param {ArrayLike<number>} values
 */
export function setMemoryFloat32(memory, values) {
  const view = new DataView(memory.buffer);

  for (let i = 0; i < values.length; i++) {
    view.setFloat32(i * 4, values[i], true);
  }
}

/**
 * @param {WebAssembly.Memory} memory
 * @param {string} string
 * @param {number} [offset]
 */
export function setMemoryStringAscii(memory, string, offset) {
  if (offset === undefined) {
    resetMemory(memory);
    offset = 0;
  }

  const view = new DataView(memory.buffer);

  for (let i = 0; i < string.length; i++) {
    let code = string.charCodeAt(i);
    ok(code <= 0x0080, `Cannot encode non-ASCII character: ${string[i]}`);
    view.setUint8(offset + i, string.charCodeAt(i));
  }
}

/**
 * Parses a bitboard as though the top left bit is the first one. If we wrote
 * the bitboard out as a binary literal, the first bit in the literal will
 * actually be the last bit in memory, which makes it tricky to visually
 * compare for tests.
 * @param {(0 | 1)[]} bits
 */
export function parseBitboard(...bits) {
  let board = 0;
  for (let i = 0; i < bits.length; i++) {
    board |= bits[i] << i;
  }
  return board;
}
