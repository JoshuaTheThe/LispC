(

(extern printf str)
(extern memset d v l)
(extern strcmp a b)
(extern fopen p m)
(extern fclose f)

(fn setup-keywords keywords (
        (set-element keywords 0 "fn")
        (set-element keywords 4 "if")
        (set-element keywords 8 "declare")
        (set-element keywords 12 "struct")
        (set-element keywords 16 "set")
        (set-element keywords 20 "add")
        (set-element keywords 24 "sub")
        (set-element keywords 28 "mul")
        (set-element keywords 32 "div")
        (set-element keywords 36 "mod")
        (set-element keywords 40 "eq")
        (set-element keywords 44 "neq")
        (set-element keywords 48 "lt")
        (set-element keywords 52 "gt")
        (set-element keywords 56 "lte")
        (set-element keywords 60 "gte")
        (set-element keywords 64 "deref")
        (set-element keywords 68 "set-deref")
        (set-element keywords 72 "and")
        (set-element keywords 76 "or")
        (set-element keywords 80 "xor")
        (set-element keywords 84 "not")
        (set-element keywords 88 "alloca")
        (set-element keywords 92 "extern")
))

(fn is-alpha chr (
        (or (and (gte chr 65) (lte chr 90)) (and (gte chr 97) (lte chr 122)))
))
        
(fn get-identifier source keywords identifier n (
        (declare char)
        (set char (and (deref source) 255))
        (if (and (lt n 31) (eq (is-alpha char) 1)) (
                (set-element identifier n char)
                (get-identifier (add source 1) keywords identifier (add n 1))
        ) source)
))

(fn is-whitespace char (
        (or (or (or (eq char 32) (eq char 9)) (eq char 10)) (eq char 13))
))

(fn is-keyword keywords identifier n (
        (if (lt n (sub (mul 25 4) 4)) (
                (if (eq (strcmp (element keywords n) identifier) 0)
                        (add (div n 4) 16)
                        (is-keyword keywords identifier (add n 4))
                )
        ) 3)
))

(fn get-token source keywords identifier pp (
        (declare tok-id)
        (declare char)
        
        (memset identifier 0 32)

        (set char (and (deref source) 255))
        (set tok-id 0)

        (if (eq char 40)(
                (set tok-id 1)
                (set-element pp 0 (add source 1)))
        (if (eq char 41)(
                (set tok-id 2)
                (set-element pp 0 (add source 1)))
        (if (eq (is-alpha char) 1)(
                (set-element pp 0 (get-identifier source keywords identifier 0))
                (set tok-id (is-keyword keywords identifier 0)))
        (if (eq (is-whitespace char) 1)(
                (set tok-id (get-token (add source 1) keywords identifier pp)))))))
        tok-id
))
        
(fn main argc argv (
        (declare keywords)
        (declare identifier)
        (declare source)
        (declare keywords-size)
        (declare pp)
        (declare fp)
        (set keywords-size (mul 26 4))
        (set keywords (alloca keywords-size))
        (set identifier (alloca 32))
        (set pp (alloca 4))
        (set fp 0)
        (if (gt argc 1)
                (set fp (fopen (element argv 4) "r"))
                (set source "(fn main)"))
        (setup-keywords keywords)
        
        (fn mainloop source keywords identifier pp (
                (declare tok-id)
                (set tok-id (get-token source keywords identifier pp))
                (printf "Token: %d Id: %s\n" tok-id identifier))
                (if (neq tok-id 0) (
                        (mainloop (element pp 0) keywords identifier pp)))
        ))
        
        (mainloop source keywords identifier pp)
        (if fp (fclose fp))
))

)
