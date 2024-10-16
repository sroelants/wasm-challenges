(module
  (memory (export "memory") 1)

  ;; Reverse a string in place in memory.
  (func (export "reverse")
    (local $tmp i32)
    (local $i i32)
    (local $j i32)
    (local $last i32)
    (local $mid i32)
    (local.set $i (i32.const 0))
    (local.set $last (i32.sub (call $strlen) (i32.const 1)))

    (if (i32.eq (local.get $last) (i32.const -1))
      (then (return)))

    (local.set $mid (i32.div_u (local.get $last) (i32.const 2)))

    (loop $loop
      ;; swap the values at $i and $len - i
      (local.set $tmp (i32.load8_u (local.get $i)))
      (local.set $j (i32.sub (local.get $last) (local.get $i))) 

      ;;                to            from           bytes
      (; (memory.copy (local.get $i) (local.get $j) (i32.const 1)) ;)

      (i32.store8 (local.get $i) (i32.load8_u (local.get $j)))
      (i32.store8 (local.get $j) (local.get $tmp))

      ;; increment the index
      (local.set $i (i32.add (local.get $i) (i32.const 1)))

      ;; Repeat until we hit the middle of the string
      (br_if $loop (i32.le_u (local.get $i) (local.get $mid)))))

  (func $strlen (result i32)
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
    (unreachable)))
