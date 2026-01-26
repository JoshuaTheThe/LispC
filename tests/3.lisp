(fn main (
        (extern printf p)
        (fn fib n (
                (if (lt n 2) n (
                        (add (fib (sub n 1)) (fib (sub n 2)))
                ))
        ))

        (fib 10)
))