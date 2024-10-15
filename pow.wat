(module
  ;; Raise $x to the power of $y and return the result.
  ;; (You don't need to support negative powers)
  (func (export "pow") (param $x i32) (param $y i32) (result i32)
    (local $i i32)
    (local $result i32)
    
    (local.set $i (i32.const 0)) ;; Initialize the counter to 0

    (local.set $result (i32.const 1)) ;; initialize the result as 1, so $x^0 returns 1

    (loop $mul-loop

      ;; Compare counter $i to the power $y
      local.get $i
      local.get $y
      i32.lt_u

      (if
        ;; If counter is still in range, multiply
        (then
          ;; multiply
          local.get $result
          local.get $x
          i32.mul
          local.set $result

          ;; increment the counter
          local.get $i
          i32.const 1
          i32.add
          local.set $i 

          ;; Return to start of loop
          br $mul-loop)
        ;; Otherwise, just return the result
        (else)))

    local.get $result))

