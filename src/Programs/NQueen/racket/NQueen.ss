#lang racket
(provide nqueen)

(define (genseq a b)
	(cond [(> a b) `()]
				[else
					(cons a (genseq (+ a 1) b))]))

(define (nqueen n)
	(nqueen-h 0 `() (genseq 1 n)))

(define (nqueen-h n cursol poslist)
	(define (valid-add newpos)
		(define (valid-add-h sol ind)
			(cond [(empty? sol) #true]
						[(= ind (abs (- (car sol) newpos))) #false]
						[else (valid-add-h (cdr sol) (+ ind 1))]))
		(valid-add-h cursol 1))

	(cond [(empty? poslist) 1]
				[else
					(let* ([validpos (filter valid-add poslist)]
								 [counts (map (λ (pos) (nqueen-h (+ n 1)
																									(cons pos cursol)
																									(remove pos poslist)))
															validpos)])
						(foldr + 0 counts))]))

