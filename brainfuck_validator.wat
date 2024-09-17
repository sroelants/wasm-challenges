(module

  ;; Validate whether the program at the start of memory is valid Brainfuck.
  ;; https://en.wikipedia.org/wiki/Brainfuck
  (func (export "validate") (result i32)
    (local $i i32)
    (local $command i32)

    (loop $loop
      ;; Fetch the command at $i
      local.get $i
      i32.load
      i32.const 0xFF
      i32.and
      local.set $command

      ;; Check whether we reached the end of the program (a null byte).
      local.get $command
      i32.eqz
      if
        i32.const 1
        return
      end

      ;; Check whether the current char is a valid Brainfuck character.
      local.get $command
      call $is_valid_command
      i32.eqz
      if
        i32.const 0
        return
      end

      ;; Check if opening bracket has a matching closing bracket.
      local.get $command
      i32.const 0x5b
      i32.eq
      if
        ;; TODO: Check that there's a matching closing bracket
      end

      ;; Check if closing bracket has a matching opening bracket.
      local.get $command
      i32.const 0x5d
      i32.eq
      if
        ;; TODO: Check that there's a matching opening bracket
      end

      ;; Increment $i and continue
      local.get $i
      i32.const 1
      i32.add
      local.set $i
      br $loop
    )

    ;; The loop should always terminate by returning early when it reaches a
    ;; null byte (the end of the program) or discovering invalid syntax.
    unreachable
  )

  ;; Test whether a given command is a valid Brainfuck character.
  (func $is_valid_command (param $command i32)
    (block $test
      (br_if $test (i32.eq (local.get $command) (i32.const 0x2b))) ;; +
      (br_if $test (i32.eq (local.get $command) (i32.const 0x2d))) ;; -
      (br_if $test (i32.eq (local.get $command) (i32.const 0x2e))) ;; .
      (br_if $test (i32.eq (local.get $command) (i32.const 0x3c))) ;; <
      (br_if $test (i32.eq (local.get $command) (i32.const 0x3e))) ;; >
      (br_if $test (i32.eq (local.get $command) (i32.const 0x5b))) ;; [
      (br_if $test (i32.eq (local.get $command) (i32.const 0x5d))) ;; ]
      i32.const 0
      return
    )

    i32.const 1
  )
)
