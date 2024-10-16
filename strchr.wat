(module
  (memory (export "memory") 1)

  ;; Search for the first instance of $c within the null-terminated ASCII
  ;; string in memory and return the index of the match. If the character
  ;; was not present in the string, return -1.
  (func (export "strchr") (param $c i32) (result i32)
    (local $i i32)

    (local.set $i (i32.const 0))

    (loop $loop
      ;; if we hit a null terminator, return -1
      (if (i32.eq (i32.load8_u (local.get $i)) (i32.const 0))
        (then (return (i32.const -1))))

      ;; if it matches $c, return the index
      (if (i32.eq (i32.load8_u (local.get $i)) (local.get $c))
        (then (return (local.get $i))))

      ;; increment the index
      (local.set $i (i32.add (local.get $i) (i32.const 1)))

      ;; goto start of the loop
      (br $loop))

    (unreachable)))
