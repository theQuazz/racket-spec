#lang racket

;; this is just to make sure that the
;; run-spec.rkt works

(require "example2.rkt")

(provide person person-is-sleepy?)

(define (person-is-sleepy? a-person)
  (string=? (person-full-name a-person) "Jesse Rogers"))

