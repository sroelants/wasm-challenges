(module
  (memory (export "memory") 1)

  ;; Return the "suit value" of the $nth card in memory. See "Poker Notes" in
  ;; the README for a description of how cards are represented in memory.
  ;;
  ;; Hint: WebAssembly doesn't have a `u8.load` instruction but it does have
  ;; `i32.load8_u`.
  (func (export "suit") (param $n i32) (result i32)
        (i32.load8_u 
          (i32.add (i32.const 1)
                   (i32.mul (i32.const 2) 
                            (local.get $n))))))
