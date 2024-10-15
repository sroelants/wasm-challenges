(module
  ;; Increment the parameter by 1 and return the value.
  (func (export "increment") (param $x i32) (result i32)
      local.get $x
      i32.const 1
      i32.add
  )
)
