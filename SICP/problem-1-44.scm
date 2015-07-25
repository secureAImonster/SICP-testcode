(define (smooth f)
  (lambda (x)
	(/ (+ (f (- x dx))
		  (f x)
		  (f (+ x dx)))
	   3)))

(define (n-fold-smooth f n)
  ((repeated smooth n) f))

(define (repeated f n)
  (if (< n 1)
	(lambda (x) x)
	(compose f (repeated f (- n 1)))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define dx 0.00001)

(define (f x)
  (+ (* 2 x) 5))

(display ((n-fold-smooth 5 f) 6))
