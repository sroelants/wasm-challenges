(module
  ;; Clamp the value to the range $min..$max and return the clamped value.
  (func (export "clamp") (param $min i32) (param $max i32) (param $val i32) (result i32)
        (if (result i32) (i32.le_s (local.get $min) (local.get $val))
          (then
            (if (result i32) (i32.le_s (local.get $val) (local.get $max))
              (then local.get $val)
              (else local.get $max)))
          (else
            local.get $min))))
