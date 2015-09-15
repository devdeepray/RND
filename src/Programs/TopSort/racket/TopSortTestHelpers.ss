#lang racket
(require "../../../Infrastructure/SpeedTest.ss" "TopSort.ss")
(provide gen-big-dag gen-sparse-dag test)

(define (gen-big-dag n)
  (define (helper n)
    (cond [(= n 1) (list (node 0 `()))]
          [else (let* ([smaller-dag (helper (- n 1))]
                      [old-nbr (node-nbrs (car smaller-dag))]
                      [new-nbr (cons (- n 2) old-nbr)])
                  (cons (node (- n 1) new-nbr) smaller-dag))]))
  (list->vector (reverse (helper n))))

(define (gen-sparse-dag n deg)
  (define (helper n)
    (cond [(= n 1) (list (node 0 `()))]
          [else (let* ([smaller-dag (helper (- n 1))]
                       [new-nbr (create-seq (max 0 (- (- n 2) deg)) (- n 2))])
                  (cons (node (- n 1) new-nbr) smaller-dag))]))
  (list->vector (reverse (helper n))))

(define (create-seq i j)
  (cond [(> i j) `()]
        [else (cons i (create-seq (+ i 1) j))]))

(define (test dag-gen numcalc start-dag end-dag delta num-run sorter)
  (define (test-helper dag-size)
    (cond [(> dag-size end-dag) 0]
          [else (let ([big-dag (dag-gen dag-size)])
                  (begin (define (func)
                           (sorter big-dag))
                         (display (numcalc dag-size))
                         (display ",")
                         (collect-garbage)
                         (display (perf-test func num-run))
                         (display ",")
                         (newline)
                         (test-helper (+ dag-size delta))))]))
  (test-helper start-dag))
