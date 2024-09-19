(module
  (memory (export "memory") 1)

  ;; Return the length of the null-terminated ASCII string in memory.
  (func (export "strlen") (result i32)
    (local $i i32)

    (loop $loop
      (if (i32.eqz (call $get_char (local.get $i)))
        (then (return (local.get $i)))
      )

      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br $loop)
    )

    unreachable
  )

  (func $get_char (param $i i32) (result i32)
    (i32.and
      (i32.load (local.get $i))
      (i32.const 0xff)
    )
  )
)
