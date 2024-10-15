(module
  ;; Check if a rook (♖/♜) would be allowed to move from (x0, y0) to (x1, y1)
  ;; on an infinite and empty chess board. Not moving is not a legal move.
  ;;
  ;; Return 1 if the move would be legal, otherwise return 0.
  (func (export "rook") (param $x0 i32) (param $y0 i32) (param $x1 i32) (param $y1 i32) (result i32)
    ;; Not moving is illegal
    (if (i32.and 
          (i32.eq (local.get $x0) (local.get $x1)) 
          (i32.eq (local.get $y0) (local.get $y1)))
      (then (return (i32.const 0))))


    (i32.or 
      (i32.eq (local.get $x0) (local.get $x1))
      (i32.eq (local.get $y0) (local.get $y1)))))
