#lang racket
(require "topsort.ss" "topsort-mutable.ss")
;; non mutable topsort speed test.
(define (gen-big-dag n)
  (cond [(= n 1) `((1))]
        [else (let ([smaller-dag (gen-big-dag (- n 1))])
                (reverse (cons (cons n (reverse (car smaller-dag))) smaller-dag)))]))

(define big-dag (gen-big-dag 5000))

(define (perf-test func num-runs)
  (define (perf-helper n) ;; num runs
    (cond [(= n 0) 1]
          [else (begin (func)
                       (perf-helper (- n 1)))]))
  (begin (define start-t (current-inexact-milliseconds))
         (perf-helper num-runs)
         (define end-t (current-inexact-milliseconds))
         (/ (- end-t start-t) num-runs)))

(define topsort-big-dag
  (λ () (topsort big-dag)))
  
(define topsort-m-big-dag
  (λ () (topsort-m big-dag)))

(display "non-mutable version test")
(newline)
(display (perf-test topsort-big-dag 10))
(newline)
(display "mutable version test")
(newline)
(display (perf-test topsort-m-big-dag 10))
(newline)