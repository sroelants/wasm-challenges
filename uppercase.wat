(module
  (memory (export "memory") 1)

  ;; Convert the ASCII string in memory to its uppercase equivalent.
  (func (export "uppercase")
    (local $i i32)
    (local $current i32)
    (local.set $i (i32.const 0))
    (local.set $current (i32.const 0))

    (loop $loop
      (local.set $current (i32.load8_u (local.get $i)))

      (if (call $is-lowercase (local.get $current))
        (then (i32.store8 (local.get $i) 
                          (i32.sub (local.get $current) 
                                   (i32.const 32)))))

      ;; increment the index
      (local.set $i (i32.add (local.get $i) (i32.const 1)))

      ;; goto start of the loop if there's characters left
      (br_if $loop (i32.ne (i32.const 0) (i32.load8_u (local.get $i))))))

  (func $is-lowercase (param i32) (result i32)
    (i32.and (i32.ge_u (local.get 0) (i32.const 97))
             (i32.le_u (local.get 0) (i32.const 122)))))
