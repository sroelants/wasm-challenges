(module
  ;; Use the $x and $y coordinates to read a single bit from $board, where
  ;; $board is an 5x5 grid of cells, encoded into an i32 in row-major order
  ;; (meaning that only the first 25 bits are in use).
  ;;
  ;; If the requested coordinate is outside of the bitboard, then return -1.
  ;;
  ;; For example, to read $x = 1, $y = 2, you would look up the bit marked with
  ;; an * in the diagram below. The # bits are unused.
  ;;
  ;; 00000
  ;; 00000
  ;; 0*000
  ;; 00000
  ;; 00000
  ;; #####
  ;; ##
  ;;
  (func (export "lookup") (param $board i32) (param $x i32) (param $y i32) (result i32)
        (local $idx i32)

        ;; Return if $x is out of bounds
        (if (i32.or 
              (i32.ge_s (local.get $x) (i32.const 5))
              (i32.lt_s (local.get $x) (i32.const 0)))
          (then (return (i32.const -1))))

        ;; Return if $y is out of bounds
        (if (i32.or 
              (i32.ge_s (local.get $y) (i32.const 5))
              (i32.lt_s (local.get $y) (i32.const 0)))
          (then (return (i32.const -1))))

        ;; Convert into a bit index
        (local.set $idx (i32.add 
                          (i32.mul (local.get $y) (i32.const 5)) 
                          (local.get $x)))

        (i32.and (i32.shr_u (local.get $board) (local.get $idx)) (i32.const 1))))
