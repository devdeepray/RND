#lang racket
(require racket/set)
(provide topsort)

;; Graph input is a list of lists. Each list inside has the node as car
;; and the list of neighbors as cdr.
(define (topsort graph)
  (topsort-helper (make-hash graph) ;; Hash the graph for quick node lookup.
                  `() ;; Initialize list of sorted nodes.
                  (apply set (map car graph)) ;; get the list of nodes.
                  (set))) ;; empty set of seen nodes.


;; Helper to pick nodes from unmarked and run dfs on it to topologically sort all nodes
;; reacheable from the picked node.
(define (topsort-helper graph sorted unmarked seen)
  
  (define (explore node sorted unmarked seen)
    
    (define (explore-helper node retval)
      (cond [(car retval) (explore node (cadr retval) (caddr retval) (cadddr retval))]
            [else retval]))
    
    (cond [(set-member? seen node) (list #f sorted unmarked seen)] ;; cycle found.
          [(not (set-member? unmarked node)) (list #t sorted unmarked seen)] ;; Already explored.
          [else (let* ([tmp-seen (set-add seen node)]
                       [retval (foldl explore-helper 
                                      (list #t sorted unmarked tmp-seen) 
                                      (hash-ref graph node))] ;; Explore all neighbors
                       [is-cycle (not (car retval))]
                       [sorted-new (cons node (cadr retval))]
                       [unmarked-new (set-remove (caddr retval) node)]
                       [seen-new (set-remove (cadddr retval) node)])
                  (list (not is-cycle) sorted-new unmarked-new seen-new))]))
  
  (cond [(set-empty? unmarked) (cons sorted #t)] ;; no more nodes.
        [else (let* ([node (set-first unmarked)] ;; pick some node.
                     [retval (explore node sorted unmarked seen)] ;; Run dfs.
                     [is-cycle (not (car retval))]
                     [sorted-new (cadr retval)]
                     [unmarked-new (caddr retval)]
                     [seen-new (cadddr retval)])
                (cond [is-cycle (cons sorted #f)] ;; Cannot do topSort.
                      [else (topsort-helper graph sorted-new unmarked-new seen-new)]))]))








