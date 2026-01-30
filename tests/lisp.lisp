(fn main argc argv (
                ; LibC Imports
                (extern printf)
                (extern memset)
                (extern strcmp)
                (extern fopen)
                (extern fclose)
                (extern fread)
                (extern exit)
                (extern realloc)
                (extern strdup)

                ; ---------
                ; TOKENISER
                ; ---------
                
        (fn setup-keywords keywords (
                (set-element keywords 0 "fn")
                (set-element keywords 4 "if")
                (set-element keywords 8 "declare")

                ; Unused in C++ bootstrapped compiler, so we will not impl
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
                (set-element keywords 68 "set_deref")
                (set-element keywords 72 "and")
                (set-element keywords 76 "or")
                (set-element keywords 80 "xor")
                (set-element keywords 84 "not")
                (set-element keywords 88 "alloca")
                (set-element keywords 92 "extern")
                (set-element keywords 96 "element")
                (set-element keywords 100 "set_element")
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
                (if (lt n (sub (mul 27 4) 4)) (
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
                ) (div n 4))
        ))

        (fn parse-end source keywords identifier pp local-var-names local-var-offsets n variable-count (
                (declare token)
                (declare ppb)
                (set ppb (alloca 12))
                (set-element ppb 4 0)
                (set token (get-token (element pp 0) keywords identifier ppb))
                (if (neq token 2) (
                        (parse-primary (element pp 0) keywords identifier pp local-var-names local-var-offsets variable-count)
                        (parse-end (element pp 0) keywords identifier pp local-var-names local-var-offsets (add n 1) variable-count)
                ) ((set token (get-token (element pp 0) keywords identifier pp)) n))
        ))

        (fn print-vars count hashes offsets n (
                (if (lt n (element count 0)) (
                        (printf "HASH=%d,OFFSET=%d\n" (element hashes (mul n 4)) (element offsets (mul n 4)))
                        (print-vars count hashes offsets (add n 1))
                ))
        ))

        (fn parse-nested source keywords identifier pp variable-names variable-offsets variable-count (
                (declare tok-id)
                (declare name-tok)
                (declare fn-name)
                (declare local-var-names)
                (declare local-var-offsets)
                (declare local-var-count)
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

                ; First is count, second is EBP
                (set local-var-count (alloca 8))
                (set-element local-var-count 0 0)
                (set-element local-var-count 4 0)

                ; Function
                (if (eq tok-id 16) (
                        (set name-tok (get-token (element pp 0) keywords fn-name pp))
                        (if (neq name-tok 3) (
                                (printf "The Fuck Did You Do?\n")
                                (exit 1)
                        ))
                        (set A (element pp 4))
                        (set-element pp 4 (add (element pp 4) 1))

                        (printf "\tjmp m%d\n" A)
                        (printf "\tglobal %s\n" fn-name)
                        (printf "%s:\n" fn-name)
                        (printf "\tpush ebp\n")
                        (printf "\tmov ebp, esp\n")
                        
                        (set-element local-var-count 0 (parse-declaration-arguments source keywords identifier pp local-var-names               local-var-offsets 0 8))
                        (set-element local-var-count 4 (sub 0 4))
                        (parse-end source keywords identifier pp local-var-names local-var-offsets 0 local-var-count)
                        
                        (printf "%s.end:\n" fn-name)
                        (printf "\tpop eax\n")
                        (printf "\tmov esp, ebp\n")
                        (printf "\tpop ebp\n")
                        (printf "\tret\n")
                        (printf "m%d:\n" A)
                )

                ; Declare
                (if (eq tok-id 18) (
                        (set name-tok (get-token (element pp 0) keywords fn-name pp))
                        (if (neq name-tok 3) (
                                (printf "The Fuck Did You Do?\n")
                                (exit 1)
                        ))

                        (set-element variable-names (mul (element variable-count 0) 4) (hash fn-name))
                        (set-element variable-offsets (mul (element variable-count 0) 4) (element variable-count 4))
                        (set-element variable-count 4 (sub (element variable-count 4) 4))
                        (set-element variable-count 0 (add (element variable-count 0) 1))

                        (parse-end source keywords identifier pp variable-names variable-offsets 0 variable-count)
                        (printf "\tsub esp, %d\n" (mul 4 1));
                )
                
                ; Set
                (if (eq tok-id 20) (
                        (set name-tok (get-token (element pp 0) keywords fn-name pp))
                        (if (neq name-tok 3) (
                                (printf "The Fuck Did You Do?\n")
                                (exit 1)
                        ))
                        (parse-end source keywords identifier pp variable-names variable-offsets 0 variable-count)
                        (printf "\tpop dword [ebp+%d]\n" (find-variable variable-names variable-offsets variable-count (hash fn-name) 0))
                )

                ; If
                (if (eq tok-id 17) (
                        ; Label Counter
                        (set B (element pp 4))
                        (set-element pp 4 (add (element pp 4) 1))
                        (set C (element pp 4))
                        (set-element pp 4 (add (element pp 4) 1))
                        
                        ; Condition
                        (parse-primary (element pp 0) keywords identifier pp variable-names variable-offsets variable-count)
                        (printf "\tpop eax\n")
                        (printf "\ttest eax, eax\n")
                        (printf "\tjz m%d\n" C)
                        
                        ; Then
                        (parse-primary (element pp 0) keywords identifier pp variable-names variable-offsets variable-count)
                        (printf "\tjmp m%d\n" B)
                        
                        ; Else
                        (printf "m%d:\n" C)
                        (parse-primary (element pp 0) keywords identifier pp variable-names variable-offsets variable-count)
                        (printf "m%d:\n" B)
                )
                
                ; ADD to GTE
                (if (and (gte tok-id 21) (lt tok-id 32)) (
                        (parse-end (element pp 0) keywords identifier pp variable-names variable-offsets 0 variable-count)
                        (set C (alloca 44))
                        (set-element C 0 "\tadd eax, ebx\n")        ; Add
                        (set-element C 4 "\tsub eax, ebx\n")        ; Sub
                        (set-element C 8 "\tmul ebx\n")                ; Mul
                        (set-element C 12 "\tcdq\n\tdiv ebx\n") ; Div
                        (set-element C 16 "\tcdq\n\tdiv ebx\n\tmov eax, edx\n")        ; Mod
                        (set-element C 20 "\tcmp eax, ebx\n\tsete al\n\tmovzx eax, al\n")
                        (set-element C 24 "\tcmp eax, ebx\n\tsetne al\n\tmovzx eax, al\n")
                        (set-element C 28 "\tcmp eax, ebx\n\tsetl al\n\tmovzx eax, al\n")
                        (set-element C 32 "\tcmp eax, ebx\n\tsetg al\n\tmovzx eax, al\n")
                        (set-element C 36 "\tcmp eax, ebx\n\tsetle al\n\tmovzx eax, al\n")
                        (set-element C 40 "\tcmp eax, ebx\n\tsetge al\n\tmovzx eax, al\n")
                        (printf "\tpop ebx\n");
                        (printf "\tpop eax\n");
                        (printf "%s" (element C (mul (sub tok-id 21) 4)))
                        (printf "\tpush eax\n")
                )

                ; Deref
                (if (eq tok-id 32) (
                        (parse-end (element pp 0) keywords identifier pp variable-names variable-offsets 0 variable-count)
                        (printf "\tpop eax\n")
                        (printf "\tpush dword [eax]\n")
                )

                ; Set-Deref
                (if (eq tok-id 33) (
                        ; (set-deref $addr $value)
                        (parse-end (element pp 0) keywords identifier pp variable-names variable-offsets 0 variable-count)
                        (printf "\tpop ebx\n")
                        (printf "\tpop eax\n")
                        (printf "\tmov dword [eax], ebx\n")
                )

                ; And, Or, Xor
                (if (and (gte tok-id 34) (lte tok-id 36)) (
                        (parse-end (element pp 0) keywords identifier pp variable-names variable-offsets 0 variable-count)
                        (set C (alloca 12))
                        (set-element C 0 "\tand eax, ebx\n")        ; And
                        (set-element C 4 "\tor eax, ebx\n")        ; UOr
                        (set-element C 8 "\txor eax, ebx\n")        ; XOr
                        (printf "\tpop ebx\n");
                        (printf "\tpop eax\n");
                        (printf "%s" (element C (mul (sub tok-id 34) 4)))
                        (printf "\tpush eax\n")
                )

                ; Not (Xor -1)
                (if (eq tok-id 37) (
                        (parse-end (element pp 0) keywords identifier pp variable-names variable-offsets 0 variable-count)
                        (printf "\tpop eax\n")
                        (printf "\txor eax, -1\n")
                        (printf "\tpush eax\n")
                )

                ; AllocA
                (if (eq tok-id 38) (
                        (parse-end (element pp 0) keywords identifier pp variable-names variable-offsets 0 variable-count)
                        (printf "\tpop eax\n")
                        (printf "\tsub esp, eax\n")
                        (printf "\tpush esp\n")
                )
                
                ; Extern
                (if (eq tok-id 39) (
                        (set name-tok (get-token (element pp 0) keywords fn-name pp))
                        (if (neq name-tok 3) (
                                (printf "The Fuck Did You Do?\n")
                                (exit 1)
                        ))
                        (printf "\textern %s\n" fn-name)
                        (parse-end (element pp 0) keywords identifier pp variable-names variable-offsets 0 variable-count)
                )

                ; Element
                (if (eq tok-id 40) (
                        (set name-tok (get-token (element pp 0) keywords fn-name pp))
                        (if (neq name-tok 3) (
                                (printf "The Fuck Did You Do?\n")
                                (exit 1)
                        ))
                        (parse-end (element pp 0) keywords identifier pp variable-names variable-offsets 0 variable-count)
                        (printf "\tpop edx\n")
                        (printf "\tpop ebx\n")
                        (printf "\tadd ebx, edx\n")
                        (printf "\tpush dword [ebx]\n")
                )

                ; Set-Element
                (if (eq tok-id 41) (
                        (set name-tok (get-token (element pp 0) keywords fn-name pp))
                        (if (neq name-tok 3) (
                                (printf "The Fuck Did You Do?\n")
                                (exit 1)
                        ))
                        (parse-end (element pp 0) keywords identifier pp variable-names variable-offsets 0 variable-count)
                        (printf "\tpop eax\n")
                        (printf "\tpop edx\n")
                        (printf "\tpop ebx\n")
                        (printf "\tadd ebx, edx\n")
                        (printf "\tmov dword [ebx], eax\n")
                )
                
                ; Call
                (if (eq tok-id 3) (
                        (set count (parse-end source keywords identifier pp variable-names variable-offsets 0 variable-count))
                        (printf "\tcall %s\n" fn-name)
                        (printf "\tadd esp, %d\n" (mul count 4))
                        (printf "\tpush eax\n")
                )

                (if (eq tok-id 1) (
                        (parse-nested (element pp 0) keywords identifier pp variable-names variable-offsets variable-count)
                )
                
                (parse-primary (element pp 0) keywords identifier pp variable-names variable-offsets variable-count))))))))))))))))
        ))


        (fn find-variable variable-names variable-offsets variable-count hashed n (
                (if (lt n (element variable-count 0)) (
                        (if (eq (element variable-names (mul n 4)) hashed)
                                  ((element variable-offsets (mul n 4)))
                                  (find-variable variable-names variable-offsets variable-count hashed (add n 1)))
                ))
        ))

        (fn add-string identifier pp (
                (declare ide)
                (set ide (strdup identifier))

                ; ++Count
                (set-element pp 8 (add (element pp 8) 1))
                ; Strings = realloc(Strings, Count * sizeof(char*));
                (set-element pp 12
                        (realloc
                                (element pp 12)
                                (mul (element pp 8) 4)))

                ; *(Strings + (Count - 1) * 4) = strdup(Identifier);
                (set-deref (add (element pp 12) (mul (sub (element pp 8) 1) 4)) ide)
        ))

        (fn parse-primary source keywords identifier pp variable-names variable-offsets variable-count (
                (declare tok-id)
                (set tok-id (get-token (element pp 0) keywords identifier pp))
                ; STRING
                (if (eq tok-id 5) (
                        (add-string identifier pp)
                        (printf "\tpush __string_%d\n" (element pp 8))
                ))

                ; NUMBER
                (if (eq tok-id 4) ((printf "\tpush %s\n" identifier)))
                ; IDENTIFIER
                (if (eq tok-id 3) ((printf "\tpush dword [ebp+%d]\n" (find-variable variable-names variable-offsets variable-count (hash identifier) 0))))
                ; LPAREN ... RPAREN
                (if (eq tok-id 1) (
                        (parse-nested (element pp 0) keywords identifier pp variable-names variable-offsets variable-count)
                ))
        ))

        (fn emit-bytes c_str n (
                (if (and (deref c_str) 255) (
                        (printf "\tdb %d\n" (and (deref c_str) 255))
                        (emit-bytes (add c_str 1) (add n 1))
                ) (printf "\tdb 0\n"))
        ))

        (fn emit-strings pp n (
                (if (lt n (element pp 8)) (
                        (printf "__string_%d:\n" (add n 1))
                        (emit-bytes (deref (add (element pp 12) (mul n 4))) 0)
                        (emit-strings pp (add n 1))
                ))
        ))

        (declare keywords)
        (declare identifier)
        (declare source)
        (declare keywords-size)
        (declare pp)
        (declare fp)
        (declare buff)
        (set buff (alloca 65536))
        (set keywords-size (mul 40 4))
        (set keywords (alloca keywords-size))
        (set identifier (alloca 32))
        ; 0 == Position
        ; 4 == Label Count
        ; 8 == String Count
        ; 12 == &Strings
        (set pp (alloca 16))

        (set fp 0)
        (set-element pp 4 0)
        (set-element pp 8 0)
        (set-element pp 12 0)
        (if (gt argc 1)(
                (set fp (fopen (element argv 4) "r"))
                (fread buff 1 65536 fp)
                (set source buff))
                (set source "(fn main a b c ((not 10)))"))
        (set-element pp 0 source)
        (setup-keywords keywords)
        (printf "\tsection .text\n")
        (parse-primary source keywords identifier pp 0 0 0)
        (printf "\tsection .data\n")
        (emit-strings pp 0)
        (if fp (fclose fp))
))
