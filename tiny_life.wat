(module
  ;; $state is an 5x5 game of life state encoded into a single i32 where the
  ;; bits represent the state of the cells in row-major order.
  (func (export "simulate") (param $state i32) (result i32)
    ;; The next state of the simulation
    (local $next i32)

    ;; The number of alive neighbours
    (local $n i32)

    ;; Loop variables
    (local $x i32)
    (local $y i32)

    (loop $y_loop
      (loop $x_loop
        local.get $state
        local.get $x
        local.get $y
        call $alive_neighbours
        local.set $n

        local.get $state
        local.get $x
        local.get $y
        call $alive
        i32.eqz

        if
         ;; current cell is alive
        else
         ;; current cell is dead
        end

        ;; Increment $x
        local.get $x
        i32.const 1
        i32.add
        local.set $x

        ;; Loop if $x is less than 8
        local.get $x
        i32.const 8
        i32.le_s
        br_if $x_loop
      )

      ;; Reset $x to 0
      i32.const 0
      local.set $x

      ;; Increment $y
      local.get $y
      i32.const 1
      i32.add
      local.set $y

      ;; Break when $y is 8
      local.get $y
      i32.const 8
      i32.le_s
      br_if $y_loop
    )

    local.get $next
  )

  ;; Count how many of a given cells neighbours are alive.
  ;;
  ;; TODO: Pretty sure it might be simpler to calculate the bitmask for the
  ;; neighbours then AND and POPCNT them. Is there a neat closed form way to 
  ;; calculate the mask though?
  (func $alive_neighbours (param $state i32) (param $x i32) (param $y i32) (result i32)
    local.get $state
    (i32.sub (local.get $x) (i32.const 1))
    (i32.sub (local.get $y) (i32.const 1))
    call $alive
    i32.pop

    local.get $state
    local.get $x
    (i32.sub (local.get $y) (i32.const 1))
    call $alive
    i32.add

    local.get $state
    (i32.add (local.get $x) (i32.const 1))
    (i32.sub (local.get $y) (i32.const 1))
    call $alive
    i32.add

    local.get $state
    (i32.sub (local.get $x) (i32.const 1))
    local.get $y
    call $alive
    i32.add

    local.get $state
    (i32.add (local.get $x) (i32.const 1))
    local.get $y
    call $alive
    i32.add

    local.get $state
    (i32.sub (local.get $x) (i32.const 1))
    (i32.add (local.get $y) (i32.const 1))
    call $alive
    i32.add

    local.get $state
    local.get $x
    (i32.add (local.get $y) (i32.const 1))
    call $alive
    i32.add

    local.get $state
    (i32.add (local.get $x) (i32.const 1))
    (i32.add (local.get $y) (i32.const 1))
    call $alive
    i32.add
  )

  ;; Test whether the cell at $x, $y is alive. Cells outside of the grid always
  ;; count as dead.
  (func $alive (param $state i32) (param $x i32) (param $y i32) (result i32)
    local.get $x
    local.get $y
    call $inside
    i32.eqz
    if
      i32.const 0
      return
    end

    local.get $state

    local.get $x
    local.get $y
    call $xy_to_index

    i32.shr_s
    i32.const 1
    i32.and
  )

  (func $xy_to_index (param $x i32) (param $y i32) (result i32)
    local.get $y
    i32.const 8
    i32.mul
    local.get $x
    i32.add
  )

  (func $set (param $state i32) (param $x i32) (param $y i32) (param $alive i32)
    local.get $x
    local.get $y
  )

  ;; Check whether coordinates are inside the game simulation.
  (func $inside (param $x i32) (param $y i32) (result i32)
    local.get $x
    i32.const 0
    i32.ge_s

    local.get $y
    i32.const 0
    i32.ge_s

    i32.and

    local.get $x
    i32.const 8
    i32.lt_s

    local.get $y
    i32.const 8
    i32.lt_s

    i32.and

    i32.and
  )
)
