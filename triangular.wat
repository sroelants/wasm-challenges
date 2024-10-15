(module
  ;; Returns the nth triangular number.
  ;; Returns 1 when $n <= 0.
  ;; https://en.wikipedia.org/wiki/Triangular_number
  (func (export "triangular") (param $n i32) (result i32)
    (local $i i32)
    (local $result i32)
    (local.set $i (i32.const 0))
    (local.set $result (i32.const 0))

    (loop $sum-loop
      (local.set $result (i32.add (local.get $i) (local.get $result)))
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br_if $sum-loop (i32.le_s (local.get $i) (local.get $n))))

    local.get $result))
