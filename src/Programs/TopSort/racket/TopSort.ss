#lang racket
(require racket/set)
(provide topsort (struct-out node) (struct-out sortres))


(struct node (payload nbrs) #:transparent)
(struct sortres (cansort sorted) #:transparent)
;; graph is a vector of of "node"s, with each node having a payload and a vector
;; of neighbors. 
(define (topsort graph)
  (topsort-helper graph
                  `() ;; Initialize list of sorted nodes.
                  (make-vector (vector-length graph) #f) ;; vector to keep track of explored nodes
                  (make-vector (vector-length graph) #f))) ;; vector to keep track of temp marks.


;; Helper to pick nodes from unmarked and run dfs on it to topologically sort all nodes
;; reacheable from the picked node.
(define (genl n)
  (cond [(= n 0) `()]
        [else (cons (- n 1) (genl (- n 1)))]))

(define (topsort-helper graph sorted explored seen)
  (define (explore-helper node sr)
      (cond [(sortres-cansort sr) (explore node (sortres-sorted sr))]
            [else sr]))
  
  (define (explore node sorted)
    (cond [(vector-ref seen node) (sortres #f sorted)] ;; cycle found.
          [(vector-ref explored node) (sortres #t sorted)] ;; Already explored.
          [else (begin
                  (vector-set! seen node #t)
                  (define sr (foldl explore-helper
                                    (sortres #t sorted)
                                    (node-nbrs (vector-ref graph node))))
                  (vector-set! seen node #f)
                  (vector-set! explored node #t)
                  (sortres (sortres-cansort sr)
                           (cons node (sortres-sorted sr))))]))
  
  (let ([sr (foldl explore-helper
                   (sortres #t `())
                   (genl (vector-length graph)))])
    sr))

                 
