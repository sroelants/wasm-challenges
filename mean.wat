(module
  (memory (export "memory") 1)

  ;; Find the mean value of the first $length f32 values in memory.
  (func (export "mean") (param $length i32) (result f32)
    (local $i i32)
    (local $total f32)

    ;; Return immediately if $i is 0
    (i32.eqz (local.get $length))
    if
      f32.const 0
      return
    end

    (loop $loop
      ;; The next f32 will be at the address $i * 4
      (i32.mul (local.get $i) (i32.const 4))
      ;; Add to the total value
      (f32.add (f32.load) (local.get $total))
      local.set $total

      ;; Increment $i
      (i32.add (local.get $i) (i32.const 1))
      ;; Continue if i <= $length
      (i32.lt_s (local.tee $i) (local.get $length))
      br_if $loop
    )

    local.get $total
    local.get $length
    f32.convert_i32_s
    f32.div
  )
)
