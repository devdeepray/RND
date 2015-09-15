#lang racket
(require "TopSort.ss" "TopSortTestHelpers.ss")
(display "[DENSE]")
(newline)
(define a (test gen-big-dag (lambda (x) (+ (/ (* x x) 2) x)) 1000 10000 200 1 topsort))
(display "[SPARSE]")
(newline)
(define b (test (lambda (s) (gen-sparse-dag s 500)) (lambda (s) (* 500 s)) 1000 10000 200 1 topsort))
