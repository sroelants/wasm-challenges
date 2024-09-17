(module
  (import  "env" "out" (func $out (param i32)))

  ;; Initialize two pages of memory. The first page is for instructions and the
  ;; second page is for data.
  (memory 2)

  ;; Instruction pointer points to the current symbol in the first page of
  ;; memory.
  (global $ip (mut i32) (i32.const 0))

  ;; Data pointer points to the current data address in the second page of
  ;; memory.
  (global $dp (mut i32) (i32.const 65536))

  ;; Fetch the instruction at $addr.
  (func $fetch (param $addr i32) (result i32)
    local.get $addr ;; Put the address onto the stack
    i32.load        ;; Load the instruction at the address
    i32.const 0xFF  ;; Put a mask for the instruction byte
    i32.and         ;; Use the mask to isolate the first byte
  )

  ;; Execute the current instruction and return the halt state of the program.
  (func $execute (result i32)
    (local $inst i32)

    ;; Fetch the current instruction.
    global.get $ip
    call $fetch
    local.set $inst

    (block $test
      ;; >
      ;; Increment the data pointer by one (to point to the next cell to the right).
      local.get $inst
      i32.const 0x3E
      i32.eq
      if
        global.get $dp
        i32.const 1
        i32.add
        global.set $dp
        br $test
      end

      ;; <
      ;; Decrement the data pointer by one (to point to the next cell to the left).
      local.get $inst
      i32.const 0x3C
      i32.eq
      if
        global.get $dp
        i32.const 1
        i32.sub
        global.set $dp
        br $test
      end

      ;; +
      ;; Increment the byte at the data pointer by one.
      local.get $inst
      i32.const 0x2B
      i32.eq
      if
        global.get $dp
        global.get $dp
        i32.load
        i32.const 1
        i32.add
        i32.store
        br $test
      end

      ;; -
      ;; Decrement the byte at the data pointer by one.
      local.get $inst
      i32.const 0x2D
      i32.eq
      if
        global.get $dp
        global.get $dp
        i32.load
        i32.const 1
        i32.sub
        i32.store
        br $test
      end

      ;; .
      ;; Output the byte at the data pointer.
      local.get $inst
      i32.const 0x2E
      i32.eq
      if
        global.get $dp
        i32.load
        call $out
        br $test
      end

      ;; [
      ;; If the byte at the data pointer is zero, then instead of moving the
      ;; instruction pointer forward to the next command, jump it forward to the
      ;; command after the _matching_ ] command.
      local.get $inst
      i32.const 0x5B
      i32.eq
      if
        call $find_matching_closing_bracket
        global.set $ip
        br $test
      end

      ;; ]
      ;; If the byte at the data pointer is zero, then instead of moving the
      ;; instruction pointer forward to the next command, jump it _back_ to the
      ;; command after the _matching_ [ command.
      local.get $inst
      i32.const 0x5B
      i32.eq
      if
        call $find_matching_opening_bracket
        global.set $ip
        br $test
      end
    )

    ;; Increment the IP
    global.get $ip
    i32.const 1
    i32.add
    global.set $ip

    ;; Check whether we're at the end of the program.
    global.get $ip
    i32.load
    i32.const 0
    i32.ne
  )

  ;; Find the index of the matching closing bracket after the IP.
  (func $find_matching_closing_bracket (result i32)
    (local $depth i32)
    (local $i i32)
    (local $ch i32)
    (local.set $i (global.get $ip))

    (loop $loop
      local.get $i
      call $fetch
      local.set $ch

      ;; If we reach 0x0 bytes then we left the program.
      local.get $ch
      i32.eqz
      if
        unreachable
      end

      ;; [
      ;; Increase the depth
      local.get $ch
      i32.const 0x5B
      i32.eq
      if
        local.get $depth
        i32.const 1
        i32.add
        local.set $depth
      end

      ;; ]
      ;; Match if depth is zero, otherwise decrement depth and continue.
      local.get $ch
      i32.const 0x5D
      i32.eq
      if
        local.get $depth
        i32.eqz
        if
          local.get $i
          return
        end
        local.get $depth
        i32.const 1
        i32.sub
        local.set $depth
      end

      local.get $i
      i32.const 1
      i32.add
      local.set $i
      br $loop
    )

    unreachable
  )

  ;; Find the index of the matching opening bracket before the IP.
  (func $find_matching_opening_bracket (result i32)
    (local $depth i32)
    (local $i i32)
    (local $ch i32)
    (local.set $i (global.get $ip))

    (loop $loop
      local.get $i
      call $fetch
      local.set $ch

      ;; If we reach 0x0 bytes then we left the program.
      local.get $ch
      i32.eqz
      if
        unreachable
      end

      ;; ]
      ;; Increase the depth
      local.get $ch
      i32.const 0x5D
      i32.eq
      if
        local.get $depth
        i32.const 1
        i32.add
        local.set $depth
      end

      ;; [
      ;; Match if depth is zero, otherwise decrement depth and continue.
      local.get $ch
      i32.const 0x5B
      i32.eq
      if
        local.get $depth
        i32.eqz
        if
          local.get $i
          return
        end
        local.get $depth
        i32.const 1
        i32.sub
        local.set $depth
      end

      local.get $i
      i32.const 1
      i32.sub ;; We're going backwards
      local.set $i
      br $loop
    )

    unreachable
  )

  ;; Run the program that is currently loaded into memory.
  (func (export "run")
    (loop $loop
      call $execute
      br_if $loop
    )
  )
)
