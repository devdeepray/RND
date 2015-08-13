#lang racket
(require "topsort.ss" "topsort-mutable.ss")
;; non mutable topsort speed test.
(define (gen-big-dag n)
  (cond [(= n 1) `((1))]
        [else (let ([smaller-dag (gen-big-dag (- n 1))])
                (reverse (cons (cons n (reverse (car smaller-dag))) smaller-dag)))]))

(define (perf-test func num-runs)
  (define (perf-helper n ttime) ;; num runs
    (cond [(= n 0) ttime]
          [else (begin (collect-garbage)
                       (define start-t (current-inexact-milliseconds))
                       (func)
                       (define end-t (current-inexact-milliseconds))
                       (perf-helper (- n 1) (+ (- end-t start-t) ttime)))]))
         (/ (perf-helper num-runs 0) num-runs))

(define (test start-dag end-dag delta num-run sorter)
  (define (test-helper dag-size)
    (cond [(> dag-size end-dag) 0]
          [else (let ([big-dag (gen-big-dag dag-size)])
                  (begin (define (func)
                           (sorter big-dag))
                         (display dag-size)
                         (display ",")
                         (collect-garbage)
                         (display (perf-test func num-run))
                         (display ",")
                         (newline)
                         (test-helper (+ dag-size delta))))]))
  (test-helper start-dag))

(display "Pure functional speed test")
(newline)
(test 200 800 200 10 topsort)
(test 850 900 10 10 topsort) ;; Weird jump at 872 nodes. Maybe a data structure switch.
(test 1000 10000 200 10 topsort)
;; (display "Mutable speed test")
;; (newline)
;; (test 500 10000 200 10 topsort-m)