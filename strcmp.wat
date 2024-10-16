(module
  (import "debug" "i32" (func $debug_i32 (param i32)))
  (memory (export "memory") 1)

  ;; Check whether two strings are equal, where each parameter is the pointer
  ;; to the first character of a null-terminated ASCII string.
  ;; Return 1 if the strings are equal and 0 if not.
  (func (export "strcmp") (param $str1 i32) (param $str2 i32) (result i32)
    (local $i i32)
    (local $j i32)
    (local.set $i (local.get $str1))
    (local.set $j (local.get $str2))

    (loop $loop
      ;; return -1 if the characters are not equal
      (if (i32.ne (i32.load8_u (local.get $i)) (i32.load8_u (local.get $j)))
        (then (return (i32.const 0))))

      ;; break if we've hit a null terminator
      (if (i32.eqz (i32.load8_u (local.get $i)))
        (then (return (i32.const 1))))

      ;; Increment the indices
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (local.set $j (i32.add (local.get $j) (i32.const 1)))

      (br $loop))
    (unreachable)))
