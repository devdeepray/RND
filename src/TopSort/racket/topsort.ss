#lang racket
(require racket/set)

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
    
    (define (explore-helper node-list sorted unmarked seen)
      (cond [(empty? node-list) (list #t sorted unmarked seen)]
            [else (let* ([next-node (car node-list)]
                         [full-data (explore next-node sorted unmarked seen)]
                         [is-cycle (not (car full-data))]
                         [sorted-new (cadr full-data)]
                         [unmarked-new (caddr full-data)]
                         [seen-new (cadddr full-data)])
                    (cond [is-cycle (list #f sorted-new unmarked-new seen-new)]
                          [else (explore-helper (cdr node-list) sorted-new unmarked-new seen-new)]))]))
    
    (cond [(set-member? seen node) (list #f sorted unmarked seen)] ;; cycle found.
          [(not (set-member? unmarked node)) (list #t sorted unmarked seen)] ;; Already explored, skip.
          [else (let* ([tmp-seen (set-add seen node)]
                       [full-data (explore-helper (hash-ref graph node) sorted unmarked tmp-seen)]
                       [is-cycle (not (car full-data))]
                       [sorted-new (cons node (cadr full-data))]
                       [unmarked-new (set-remove (caddr full-data) node)]
                       [seen-new (set-remove (cadddr full-data) node)])
                  (list (not is-cycle) sorted-new unmarked-new seen-new))]))
  
  (cond [(set-empty? unmarked) (cons sorted #t)] ;; no more nodes.
        [else (let* ([node (set-first unmarked)] ;; pick some node.
                     [full-data (explore node sorted unmarked seen)] ;; Run dfs.
                     [is-cycle (not (car full-data))]
                     [sorted-new (cadr full-data)]
                     [unmarked-new (caddr full-data)]
                     [seen-new (cadddr full-data)])
                (cond [is-cycle (cons sorted #f)] ;; Cannot do topSort.
                      [else (topsort-helper graph sorted-new unmarked-new seen-new)]))]))








