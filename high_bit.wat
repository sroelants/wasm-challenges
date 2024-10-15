(module
  ;; Return the value of the single highest 1 bit in a _u32_ value.
  (func (export "high") (param $val i32) (result i32)
    (local $msb i32)
    (local.set $msb (i32.sub (i32.const 31) (i32.clz (local.get $val))))

    ;; If the msb is < 0, then the original value must've been 0
    (if (i32.lt_s (local.get $msb) (i32.const 0))
      (then (return (i32.const 0))))

    (i32.shl (i32.const 1) (local.get $msb))))
