(module
  (memory (export "memory") 1)

  ;; Sum together the first $length i32 values in memory.
  (func (export "sum") (param $length i32) (result i32)
    (local $counter i32)
    (local $total i32)

    ;; return early if $length is zero
    local.get $length
    i32.eqz
    (if (then
      i32.const 0
      return))

    (loop $loop
      ;; load the nth value from memory
      local.get $counter
      i32.const 4 ;; 4 bytes per i32
      i32.mul
      i32.load

      ;; add the value to the total
      local.get $total
      i32.add
      local.set $total

      ;; increment the counter
      local.get $counter
      i32.const 1
      i32.add
      local.tee $counter

      ;; continue the loop if $counter < $length
      local.get $length
      i32.lt_s
      br_if $loop
    )

    local.get $total
  )
)
