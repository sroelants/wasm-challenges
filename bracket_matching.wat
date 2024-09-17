(module
  (import "console" "log" (func $log (param i32)))

  (memory (export "memory") 1)

  ;; Check whether the square brackets in memory are balanced. Every [ should
  ;; have a corresponding ].
  (func (export "matching") (result i32)
    (local $depth i32)
    (local $i i32)
    (local $char i32)

    (loop $loop
      ;; Load the current character as a byte.
      local.get $i
      i32.load
      i32.const 0xff
      i32.and
      local.set $char

      ;; Check whether we reached the end of the string (a 0x00 byte).
      local.get $char
      i32.eqz
      if
        ;; If so, make sure the $depth is zero, meaning that all opened
        ;; brackets had been closed.
        local.get $depth
        i32.eqz
        return
      end

      ;; If we found an opening bracket then increment the $depth
      local.get $char
      i32.const 0x5b ;; [
      i32.eq
      if
        local.get $depth
        i32.const 1
        i32.add
        local.set $depth
      end

      ;; If we found a closing bracket then decrement the $depth
      local.get $char
      i32.const 0x5d ;; ]
      i32.eq
      if
        ;; Fail if the depth is already zero
        local.get $depth
        i32.eqz
        if
          i32.const 0
          return
        end

        local.get $depth
        i32.const 1
        i32.sub
        local.set $depth
      end

      ;; Increment $i and continue
      local.get $i
      i32.const 1
      i32.add
      local.set $i
      br $loop
    )

    ;; The program will always exit on finding an unmatched bracket or by
    ;; reaching the end of the source.
    unreachable
  )
)
