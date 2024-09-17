(module
  ;; Just like inside_range.wat but now the limits of the range can be passed
  ;; in any order. For example, both of the following calls should return 1.
  ;;
  ;; inside(0, 10, 5)
  ;; inside(10, 0, 5)
  (func (export "inside") (param $l0 i32) (param $l1 i32) (param $val i32) (result i32)
    (local $min i32)
    (local $max i32)

    local.get $l0
    local.get $l1
    (i32.lt_s (local.get $l0) (local.get $l1))
    select
    local.set $min

    local.get $l0
    local.get $l1
    (i32.gt_s (local.get $l0) (local.get $l1))
    select
    local.set $max

    (i32.ge_s (local.get $val) (local.get $min)) ;; $val >= $min
    (i32.lt_s (local.get $val) (local.get $max)) ;; $val < $max
    i32.and
  )
)
