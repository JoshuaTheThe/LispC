(fn main (
        ; We wish to use these functions
        (extern fopen)
        (extern fclose)
        (extern fread)
        (extern printf)
        ; Create our pointer and buffer
        (declare f)
        (declare length)
        (declare buff)
        ; Allocate our buffer
        (set buff (alloca 1024))
        ; Open our file
        (set f (fopen "r" "tests/4.lisp"))
        (if (neq f 0) (
                (set length (fread f 1024 1 buff))
                ; Null Terminate
                (if (lt length 1020)
                    (set-element buff length 0)
                    (set-element buff 1020 0))
                (printf buff "%s")
                ; End
                (fclose f)
        ) 1)
))