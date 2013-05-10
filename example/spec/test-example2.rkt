#lang racket

(require "../example2.rkt")
(require "spec.rkt")

;; this is the tests for example2.rkt

(define jesse (person "Jesse" "Rogers" 20 'male))
(define becca (person "Rebecca" "Gillmore" 20 'female))

(spec "Jesse's full name should be Jesse Rogers"
      (should string=? "Jesse Rogers" (person-full-name jesse)))

(spec "Becca's full name should be Rebecca Gillmore"
      (should string=? "Rebecca Gillmore" (person-full-name becca)))

(spec "Jesse should be male"
      (should person-is-male? jesse))

(spec "Becca should be female"
      (should person-is-female? becca))

(spec "Becca's life expectancy should be 82"
      (should = 82 (person-life-expectancy becca)))

(spec "Jesse should have 52 years left"
      (should = 52 (person-years-left jesse)))

(spec-summary)

