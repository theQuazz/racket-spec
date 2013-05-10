#lang racket

;; this is just to make sure that the
;; run-spec.rkt works

(provide foo inc lucky-name?)

(define foo #t)

(define (inc num)
  (+ 1 num))

(define (lucky-name? name)
  (string=? name "Jesse"))

