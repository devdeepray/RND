#lang racket
(require "../../../Infrastructure/SpeedTest.ss" "TopSort.ss")
(provide gen-big-dag gen-sparse-dag test)

(define (gen-big-dag n)
 (list->vector (map (lambda(x)(node x (create-seq (+ x 1) (- n 1)))) (create-seq 0 (- n 1)))))

(define (gen-sparse-dag n k)
 (list->vector (map (lambda(x)(node x (create-seq (+ x 1) (min (+ x k) (- n 1))))) (create-seq 0 (- n 1)))))

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
