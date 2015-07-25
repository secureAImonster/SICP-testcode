(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
      midpoint
      (let ((test-value (f midpoint)))
        (cond ((positive? test-value)
               (search f neg-point midpoint))
              ((negative? test-value)
               (search f midpoint pos-point))
              (else midpoint))))))

(define (close-enough? x y)
  (< (abs (- x y)) 0.001))

(define (average x y)
  (/ (+ x y) 2))

(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
            (error "Values are not of opposite sign" a b)))))


(define tolerance 0.000001)

(define (fixed-point f firstguess)
  (define (close-enough? x y)
    (< (abs (- x y)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
        next
        (try next))))
  (try firstguess))


(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y))) 1.0))





(display (half-interval-method sin 2.0 4.0))
(newline)
(display (half-interval-method (lambda (x) (- (* x x x) (* 2 x) 3)) 1.0 2.0))
(newline)
(display (fixed-point cos 1.0))
(newline)
(display (fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0))

