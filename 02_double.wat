(module
  ;; Double the parameter value and return it.
  (func (export "double") (param i32) (result i32)
    local.get 0
    i32.const 2
    i32.mul
  )
)

