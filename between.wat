(module
  ;; Check whether $val is between $a and $b (inclusive).
  ;;
  ;; The range is effectively:
  ;;   min($a, $b) <= $val <= max($a, $b)
  ;;
  ;; Return 1 if $val is within the range.
  ;; Return 0 if not.
  ;;
  (func (export "between") (param $a i32) (param $b i32) (param $val i32) (result i32)
    (local $min_ab i32)
    (local $max_ab i32)

    ;; Get the min of $a and $b
    local.get $a
    local.get $b
    (local.set $min_ab (call $min))

    ;; Get the max of $a and $b
    local.get $a
    local.get $b
    (local.set $max_ab (call $max))

    ;; If $min_ab <= $val, check the whether $val <= $max_ab, otherwise return 
    ;; 0 immediately.
    local.get $min_ab
    local.get $val
    i32.le_s

    (if (result i32)
      (then 
        local.get $val
        local.get $max_ab
        i32.le_s
        (if (result i32)
          (then i32.const 1)
          (else i32.const 0)))
      (else
        i32.const 0)))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;
  ;; Helpers
  ;; 
  ;; Unnecessary, but I wanted to play around with calling other functions.
  ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; Return the smaller of two values
  (func $min (param $a i32) (param $b i32) (result i32)
    ;; Push these in advance
    local.get $a
    local.get $b

    ;; Check which is greater
    local.get $a
    local.get $b
    i32.lt_s

    ;; return the greater of the two
    select)

  ;; Return the larger of two values
  (func $max (param $a i32) (param $b i32) (result i32)
    ;; Push these in advance
    local.get $a
    local.get $b

    ;; Check which is greater
    local.get $a
    local.get $b
    i32.gt_s

    ;; return the greater of the two
    select))
