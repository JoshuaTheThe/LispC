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
        (set f (fopen "tests/4.lisp" "r"))
                (if (neq f 0) (
                (set length (fread buff 1 1024 f))
                ; Null Terminate
                (if (lt length 1020)
                    (set-element buff length 0)
                    (set-element buff 1020 0))
                (printf "%s" buff)
                ; End
                (fclose f)
        ))
))