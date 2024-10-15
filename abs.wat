(module
  ;; Return the absolute value of an i32.
  ;;
  ;; Using f32.abs is cheating!
  (func (export "abs") (param $val i32) (result i32)
        ;; Push $val and 0, so we can compare them
        local.get $val
        i32.const 0

        ;; Push 1 if first value is greater, otherwise 0
        i32.gt_s 

        ;; If value on top of stack is 1 (i.e., $val > 0), push $val,
        ;; otherwise, push -$val
        (if (result i32) 
          (then 
            local.get $val)
          (else 
            local.get $val
            i32.const -1
            i32.mul))))
