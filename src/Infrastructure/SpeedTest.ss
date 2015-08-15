#lang racket
(provide perf-test)

(define (perf-test func num-runs)
  (define (perf-helper n ttime) ;; num runs
    (cond [(= n 0) ttime]
          [else (begin (collect-garbage)
                       (define start-t (current-inexact-milliseconds))
                       (func)
                       (define end-t (current-inexact-milliseconds))
                       (perf-helper (- n 1) (+ (- end-t start-t) ttime)))]))
         (/ (perf-helper num-runs 0) num-runs))

