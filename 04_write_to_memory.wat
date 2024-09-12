(module
  (memory (export "memory") 1)

  ;; Write $val into the $nth i32 in memory.
  (func (export "store") (param $n i32) (param $val i32)
    local.get $n
    i32.const 4 ;; 4 bytes per i32
    i32.mul
    local.get $val
    i32.store
  )
)
