(module
  (memory (export "memory") 1)

  ;; Find the sum of the first $n u8 numbers in memory.
  ;; If $n <= 0, return 0.
  (func (export "sum") (param $n i32) (result i32)
    (local $i i32)
    (local $total i32)

    (if
      (i32.le_s (local.get $n) (i32.const 0)) ;; $n <= 0
      (then (return (i32.const 0)))
    )

    (loop $loop
      (local.set $total
        (i32.add
          (local.get $total)
          (call $u8_load (local.get $i))
        )
      )

      (local.set $i (i32.add (local.get $i) (i32.const 1))) ;; $i += 1
      (br_if $loop (i32.lt_s (local.get $i) (local.get $n))) ;; $i < $n
    )

    local.get $total
  )

  ;; There is no u8.load in WebAssembly so we'll instead load an i32 and mask
  ;; it to discard the bits we don't care about.
  (func $u8_load (param i32) (result i32)
    (i32.and
      (i32.load (local.get 0))
      (i32.const 0xff)
    )
  )
)
