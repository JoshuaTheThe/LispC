(fn main (
        (extern printf p)
        (fn foo n (
                (if (gt n 0) (
                        (foo (sub n 1))
                        (printf "Hello, World! %d\n" n)
                ))
        ))
        (foo 10)
))