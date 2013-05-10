#lang racket

(require "../example3.rkt")
(require "../../spec.rkt")

;; this is the tests for example1.rkt

(define jesse (person "Jesse" "Rogers" 20 'male))

(spec "Jesse should be sleepy"
      (should be-true (person-is-sleepy? jesse)))

(spec-summary)

