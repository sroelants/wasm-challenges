(module
  ;; Check if a pawn (♟/♙) would be allowed to move from (x0,y0) to (x1,y1)
  ;; on an infinite and empty chess board. Not moving is not legal.
  ;;
  ;; Unlike the other pieces, pawns can only move forwards and on our infinite
  ;; chess board, forward is in the _positive_ Y direction.
  ;;
  ;; If a pawn is on the starting row (y = 1) it can legally perform a double
  ;; move.
  ;;
  ;; Return 1 if the move would be legal, otherwise return 0.
  (func (export "pawn") (param $x0 i32) (param $y0 i32) (param $x1 i32) (param $y1 i32) (result i32)
    (local $dx i32)
    (local $dy i32)
    (local $startpos i32)

    (local.set $dx (i32.sub (local.get $x1) (local.get $x0)))
    (local.set $dy (i32.sub (local.get $y1) (local.get $y0)))
    (local.set $startpos (i32.eq (local.get $y0) (i32.const 1)))

    (i32.and 
      (i32.eqz (local.get $dx))
      (i32.or (i32.eq (local.get $dy) (i32.const 1))
              (i32.and (local.get $startpos) 
                       (i32.eq (local.get $dy) (i32.const 2)))))))
