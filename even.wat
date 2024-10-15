(module
  ;; Return 1 if the parameter is even or 0 if it is odd.
  (func (export "even") (param $a i32) (result i32)
    ;; Eventual result values we'll return
    i32.const 0 ;; odd
    i32.const 1 ;; even

    ;; Get even/add bit as a bitwise &
    local.get $a
    i32.const 1
    i32.and

    select))
