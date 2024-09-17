(module
  ;; Return the absolute value of the parameter (preferably without converting
  ;; it and using f32.abs).
  (func (export "abs") (param i32) (result i32)
    local.get 0
    i32.const 0
    i32.lt_s

    if (result i32)
      i32.const 0
      local.get 0
      i32.sub
    else
      local.get 0
    end
  )
)
