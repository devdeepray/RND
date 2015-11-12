#lang racket
(require "TopSort.ss" "TopSortTestHelpers.ss")
(display "[DENSE]")
(newline)
(define a (test gen-big-dag (lambda(x) x) 1000 3000 100 1 topsort))
(display "[SPARSE]")
(newline)
(define b (test (lambda (s) (gen-sparse-dag s 500)) (lambda (s) s) 1000 3000 100 1 topsort))
