(define (new-if predicate then-clause else-clause)
        (cond
                (predicate then-clause)
                (else else-clause)
        )
)
(define (sqrt-iter guess x)
        (new-if (good-enough? guess x)
                guess
                (sqrt-iter (improve guess x)
                        x)
        )
)



(sqrt-iter 1.0 2)
=>
(new-if (good-enough? 1.0 2)
        1.0
        (sqrt-iter (improve 1.0 2) 2)
)
=>
(new-if #f ;; (good-enough? 1.0 2)を評価
        1.0
        (sqrt-iter 1.5 2) ;;(improve 1.0 2)を評価したが、sqrt-iterをまだ評価できるのでnew-ifの評価に進まない
) 
=>
(new-if #f ;; 
        1.0
        (new-if #f ;; (good-enough? 1.5 2)を評価
                1.5
                (sqrt-iter 1.4166666666666665 2) ;;(improve 1.5 2)を評価するが、sqrt-iterがまだ評価出来る...以下ループ
        )
)
