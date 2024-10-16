(module
  (memory (export "memory") 1)

  ;; Find the sum of the first $n u8 numbers in memory.
  ;; If $n <= 0, return 0.
  (func (export "sum") (param $n i32) (result i32)
    (local $result i32)
    (local $i i32)
    (local.set $result (i32.const 0))
    (local.set $i (i32.const 0))

    ;; return early for invalid values
    (if (i32.le_s (local.get $n) (i32.const 0))
      (then (return (i32.const 0))))

    (loop $loop
      ;; update the result
      (local.set $result 
                (i32.add 
                  (local.get $result) 
                  (i32.load8_u (local.get $i))))

      ;; increment the counter
      (local.set $i (i32.add (local.get $i) (i32.const 1)))

      ;; goto start of the loop if we're not done yet
      (br_if $loop (i32.lt_u (local.get $i) (local.get $n))))

    ;; return the result
    (local.get $result)))
