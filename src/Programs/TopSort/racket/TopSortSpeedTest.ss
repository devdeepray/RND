#lang racket
(require "TopSort.ss" "TopSortTestHelpers.ss")

(begin 
  (test 200 800 200 10 topsort)
  (test 850 900 10 10 topsort) ;; Weird jump at 872 nodes. Maybe a data structure switch.
  (test 1000 10000 200 10 topsort)
  (newline))
