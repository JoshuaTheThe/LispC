(extern printf)

(fn foo n (
        (if (gt n 0) (
                (foo (sub n 1))
                (printf n "Hello, World! %d\n")
        ))
))

(fn main (
        (foo 10)
))