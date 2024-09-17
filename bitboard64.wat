(module
  ;; Just like the bitboard challenge, except this time the board is an 8x8
  ;; encoded into an i64.
  (func (export "lookup") (param $board i64) (param $x i64) (param $y i64) (result i64)
    ;; If $x and $y are not inside the bounds then return early with -1.
    (call $inside (local.get $x) (local.get $y))
    i32.eqz
    if
      i64.const -1
      return
    end

    ;; Put the board on the stack ready to be shifted.
    local.get $board

    ;; Turn $x and $y into the index of the bit to look up.
    (i64.mul (local.get $y) (i64.const 5))
    (i64.add (local.get $x))

    ;; Right shift the board by the index so that the bit we want is first.
    i64.shr_u

    ;; AND to remove all other bits.
    (i64.and (i64.const 1))
  )

  ;; Checks whether $x and $y are inside the bounds of the bit board.
  (func $inside (param $x i64) (param $y i64) (result i32)
    (i64.ge_s (local.get $x) (i64.const 0))
    (i64.lt_s (local.get $x) (i64.const 5))
    i32.and

    (i64.ge_s (local.get $y) (i64.const 0))
    (i64.lt_s (local.get $y) (i64.const 5))
    i32.and

    i32.and
  )
)
