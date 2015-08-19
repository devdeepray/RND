#lang racket
(require racket/set)
(provide topsort-m)

;; Graph input is a list of lists. Each list inside has the node as car
;; and the list of neighbors as cdr.
(define (topsort-m graph)
  (topsort-helper (make-hash graph) ;; Hash the graph for quick node lookup.
                  `() ;; Initialize list of sorted nodes.
                  (make-hash (map (λ (x) (cons (car x) `())) graph)) ;; get the list of nodes.
                  (make-hash))) ;; empty set of seen nodes.


;; Helper to pick nodes from unmarked and run dfs on it to topologically sort all nodes
;; reacheable from the picked node.
(define (topsort-helper graph sorted unmarked seen)
  
  (define (pick-one hmap)
    (let ([pos (hash-iterate-first hmap)])
      (hash-iterate-key hmap pos)))
  
  (define (explore node sorted)
    (define (explore-helper node explore-helper-ret)
      (cond [(car explore-helper-ret) (explore node (cadr explore-helper-ret))]
            [else explore-helper-ret]))
    
    (cond [(hash-has-key? seen node) (list #f `())] ;; cycle found.
          [(not (hash-has-key? unmarked node)) (list #t sorted)] ;; Already explored, skip.
          [else (begin
                  (hash-set! seen node `())
                  (let* ([full-data (foldl explore-helper (list #t sorted) (hash-ref graph node))]
                         [is-cycle (not (car full-data))]
                         [sorted-new (cons node (cadr full-data))])
                    (begin (hash-remove! unmarked node)
                           (hash-remove! seen node)
                           (list (not is-cycle) sorted-new))))]))
  
  (cond [(= 0 (hash-count unmarked)) (cons sorted #t)] ;; no more nodes.
        [else (let* ([node (pick-one unmarked)] ;; pick some node.
                     [full-data (explore node sorted)] ;; Run dfs.
                     [is-cycle (not (car full-data))]
                     [sorted-new (cadr full-data)])
                (cond [is-cycle (cons sorted #f)] ;; Cannot do topSort.
                      [else (topsort-helper graph sorted-new unmarked seen)]))]))







