(module
  ;; Return the nth triangular number
  ;; https://en.wikipedia.org/wiki/Triangular_number
  (func (export "triangular") (param $n i32) (result i32)
    (local $counter i32)
    (local $value i32)

    (loop $l
      local.get $counter
      local.get $value
      i32.add
      local.set $value

      local.get $counter
      i32.const 1
      i32.add
      local.tee $counter

      local.get $n
      i32.le_s
      br_if $l
    )

    local.get $value
  )
)


