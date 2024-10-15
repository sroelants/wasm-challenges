(module
  ;; Check if a knight (♘/♞) would be allowed to move from (x0,y0) to (x1,y1)
  ;; on an infinite and empty chess board. Not moving is not legal.
  ;;
  ;; Return 1 if the move would be legal, otherwise return 0.
  (func (export "knight") (param $x0 i32) (param $y0 i32) (param $x1 i32) (param $y1 i32) (result i32)
    (local $dx i32)
    (local $dy i32)

    (local.set $dx (i32.sub (local.get $x1) (local.get $x0)))
    (local.set $dy (i32.sub (local.get $y1) (local.get $y0)))

    (if (i32.and 
          (i32.eq (local.get $dx) (i32.const 1))
          (i32.eq (local.get $dy) (i32.const 2)))
      (then (return (i32.const 1))))

    (if (i32.and 
          (i32.eq (local.get $dx) (i32.const -1))
          (i32.eq (local.get $dy) (i32.const 2)))
      (then (return (i32.const 1))))

    (if (i32.and 
          (i32.eq (local.get $dx) (i32.const 1))
          (i32.eq (local.get $dy) (i32.const -2)))
      (then (return (i32.const 1))))

    (if (i32.and 
          (i32.eq (local.get $dx) (i32.const -1))
          (i32.eq (local.get $dy) (i32.const -2)))
      (then (return (i32.const 1))))

    (if (i32.and 
          (i32.eq (local.get $dx) (i32.const 2))
          (i32.eq (local.get $dy) (i32.const 1)))
      (then (return (i32.const 1))))

    (if (i32.and 
          (i32.eq (local.get $dx) (i32.const -2))
          (i32.eq (local.get $dy) (i32.const 1)))
      (then (return (i32.const 1))))

    (if (i32.and 
          (i32.eq (local.get $dx) (i32.const 2))
          (i32.eq (local.get $dy) (i32.const -1)))
      (then (return (i32.const 1))))

    (if (i32.and 
          (i32.eq (local.get $dx) (i32.const -2))
          (i32.eq (local.get $dy) (i32.const -1)))
      (then (return (i32.const 1))))

    (i32.const 0)))
