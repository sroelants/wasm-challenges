#!/usr/bin/env node

// @ts-check

import { readFileSync } from "node:fs";
import { equal, ok } from "node:assert";
import { test } from "node:test";
import { execSync } from "node:child_process";

challenge("01_increment", (wasm) => {
  const increment = expectFunc(wasm.instance.exports.increment);
  equal(increment(0), 1);
  equal(increment(2), 3);
  equal(increment(10), 11);
  equal(increment(-4), -3);
});

challenge("02_double", (wasm) => {
  const double = expectFunc(wasm.instance.exports.double);
  equal(double(0), 0);
  equal(double(2), 4);
  equal(double(10), 20);
  equal(double(-4), -8);
});

challenge("03_read_from_memory", (wasm) => {
  const load = expectFunc(wasm.instance.exports.load);
  const memory = expectMemory(wasm.instance.exports.memory);
  setMemoryInt32(memory, [11, 22, 33]);
  equal(load(0), 11);
  equal(load(1), 22);
  equal(load(2), 33);
});

challenge("04_write_to_memory", (wasm) => {
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

challenge("05_triangle_numbers", (wasm) => {
  const triangular = expectFunc(wasm.instance.exports.triangular);
  equal(triangular(0), 0);
  equal(triangular(1), 1);
  equal(triangular(2), 3);
  equal(triangular(3), 6);
  equal(triangular(10), 55);
  equal(triangular(20), 210);
});

challenge("06_sum_array", (wasm) => {
  const sum = expectFunc(wasm.instance.exports.sum);
  const memory = expectMemory(wasm.instance.exports.memory);
  setMemoryInt32(memory, [1, 2, 3, 4, 5, 6]);
  equal(sum(1), 1);
  equal(sum(2), 3);
  equal(sum(3), 6);
  equal(sum(4), 10);
  equal(sum(0), 0); // zero is a bit of an edge case
});

// Testing functions

/**
 * @param {string} name
 * @param {(source: WebAssembly.WebAssemblyInstantiatedSource) => void} callback
 */
async function challenge(name, callback) {
  return test(name, async () => {
    execSync(`wat2wasm ${name}.wat`);
    const buffer = readFileSync(`${name}.wasm`);
    const imports = { console: { log: console.log } };
    const wasm = await WebAssembly.instantiate(buffer, imports);
    callback(wasm);
  });
}

/**
 * Check that the value of the web assembly export is a function and return it.
 * @param {WebAssembly.ExportValue} exportValue
 * @returns {Function}
 */
function expectFunc(exportValue) {
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
function expectMemory(exportValue) {
  ok(
    exportValue instanceof WebAssembly.Memory,
    "Expected export to be WebAssembly memory!",
  );
  return exportValue;
}

/**
 * @param {WebAssembly.Memory} memory
 * @param {ArrayLike<number>} values
 */
function setMemoryInt32(memory, values) {
  if (memory.buffer.byteLength === 0) {
    memory.grow(1);
  }

  const view = new DataView(memory.buffer);

  for (let i = 0; i < values.length; i++) {
    view.setInt32(i * 4, values[i], true);
  }
}
