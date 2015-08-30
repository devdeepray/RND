#lang racket
(require "../../../Infrastructure/SpeedTest.ss" "TopSort.ss")
(provide gen-big-dag test)

(define (gen-big-dag n)
  (define (helper n)
    (cond [(= n 1) (list (node 0 `()))]
          [else (let* ([smaller-dag (helper (- n 1))]
                      [old-nbr (node-nbrs (car smaller-dag))]
                      [new-nbr (cons (- n 2) old-nbr)])
                  (cons (node 0 new-nbr) smaller-dag))]))
  (list->vector (reverse (helper n))))


(define (test start-dag end-dag delta num-run sorter)
  (define (test-helper dag-size)
    (cond [(> dag-size end-dag) 0]
          [else (let ([big-dag (gen-big-dag dag-size)])
                  (begin (define (func)
                           (sorter big-dag))
                         (display (/ (* dag-size dag-size) 4))
                         (display ",")
                         (collect-garbage)
                         (display (perf-test func num-run))
                         (display ",")
                         (newline)
                         (test-helper (+ dag-size delta))))]))
  (test-helper start-dag))
