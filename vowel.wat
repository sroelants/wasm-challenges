(module
  ;; Returns 1 if $char is a vowel (aeiou) and 0 otherwise.
  (func (export "vowel") (param $char i32) (result i32)
    ;; a
    (if (i32.eq (local.get $char) (i32.const 65))
      (then (return (i32.const 1))))

    (if (i32.eq (local.get $char) (i32.const 97))
      (then (return (i32.const 1))))

    ;; e
    (if (i32.eq (local.get $char) (i32.const 69))
      (then (return (i32.const 1))))
    
    (if (i32.eq (local.get $char) (i32.const 101))
      (then (return (i32.const 1))))

    ;; i
    (if (i32.eq (local.get $char) (i32.const 73))
      (then (return (i32.const 1))))

    (if (i32.eq (local.get $char) (i32.const 105))
      (then (return (i32.const 1))))

    ;; o
    (if (i32.eq (local.get $char) (i32.const 79))
      (then (return (i32.const 1))))

    (if (i32.eq (local.get $char) (i32.const 111))
      (then (return (i32.const 1))))

    ;; u
    (if (i32.eq (local.get $char) (i32.const 85))
      (then (return (i32.const 1))))

    (if (i32.eq (local.get $char) (i32.const 117))
      (then (return (i32.const 1))))

    (i32.const 0)))
