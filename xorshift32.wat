(module
  (global $state (mut i32) (i32.const 0x123456))

  ;; Reset the seed value for the PRNG below.
  (func (export "seed") (param $seed i32)
    local.get $seed
    global.set $state
  )

  ;; Returns pseudo-random numbers between 0 and 1 with an implementation of
  ;; xorshift32: https://en.wikipedia.org/wiki/Xorshift
  (func (export "xorshift32") (result f32)
    global.get $state
    i32.const 13
    i32.shl
    global.get $state
    i32.xor
    global.set $state

    global.get $state
    i32.const 17 i32.shr_s
    global.get $state
    i32.xor
    global.set $state

    global.get $state
    i32.const 5
    i32.shl
    global.get $state
    i32.xor
    global.set $state

    global.get $state
    f32.convert_i32_u
    f32.const 4294967296
    f32.div
  )
)
