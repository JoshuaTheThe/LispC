(

        ; gLibC Imports
(extern printf str)
(extern memset d v l)
(extern strcmp a b)
(extern fopen p m)
(extern fclose f)
(extern fread buf a b f)
(extern exit code)

        ; ---------
        ; TOKENISER
        ; ---------
        
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
        (or (or (or (and (gte chr 65) (lte chr 90)) (and (gte chr 97) (lte chr 122))) (eq chr 95)) (eq chr 45))
))
        
(fn get-identifier source keywords identifier n (
        (declare char)
        (set char (and (deref source) 255))
        (set char (if (eq char 45) 95 char))
        (if (and (lt n 31) (eq (is-alpha char) 1)) (
                (set-element identifier n char)
                (get-identifier (add source 1) keywords identifier (add n 1))
        ) ((set-element identifier n 0) source))
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

(fn is-numeric char (
        (and (gte char 48) (lte char 57))
))

(fn get-number source keywords identifier n (
        (declare char)
        (set char (and (deref source) 255))
        (if (and (lt n 31) (eq (is-numeric char) 1)) (
                (set-element identifier n char)
                (get-number (add source 1) keywords identifier (add n 1))
        ) ((set-element identifier n 0) source))
))

(fn decode-sub char (
        (if (eq char 110) 10 (
        (if (eq char 116) 9 char)))
))

(fn get-string source keywords identifier n (
        (declare char)
        (set char (and (deref source) 255))
        (if (and (lt n 31) (neq char 34)) (
                ; '\\'
                (if (eq char 92) (
                        (set char (and (deref (add source 1)) 255))
                        (set-element identifier n (decode-sub char))
                        (get-string (add source 2) keywords identifier (add n 1))
                )(
                        (set-element identifier n char)
                        (get-string (add source 1) keywords identifier (add n 1))
                ))
        ) ((set-element identifier n 0) (add source 1)))
))

(fn get-comment source (
        (declare char)
        (set char (and (deref source) 255))
        ; If LF || CR
        (if (or (eq char 10) (eq char 13)) source
        (      ; Else
                (get-comment (add source 1))
        ))
))

        ; 0      =       None
        ; 1      =       LPAREN
        ; 2      =       RPAREN
        ; 3      =       IDENT
        ; 4      =       NUMBER
        ; 5      =       STRING
        ; 6      =       IGNORE
        ; 16..39 =       KEYWORD
(fn get-token source keywords identifier pp (
        (declare tok-id)
        (declare char)
        
        (memset identifier 0 32)

        (set char (and (deref source) 255))
        (set tok-id 0)
        
        ; IF-Else chain, which looks cursed as we have no else keyword
        ; #lisp
        
        ; COMMENT
        (if (eq char 59) (set tok-id (get-token (get-comment source) keywords identifier pp))
                ; NUMBER
                (if (eq (is-numeric char) 1) ((set tok-id 4) (set-element pp 0 (get-number source keywords identifier 0)) )
                        ; STRING
                        (if (eq char 34) ((set tok-id 5) (set-element pp 0 (get-string (add source 1) keywords identifier 0) ))
                                ; LPAREN
                                (if (eq char 40) ((set tok-id 1) (set-element pp 0 (add source 1)) )
                                        ; RPAREN
                                        (if (eq char 41) ((set tok-id 2) (set-element pp 0 (add source 1)) )
                                                ; IDENT // KEYWORD
                                                (if (eq (is-alpha char) 1) ((set-element pp 0 (get-identifier source keywords identifier 0)) (set tok-id (is-keyword keywords identifier 0)) )
                                                        ; *
                                                        (if (eq (is-whitespace char) 1) ((set tok-id (get-token (add source 1) keywords identifier pp))))))))))
        tok-id
))

        ; ---------
        ; PARSER
        ; ---------
(fn hash-iter name i k (
        (if (and (lt i 16) (neq (deref (add name i)) 0))
                        (hash-iter name (add i 1)
                        (add (mul k (add i 1)) (deref (add name i))))k)
))

(fn hash name (
        (hash-iter name 0 0)
))

(fn parse-declaration-arguments source keywords identifier pp variable-names variable-offsets n ebp (
        (declare name)
        (declare name-tok)
        (set name (alloca 32))
        (set name-tok (get-token (element pp 0) keywords name pp))
        
        (if (eq name-tok 3) (
                (set-element variable-names n (hash name))
                (set-element variable-offsets n ebp)
                (parse-declaration-arguments (element pp 0) keywords identifier pp variable-names variable-offsets (add n 4) (add ebp 4))
        ))
))

(fn parse-end source keywords identifier pp local-var-names local-var-offsets n (
        (declare token)
        (declare ppb)
        (set ppb (alloca 4))
        (set token (get-token (element pp 0) keywords identifier ppb))
        (if (neq token 2) (
                (parse-primary (element pp 0) keywords identifier pp local-var-names local-var-offsets)
                (parse-end (element pp 0) keywords identifier pp local-var-names local-var-offsets (add n 1))
        ) ((set token (get-token (element pp 0) keywords identifier pp)) n))
))

(fn parse-nested source keywords identifier pp variable-names variable-offsets (
        (declare tok-id)
        (declare name-tok)
        (declare fn-name)
        (declare local-var-names)
        (declare local-var-offsets)
        (declare count)
        (declare A)
        (declare B)
        (declare C)
        
        ; A Maximum of 256 variables per function
        ; Store hashes of the name, not the name itself
        (set local-var-names (alloca 1024))
        (set local-var-offsets (alloca 1024))
        
        (set fn-name (alloca 32))
        (set tok-id (get-token (element pp 0) keywords fn-name pp))
        ; Function
        (if (eq tok-id 16) (
                (set name-tok (get-token (element pp 0) keywords fn-name pp))
                (if (neq name-tok 3) (
                        (printf "The Fuck Did You Do?\n")
                        (exit 1)
                ))
                (printf "\tglobal %s\n" fn-name)
                (printf "%s:\n" fn-name)
                (printf "\tpush ebp\n")
                (printf "\tmov ebp, esp\n")
                
                (parse-declaration-arguments source keywords identifier pp local-var-names local-var-offsets 0 4)
                (parse-end source keywords identifier pp local-var-names local-var-offsets 0)
                
                (printf "%s.end:\n" fn-name)
                (printf "\tpop eax\n")
                (printf "\tmov esp, ebp\n")
                (printf "\tpop ebp\n")
                (printf "\tret\n")
        ))
        
        ; If
        (if (eq tok-id 17) (
                (set A (element pp 4))
                (set-element pp 4 (add (element pp 4) 1))
                (set B (element pp 4))
                (set-element pp 4 (add (element pp 4) 1))
                (set C (element pp 4))
                (set-element pp 4 (add (element pp 4) 1))
                
                ; Condition
                (parse-primary (element pp 0) keywords identifier pp local-var-names local-var-offsets 0)
                (printf "\tpop eax\n")
                (printf "\ttest eax, eax\n")
                (printf "\tjz m%d\n" C)
                
                ; Then
                (printf "m%d:\n" A)
                (parse-primary (element pp 0) keywords identifier pp local-var-names local-var-offsets 0)
                (printf "\tjmp m%d\n" B)
                
                ; Else
                (printf "m%d:\n" C)
                (parse-end source keywords identifier pp local-var-names local-var-offsets 0)
                (printf "m%d:\n" B)
        )
        
        ; Call
        (if (eq tok-id 3) (
                (set count (parse-end source keywords identifier pp local-var-names local-var-offsets 0))
                (printf "\tcall %s\n" fn-name)
                (printf "\tadd esp, %d\n" (mul count 4))
        ) (parse-end (element pp 0) keywords identifier pp local-var-names local-var-offsets 0)))
))

(fn parse-primary source keywords identifier pp variable-names variable-offsets (
        (declare tok-id)
        (set tok-id (get-token (element pp 0) keywords identifier pp))
        ; NUMBER
        (if (eq tok-id 4) ((printf "\tpush %s\n" identifier)))
        ; IDENTIFIER
        (if (eq tok-id 3) ((printf "\tpush %s\n" identifier)))
        ; LPAREN ... RPAREN
        (if (eq tok-id 1) (
                (parse-nested (element pp 0) keywords identifier pp)
        ))
))

        
(fn main argc argv (
        (declare keywords)
        (declare identifier)
        (declare source)
        (declare keywords-size)
        (declare pp)
        (declare fp)
        (declare buff)
        (set buff (alloca 65536))
        (set keywords-size (mul 26 4))
        (set keywords (alloca keywords-size))
        (set identifier (alloca 32))
        (set pp (alloca 8))
        (set fp 0)
        (set-element pp 4 0)
        (if (gt argc 1)(
                (set fp (fopen (element argv 4) "r"))
                (fread buff 1 65536 fp)
                (set source buff))
                (set source "(fn main a b c ((if 3 2 1)))"))
        (set-element pp 0 source)
        (setup-keywords keywords)
        
        (fn mainloop source keywords identifier pp (
                (declare tok-id)
                (set tok-id (get-token source keywords identifier pp))
                (printf "Token: %d Id: '%s'\n" tok-id identifier)
                (if (neq tok-id 0) (
                        (mainloop (element pp 0) keywords identifier pp)))
        ))
        
        (parse-primary source keywords identifier pp 0 0)
        (if fp (fclose fp))
))

)
