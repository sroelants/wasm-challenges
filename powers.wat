(module
  ;; Raise the value to the given exponent
  (func (export "pow") (param $value i32) (param $exponent i32) (result i32)
    (local $i i32)
    (local $acc i32)

    i32.const 1
    local.set $acc

    ;; Anything raised to the power 0 is 1
    (i32.eqz (local.get $exponent))
    if
      i32.const 1
      return
    end

    (loop $loop
      ;; Multiply $acc by $value
      (i32.mul (local.get $acc) (local.get $value))
      local.set $acc

      ;; Increment $i and loop if $i < $exponent
      (i32.add (local.get $i) (i32.const 1))
      (i32.lt_s (local.tee $i) (local.get $exponent))
      br_if $loop
    )

    local.get $acc
  )
)
