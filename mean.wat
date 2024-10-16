(module
  (memory (export "memory") 1)

  ;; Find the mean of the first $n f32 numbers in memory.
  ;; If $n <= 0, return 0.
  ;;
  ;; See https://en.wikipedia.org/wiki/Arithmetic_mean
  (func (export "mean") (param $n i32) (result f32)
    (local $result f32)
    (local $i i32)

    (local.set $result (f32.const 0))
    (local.set $i (i32.const 0))

    ;; return early for invalid values
    (if (i32.le_s (local.get $n) (i32.const 0))
      (then (return (local.get $result))))

    (loop $loop
      ;; update the result
      (local.set $result 
                (f32.add 
                  (local.get $result) 
                  (f32.load (i32.mul (local.get $i) (i32.const 4)))))

      ;; increment the counter
      (local.set $i (i32.add (local.get $i) (i32.const 1)))

      ;; goto start of the loop if we're not done yet
      (br_if $loop (i32.lt_u (local.get $i) (local.get $n))))

    ;; divide the result by $n
    (f32.div (local.get $result) (f32.convert_i32_u (local.get $n)))))
