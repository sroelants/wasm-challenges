(module
  ;; Swizzle the components of an RGB color encoded as 0xRRGGBB into 0xBBGGRR
  ;; and return the swizzled value.
  (func (export "rgb2bgr") (param $rgb i32) (result i32)
    (local $r i32)
    (local $g i32)
    (local $b i32)

    ;; Isolate out the r,g, and b components
    (local.set $r (i32.shr_u
                    (i32.and (local.get $rgb) (i32.const 0xFF0000))
                    (i32.const 16)))

    (local.set $g (i32.shr_u 
                    (i32.and (local.get $rgb) (i32.const 0xFF00))
                    (i32.const 8)))

    (local.set $b (i32.and (local.get $rgb) (i32.const 0xFF)))

    ;; Reassemble them, in reverse order
    (i32.or 
      (i32.shl (local.get $b) (i32.const 16))
      (i32.or 
        (i32.shl (local.get $g) (i32.const 8))
        (local.get $r)))))
