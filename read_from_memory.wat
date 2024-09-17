(module
  (memory (export "memory") 1)

  ;; Read and return the $nth i32 from memory.
  (func (export "load") (param $n i32) (result i32)
    local.get $n
    i32.const 4 ;; 4 bytes per i32
    i32.mul
    i32.load
  )
)
