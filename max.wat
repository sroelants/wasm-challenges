(module
  ;; Returns the max of two i32 values.
  (func (export "max") (param $a i32) (param $b i32) (result i32)
    ;; Push these in advance
    local.get $a
    local.get $b

    ;; Check which is greater
    local.get $a
    local.get $b
    i32.gt_s

    ;; return the greater of the two
    select))
