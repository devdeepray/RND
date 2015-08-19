#lang racket
(require "TopSortMutable.ss" "TopSortTestHelpers.ss")
(define a (test 1000 5000 100 1 topsort-m))
