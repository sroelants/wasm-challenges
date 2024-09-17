(module
  (memory (export "memory") 1)

  ;; Search for and return the first index of $char within the string in memory
  ;; or -1 if you reach a 0x0 byte without finding it.
  (func (export "search") (param $char i32) (result i32)
    (local $i i32)
    (local $c i32)

    (loop $loop
      local.get $i    ;; Store the address of the next byte on the stack
      i32.load        ;; Load the next four bytes onto the stack
      i32.const 0xFF  ;; Put a low byte mask onto the stack
      i32.and         ;; Bitwise AND to apply the mask
      local.tee $c

      ;; Break out of the loop if we hit a 0x0 byte.
      i32.const 0
      i32.eq
      if
        i32.const -2
        local.get $i
        return
      end

      ;; Check if $c matches $char
      local.get $c
      local.get $char
      i32.eq
      if
        local.get $i  ;; Return the index where we found the match.
        return
      end

      ;; Otherwise increment $i and continue
      local.get $i
      i32.const 1
      i32.add
      local.set $i
      br $loop
    )

    unreachable
  )
)
