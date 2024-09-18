(module
  (memory (export "memory") 1)

  ;; Search for the first instance of the null-terminated ASCII string at $str2
  ;; within the null-terminated ASCII string at $str1.
  (func (export "strstr") (param $str1 i32) (param $str2 i32) (result i32)
    (local $i i32)
    (local $j i32)

    (loop $outer
      (local.set $j 0)
      (loop $inner
        (if
          (i32.eq
            (call $get_char (i32.add (local.get $str1) (local.get $j)))
            (call $get_char (i32.add (local.get $str2) (local.get $j)))
          )
        )
      )
    )
  )

  (func $get_char (param $ptr i32) (result i32)
    (i32.and
      (i32.load (local.get $ptr))
      (i32.const 0xff)
    )
  )
)

