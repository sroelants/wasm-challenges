(module
  ;; Check whether a given number is prime. Return 1 if true, or 0 otherwise.
  (func (export "prime") (param $n i32) (result i32)
    (local $i i32)
    (local $m i32)
    (local.set $i (i32.const 2))

    ;; Remap to a positive number, because the test suite also considers
    ;; negative numbers, which are never prime.
    (local.set $m (select (local.get $n)
                    (i32.mul (i32.const -1) (local.get $n))
                    (i32.lt_s (i32.const 0) (local.get $n))))

    ;; 1 is an exception
    (if (i32.eq (local.get $m) (i32.const 1))
      (then (return (i32.const 0))))

    (loop $loop
      ;; If we've reached $m, return 1
      (if (i32.eq (local.get $i) (local.get $m))
        (then (return (i32.const 1))))

      ;; if remainder is 0, $m is not prime
      (if (i32.eqz (i32.rem_u (local.get $m) (local.get $i)))
        (then (return (i32.const 0))))

      ;; Increment $i, rinse, and repeat.
      (local.set $i (i32.add (local.get $i) (i32.const 1)))

      br $loop)

    unreachable))
