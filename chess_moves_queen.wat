(module
  ;; Check if a queen (♕/♛) would be allowed to move from (x0, y0) to (x1, y1)
  ;; on an infinite and empty chess board. Not moving is not a legal move.
  ;;
  ;; Return 1 if the move would be legal, otherwise return 0.
  (func (export "queen") (param $x0 i32) (param $y0 i32) (param $x1 i32) (param $y1 i32) (result i32)
    (local $dx i32)
    (local $dy i32)

    ;; Not moving is illegal
    (if (i32.and 
          (i32.eq (local.get $x0) (local.get $x1)) 
          (i32.eq (local.get $y0) (local.get $y1)))
      (then (return (i32.const 0))))

    (local.set $dx (i32.sub (local.get $x1) (local.get $x0)))
    (local.set $dy (i32.sub (local.get $y1) (local.get $y0)))

    ;; Bishop move
    (if (i32.or
          (i32.eq (local.get $dx) (local.get $dy))
          (i32.eq (local.get $dx) (i32.mul (i32.const -1) (local.get $dy))))
      (then (return (i32.const 1))))

    ;; Rook move
    (if (i32.or 
          (i32.eq (local.get $x0) (local.get $x1))
          (i32.eq (local.get $y0) (local.get $y1)))
        (then (return (i32.const 1))))
    
    (i32.const 0)))
