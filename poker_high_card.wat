(module
  (memory (export "memory") 1)

  ;; Analyse the five card poker hand in memory (see "Poker Notes" in README)
  ;; and return the _rank value_ of the highest card. Remember that A is high!
  (func (export "high") (result i32)
    (local $result i32)
    (local $i i32)
    (local $current i32)
    (local.set $result (i32.const 0))
    (local.set $i (i32.const 0))
    (local.set $current (i32.const 0))

    (loop $loop
      ;; load the current rank
      (local.set $current 
                 (i32.load8_u (i32.mul (i32.const 2) (local.get $i))))

      ;; If it's an ace, return early, because it's guaranteed to be the highest
      (if (i32.eq (local.get $current) (i32.const 1))
        (then (return (local.get $current))))

      ;; If it's higher than the current highest card, save it
      (if (i32.gt_u (local.get $current) (local.get $result))
        (then (local.set $result (local.get $current))))

      ;; increment the counter
      (local.set $i (i32.add (local.get $i) (i32.const 1)))

      ;; goto start of the loop if we're not done yet
      (br_if $loop (i32.lt_u (local.get $i) (i32.const 5))))
    
    (local.get $result)))
