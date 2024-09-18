(module
  (memory (export "memory") 1)

  ;; Return the "suit value" of the $nth card in memory. See "Poker Notes" in
  ;; the README for a description of how cards are represented in memory.
  ;;
  ;; Hint: WebAssembly doesn't have a u8.load instruction, but you can get a u8
  ;; from an i32.
  (func (export "suit") (param $n i32) (result i32)
    (i32.and
      (i32.shr_u
        (i32.load (i32.mul (local.get $n) (i32.const 2)))
        (i32.const 8)
      )
      (i32.const 0xff)
    )
  )
)
