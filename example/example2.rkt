#lang racket

;; this is just to make sure that the
;; run-spec.rkt works

(provide person person-full-name person-life-expectancy person-years-left person-is-male? person-is-female?)

(struct person (first-name last-name age gender) #:transparent)

(define (person-full-name a-person)
  (string-append (person-first-name a-person) " "
                 (person-last-name a-person)))

(define (person-is-male? a-person)
  (symbol=? 'male (person-gender a-person)))

(define (person-is-female? a-person)
  (symbol=? 'female (person-gender a-person)))

(define (person-life-expectancy a-person)
  (cond [(person-is-male? a-person) 72]
        [(person-is-female? a-person) 82]
        [else 0]))

(define (person-years-left a-person)
  (define diff (- (person-life-expectancy a-person)
                  (person-age a-person)))
  (if (< diff 0) #f diff))

