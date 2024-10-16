(module
  (memory (export "memory") 1)

  ;; Return the length of the null-terminated ASCII string in memory.
  (func (export "strlen") (result i32)
    (local $result i32)
    (local $i i32)

    (local.set $result (i32.const 0))
    (local.set $i (i32.const 0))

    (loop $loop
      ;; if we hit a null terminator, return the result
      (if (i32.eq (i32.load8_u (local.get $i)) (i32.const 0))
        (then (return (local.get $result))))

      ;; increment the length
      (local.set $result 
                (i32.add (local.get $result) (i32.const 1)))

      ;; increment the counter
      (local.set $i (i32.add (local.get $i) (i32.const 1)))

      ;; goto start of the loop if we're not done yet
      (br $loop))

    ;; return the result
    (local.get $result)))
