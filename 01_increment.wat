(module
  ;; Increment the parameter value by 1 and return it.
  (func (export "increment") (param i32) (result i32)
    local.get 0
    i32.const 1
    i32.add
  )
)

