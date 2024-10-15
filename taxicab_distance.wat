(module
  ;; Return the taxicab distance between x0,y0 and x1,y1.
  ;; https://en.wikipedia.org/wiki/Taxicab_geometry
  (func (export "taxicab") (param $x0 i32) (param $y0 i32) (param $x1 i32) (param $y1 i32) (result i32)
    (local $dx i32)
    (local $dy i32)

    (local.set $dx (if (result i32) (i32.lt_s (local.get $x0) (local.get $x1))
                     (then (i32.sub (local.get $x1) (local.get $x0)))
                     (else (i32.sub (local.get $x0) (local.get $x1)))))

    (local.set $dy (if (result i32) (i32.lt_s (local.get $y0) (local.get $y1))
                     (then (i32.sub (local.get $y1) (local.get $y0)))
                     (else (i32.sub (local.get $y0) (local.get $y1)))))

    (i32.add (local.get $dx) (local.get $dy))))
