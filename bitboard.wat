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
  (func (export "lookup") (param $board i32) (param $x i32) (param $y i32) (result i32)
    ;; If $x and $y are not inside the bounds then return early with -1.
    (call $inside (local.get $x) (local.get $y))
    i32.eqz
    if
      i32.const -1
      return
    end

    ;; Put the board on the stack ready to be shifted.
    local.get $board

    ;; Turn $x and $y into the index of the bit to look up.
    (i32.mul (local.get $y) (i32.const 5))
    (i32.add (local.get $x))

    ;; Right shift the board by the index so that the bit we want is first.
    i32.shr_u

    ;; Bitwise AND to remove all other bits.
    (i32.and (i32.const 1))
  )

  ;; Checks whether $x and $y are inside the bounds of the bit board.
  (func $inside (param $x i32) (param $y i32) (result i32)
    (i32.ge_s (local.get $x) (i32.const 0))
    (i32.lt_s (local.get $x) (i32.const 5))
    i32.and

    (i32.ge_s (local.get $y) (i32.const 0))
    (i32.lt_s (local.get $y) (i32.const 5))
    i32.and

    i32.and
  )
)
