#lang racket
(require "NQueen.ss" "../../../Infrastructure/SpeedTest.ss")
(define (test a b)
  (cond [(> a b) 0]
        [else (begin
                (display a)
                (display ",")
                (collect-garbage)
                (display (log (perf-test (lambda() (nqueen a)) 1)))
                (display ",")
                (newline)
                (test (+ a 1) b))]))
(define y (test 4 10))
(define x (test 4 14))
