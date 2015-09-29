#lang racket
(require "NQueen.ss" "../../../Infrastructure/SpeedTest.ss")
(define (test a b)
  (cond [(> a b) 0]
        [else (begin
                (display a)
                (display ",")
                (collect-garbage)
                (display (perf-test (lambda() (nqueen a)) 1))
                (display ",")
                (newline)
                (test (+ a 1) b))]))

(define x (test 4 14))
