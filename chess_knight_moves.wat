(module
  ;; Check whether it would be legal for a Knight (♞) to move from $x0, $y0 to
  ;; $x1, $y1 on an infinite and empty chess board.
  (func (export "knight") (param $x0 i32) (param $y0 i32) (param $x1 i32) (param $y1 i32) (result i32)
    (i32.sub (local.get $x1) (local.get $x0)) ;; dx
    call $abs

    (i32.sub (local.get $y1) (local.get $y0)) ;; dy
    call $abs

    i32.add ;; dx + dy

    ;; This doesn't work because of dx=3,dy=0 moves
    (i32.eq (i32.const 3)) ;; == 3
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
