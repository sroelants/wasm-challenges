(module
  ;; Check whether it would be legal for a King (♚) to move from $x0, $y0 to
  ;; $x1, $y1 on an infinite and empty chess board.
  (func (export "king") (param $x0 i32) (param $y0 i32) (param $x1 i32) (param $y1 i32) (result i32)
    (local $dx i32)
    (local $dy i32)

    (i32.sub (local.get $x1) (local.get $x0))
    call $abs
    local.set $dx

    (i32.sub (local.get $y1) (local.get $y0)) ;; dy
    call $abs
    local.set $dy

    ;; Check if it was a diagonal move
    (i32.and
      (i32.eq (local.get $dx) (i32.const 1))
      (i32.eq (local.get $dy) (i32.const 1)))

    ;; Check if it was a vertical move
    (i32.and
      (i32.eq (local.get $dx) (i32.const 0))
      (i32.eq (local.get $dy) (i32.const 1)))

    i32.or

    ;; Check if it was a horizontal move
    (i32.and
      (i32.eq (local.get $dx) (i32.const 1))
      (i32.eq (local.get $dy) (i32.const 0)))

    i32.or
  )

  ;; Return the absolute value of the parameter.
  (func $abs (param i32) (result i32)
    local.get 0
    i32.const 0
    i32.lt_s

    if (result i32)
      i32.const 0
      local.get 0
      i32.sub
    else
      local.get 0
    end
  )
)
