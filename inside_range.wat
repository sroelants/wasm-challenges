(module
  ;; Test whether $val is inside the range described by $min <= $val < $max.
  (func (export "inside") (param $min i32) (param $max i32) (param $val i32) (result i32)
    (i32.ge_s (local.get $val) (local.get $min)) ;; $val >= $min
    (i32.lt_s (local.get $val) (local.get $max)) ;; $val <  $max
    i32.and
  )
)
