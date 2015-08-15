#lang racket
(require "../../../Infrastructure/SpeedTest.ss")
(provide gen-big-dag test)

(define (gen-big-dag n)
  (cond [(= n 1) `((1))]
        [else (let ([smaller-dag (gen-big-dag (- n 1))])
                (reverse (cons (cons n (reverse (car smaller-dag))) smaller-dag)))]))


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
