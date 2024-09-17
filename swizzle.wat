(module
  ;; Take an i32 which encodes an RGB value as 0xRRGGBB and swizzle the
  ;; components to return the same value but encoded as 0xBBGGRR.
  (func (export "swizzle") (param $rgb i32) (result i32)
    ;; Shift the R component right
    local.get $rgb
    i32.const 0xFF0000
    i32.and
    i32.const 0x10
    i32.shr_u

    ;; Isolate the G component
    local.get $rgb
    i32.const 0x00FF00
    i32.and

    ;; Shift the B component left
    local.get $rgb
    i32.const 0x0000FF
    i32.and
    i32.const 0x10
    i32.shl

    ;; OR the components back together
    i32.or
    i32.or
  )
)
