#lang racket

(provide nqueen)

(define (genseq a b)
  (cond [(> a b) `()]
        [else
         (cons a (genseq (+ a 1) b))]))

(define (nqueen n)
  (nqueen-h 0 `() (genseq 1 n)))

(define (nqueen-h n cursol poslist)
  (cond [(empty? poslist) 1]
        [else
         (let* ([validpos (filter (λ(pos) (valid-add cursol pos 1)) poslist)]
               [counts ((if (= n 0) 
                            map
                            map)
                        (λ (pos)
                          (nqueen-h (+ n 1)
                                    (cons pos cursol)
                                    (remove pos poslist)))
                        validpos)])
           (foldr + 0 counts))]))

(define (valid-add sol newpos ind)
  (cond [(empty? sol) #true]
        [(= ind (abs (- (car sol) newpos))) #false]
        [else (valid-add (cdr sol) newpos (+ ind 1))]))

(define (pmap f l)
  (map touch (map (λ(x)(future (λ() (f x)))) l)))

;; Stack overflow
(define (parmap f xs)
  ;; Make one channel for each element of xs.
  (define cs (for/list ([x xs])
               (make-channel)))
  ;; Make one thread for each elemnet of xs.
  ;; Each thread calls (f x) and puts the result to its channel.
  (for ([x xs]
        [c cs])
    (thread (thunk (channel-put c (f x)))))
  ;; Get the result from each channel.
  ;; Note: This will block on each channel if not yet ready.
  (for/list ([c cs])
    (channel-get c)))
