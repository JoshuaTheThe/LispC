(fn main (
        ; We wish to use these functions
        (extern fopen)
        (extern fclose)
        (extern fread)
        (extern printf)
        ; Create our pointer and buffer
        (declare f)
        (declare buff)
        ; Allocate our buffer
        (set buff (alloca 1024))
        ; Open our file
        (set f (fopen "tests/4.lisp" "r")
        (fread buff 1 1024 f)
        ; \0
        (set-element buff 1020 0)
        (printf "%s" buff)
        ; End
        (fclose f)
))