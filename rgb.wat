(module
  ;; Take R, G, and B as byte values and return them as a single i32
  ;; where the format is 0xRRGGBB.
  (func (export "rgb") (param $r i32) (param $g i32) (param $b i32) (result i32)
    local.get $r
    i32.const 16
    i32.shl

    local.get $g
    i32.const 8
    i32.shl

    local.get $b
    i32.or
    i32.or
  )
)
