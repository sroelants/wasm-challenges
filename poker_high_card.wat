(module
  (memory (export "hand") 1)

  ;; Returns the face value of the highest card. See "Poker Notes" in the
  ;; README.md for more information about the card representations. Remember
  ;; that aces are high!
  (func (export "high_card") (result i32)
    (local $high i32)
    (local $card i32)
    (local $i i32)

    (loop $loop
      ;; Calculate the memory address of the card $i.
      local.get $i
      i32.const 4
      i32.mul         ;; Multiply $i by 4 to find the i32 which contains the card's value.
      i32.load        ;; Load the i32 into memory.
      local.set $card ;;

      ;; Test if $card is higher than $high.
      local.get $card
      local.get $high
      i32.gt_s

      ;; Test if card is an ace
      local.get $card
      i32.const 1
      i32.eq

      i32.or
      if
        local.get $card
        local.set $high
      end

      ;; Increment loop counter and continue if $i < 5.
      local.get $i
      i32.const 1
      i32.add
      local.tee $i
      i32.const 5
      i32.lt_s
      br_if $loop
    )

    local.get $high
  )
)
