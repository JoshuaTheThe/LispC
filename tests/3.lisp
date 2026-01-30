(fn main (
        (fib 10)
        (fn fib n (
                (if (lt n 2) n (
                        (add (fib (sub n 1)) (fib (sub n 2)))
                ))
        ))
))
