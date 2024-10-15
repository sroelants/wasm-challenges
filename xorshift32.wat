(module
  (global $state (mut i32) (i32.const 0x123456))

  ;; Reset the seed value for the PRNG below.
  (func (export "seed") (param $seed i32)
    local.get $seed
    global.set $state
  )

  ;; Returns pseudo-random numbers from an implementation of xorshift32.
  ;; See https://en.wikipedia.org/wiki/Xorshift.
  (func (export "xorshift32") (result i32)
        (local $x i32)
        (local.set $x (global.get $state))

        (local.set $x (i32.xor (local.get $x) (i32.shl   (local.get $x) (i32.const 13))))
        (local.set $x (i32.xor (local.get $x) (i32.shr_u (local.get $x) (i32.const 17))))
        (local.set $x (i32.xor (local.get $x) (i32.shl   (local.get $x) (i32.const  5))))

        (global.set $state (local.get $x))
        (local.get $x)))
