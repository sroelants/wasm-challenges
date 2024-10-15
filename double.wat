(module
  ;; Double the parameter and return the value.
  (func (export "double") (param $x i32) (result i32)
      local.get $x
      i32.const 2
      i32.mul
  )
)
